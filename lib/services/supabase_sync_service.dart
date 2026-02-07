import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sqflite/sqflite.dart';
import '../features/analytics/services/analytics_service.dart';

/// Supabase cloud sync service
/// Syncs local SQLite data to Supabase cloud for backup and cross-device sync
class SupabaseSyncService {
  static final SupabaseClient _supabase = Supabase.instance.client;
  
  /// Sync a completed workout session to Supabase
  static Future<bool> syncWorkoutSession(String sessionId) async {
    try {
      final db = await AnalyticsService.database;
      
      // Get session data
      final sessionResult = await db.query(
        'workout_sessions',
        where: 'id = ?',
        whereArgs: [sessionId],
      );
      
      if (sessionResult.isEmpty) {
        debugPrint('❌ Session $sessionId not found');
        return false;
      }
      
      final session = sessionResult.first;
      final userId = _supabase.auth.currentUser?.id;
      
      if (userId == null) {
        debugPrint('⚠️  User not logged in, skipping sync');
        return false;
      }
      
      // Upload session to Supabase
      await _supabase.from('workout_sessions').upsert({
        'id': session['id'],
        'user_id': userId,
        'name': session['name'],
        'date': session['date'],
        'start_time': session['start_time'],
        'end_time': session['end_time'],
        'duration_minutes': session['duration_minutes'],
        'status': session['status'],
        'total_reps': session['total_reps'],
        'total_volume': session['total_volume'],
        'avg_form_score': session['avg_form_score'],
        'perfect_reps': session['perfect_reps'],
        'calories_burned': session['calories_burned'],
        'workout_mode': session['workout_mode'],
        'notes': session['notes'],
        'created_at': session['created_at'],
      });
      
      debugPrint('✅ Session synced to Supabase: $sessionId');
      
      // Sync exercise sets
      await _syncExerciseSets(sessionId, userId);
      
      // Sync PRs if any
      await _syncPersonalRecords(userId);
      
      return true;
    } catch (e) {
      debugPrint('❌ Error syncing workout session: $e');
      return false;
    }
  }
  
  /// Sync exercise sets for a session
  static Future<void> _syncExerciseSets(String sessionId, String userId) async {
    try {
      final db = await AnalyticsService.database;
      
      final sets = await db.query(
        'exercise_sets',
        where: 'session_id = ?',
        whereArgs: [sessionId],
      );
      
      if (sets.isEmpty) return;
      
      final setsToSync = sets.map((set) => {
        'session_id': set['session_id'],
        'user_id': userId,
        'exercise_name': set['exercise_name'],
        'set_number': set['set_number'],
        'weight': set['weight'],
        'reps_completed': set['reps_completed'],
        'reps_target': set['reps_target'],
        'form_score': set['form_score'],
        'perfect_reps': set['perfect_reps'],
        'good_reps': set['good_reps'],
        'missed_reps': set['missed_reps'],
        'max_combo': set['max_combo'],
        'duration_seconds': set['duration_seconds'],
        'rest_time_seconds': set['rest_time_seconds'],
        'timestamp': set['timestamp'],
        'notes': set['notes'],
      }).toList();
      
      await _supabase.from('exercise_sets').upsert(setsToSync);
      
      debugPrint('✅ Synced ${sets.length} exercise sets');
    } catch (e) {
      debugPrint('❌ Error syncing exercise sets: $e');
    }
  }
  
  /// Sync personal records
  static Future<void> _syncPersonalRecords(String userId) async {
    try {
      final db = await AnalyticsService.database;
      
      final prs = await db.query(
        'personal_records',
        where: 'is_current = 1',
      );
      
      if (prs.isEmpty) return;
      
      final prsToSync = prs.map((pr) => {
        'user_id': userId,
        'exercise_name': pr['exercise_name'],
        'weight': pr['weight'],
        'reps': pr['reps'],
        'e1rm': pr['e1rm'],
        'date': pr['date'],
        'session_id': pr['session_id'],
        'is_current': pr['is_current'],
        'created_at': pr['created_at'],
      }).toList();
      
      await _supabase.from('personal_records').upsert(prsToSync);
      
      debugPrint('✅ Synced ${prs.length} personal records');
    } catch (e) {
      debugPrint('❌ Error syncing personal records: $e');
    }
  }
  
  /// Sync body measurements
  static Future<bool> syncBodyMeasurement(String measurementId) async {
    try {
      final db = await AnalyticsService.database;
      final userId = _supabase.auth.currentUser?.id;
      
      if (userId == null) return false;
      
      final results = await db.query(
        'body_measurements',
        where: 'id = ?',
        whereArgs: [measurementId],
      );
      
      if (results.isEmpty) return false;
      
      final measurement = results.first;
      
      await _supabase.from('body_measurements').upsert({
        'id': measurement['id'],
        'user_id': userId,
        'date': measurement['date'],
        'weight': measurement['weight'],
        'body_fat': measurement['body_fat'],
        'chest': measurement['chest'],
        'arms': measurement['arms'],
        'forearms': measurement['forearms'],
        'waist': measurement['waist'],
        'hips': measurement['hips'],
        'thighs': measurement['thighs'],
        'calves': measurement['calves'],
        'shoulders': measurement['shoulders'],
        'neck': measurement['neck'],
        'notes': measurement['notes'],
        'created_at': measurement['created_at'],
      });
      
      debugPrint('✅ Measurement synced to Supabase');
      return true;
    } catch (e) {
      debugPrint('❌ Error syncing measurement: $e');
      return false;
    }
  }
  
  /// Pull all workout data from cloud (for new device or restore)
  static Future<void> pullCloudWorkouts() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        debugPrint('⚠️  User not logged in, cannot pull cloud data');
        return;
      }
      
      debugPrint('📥 Pulling workouts from cloud...');
      
      // Get all sessions for this user
      final sessions = await _supabase
          .from('workout_sessions')
          .select()
          .eq('user_id', userId)
          .order('date', ascending: false)
          .limit(100);
      
      final db = await AnalyticsService.database;
      
      for (final session in sessions) {
        // Insert into local DB (ignore conflicts)
        try {
          await db.insert('workout_sessions', {
            'id': session['id'],
            'name': session['name'],
            'date': session['date'],
            'start_time': session['start_time'],
            'end_time': session['end_time'],
            'duration_minutes': session['duration_minutes'],
            'status': session['status'],
            'total_reps': session['total_reps'],
            'total_volume': session['total_volume'],
            'avg_form_score': session['avg_form_score'],
            'perfect_reps': session['perfect_reps'],
            'calories_burned': session['calories_burned'],
            'workout_mode': session['workout_mode'],
            'notes': session['notes'],
            'created_at': session['created_at'],
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        } catch (e) {
          debugPrint('⚠️  Error inserting session ${session['id']}: $e');
        }
      }
      
      debugPrint('✅ Pulled ${sessions.length} sessions from cloud');
      
      // Pull exercise sets
      await _pullExerciseSets(userId);
      
      // Pull PRs
      await _pullPersonalRecords(userId);
      
      // Pull measurements
      await _pullMeasurements(userId);
      
    } catch (e) {
      debugPrint('❌ Error pulling cloud workouts: $e');
    }
  }
  
  /// Pull exercise sets from cloud
  static Future<void> _pullExerciseSets(String userId) async {
    try {
      final sets = await _supabase
          .from('exercise_sets')
          .select()
          .eq('user_id', userId)
          .order('timestamp', ascending: false)
          .limit(1000);
      
      final db = await AnalyticsService.database;
      
      for (final set in sets) {
        try {
          await db.insert('exercise_sets', {
            'session_id': set['session_id'],
            'exercise_name': set['exercise_name'],
            'set_number': set['set_number'],
            'weight': set['weight'],
            'reps_completed': set['reps_completed'],
            'reps_target': set['reps_target'],
            'form_score': set['form_score'],
            'perfect_reps': set['perfect_reps'],
            'good_reps': set['good_reps'],
            'missed_reps': set['missed_reps'],
            'max_combo': set['max_combo'],
            'duration_seconds': set['duration_seconds'],
            'rest_time_seconds': set['rest_time_seconds'],
            'timestamp': set['timestamp'],
            'notes': set['notes'],
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        } catch (e) {
          // Skip duplicates
        }
      }
      
      debugPrint('✅ Pulled ${sets.length} exercise sets');
    } catch (e) {
      debugPrint('❌ Error pulling exercise sets: $e');
    }
  }
  
  /// Pull personal records from cloud
  static Future<void> _pullPersonalRecords(String userId) async {
    try {
      final prs = await _supabase
          .from('personal_records')
          .select()
          .eq('user_id', userId)
          .eq('is_current', true);
      
      final db = await AnalyticsService.database;
      
      for (final pr in prs) {
        try {
          await db.insert('personal_records', {
            'exercise_name': pr['exercise_name'],
            'weight': pr['weight'],
            'reps': pr['reps'],
            'e1rm': pr['e1rm'],
            'date': pr['date'],
            'session_id': pr['session_id'],
            'is_current': pr['is_current'],
            'created_at': pr['created_at'],
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        } catch (e) {
          // Skip duplicates
        }
      }
      
      debugPrint('✅ Pulled ${prs.length} personal records');
    } catch (e) {
      debugPrint('❌ Error pulling PRs: $e');
    }
  }
  
  /// Pull measurements from cloud
  static Future<void> _pullMeasurements(String userId) async {
    try {
      final measurements = await _supabase
          .from('body_measurements')
          .select()
          .eq('user_id', userId)
          .order('date', ascending: false)
          .limit(50);
      
      final db = await AnalyticsService.database;
      
      for (final m in measurements) {
        try {
          await db.insert('body_measurements', {
            'id': m['id'],
            'date': m['date'],
            'weight': m['weight'],
            'body_fat': m['body_fat'],
            'chest': m['chest'],
            'arms': m['arms'],
            'forearms': m['forearms'],
            'waist': m['waist'],
            'hips': m['hips'],
            'thighs': m['thighs'],
            'calves': m['calves'],
            'shoulders': m['shoulders'],
            'neck': m['neck'],
            'notes': m['notes'],
            'created_at': m['created_at'],
          }, conflictAlgorithm: ConflictAlgorithm.replace);
        } catch (e) {
          // Skip duplicates
        }
      }
      
      debugPrint('✅ Pulled ${measurements.length} measurements');
    } catch (e) {
      debugPrint('❌ Error pulling measurements: $e');
    }
  }
  
  /// Sync all pending local data (call on app start if online)
  static Future<void> syncAllPendingData() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        debugPrint('⚠️  User not logged in, skipping sync');
        return;
      }
      
      debugPrint('🔄 Syncing all pending data...');
      
      final db = await AnalyticsService.database;
      
      // Get all recent sessions (last 30 days)
      final cutoffDate = DateTime.now().subtract(const Duration(days: 30));
      final sessions = await db.query(
        'workout_sessions',
        where: 'date >= ? AND status = ?',
        whereArgs: [cutoffDate.toIso8601String(), 'complete'],
      );
      
      for (final session in sessions) {
        await syncWorkoutSession(session['id'] as String);
      }
      
      debugPrint('✅ Sync complete!');
    } catch (e) {
      debugPrint('❌ Error syncing all data: $e');
    }
  }
}
