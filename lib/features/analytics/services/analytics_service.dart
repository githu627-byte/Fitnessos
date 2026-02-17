import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:path/path.dart' as path_helper;
import '../models/analytics_data.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// ANALYTICS SERVICE - Pull Real Data from Your Workouts
/// ═══════════════════════════════════════════════════════════════════════════
/// This service queries the workout_history.db to compile comprehensive
/// analytics data for the dashboard.
/// ═══════════════════════════════════════════════════════════════════════════

class AnalyticsService {
  static Database? _database;
  
  /// Get database instance
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }
  
  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final fullPath = path_helper.join(dbPath, 'workout_history.db');
    final db = await openDatabase(
      fullPath,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
    
    // Ensure tables exist even if database already existed
    await _ensureTablesExist(db);
    
    return db;
  }
  
  static Future<void> _ensureTablesExist(Database db) async {
    try {
      // FIRST: Ensure workout_sessions has all required columns
      final wsColumns = await db.rawQuery('PRAGMA table_info(workout_sessions)');
      final wsColumnNames = wsColumns.map((col) => col['name'] as String).toSet();
      
      // Add missing columns to workout_sessions
      if (!wsColumnNames.contains('total_volume')) {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN total_volume REAL DEFAULT 0');
        debugPrint('✅ Added total_volume column to workout_sessions');
      }
      if (!wsColumnNames.contains('calories_burned')) {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN calories_burned INTEGER DEFAULT 0');
        debugPrint('✅ Added calories_burned column to workout_sessions');
      }
      if (!wsColumnNames.contains('start_time')) {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN start_time TEXT');
        debugPrint('✅ Added start_time column to workout_sessions');
      }
      if (!wsColumnNames.contains('end_time')) {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN end_time TEXT');
        debugPrint('✅ Added end_time column to workout_sessions');
      }
      if (!wsColumnNames.contains('workout_mode')) {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN workout_mode TEXT');
        debugPrint('✅ Added workout_mode column to workout_sessions');
      }
      if (!wsColumnNames.contains('notes')) {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN notes TEXT');
        debugPrint('✅ Added notes column to workout_sessions');
      }
      
      // SECOND: Ensure exercise_sets has all required columns
      final esColumns = await db.rawQuery('PRAGMA table_info(exercise_sets)');
      final esColumnNames = esColumns.map((col) => col['name'] as String).toSet();
      
      if (!esColumnNames.contains('duration_seconds')) {
        await db.execute('ALTER TABLE exercise_sets ADD COLUMN duration_seconds INTEGER DEFAULT 0');
        debugPrint('✅ Added duration_seconds column to exercise_sets');
      }
      if (!esColumnNames.contains('rest_time_seconds')) {
        await db.execute('ALTER TABLE exercise_sets ADD COLUMN rest_time_seconds INTEGER DEFAULT 0');
        debugPrint('✅ Added rest_time_seconds column to exercise_sets');
      }
      if (!esColumnNames.contains('notes')) {
        await db.execute('ALTER TABLE exercise_sets ADD COLUMN notes TEXT');
        debugPrint('✅ Added notes column to exercise_sets');
      }
      if (!esColumnNames.contains('weight')) {
        await db.execute('ALTER TABLE exercise_sets ADD COLUMN weight REAL DEFAULT 0');
        debugPrint('✅ Added weight column to exercise_sets');
      }
      if (!esColumnNames.contains('timestamp')) {
        await db.execute('ALTER TABLE exercise_sets ADD COLUMN timestamp TEXT');
        debugPrint('✅ Added timestamp column to exercise_sets');
      }
      
      // THIRD: Check if body_measurements table exists
      final result = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='body_measurements'"
      );
      
      if (result.isEmpty) {
        // Table doesn't exist, create it
        await db.execute('''
          CREATE TABLE IF NOT EXISTS body_measurements (
            id TEXT PRIMARY KEY,
            date TEXT NOT NULL,
            weight REAL,
            body_fat REAL,
            chest REAL,
            arms REAL,
            forearms REAL,
            waist REAL,
            hips REAL,
            thighs REAL,
            calves REAL,
            shoulders REAL,
            neck REAL,
            notes TEXT,
            created_at TEXT NOT NULL
          )
        ''');
        await db.execute('CREATE INDEX IF NOT EXISTS idx_measurement_date ON body_measurements(date DESC)');
        debugPrint('✅ Created body_measurements table');
      }
      
      // FOURTH: Check if progress_photos table exists
      final photosResult = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name='progress_photos'"
      );
      
      if (photosResult.isEmpty) {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS progress_photos (
            id TEXT PRIMARY KEY,
            date TEXT NOT NULL,
            image_path TEXT NOT NULL,
            type TEXT NOT NULL,
            measurement_id TEXT,
            notes TEXT,
            created_at TEXT NOT NULL
          )
        ''');
        debugPrint('✅ Created progress_photos table');
      }
      
      debugPrint('✅ All database tables and columns verified');
    } catch (e) {
      debugPrint('❌ Error ensuring tables exist: $e');
    }
  }
  
  static Future<void> _createDB(Database db, int version) async {
    // Workout sessions table (if not exists)
    await db.execute('''
      CREATE TABLE IF NOT EXISTS workout_sessions (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        date TEXT NOT NULL,
        start_time TEXT,
        end_time TEXT,
        duration_minutes INTEGER,
        status TEXT NOT NULL,
        total_reps INTEGER DEFAULT 0,
        total_volume REAL DEFAULT 0,
        avg_form_score REAL DEFAULT 0.0,
        perfect_reps INTEGER DEFAULT 0,
        calories_burned INTEGER DEFAULT 0,
        workout_mode TEXT,
        notes TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // Exercise sets table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS exercise_sets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id TEXT NOT NULL,
        exercise_name TEXT NOT NULL,
        set_number INTEGER NOT NULL,
        weight REAL DEFAULT 0,
        reps_completed INTEGER NOT NULL,
        reps_target INTEGER NOT NULL,
        form_score REAL DEFAULT 0.0,
        perfect_reps INTEGER DEFAULT 0,
        good_reps INTEGER DEFAULT 0,
        missed_reps INTEGER DEFAULT 0,
        max_combo INTEGER DEFAULT 0,
        timestamp TEXT,
        duration_seconds INTEGER DEFAULT 0,
        rest_time_seconds INTEGER DEFAULT 0,
        notes TEXT,
        FOREIGN KEY (session_id) REFERENCES workout_sessions (id)
      )
    ''');
    
    // Body measurements table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS body_measurements (
        id TEXT PRIMARY KEY,
        date TEXT NOT NULL,
        weight REAL,
        body_fat REAL,
        chest REAL,
        arms REAL,
        forearms REAL,
        waist REAL,
        hips REAL,
        thighs REAL,
        calves REAL,
        shoulders REAL,
        neck REAL,
        notes TEXT,
        created_at TEXT NOT NULL
      )
    ''');
    
    // Progress photos table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS progress_photos (
        id TEXT PRIMARY KEY,
        date TEXT NOT NULL,
        image_path TEXT NOT NULL,
        type TEXT NOT NULL,
        measurement_id TEXT,
        notes TEXT,
        created_at TEXT NOT NULL
      )
    ''');
    
    // Personal records table (for faster PR lookups)
    await db.execute('''
      CREATE TABLE IF NOT EXISTS personal_records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        exercise_name TEXT NOT NULL,
        weight REAL NOT NULL,
        reps INTEGER NOT NULL,
        e1rm REAL,
        date TEXT NOT NULL,
        session_id TEXT,
        is_current INTEGER DEFAULT 1,
        created_at TEXT NOT NULL
      )
    ''');
    
    // Create indexes
    await db.execute('CREATE INDEX IF NOT EXISTS idx_session_date ON workout_sessions(date DESC)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_set_session ON exercise_sets(session_id)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_set_exercise ON exercise_sets(exercise_name)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_measurement_date ON body_measurements(date DESC)');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_pr_exercise ON personal_records(exercise_name)');
  }
  
  static Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add weight column to exercise_sets if missing
      try {
        await db.execute('ALTER TABLE exercise_sets ADD COLUMN weight REAL DEFAULT 0');
      } catch (e) {
        // Column might already exist
      }
      
      // Create new tables
      await _createDB(db, newVersion);
    }
    
    if (oldVersion < 3) {
      debugPrint('🔄 Upgrading database to v3: Adding missing columns...');
      
      // Add missing columns to workout_sessions
      try {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN calories_burned INTEGER DEFAULT 0');
        debugPrint('✅ Added calories_burned column');
      } catch (e) {
        debugPrint('⚠️  calories_burned column already exists or error: $e');
      }
      
      try {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN start_time TEXT');
        debugPrint('✅ Added start_time column');
      } catch (e) {
        debugPrint('⚠️  start_time column already exists or error: $e');
      }
      
      try {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN end_time TEXT');
        debugPrint('✅ Added end_time column');
      } catch (e) {
        debugPrint('⚠️  end_time column already exists or error: $e');
      }
      
      try {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN workout_mode TEXT');
        debugPrint('✅ Added workout_mode column');
      } catch (e) {
        debugPrint('⚠️  workout_mode column already exists or error: $e');
      }
      
      try {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN notes TEXT');
        debugPrint('✅ Added notes column to workout_sessions');
      } catch (e) {
        debugPrint('⚠️  notes column already exists or error: $e');
      }
      
      try {
        await db.execute('ALTER TABLE workout_sessions ADD COLUMN total_volume REAL DEFAULT 0');
        debugPrint('✅ Added total_volume column');
      } catch (e) {
        debugPrint('⚠️  total_volume column already exists or error: $e');
      }
      
      // Add missing columns to exercise_sets
      try {
        await db.execute('ALTER TABLE exercise_sets ADD COLUMN duration_seconds INTEGER DEFAULT 0');
        debugPrint('✅ Added duration_seconds column');
      } catch (e) {
        debugPrint('⚠️  duration_seconds column already exists or error: $e');
      }
      
      try {
        await db.execute('ALTER TABLE exercise_sets ADD COLUMN rest_time_seconds INTEGER DEFAULT 0');
        debugPrint('✅ Added rest_time_seconds column');
      } catch (e) {
        debugPrint('⚠️  rest_time_seconds column already exists or error: $e');
      }
      
      try {
        await db.execute('ALTER TABLE exercise_sets ADD COLUMN notes TEXT');
        debugPrint('✅ Added notes column to exercise_sets');
      } catch (e) {
        debugPrint('⚠️  notes column already exists or error: $e');
      }
      
      debugPrint('✅ Database upgraded to v3 successfully!');
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// MAIN LOAD METHOD - Get All Analytics Data
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<AnalyticsData> loadAnalytics({
    AnalyticsPeriod period = AnalyticsPeriod.allTime,
  }) async {
    final db = await database;
    
    final startDate = period == AnalyticsPeriod.allTime 
        ? null 
        : DateTime.now().subtract(Duration(days: period.days));
    
    // Parallel fetch for performance
    final results = await Future.wait([
      _getTotalWorkouts(db, startDate),
      _getTotalReps(db, startDate),
      _getTotalVolume(db, startDate),
      _getTotalHours(db, startDate),
      _getTotalCalories(db, startDate),
      _getCurrentStreak(db),
      _getLongestStreak(db),
      _getDailyVolumeData(db, 30),
      _getWeeklyVolumes(db, 12),
      _getMonthlyVolumes(db, 6),
      _getWorkoutIntensityMap(db, 90),
      _getWeekdayDistribution(db, startDate),
      _getWeeklyAverage(db),
      _getRecentPRs(db, 10),
      _getAllTimePRs(db),
      _getBodyPartVolumes(db, startDate),
      _getTopExercises(db, startDate, 8),
      _getExerciseFrequency(db, startDate),
      _getExerciseProgressions(db),
      _getFormScoreData(db, 30),
      _getRepQuality(db, startDate),
      _calculateFormIQ(db),
      _getLongestPerfectStreak(db),
      _getMeasurements(db, 20),
      _getWeightData(db, 60),
      _getProgressPhotos(db),
      _getMeasurementChanges(db),
    ]);
    
    final totalWorkouts = results[0] as int;
    final totalReps = results[1] as int;
    final totalVolume = results[2] as double;
    final totalHours = results[3] as double;
    final totalCalories = results[4] as int;
    final currentStreak = results[5] as int;
    final longestStreak = results[6] as int;
    final dailyVolumeData = results[7] as List<FlSpot>;
    final weeklyVolumes = results[8] as List<double>;
    final monthlyVolumes = results[9] as Map<String, double>;
    final workoutIntensityMap = results[10] as Map<DateTime, double>;
    final weekdayDistribution = results[11] as Map<int, int>;
    final weeklyAverage = results[12] as double;
    final recentPRs = results[13] as List<PersonalRecord>;
    final allTimePRs = results[14] as List<PersonalRecord>;
    final bodyPartVolumes = results[15] as Map<String, double>;
    final topExercises = results[16] as List<ExerciseVolume>;
    final exerciseFrequency = results[17] as Map<String, int>;
    final exerciseProgressions = results[18] as Map<String, List<FlSpot>>;
    final formScoreData = results[19] as List<FlSpot>;
    final repQuality = results[20] as Map<String, int>;
    final formIQ = results[21] as int;
    final longestPerfectStreak = results[22] as int;
    final measurements = results[23] as List<BodyMeasurement>;
    final weightData = results[24] as List<FlSpot>;
    final progressPhotos = results[25] as List<ProgressPhoto>;
    final measurementChanges = results[26] as Map<String, double>;
    
    // Calculate derived values
    final avgFormScore = formScoreData.isEmpty 
        ? 0.0 
        : formScoreData.fold<double>(0, (sum, spot) => sum + spot.y) / formScoreData.length;
    
    final bodyPartPercentages = _calculateBodyPartPercentages(bodyPartVolumes);
    
    final exerciseProgressPercentages = _calculateProgressPercentages(exerciseProgressions);
    
    // Calculate power level
    final powerLevel = AnalyticsData.calculatePowerLevel(
      totalVolume: totalVolume,
      workoutCount: totalWorkouts,
      streak: currentStreak,
      avgFormScore: avgFormScore,
      totalReps: totalReps,
    );
    
    return AnalyticsData(
      powerLevel: powerLevel,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      totalWorkouts: totalWorkouts,
      totalReps: totalReps,
      totalVolumeKg: totalVolume,
      totalHours: totalHours,
      totalCalories: totalCalories,
      dailyVolumeData: dailyVolumeData,
      weeklyVolumes: weeklyVolumes,
      monthlyVolumes: monthlyVolumes,
      workoutIntensityMap: workoutIntensityMap,
      weekdayDistribution: weekdayDistribution,
      weeklyAverage: weeklyAverage,
      recentPRs: recentPRs,
      allTimePRs: allTimePRs,
      bodyPartVolumes: bodyPartVolumes,
      bodyPartPercentages: bodyPartPercentages,
      topExercises: topExercises,
      exerciseFrequency: exerciseFrequency,
      exerciseProgressions: exerciseProgressions,
      exerciseProgressPercentages: exerciseProgressPercentages,
      formScoreData: formScoreData,
      perfectReps: repQuality['perfect'] ?? 0,
      goodReps: repQuality['good'] ?? 0,
      missReps: repQuality['miss'] ?? 0,
      formIQ: formIQ,
      avgFormScore: avgFormScore,
      longestPerfectStreak: longestPerfectStreak,
      measurements: measurements,
      weightData: weightData,
      progressPhotos: progressPhotos,
      measurementChanges: measurementChanges,
    );
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// HERO STATS QUERIES
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<int> _getTotalWorkouts(Database db, DateTime? startDate) async {
    try {
      final result = await db.rawQuery(
        startDate == null
            ? 'SELECT COUNT(*) as count FROM workout_sessions WHERE status = ?'
            : 'SELECT COUNT(*) as count FROM workout_sessions WHERE status = ? AND date >= ?',
        startDate == null ? ['complete'] : ['complete', startDate.toIso8601String()],
      );
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      return 0;
    }
  }
  
  static Future<int> _getTotalReps(Database db, DateTime? startDate) async {
    try {
      final result = await db.rawQuery(
        startDate == null
            ? 'SELECT SUM(total_reps) as total FROM workout_sessions WHERE status = ?'
            : 'SELECT SUM(total_reps) as total FROM workout_sessions WHERE status = ? AND date >= ?',
        startDate == null ? ['complete'] : ['complete', startDate.toIso8601String()],
      );
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      return 0;
    }
  }
  
  static Future<double> _getTotalVolume(Database db, DateTime? startDate) async {
    try {
      final result = await db.rawQuery(
        startDate == null
            ? '''
              SELECT SUM(CASE WHEN es.weight > 0 THEN es.weight * es.reps_completed ELSE es.reps_completed END) as volume
              FROM exercise_sets es
              JOIN workout_sessions ws ON es.session_id = ws.id
              WHERE ws.status = ?
            '''
            : '''
              SELECT SUM(CASE WHEN es.weight > 0 THEN es.weight * es.reps_completed ELSE es.reps_completed END) as volume
              FROM exercise_sets es
              JOIN workout_sessions ws ON es.session_id = ws.id
              WHERE ws.status = ? AND ws.date >= ?
            ''',
        startDate == null ? ['complete'] : ['complete', startDate.toIso8601String()],
      );
      return (result.first['volume'] as num?)?.toDouble() ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }
  
  static Future<double> _getTotalHours(Database db, DateTime? startDate) async {
    try {
      // Primary: use duration_minutes from workout_sessions
      final result = await db.rawQuery(
        startDate == null
            ? 'SELECT SUM(duration_minutes) as total FROM workout_sessions WHERE status = ?'
            : 'SELECT SUM(duration_minutes) as total FROM workout_sessions WHERE status = ? AND date >= ?',
        startDate == null ? ['complete'] : ['complete', startDate.toIso8601String()],
      );
      final totalMinutes = Sqflite.firstIntValue(result) ?? 0;

      if (totalMinutes > 0) return totalMinutes / 60.0;

      // Fallback: calculate from start_time and end_time
      final timeResult = await db.rawQuery(
        startDate == null
            ? '''SELECT SUM(
                  CAST((julianday(end_time) - julianday(start_time)) * 24 * 60 AS INTEGER)
                ) as total
                FROM workout_sessions
                WHERE status = ? AND start_time IS NOT NULL AND end_time IS NOT NULL'''
            : '''SELECT SUM(
                  CAST((julianday(end_time) - julianday(start_time)) * 24 * 60 AS INTEGER)
                ) as total
                FROM workout_sessions
                WHERE status = ? AND date >= ? AND start_time IS NOT NULL AND end_time IS NOT NULL''',
        startDate == null ? ['complete'] : ['complete', startDate.toIso8601String()],
      );
      final calcMinutes = Sqflite.firstIntValue(timeResult) ?? 0;

      if (calcMinutes > 0) return calcMinutes / 60.0;

      // Last fallback: estimate from workout count (45 min average)
      final countResult = await db.rawQuery(
        startDate == null
            ? 'SELECT COUNT(*) as count FROM workout_sessions WHERE status = ?'
            : 'SELECT COUNT(*) as count FROM workout_sessions WHERE status = ? AND date >= ?',
        startDate == null ? ['complete'] : ['complete', startDate.toIso8601String()],
      );
      final count = Sqflite.firstIntValue(countResult) ?? 0;

      return count * 0.75; // 45 min average per workout
    } catch (e) {
      return 0.0;
    }
  }
  
  static Future<int> _getTotalCalories(Database db, DateTime? startDate) async {
    try {
      final result = await db.rawQuery(
        startDate == null
            ? 'SELECT SUM(calories_burned) as total FROM workout_sessions WHERE status = ?'
            : 'SELECT SUM(calories_burned) as total FROM workout_sessions WHERE status = ? AND date >= ?',
        startDate == null ? ['complete'] : ['complete', startDate.toIso8601String()],
      );
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      return 0;
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// STREAK CALCULATIONS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<int> _getCurrentStreak(Database db) async {
    try {
      final result = await db.query(
        'workout_sessions',
        columns: ['date'],
        where: 'status = ?',
        whereArgs: ['complete'],
        orderBy: 'date DESC',
      );
      
      if (result.isEmpty) return 0;
      
      int streak = 0;
      DateTime? lastDate;
      final today = DateTime.now();
      
      for (var row in result) {
        final date = DateTime.parse(row['date'] as String);
        final dateOnly = DateTime(date.year, date.month, date.day);
        
        if (lastDate == null) {
          final todayOnly = DateTime(today.year, today.month, today.day);
          final diff = todayOnly.difference(dateOnly).inDays;
          
          if (diff > 1) return 0; // Streak broken
          streak = 1;
          lastDate = dateOnly;
        } else {
          final diff = lastDate.difference(dateOnly).inDays;
          if (diff == 1) {
            streak++;
            lastDate = dateOnly;
          } else if (diff == 0) {
            // Same day, skip
            continue;
          } else {
            break; // Streak broken
          }
        }
      }
      
      return streak;
    } catch (e) {
      return 0;
    }
  }
  
  static Future<int> _getLongestStreak(Database db) async {
    try {
      final result = await db.query(
        'workout_sessions',
        columns: ['date'],
        where: 'status = ?',
        whereArgs: ['complete'],
        orderBy: 'date ASC',
      );
      
      if (result.isEmpty) return 0;
      
      int longestStreak = 0;
      int currentStreak = 0;
      DateTime? lastDate;
      
      for (var row in result) {
        final date = DateTime.parse(row['date'] as String);
        final dateOnly = DateTime(date.year, date.month, date.day);
        
        if (lastDate == null) {
          currentStreak = 1;
        } else {
          final diff = dateOnly.difference(lastDate).inDays;
          if (diff == 1) {
            currentStreak++;
          } else if (diff > 1) {
            longestStreak = currentStreak > longestStreak ? currentStreak : longestStreak;
            currentStreak = 1;
          }
        }
        
        lastDate = dateOnly;
      }
      
      return currentStreak > longestStreak ? currentStreak : longestStreak;
    } catch (e) {
      return 0;
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// VOLUME DATA FOR CHARTS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<List<FlSpot>> _getDailyVolumeData(Database db, int days) async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: days));

      final results = await db.rawQuery('''
        SELECT date(ws.date) as day,
               SUM(es.weight * es.reps_completed) as volume
        FROM workout_sessions ws
        LEFT JOIN exercise_sets es ON ws.id = es.session_id
        WHERE ws.date >= ? AND ws.status = 'complete'
        GROUP BY date(ws.date)
        ORDER BY date(ws.date)
      ''', [startDate.toIso8601String()]);

      // Build a map of date -> volume
      final volumeMap = <String, double>{};
      for (final row in results) {
        final day = row['day'] as String;
        final volume = (row['volume'] as num?)?.toDouble() ?? 0.0;
        volumeMap[day] = volume;
      }

      // Generate ALL days in the range, fill missing days with 0
      final spots = <FlSpot>[];
      for (int i = 0; i < days; i++) {
        final date = startDate.add(Duration(days: i));
        final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        final volume = volumeMap[dateKey] ?? 0.0;
        spots.add(FlSpot(i.toDouble(), volume));
      }

      return spots;
    } catch (e) {
      return [];
    }
  }
  
  static Future<List<double>> _getWeeklyVolumes(Database db, int weeks) async {
    try {
      final results = await db.rawQuery('''
        SELECT strftime('%Y-%W', ws.date) as week,
               SUM(es.weight * es.reps_completed) as volume
        FROM workout_sessions ws
        LEFT JOIN exercise_sets es ON ws.id = es.session_id
        WHERE ws.date >= date('now', '-${weeks * 7} days') AND ws.status = 'complete'
        GROUP BY week
        ORDER BY week
      ''');
      
      return results.map((r) => (r['volume'] as num?)?.toDouble() ?? 0.0).toList();
    } catch (e) {
      return [];
    }
  }
  
  static Future<Map<String, double>> _getMonthlyVolumes(Database db, int months) async {
    try {
      final results = await db.rawQuery('''
        SELECT strftime('%Y-%m', ws.date) as month,
               SUM(es.weight * es.reps_completed) as volume
        FROM workout_sessions ws
        LEFT JOIN exercise_sets es ON ws.id = es.session_id
        WHERE ws.date >= date('now', '-$months months') AND ws.status = 'complete'
        GROUP BY month
        ORDER BY month
      ''');
      
      final map = <String, double>{};
      for (var r in results) {
        map[r['month'] as String] = (r['volume'] as num?)?.toDouble() ?? 0.0;
      }
      return map;
    } catch (e) {
      return {};
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// WORKOUT FREQUENCY DATA
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<Map<DateTime, double>> _getWorkoutIntensityMap(Database db, int days) async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: days));
      
      final results = await db.rawQuery('''
        SELECT date(ws.date) as day,
               SUM(es.weight * es.reps_completed) as volume
        FROM workout_sessions ws
        LEFT JOIN exercise_sets es ON ws.id = es.session_id
        WHERE ws.date >= ? AND ws.status = 'complete'
        GROUP BY date(ws.date)
      ''', [startDate.toIso8601String()]);
      
      if (results.isEmpty) return {};
      
      // Find max volume for normalization
      double maxVolume = 1.0;
      for (var r in results) {
        final volume = (r['volume'] as num?)?.toDouble() ?? 0.0;
        if (volume > maxVolume) maxVolume = volume;
      }
      
      final map = <DateTime, double>{};
      for (var r in results) {
        final date = DateTime.parse(r['day'] as String);
        final volume = (r['volume'] as num?)?.toDouble() ?? 0.0;
        map[DateTime(date.year, date.month, date.day)] = volume / maxVolume;
      }
      
      return map;
    } catch (e) {
      return {};
    }
  }
  
  static Future<Map<int, int>> _getWeekdayDistribution(Database db, DateTime? startDate) async {
    try {
      final results = await db.rawQuery(
        startDate == null
            ? '''
              SELECT strftime('%w', date) as weekday, COUNT(*) as count
              FROM workout_sessions
              WHERE status = 'complete'
              GROUP BY weekday
            '''
            : '''
              SELECT strftime('%w', date) as weekday, COUNT(*) as count
              FROM workout_sessions
              WHERE status = 'complete' AND date >= ?
              GROUP BY weekday
            ''',
        startDate == null ? [] : [startDate.toIso8601String()],
      );
      
      final map = <int, int>{};
      for (var r in results) {
        final weekday = int.parse(r['weekday'] as String);
        map[weekday] = r['count'] as int;
      }
      return map;
    } catch (e) {
      return {};
    }
  }
  
  static Future<double> _getWeeklyAverage(Database db) async {
    try {
      final result = await db.rawQuery('''
        SELECT COUNT(*) * 1.0 / 
               (julianday('now') - julianday(MIN(date))) * 7 as avg
        FROM workout_sessions
        WHERE status = 'complete'
      ''');
      return (result.first['avg'] as num?)?.toDouble() ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// PERSONAL RECORDS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<List<PersonalRecord>> _getRecentPRs(Database db, int limit) async {
    try {
      final results = await db.rawQuery('''
        SELECT exercise_name, weight, reps, e1rm, date, session_id
        FROM personal_records
        WHERE is_current = 1
        ORDER BY date DESC
        LIMIT ?
      ''', [limit]);
      
      return results.map((r) => PersonalRecord(
        exerciseName: r['exercise_name'] as String,
        weight: (r['weight'] as num).toDouble(),
        reps: r['reps'] as int,
        date: DateTime.parse(r['date'] as String),
        e1RM: (r['e1rm'] as num?)?.toDouble(),
      )).toList();
    } catch (e) {
      // Fallback: Get from exercise_sets
      return _getPRsFromSets(db, limit);
    }
  }
  
  static Future<List<PersonalRecord>> _getPRsFromSets(Database db, int limit) async {
    try {
      final results = await db.rawQuery('''
        SELECT pr.exercise_name, pr.weight, es.reps_completed as reps, ws.date
        FROM (
            SELECT exercise_name, MAX(weight) as weight
            FROM exercise_sets
            WHERE weight > 0
            GROUP BY exercise_name
        ) pr
        JOIN exercise_sets es ON es.exercise_name = pr.exercise_name AND es.weight = pr.weight
        JOIN workout_sessions ws ON es.session_id = ws.id
        WHERE ws.status = 'complete'
        GROUP BY pr.exercise_name
        ORDER BY ws.date DESC
        LIMIT ?
      ''', [limit]);

      return results.map((r) => PersonalRecord(
        exerciseName: r['exercise_name'] as String,
        weight: (r['weight'] as num).toDouble(),
        reps: r['reps'] as int,
        date: DateTime.parse(r['date'] as String),
      )).toList();
    } catch (e) {
      return [];
    }
  }
  
  static Future<List<PersonalRecord>> _getAllTimePRs(Database db) async {
    try {
      final results = await db.rawQuery('''
        SELECT pr.exercise_name, pr.weight, es.reps_completed as reps, ws.date
        FROM (
            SELECT exercise_name, MAX(weight) as weight
            FROM exercise_sets
            WHERE weight > 0
            GROUP BY exercise_name
        ) pr
        JOIN exercise_sets es ON es.exercise_name = pr.exercise_name AND es.weight = pr.weight
        JOIN workout_sessions ws ON es.session_id = ws.id
        WHERE ws.status = 'complete'
        GROUP BY pr.exercise_name
        ORDER BY pr.weight DESC
        LIMIT 20
      ''');

      return results.map((r) => PersonalRecord(
        exerciseName: r['exercise_name'] as String,
        weight: (r['weight'] as num).toDouble(),
        reps: r['reps'] as int,
        date: DateTime.parse(r['date'] as String),
        isAllTime: true,
      )).toList();
    } catch (e) {
      return [];
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// BODY PART ANALYSIS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static final _exerciseBodyPartMap = {
    // ═══════════════════════════════════════════════════════════════
    // CHEST
    // ═══════════════════════════════════════════════════════════════
    'bench_press': 'Chest', 'bench press': 'Chest',
    'incline_bench': 'Chest', 'incline bench': 'Chest',
    'incline_press': 'Chest', 'incline press': 'Chest',
    'incline_db': 'Chest',
    'decline_bench': 'Chest', 'decline bench': 'Chest',
    'decline_press': 'Chest', 'decline press': 'Chest',
    'push_up': 'Chest', 'push up': 'Chest', 'pushup': 'Chest', 'push ups': 'Chest',
    'chest_fly': 'Chest', 'chest fly': 'Chest',
    'chest_flye': 'Chest', 'chest_flys': 'Chest',
    'dumbbell_press': 'Chest', 'dumbbell press': 'Chest',
    'dumbbell_bench': 'Chest',
    'cable_crossover': 'Chest', 'cable crossover': 'Chest',
    'cable_fly': 'Chest', 'cable_flye': 'Chest',
    'pec_deck': 'Chest', 'pec deck': 'Chest',
    'machine_chest': 'Chest',
    'machine_fly': 'Chest',
    'close_grip_bench': 'Chest',
    'landmine_press': 'Chest',
    'jm_press': 'Chest',
    'dip': 'Chest', 'dips': 'Chest',
    'chest_dip': 'Chest',

    // ═══════════════════════════════════════════════════════════════
    // BACK
    // ═══════════════════════════════════════════════════════════════
    'deadlift': 'Back', 'deadlifts': 'Back',
    'pull_up': 'Back', 'pull up': 'Back', 'pullup': 'Back', 'pull ups': 'Back',
    'chin_up': 'Back', 'chin up': 'Back', 'chinup': 'Back',
    'lat_pulldown': 'Back', 'lat pulldown': 'Back',
    'cable_pulldown': 'Back',
    'row': 'Back', 'rows': 'Back',
    'bent_over_row': 'Back', 'bent over row': 'Back',
    'barbell_row': 'Back', 'barbell row': 'Back',
    'dumbbell_row': 'Back', 'dumbbell row': 'Back',
    'cable_row': 'Back', 'cable row': 'Back',
    'seated_row': 'Back', 'seated_cable_row': 'Back',
    'machine_row': 'Back',
    'chest_supported_row': 'Back',
    'tbar_row': 'Back', 't_bar_row': 'Back', 't bar row': 'Back',
    'pendlay_row': 'Back',
    'inverted_row': 'Back',
    'renegade_row': 'Back',
    'face_pull': 'Back', 'face pull': 'Back',
    'straight_arm_pulldown': 'Back',
    'muscle_up': 'Back',
    'back_extension': 'Back', 'hyperextension': 'Back',
    'reverse_hyper': 'Back',
    'good_morning': 'Back',
    'rack_pull': 'Back',

    // ═══════════════════════════════════════════════════════════════
    // SHOULDERS
    // ═══════════════════════════════════════════════════════════════
    'overhead_press': 'Shoulders', 'overhead press': 'Shoulders',
    'shoulder_press': 'Shoulders', 'shoulder press': 'Shoulders',
    'military_press': 'Shoulders', 'military press': 'Shoulders',
    'lateral_raise': 'Shoulders', 'lateral raise': 'Shoulders',
    'front_raise': 'Shoulders', 'front raise': 'Shoulders',
    'rear_delt': 'Shoulders', 'rear delt': 'Shoulders',
    'reverse_fly': 'Shoulders', 'reverse_flye': 'Shoulders',
    'upright_row': 'Shoulders', 'upright row': 'Shoulders',
    'arnold_press': 'Shoulders', 'arnold press': 'Shoulders',
    'push_press': 'Shoulders',
    'seated_db_press': 'Shoulders',
    'seated_dumbbell_press': 'Shoulders',
    'standing_dumbbell_press': 'Shoulders',
    'db_overhead_press': 'Shoulders',
    'machine_shoulder': 'Shoulders',
    'shrug': 'Shoulders', 'shrugs': 'Shoulders',
    'barbell_shrug': 'Shoulders',
    'dumbbell_shrug': 'Shoulders',
    'ohp': 'Shoulders',
    'standing_ohp': 'Shoulders',
    'pike_pushup': 'Shoulders', 'pike_push_up': 'Shoulders',

    // ═══════════════════════════════════════════════════════════════
    // ARMS
    // ═══════════════════════════════════════════════════════════════
    'bicep_curl': 'Arms', 'bicep curl': 'Arms',
    'bicep': 'Arms',
    'curl': 'Arms',
    'curls': 'Arms',
    'hammer_curl': 'Arms', 'hammer curl': 'Arms',
    'preacher_curl': 'Arms', 'preacher curl': 'Arms',
    'concentration_curl': 'Arms', 'concentration curl': 'Arms',
    'cable_curl': 'Arms', 'cable curl': 'Arms',
    'incline_curl': 'Arms',
    'spider_curl': 'Arms',
    'ez_bar_curl': 'Arms',
    'barbell_curl': 'Arms',
    'dumbbell_curl': 'Arms',
    'reverse_curl': 'Arms',
    'zottman_curl': 'Arms',
    '21s': 'Arms',
    'tricep_extension': 'Arms', 'tricep extension': 'Arms',
    'tricep_pushdown': 'Arms', 'tricep pushdown': 'Arms',
    'tricep': 'Arms',
    'skull_crusher': 'Arms', 'skull crusher': 'Arms',
    'overhead_tricep': 'Arms',
    'rope_pushdown': 'Arms',
    'cable_pushdown': 'Arms',
    'tricep_kickback': 'Arms',
    'dumbbell_kickback': 'Arms',
    'cable_tricep': 'Arms',
    'wrist_curl': 'Arms',
    'reverse_wrist': 'Arms',

    // ═══════════════════════════════════════════════════════════════
    // LEGS
    // ═══════════════════════════════════════════════════════════════
    'squat': 'Legs', 'squats': 'Legs',
    'back_squat': 'Legs',
    'front_squat': 'Legs',
    'goblet_squat': 'Legs', 'goblet squat': 'Legs',
    'leg_press': 'Legs', 'leg press': 'Legs',
    'lunge': 'Legs', 'lunges': 'Legs',
    'split_squat': 'Legs', 'bulgarian': 'Legs',
    'leg_extension': 'Legs', 'leg extension': 'Legs',
    'leg_curl': 'Legs', 'leg curl': 'Legs',
    'hamstring_curl': 'Legs', 'hamstring': 'Legs',
    'calf_raise': 'Legs', 'calf raise': 'Legs',
    'calf': 'Legs',
    'romanian_deadlift': 'Legs', 'romanian deadlift': 'Legs',
    'rdl': 'Legs',
    'hip_thrust': 'Legs', 'hip thrust': 'Legs',
    'glute_bridge': 'Legs', 'glute bridge': 'Legs',
    'glute': 'Legs',
    'step_up': 'Legs', 'step up': 'Legs',
    'box_jump': 'Legs',
    'jump_squat': 'Legs',
    'pistol_squat': 'Legs',
    'hack_squat': 'Legs',
    'sumo_squat': 'Legs', 'sumo_deadlift': 'Legs',
    'wall_sit': 'Legs',
    'nordic_curl': 'Legs',
    'donkey_kick': 'Legs',
    'fire_hydrant': 'Legs',
    'glute_kickback': 'Legs',
    'cable_kickback': 'Legs',
    'standing_glute_kickback': 'Legs',
    'frog_pump': 'Legs',
    'stiff_leg': 'Legs',
    'single_leg': 'Legs',
    'kettlebell_swing': 'Legs',
    'kb_swing': 'Legs',
    'cable_pull_through': 'Legs',

    // ═══════════════════════════════════════════════════════════════
    // CORE
    // ═══════════════════════════════════════════════════════════════
    'plank': 'Core', 'planks': 'Core',
    'crunch': 'Core', 'crunches': 'Core',
    'sit_up': 'Core', 'sit up': 'Core', 'situp': 'Core',
    'russian_twist': 'Core', 'russian twist': 'Core',
    'leg_raise': 'Core', 'leg raise': 'Core',
    'ab_wheel': 'Core', 'ab wheel': 'Core',
    'cable_crunch': 'Core', 'cable crunch': 'Core',
    'mountain_climber': 'Core', 'mountain climber': 'Core',
    'dead_bug': 'Core', 'dead bug': 'Core',
    'v_up': 'Core', 'v up': 'Core',
    'bicycle_crunch': 'Core',
    'flutter_kick': 'Core',
    'scissor_kick': 'Core',
    'wood_chop': 'Core', 'woodchop': 'Core',
    'pallof': 'Core',
    'side_plank': 'Core',
    'hollow': 'Core',
    'superman': 'Core',
    'bird_dog': 'Core',
    'oblique': 'Core',
    'hanging_leg_raise': 'Core',
    'windmill': 'Core',
    'l_sit': 'Core',
  };
  
  static Future<Map<String, double>> _getBodyPartVolumes(Database db, DateTime? startDate) async {
    try {
      final results = await db.rawQuery(
        startDate == null
            ? '''
              SELECT es.exercise_name, SUM(CASE WHEN es.weight > 0 THEN es.weight * es.reps_completed ELSE es.reps_completed END) as volume
              FROM exercise_sets es
              JOIN workout_sessions ws ON es.session_id = ws.id
              WHERE ws.status = 'complete'
              GROUP BY es.exercise_name
            '''
            : '''
              SELECT es.exercise_name, SUM(CASE WHEN es.weight > 0 THEN es.weight * es.reps_completed ELSE es.reps_completed END) as volume
              FROM exercise_sets es
              JOIN workout_sessions ws ON es.session_id = ws.id
              WHERE ws.status = 'complete' AND ws.date >= ?
              GROUP BY es.exercise_name
            ''',
        startDate == null ? [] : [startDate.toIso8601String()],
      );
      
      final bodyPartVolumes = <String, double>{
        'Chest': 0, 'Back': 0, 'Shoulders': 0, 'Arms': 0, 'Legs': 0, 'Core': 0,
      };

      for (var r in results) {
        final exerciseName = (r['exercise_name'] as String).toLowerCase();
        // Also create a space-separated version for matching
        final exerciseNameSpaced = exerciseName.replaceAll('_', ' ');
        final volume = (r['volume'] as num?)?.toDouble() ?? 0.0;

        if (volume <= 0) continue; // Skip zero-volume exercises

        String? bodyPart;
        int longestMatch = 0;

        // Find the LONGEST matching key (most specific match wins)
        for (var entry in _exerciseBodyPartMap.entries) {
          if ((exerciseName.contains(entry.key) || exerciseNameSpaced.contains(entry.key))
              && entry.key.length > longestMatch) {
            bodyPart = entry.value;
            longestMatch = entry.key.length;
          }
        }

        // Fallback: try to infer from keywords
        if (bodyPart == null) {
          if (exerciseName.contains('press') || exerciseName.contains('fly') || exerciseName.contains('push')) {
            bodyPart = 'Chest';
          } else if (exerciseName.contains('row') || exerciseName.contains('pull')) {
            bodyPart = 'Back';
          } else if (exerciseName.contains('curl') || exerciseName.contains('tricep')) {
            bodyPart = 'Arms';
          } else if (exerciseName.contains('squat') || exerciseName.contains('lunge') || exerciseName.contains('leg')) {
            bodyPart = 'Legs';
          }
        }

        // Only add if we have a body part match
        if (bodyPart != null) {
          bodyPartVolumes[bodyPart] = (bodyPartVolumes[bodyPart] ?? 0) + volume;
        }
      }

      return bodyPartVolumes;
    } catch (e) {
      return {};
    }
  }
  
  static Map<String, double> _calculateBodyPartPercentages(Map<String, double> volumes) {
    final total = volumes.values.fold<double>(0, (sum, v) => sum + v);
    if (total == 0) return {};
    
    return volumes.map((key, value) => MapEntry(key, (value / total) * 100));
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// TOP EXERCISES
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<List<ExerciseVolume>> _getTopExercises(Database db, DateTime? startDate, int limit) async {
    try {
      final results = await db.rawQuery(
        startDate == null
            ? '''
              SELECT es.exercise_name,
                     SUM(CASE WHEN es.weight > 0 THEN es.weight * es.reps_completed ELSE es.reps_completed END) as volume,
                     COUNT(*) as set_count,
                     SUM(es.reps_completed) as total_reps,
                     AVG(CASE WHEN es.weight > 0 THEN es.weight ELSE NULL END) as avg_weight
              FROM exercise_sets es
              JOIN workout_sessions ws ON es.session_id = ws.id
              WHERE ws.status = 'complete'
              GROUP BY es.exercise_name
              ORDER BY volume DESC
              LIMIT ?
            '''
            : '''
              SELECT es.exercise_name,
                     SUM(CASE WHEN es.weight > 0 THEN es.weight * es.reps_completed ELSE es.reps_completed END) as volume,
                     COUNT(*) as set_count,
                     SUM(es.reps_completed) as total_reps,
                     AVG(CASE WHEN es.weight > 0 THEN es.weight ELSE NULL END) as avg_weight
              FROM exercise_sets es
              JOIN workout_sessions ws ON es.session_id = ws.id
              WHERE ws.status = 'complete' AND ws.date >= ?
              GROUP BY es.exercise_name
              ORDER BY volume DESC
              LIMIT ?
            ''',
        startDate == null ? [limit] : [startDate.toIso8601String(), limit],
      );
      
      return results.map((r) => ExerciseVolume(
        exerciseName: r['exercise_name'] as String,
        totalVolume: (r['volume'] as num?)?.toDouble() ?? 0.0,
        setCount: r['set_count'] as int? ?? 0,
        totalReps: r['total_reps'] as int? ?? 0,
        avgWeight: (r['avg_weight'] as num?)?.toDouble() ?? 0.0,
      )).toList();
    } catch (e) {
      return [];
    }
  }
  
  static Future<Map<String, int>> _getExerciseFrequency(Database db, DateTime? startDate) async {
    try {
      final results = await db.rawQuery(
        startDate == null
            ? '''
              SELECT es.exercise_name, COUNT(DISTINCT ws.id) as frequency
              FROM exercise_sets es
              JOIN workout_sessions ws ON es.session_id = ws.id
              WHERE ws.status = 'complete'
              GROUP BY es.exercise_name
              ORDER BY frequency DESC
            '''
            : '''
              SELECT es.exercise_name, COUNT(DISTINCT ws.id) as frequency
              FROM exercise_sets es
              JOIN workout_sessions ws ON es.session_id = ws.id
              WHERE ws.status = 'complete' AND ws.date >= ?
              GROUP BY es.exercise_name
              ORDER BY frequency DESC
            ''',
        startDate == null ? [] : [startDate.toIso8601String()],
      );
      
      return {for (var r in results) r['exercise_name'] as String: r['frequency'] as int};
    } catch (e) {
      return {};
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// EXERCISE PROGRESSIONS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<Map<String, List<FlSpot>>> _getExerciseProgressions(Database db) async {
    try {
      // Dynamically find user's top exercises by frequency
      final topExerciseResults = await db.rawQuery('''
        SELECT es.exercise_name, COUNT(DISTINCT ws.id) as frequency
        FROM exercise_sets es
        JOIN workout_sessions ws ON es.session_id = ws.id
        WHERE ws.status = 'complete' AND es.weight > 0
        GROUP BY es.exercise_name
        ORDER BY frequency DESC
        LIMIT 6
      ''');

      final exercises = topExerciseResults
          .map((r) => r['exercise_name'] as String)
          .toList();

      // Fallback to Big 3 if no data
      if (exercises.isEmpty) {
        exercises.addAll(['Bench Press', 'Squat', 'Deadlift', 'Overhead Press', 'Barbell Row']);
      }

      final progressions = <String, List<FlSpot>>{};

      for (var exercise in exercises) {
        final results = await db.rawQuery('''
          SELECT date(ws.date) as day,
                 MAX(es.weight) as max_weight
          FROM exercise_sets es
          JOIN workout_sessions ws ON es.session_id = ws.id
          WHERE es.exercise_name = ? AND ws.status = 'complete'
          GROUP BY date(ws.date)
          ORDER BY date(ws.date)
          LIMIT 30
        ''', [exercise]);

        if (results.isNotEmpty) {
          final spots = <FlSpot>[];
          for (int i = 0; i < results.length; i++) {
            final weight = (results[i]['max_weight'] as num?)?.toDouble() ?? 0.0;
            spots.add(FlSpot(i.toDouble(), weight));
          }
          progressions[exercise] = spots;
        }
      }

      return progressions;
    } catch (e) {
      return {};
    }
  }
  
  static Map<String, double> _calculateProgressPercentages(Map<String, List<FlSpot>> progressions) {
    final percentages = <String, double>{};
    
    for (var entry in progressions.entries) {
      final spots = entry.value;
      if (spots.length >= 2) {
        final first = spots.first.y;
        final last = spots.last.y;
        if (first > 0) {
          percentages[entry.key] = ((last - first) / first) * 100;
        }
      }
    }
    
    return percentages;
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// FORM DATA (CAMERA MODE)
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<List<FlSpot>> _getFormScoreData(Database db, int days) async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: days));
      
      final results = await db.rawQuery('''
        SELECT date(ws.date) as day,
               AVG(es.form_score) as avg_score
        FROM exercise_sets es
        JOIN workout_sessions ws ON es.session_id = ws.id
        WHERE es.form_score > 0 AND ws.status = 'complete' AND ws.date >= ?
        GROUP BY date(ws.date)
        ORDER BY date(ws.date)
      ''', [startDate.toIso8601String()]);
      
      final spots = <FlSpot>[];
      for (int i = 0; i < results.length; i++) {
        final score = (results[i]['avg_score'] as num?)?.toDouble() ?? 0.0;
        spots.add(FlSpot(i.toDouble(), score));
      }
      
      return spots;
    } catch (e) {
      return [];
    }
  }
  
  static Future<Map<String, int>> _getRepQuality(Database db, DateTime? startDate) async {
    try {
      final results = await db.rawQuery(
        startDate == null
            ? '''
              SELECT SUM(perfect_reps) as perfect,
                     SUM(good_reps) as good,
                     SUM(missed_reps) as missed
              FROM exercise_sets es
              JOIN workout_sessions ws ON es.session_id = ws.id
              WHERE ws.status = 'complete'
            '''
            : '''
              SELECT SUM(perfect_reps) as perfect,
                     SUM(good_reps) as good,
                     SUM(missed_reps) as missed
              FROM exercise_sets es
              JOIN workout_sessions ws ON es.session_id = ws.id
              WHERE ws.status = 'complete' AND ws.date >= ?
            ''',
        startDate == null ? [] : [startDate.toIso8601String()],
      );
      
      if (results.isEmpty) return {'perfect': 0, 'good': 0, 'miss': 0};
      
      return {
        'perfect': (results.first['perfect'] as num?)?.toInt() ?? 0,
        'good': (results.first['good'] as num?)?.toInt() ?? 0,
        'miss': (results.first['missed'] as num?)?.toInt() ?? 0,
      };
    } catch (e) {
      return {'perfect': 0, 'good': 0, 'miss': 0};
    }
  }
  
  static Future<int> _calculateFormIQ(Database db) async {
    try {
      final quality = await _getRepQuality(db, null);
      final total = quality.values.fold<int>(0, (sum, v) => sum + v);
      
      if (total == 0) return 0;
      
      final perfectPercent = quality['perfect']! / total;
      final goodPercent = quality['good']! / total;
      
      // Form IQ = weighted score (perfect = 100%, good = 70%, miss = 0%)
      final score = (perfectPercent * 100 + goodPercent * 70);
      
      return score.toInt();
    } catch (e) {
      return 0;
    }
  }
  
  static Future<int> _getLongestPerfectStreak(Database db) async {
    try {
      final result = await db.rawQuery('''
        SELECT MAX(max_combo) as longest
        FROM exercise_sets
      ''');
      return (result.first['longest'] as num?)?.toInt() ?? 0;
    } catch (e) {
      return 0;
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// BODY MEASUREMENTS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<List<BodyMeasurement>> _getMeasurements(Database db, int limit) async {
    try {
      final results = await db.query(
        'body_measurements',
        orderBy: 'date DESC',
        limit: limit,
      );
      
      return results.map((r) => BodyMeasurement.fromJson(r)).toList();
    } catch (e) {
      return [];
    }
  }
  
  static Future<List<FlSpot>> _getWeightData(Database db, int days) async {
    try {
      final startDate = DateTime.now().subtract(Duration(days: days));
      
      final results = await db.query(
        'body_measurements',
        columns: ['date', 'weight'],
        where: 'weight IS NOT NULL AND date >= ?',
        whereArgs: [startDate.toIso8601String()],
        orderBy: 'date ASC',
      );
      
      final spots = <FlSpot>[];
      for (int i = 0; i < results.length; i++) {
        final weight = (results[i]['weight'] as num?)?.toDouble() ?? 0.0;
        spots.add(FlSpot(i.toDouble(), weight));
      }
      
      return spots;
    } catch (e) {
      return [];
    }
  }
  
  static Future<List<ProgressPhoto>> _getProgressPhotos(Database db) async {
    try {
      final results = await db.query(
        'progress_photos',
        orderBy: 'date DESC',
      );
      
      return results.map((r) => ProgressPhoto.fromJson({
        'id': r['id'],
        'date': r['date'],
        'imagePath': r['image_path'],
        'type': r['type'],
        'associatedMeasurementId': r['measurement_id'],
        'notes': r['notes'],
      })).toList();
    } catch (e) {
      return [];
    }
  }
  
  static Future<Map<String, double>> _getMeasurementChanges(Database db) async {
    try {
      final results = await db.query(
        'body_measurements',
        orderBy: 'date ASC',
        limit: 100,
      );
      
      if (results.length < 2) return {};
      
      final first = BodyMeasurement.fromJson(results.first);
      final last = BodyMeasurement.fromJson(results.last);
      
      return last.getChanges(first).map((key, value) => 
        MapEntry(key, value ?? 0.0)
      );
    } catch (e) {
      return {};
    }
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// MEASUREMENT CRUD OPERATIONS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<void> saveMeasurement(BodyMeasurement measurement) async {
    final db = await database;
    
    // Ensure table exists before inserting
    await _ensureTablesExist(db);
    
    try {
      await db.insert(
        'body_measurements',
        {
          'id': measurement.id,
          'date': measurement.date.toIso8601String(),
          'weight': measurement.weight,
          'body_fat': measurement.bodyFat,
          'chest': measurement.chest,
          'arms': measurement.arms,
          'forearms': measurement.forearms,
          'waist': measurement.waist,
          'hips': measurement.hips,
          'thighs': measurement.thighs,
          'calves': measurement.calves,
          'shoulders': measurement.shoulders,
          'neck': measurement.neck,
          'notes': measurement.notes,
          'created_at': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('Error saving measurement: $e');
      rethrow;
    }
  }
  
  static Future<void> deleteMeasurement(String id) async {
    final db = await database;
    await db.delete('body_measurements', where: 'id = ?', whereArgs: [id]);
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// PHOTO CRUD OPERATIONS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  static Future<void> saveProgressPhoto(ProgressPhoto photo) async {
    final db = await database;
    
    // Ensure table exists before inserting
    await _ensureTablesExist(db);
    
    try {
      await db.insert(
        'progress_photos',
        {
          'id': photo.id,
          'date': photo.date.toIso8601String(),
          'image_path': photo.imagePath,
          'type': photo.type,
          'measurement_id': photo.associatedMeasurementId,
          'notes': photo.notes,
          'created_at': DateTime.now().toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('Error saving progress photo: $e');
      rethrow;
    }
  }
  
  static Future<void> deleteProgressPhoto(String id) async {
    final db = await database;
    await db.delete('progress_photos', where: 'id = ?', whereArgs: [id]);
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// NEW METHODS FOR HOME TAB & WORKOUTS TAB
  /// ═══════════════════════════════════════════════════════════════════════════
  
  /// Get workouts completed this week
  static Future<int> getWorkoutsThisWeek() async {
    try {
      final db = await database;
      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      final weekStartStr = DateTime(weekStart.year, weekStart.month, weekStart.day).toIso8601String();
      
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM workout_sessions WHERE date >= ? AND status = ?',
        [weekStartStr, 'complete'],
      );
      
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      debugPrint('Error getting workouts this week: $e');
      return 0;
    }
  }
  
  /// Get recent PRs (last 7 days)
  static Future<List<PersonalRecord>> getRecentPRs({int days = 7}) async {
    try {
      final db = await database;
      final cutoffDate = DateTime.now().subtract(Duration(days: days));
      
      final results = await db.rawQuery('''
        SELECT exercise_name, weight, reps, e1rm, date, session_id
        FROM personal_records
        WHERE is_current = 1 AND date >= ?
        ORDER BY date DESC
      ''', [cutoffDate.toIso8601String()]);
      
      return results.map((r) => PersonalRecord(
        exerciseName: r['exercise_name'] as String,
        weight: (r['weight'] as num).toDouble(),
        reps: r['reps'] as int,
        date: DateTime.parse(r['date'] as String),
        e1RM: (r['e1rm'] as num?)?.toDouble(),
      )).toList();
    } catch (e) {
      debugPrint('Error getting recent PRs: $e');
      return [];
    }
  }
  
  /// Get last 10 completed workouts for history
  static Future<List<WorkoutSummary>> getRecentWorkoutHistory({int limit = 10}) async {
    try {
      final db = await database;
      
      final results = await db.rawQuery('''
        SELECT 
          id,
          name,
          date,
          duration_minutes,
          total_reps,
          total_volume,
          calories_burned,
          workout_mode
        FROM workout_sessions
        WHERE status = 'complete'
        ORDER BY date DESC
        LIMIT ?
      ''', [limit]);
      
      return results.map((r) => WorkoutSummary(
        id: r['id'] as String,
        name: r['name'] as String,
        date: DateTime.parse(r['date'] as String),
        durationMinutes: r['duration_minutes'] as int? ?? 0,
        totalReps: r['total_reps'] as int? ?? 0,
        totalVolume: (r['total_volume'] as num?)?.toDouble() ?? 0.0,
        caloriesBurned: r['calories_burned'] as int? ?? 0,
        workoutMode: r['workout_mode'] as String?,
      )).toList();
    } catch (e) {
      debugPrint('Error getting recent workout history: $e');
      return [];
    }
  }
  
  /// Get detailed breakdown of a single workout session
  static Future<WorkoutSessionDetail?> getWorkoutSessionDetail(String sessionId) async {
    try {
      final db = await database;
      
      // Get session info
      final sessionResults = await db.query(
        'workout_sessions',
        where: 'id = ?',
        whereArgs: [sessionId],
      );
      
      if (sessionResults.isEmpty) return null;
      final session = sessionResults.first;
      
      // Get all sets for this session
      final setResults = await db.query(
        'exercise_sets',
        where: 'session_id = ?',
        whereArgs: [sessionId],
        orderBy: 'exercise_name, set_number',
      );
      
      // Group sets by exercise
      final exerciseGroups = <String, List<Map<String, dynamic>>>{};
      for (final set in setResults) {
        final exerciseName = set['exercise_name'] as String;
        if (!exerciseGroups.containsKey(exerciseName)) {
          exerciseGroups[exerciseName] = [];
        }
        exerciseGroups[exerciseName]!.add(set);
      }
      
      return WorkoutSessionDetail(
        id: session['id'] as String,
        name: session['name'] as String,
        date: DateTime.parse(session['date'] as String),
        durationMinutes: session['duration_minutes'] as int? ?? 0,
        totalReps: session['total_reps'] as int? ?? 0,
        totalVolume: (session['total_volume'] as num?)?.toDouble() ?? 0.0,
        caloriesBurned: session['calories_burned'] as int? ?? 0,
        workoutMode: session['workout_mode'] as String?,
        exerciseSets: exerciseGroups,
      );
    } catch (e) {
      debugPrint('Error getting workout session detail: $e');
      return null;
    }
  }
  
  // ============================================================================
  // EXERCISE-SPECIFIC ANALYTICS (for Pro Logger Exercise Detail Screen)
  // ============================================================================
  
  /// Get exercise history across all workout modes (Auto/Visual Guide/Pro Logger)
  static Future<List<ExerciseHistoryEntry>> getExerciseHistory(String exerciseName) async {
    try {
      final db = await database;
      
      // Get all sets for this exercise, ordered by date
      final results = await db.rawQuery('''
        SELECT 
          es.*,
          ws.date as workout_date,
          ws.workout_mode
        FROM exercise_sets es
        INNER JOIN workout_sessions ws ON es.session_id = ws.id
        WHERE LOWER(es.exercise_name) = LOWER(?)
        ORDER BY ws.date DESC
      ''', [exerciseName]);
      
      // Group by session
      final Map<String, List<Map<String, dynamic>>> sessionGroups = {};
      for (final row in results) {
        final sessionId = row['session_id'] as String;
        if (!sessionGroups.containsKey(sessionId)) {
          sessionGroups[sessionId] = [];
        }
        sessionGroups[sessionId]!.add(row);
      }
      
      // Convert to ExerciseHistoryEntry objects
      final entries = <ExerciseHistoryEntry>[];
      for (final sessionId in sessionGroups.keys) {
        final sets = sessionGroups[sessionId]!;
        final firstSet = sets.first;
        
        entries.add(ExerciseHistoryEntry(
          sessionId: sessionId,
          date: DateTime.parse(firstSet['workout_date'] as String),
          workoutMode: firstSet['workout_mode'] as String?,
          sets: sets.map((set) => ExerciseSetDetail(
            setNumber: set['set_number'] as int,
            weight: (set['weight'] as num?)?.toDouble() ?? 0.0,
            reps: set['reps_completed'] as int? ?? 0,
            formScore: (set['form_score'] as num?)?.toDouble(),
            volume: ((set['weight'] as num?)?.toDouble() ?? 0.0) * (set['reps_completed'] as int? ?? 0),
          )).toList(),
        ));
      }
      
      return entries;
    } catch (e) {
      debugPrint('Error getting exercise history: $e');
      return [];
    }
  }
  
  /// Get exercise personal records
  static Future<ExercisePersonalRecords> getExercisePersonalRecords(String exerciseName) async {
    try {
      final db = await database;
      
      // Heaviest weight (single rep)
      final heaviestResult = await db.rawQuery('''
        SELECT MAX(weight) as max_weight, reps_completed
        FROM exercise_sets
        WHERE LOWER(exercise_name) = LOWER(?)
        GROUP BY weight
        ORDER BY weight DESC
        LIMIT 1
      ''', [exerciseName]);
      
      final heaviestWeight = (heaviestResult.isNotEmpty) 
          ? (heaviestResult.first['max_weight'] as num?)?.toDouble() ?? 0.0
          : 0.0;
      
      // Best 1RM (using Brzycki formula: weight × (36 / (37 - reps)))
      final best1rmResult = await db.rawQuery('''
        SELECT weight, reps_completed
        FROM exercise_sets
        WHERE LOWER(exercise_name) = LOWER(?) AND weight > 0 AND reps_completed > 0
        ORDER BY (weight * (36.0 / (37.0 - reps_completed))) DESC
        LIMIT 1
      ''', [exerciseName]);
      
      double best1rm = 0.0;
      if (best1rmResult.isNotEmpty) {
        final weight = (best1rmResult.first['weight'] as num?)?.toDouble() ?? 0.0;
        final reps = best1rmResult.first['reps_completed'] as int? ?? 0;
        if (reps > 0 && reps < 37) {
          best1rm = weight * (36.0 / (37.0 - reps));
        }
      }
      
      // Best set volume (weight × reps)
      final bestSetVolumeResult = await db.rawQuery('''
        SELECT weight, reps_completed, (weight * reps_completed) as volume
        FROM exercise_sets
        WHERE LOWER(exercise_name) = LOWER(?)
        ORDER BY volume DESC
        LIMIT 1
      ''', [exerciseName]);
      
      final bestSetVolume = (bestSetVolumeResult.isNotEmpty)
          ? (bestSetVolumeResult.first['volume'] as num?)?.toDouble() ?? 0.0
          : 0.0;
      final bestSetVolumeWeight = (bestSetVolumeResult.isNotEmpty)
          ? (bestSetVolumeResult.first['weight'] as num?)?.toDouble() ?? 0.0
          : 0.0;
      final bestSetVolumeReps = (bestSetVolumeResult.isNotEmpty)
          ? bestSetVolumeResult.first['reps_completed'] as int? ?? 0
          : 0;
      
      // Best session volume (sum of all sets in a session)
      final bestSessionVolumeResult = await db.rawQuery('''
        SELECT 
          session_id,
          SUM(weight * reps_completed) as total_volume
        FROM exercise_sets
        WHERE LOWER(exercise_name) = LOWER(?)
        GROUP BY session_id
        ORDER BY total_volume DESC
        LIMIT 1
      ''', [exerciseName]);
      
      final bestSessionVolume = (bestSessionVolumeResult.isNotEmpty)
          ? (bestSessionVolumeResult.first['total_volume'] as num?)?.toDouble() ?? 0.0
          : 0.0;
      
      return ExercisePersonalRecords(
        heaviestWeight: heaviestWeight,
        best1rm: best1rm,
        bestSetVolume: bestSetVolume,
        bestSetVolumeWeight: bestSetVolumeWeight,
        bestSetVolumeReps: bestSetVolumeReps,
        bestSessionVolume: bestSessionVolume,
      );
    } catch (e) {
      debugPrint('Error getting exercise PRs: $e');
      return ExercisePersonalRecords(
        heaviestWeight: 0.0,
        best1rm: 0.0,
        bestSetVolume: 0.0,
        bestSetVolumeWeight: 0.0,
        bestSetVolumeReps: 0,
        bestSessionVolume: 0.0,
      );
    }
  }
  
  /// Get exercise progress data for chart (weight and reps over time)
  static Future<List<ExerciseProgressPoint>> getExerciseProgressData(String exerciseName, {int daysBack = 90}) async {
    try {
      final db = await database;
      final startDate = DateTime.now().subtract(Duration(days: daysBack));
      
      // Get average weight and reps per workout session
      final results = await db.rawQuery('''
        SELECT 
          ws.date,
          AVG(es.weight) as avg_weight,
          AVG(es.reps_completed) as avg_reps,
          MAX(es.weight) as max_weight
        FROM exercise_sets es
        INNER JOIN workout_sessions ws ON es.session_id = ws.id
        WHERE LOWER(es.exercise_name) = LOWER(?) AND ws.date >= ?
        GROUP BY ws.date
        ORDER BY ws.date ASC
      ''', [exerciseName, startDate.toIso8601String()]);
      
      return results.map((row) => ExerciseProgressPoint(
        date: DateTime.parse(row['date'] as String),
        avgWeight: (row['avg_weight'] as num?)?.toDouble() ?? 0.0,
        avgReps: (row['avg_reps'] as num?)?.toDouble() ?? 0.0,
        maxWeight: (row['max_weight'] as num?)?.toDouble() ?? 0.0,
      )).toList();
    } catch (e) {
      debugPrint('Error getting exercise progress data: $e');
      return [];
    }
  }
}

/// Helper model for workout summary in history
class WorkoutSummary {
  final String id;
  final String name;
  final DateTime date;
  final int durationMinutes;
  final int totalReps;
  final double totalVolume;
  final int caloriesBurned;
  final String? workoutMode;
  
  WorkoutSummary({
    required this.id,
    required this.name,
    required this.date,
    required this.durationMinutes,
    required this.totalReps,
    required this.totalVolume,
    required this.caloriesBurned,
    this.workoutMode,
  });
}

/// Helper model for detailed workout session
class WorkoutSessionDetail {
  final String id;
  final String name;
  final DateTime date;
  final int durationMinutes;
  final int totalReps;
  final double totalVolume;
  final int caloriesBurned;
  final String? workoutMode;
  final Map<String, List<Map<String, dynamic>>> exerciseSets;
  
  WorkoutSessionDetail({
    required this.id,
    required this.name,
    required this.date,
    required this.durationMinutes,
    required this.totalReps,
    required this.totalVolume,
    required this.caloriesBurned,
    this.workoutMode,
    required this.exerciseSets,
  });
}

/// Exercise history entry
class ExerciseHistoryEntry {
  final String sessionId;
  final DateTime date;
  final String? workoutMode;
  final List<ExerciseSetDetail> sets;
  
  ExerciseHistoryEntry({
    required this.sessionId,
    required this.date,
    this.workoutMode,
    required this.sets,
  });
  
  double get totalVolume => sets.fold(0.0, (sum, set) => sum + set.volume);
  double get avgWeight => sets.isEmpty ? 0.0 : sets.map((s) => s.weight).reduce((a, b) => a + b) / sets.length;
  int get totalReps => sets.fold(0, (sum, set) => sum + set.reps);
}

/// Exercise set detail
class ExerciseSetDetail {
  final int setNumber;
  final double weight;
  final int reps;
  final double? formScore;
  final double volume;
  
  ExerciseSetDetail({
    required this.setNumber,
    required this.weight,
    required this.reps,
    this.formScore,
    required this.volume,
  });
}

/// Exercise personal records
class ExercisePersonalRecords {
  final double heaviestWeight;
  final double best1rm;
  final double bestSetVolume;
  final double bestSetVolumeWeight;
  final int bestSetVolumeReps;
  final double bestSessionVolume;
  
  ExercisePersonalRecords({
    required this.heaviestWeight,
    required this.best1rm,
    required this.bestSetVolume,
    required this.bestSetVolumeWeight,
    required this.bestSetVolumeReps,
    required this.bestSessionVolume,
  });
}

/// Exercise progress point for charts
class ExerciseProgressPoint {
  final DateTime date;
  final double avgWeight;
  final double avgReps;
  final double maxWeight;
  
  ExerciseProgressPoint({
    required this.date,
    required this.avgWeight,
    required this.avgReps,
    required this.maxWeight,
  });
}


/// ═══════════════════════════════════════════════════════════════════════════
/// PUBLIC STAT METHODS FOR STATS PROVIDER
/// ═══════════════════════════════════════════════════════════════════════════
extension AnalyticsServiceStats on AnalyticsService {
  /// Get total completed workouts
  Future<int> getTotalWorkouts() async {
    final db = await AnalyticsService.database;
    return await AnalyticsService._getTotalWorkouts(db, null);
  }
  
  /// Get current streak
  Future<int> getCurrentStreak() async {
    final db = await AnalyticsService.database;
    return await AnalyticsService._getCurrentStreak(db);
  }
  
  /// Get longest streak
  Future<int> getLongestStreak() async {
    final db = await AnalyticsService.database;
    return await AnalyticsService._getLongestStreak(db);
  }
  
  /// Get total reps this week
  Future<int> getTotalRepsThisWeek() async {
    final db = await AnalyticsService.database;
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekStartDate = DateTime(weekStart.year, weekStart.month, weekStart.day);
    
    final result = await db.rawQuery(
      'SELECT SUM(total_reps) as total FROM workout_sessions WHERE date >= ? AND status = ?',
      [weekStartDate.toIso8601String(), 'complete'],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
  
  /// Get total reps last week
  Future<int> getTotalRepsLastWeek() async {
    final db = await AnalyticsService.database;
    final now = DateTime.now();
    final thisWeekStart = now.subtract(Duration(days: now.weekday - 1));
    final lastWeekStart = thisWeekStart.subtract(const Duration(days: 7));
    final lastWeekStartDate = DateTime(lastWeekStart.year, lastWeekStart.month, lastWeekStart.day);
    final lastWeekEndDate = DateTime(thisWeekStart.year, thisWeekStart.month, thisWeekStart.day);
    
    final result = await db.rawQuery(
      'SELECT SUM(total_reps) as total FROM workout_sessions WHERE date >= ? AND date < ? AND status = ?',
      [lastWeekStartDate.toIso8601String(), lastWeekEndDate.toIso8601String(), 'complete'],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
  
  /// Get workouts this week (already exists as static, adding instance method)
  Future<int> getWorkoutsThisWeek() async {
    return await AnalyticsService.getWorkoutsThisWeek();
  }
  
  /// Get total training minutes
  Future<int> getTotalTrainingMinutes() async {
    final db = await AnalyticsService.database;
    final result = await db.rawQuery(
      'SELECT SUM(duration_minutes) as total FROM workout_sessions WHERE status = ?',
      ['complete'],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }
  
  /// Get total lifetime reps
  Future<int> getTotalLifetimeReps() async {
    final db = await AnalyticsService.database;
    return await AnalyticsService._getTotalReps(db, null);
  }
  
  /// Get average form score
  Future<double> getAverageFormScore() async {
    final db = await AnalyticsService.database;
    final result = await db.rawQuery(
      'SELECT AVG(avg_form_score) as avg FROM workout_sessions WHERE status = ? AND avg_form_score > 0',
      ['complete'],
    );
    return (result.first['avg'] as num?)?.toDouble() ?? 0.0;
  }
  
  /// Get last workout date
  Future<DateTime?> getLastWorkoutDate() async {
    final db = await AnalyticsService.database;
    final result = await db.rawQuery(
      'SELECT date FROM workout_sessions WHERE status = ? ORDER BY date DESC LIMIT 1',
      ['complete'],
    );
    if (result.isEmpty) return null;
    return DateTime.parse(result.first['date'] as String);
  }
}

