import 'package:flutter/foundation.dart';
import '../models/exercise_set_data.dart';
import '../features/analytics/services/analytics_service.dart';
import 'supabase_sync_service.dart';
import 'storage_service.dart';
import 'calorie_calculation_service.dart';
import 'muscle_recovery_service.dart';

/// Workout mode enum
enum WorkoutMode {
  autoCamera,
  visualGuide,
  proLogger,
}

extension WorkoutModeExtension on WorkoutMode {
  String get name {
    switch (this) {
      case WorkoutMode.autoCamera:
        return 'auto_camera';
      case WorkoutMode.visualGuide:
        return 'visual_guide';
      case WorkoutMode.proLogger:
        return 'pro_logger';
    }
  }
  
  String get displayName {
    switch (this) {
      case WorkoutMode.autoCamera:
        return 'Auto Mode';
      case WorkoutMode.visualGuide:
        return 'Visual Guide';
      case WorkoutMode.proLogger:
        return 'Pro Logger';
    }
  }
}

/// Unified service to save completed workouts from all 3 modes
/// Handles: Auto Mode, Visual Guide, Pro Logger
class UnifiedWorkoutSaveService {
  /// Save a completed workout to the database
  /// Returns a map with 'success' (bool) and 'caloriesBurned' (int)
  static Future<Map<String, dynamic>> saveCompletedWorkout({
    required String workoutName,
    required WorkoutMode mode,
    required DateTime startTime,
    required DateTime endTime,
    required List<ExerciseSetData> exerciseSets,
    String? notes,
    String? sessionId,
  }) async {
    try {
      debugPrint('💾 Saving workout: $workoutName (${mode.displayName})');
      
      // Generate session ID if not provided
      final finalSessionId = sessionId ?? DateTime.now().millisecondsSinceEpoch.toString();
      
      // Calculate stats
      final duration = endTime.difference(startTime);
      final durationMinutes = duration.inMinutes > 0 ? duration.inMinutes : (duration.inSeconds / 60.0).ceil().clamp(1, 999);
      final totalReps = exerciseSets.fold<int>(0, (sum, set) => sum + set.repsCompleted);
      final totalVolume = _calculateTotalVolume(exerciseSets);
      final caloriesBurned = await _calculateCalories(
        exerciseSets: exerciseSets,
        duration: duration,
      );
      
      // Calculate form metrics (only for camera mode)
      final avgFormScore = mode == WorkoutMode.autoCamera
          ? _calculateAverageFormScore(exerciseSets)
          : 0.0;
      final perfectReps = exerciseSets.fold<int>(0, (sum, set) => sum + set.perfectReps);
      
      debugPrint('📊 Stats: $totalReps reps, ${totalVolume.toStringAsFixed(1)}kg volume, $caloriesBurned cal, $durationMinutes min');
      
      // Get database
      final db = await AnalyticsService.database;
      
      // Save workout session
      await db.insert(
        'workout_sessions',
        {
          'id': finalSessionId,
          'name': workoutName,
          'date': startTime.toIso8601String(),
          'start_time': startTime.toIso8601String(),
          'end_time': endTime.toIso8601String(),
          'duration_minutes': durationMinutes,
          'status': 'complete',
          'total_reps': totalReps,
          'total_volume': totalVolume,
          'avg_form_score': avgFormScore,
          'perfect_reps': perfectReps,
          'calories_burned': caloriesBurned,
          'workout_mode': mode.name,
          'notes': notes,
          'created_at': DateTime.now().toIso8601String(),
        },
      );
      
      debugPrint('✅ Session saved: $finalSessionId');
      
      // Save all exercise sets
      for (final set in exerciseSets) {
        await db.insert('exercise_sets', set.toMap()..['session_id'] = finalSessionId);
      }
      
      debugPrint('✅ Saved ${exerciseSets.length} exercise sets');
      
      // Update personal records
      await _updatePersonalRecords(db, exerciseSets, finalSessionId, startTime);
      
      debugPrint('✅ Workout saved successfully!');

      // Track muscle recovery - now with muscle data from exercises
      final exerciseNames = exerciseSets.map((e) => e.exerciseName).toSet().toList();

      // Build muscle data map from exercise sets
      final Map<String, List<String>> exerciseMuscleData = {};
      for (final set in exerciseSets) {
        if (set.primaryMuscles.isNotEmpty && !exerciseMuscleData.containsKey(set.exerciseName)) {
          exerciseMuscleData[set.exerciseName] = set.primaryMuscles;
        }
      }

      MuscleRecoveryService.recordWorkout(
        exerciseNames,
        exerciseMuscleData: exerciseMuscleData.isNotEmpty ? exerciseMuscleData : null,
      ).then((_) {
        debugPrint('💪 Muscle recovery tracked for: ${exerciseNames.join(", ")}');
      });
      
      // Sync to Supabase in background (don't wait for it)
      SupabaseSyncService.syncWorkoutSession(finalSessionId).then((success) {
        if (success) {
          debugPrint('☁️  Workout synced to cloud');
        } else {
          debugPrint('⚠️  Cloud sync skipped (user not logged in or error)');
        }
      });
      
      return {'success': true, 'caloriesBurned': caloriesBurned};
    } catch (e) {
      debugPrint('❌ Error saving workout: $e');
      debugPrint('Stack trace: ${StackTrace.current}');
      return {'success': false, 'caloriesBurned': 0};
    }
  }
  
  /// Calculate total volume (weight × reps) in kg
  static double _calculateTotalVolume(List<ExerciseSetData> sets) {
    return sets.fold<double>(0, (sum, set) {
      final weight = set.weight ?? 0.0;
      return sum + (weight * set.repsCompleted);
    });
  }
  
  /// Calculate calories burned using MET-based formula
  /// Now uses user's actual bodyweight and exercise-specific MET values
  static Future<int> _calculateCalories({
    required List<ExerciseSetData> exerciseSets,
    required Duration duration,
  }) async {
    // Get user weight from storage
    final userWeight = await StorageService.getUserWeight() ?? 70.0; // Default to 70kg
    
    // Use new science-based calorie calculation service
    return CalorieCalculationService.calculateActualCalories(
      exerciseSets: exerciseSets,
      duration: duration,
      userWeightKg: userWeight,
    );
  }
  
  /// Calculate average form score
  static double _calculateAverageFormScore(List<ExerciseSetData> sets) {
    final setsWithFormData = sets.where((set) => set.formScore > 0).toList();
    if (setsWithFormData.isEmpty) return 0.0;
    
    final totalScore = setsWithFormData.fold<double>(0, (sum, set) => sum + set.formScore);
    return totalScore / setsWithFormData.length;
  }
  
  /// Update personal records if any PRs were achieved
  static Future<void> _updatePersonalRecords(
    dynamic db,
    List<ExerciseSetData> sets,
    String sessionId,
    DateTime date,
  ) async {
    // Group sets by exercise
    final exerciseGroups = <String, List<ExerciseSetData>>{};
    for (final set in sets) {
      if (!exerciseGroups.containsKey(set.exerciseName)) {
        exerciseGroups[set.exerciseName] = [];
      }
      exerciseGroups[set.exerciseName]!.add(set);
    }
    
    // Check each exercise for PRs
    for (final entry in exerciseGroups.entries) {
      final exerciseName = entry.key;
      final exerciseSets = entry.value;
      
      // Find max weight for this exercise in this workout
      final maxWeightSet = exerciseSets.reduce((a, b) => 
        (a.weight ?? 0) > (b.weight ?? 0) ? a : b
      );
      
      final weight = maxWeightSet.weight ?? 0.0;
      if (weight == 0) continue; // Skip bodyweight exercises
      
      // Check if this is a PR
      final existingPRs = await db.query(
        'personal_records',
        where: 'exercise_name = ? AND is_current = 1',
        whereArgs: [exerciseName],
        orderBy: 'weight DESC',
        limit: 1,
      );
      
      final isNewPR = existingPRs.isEmpty || 
                      (existingPRs.first['weight'] as double) < weight;
      
      if (isNewPR) {
        debugPrint('🏆 NEW PR: $exerciseName - ${weight}kg × ${maxWeightSet.repsCompleted}');
        
        // Mark old PRs as not current
        if (existingPRs.isNotEmpty) {
          await db.update(
            'personal_records',
            {'is_current': 0},
            where: 'exercise_name = ? AND is_current = 1',
            whereArgs: [exerciseName],
          );
        }
        
        // Insert new PR
        await db.insert('personal_records', {
          'exercise_name': exerciseName,
          'weight': weight,
          'reps': maxWeightSet.repsCompleted,
          'e1rm': _calculateE1RM(weight, maxWeightSet.repsCompleted),
          'date': date.toIso8601String(),
          'session_id': sessionId,
          'is_current': 1,
          'created_at': DateTime.now().toIso8601String(),
        });
      }
    }
  }
  
  /// Calculate estimated 1 rep max using Epley formula
  static double _calculateE1RM(double weight, int reps) {
    if (reps == 1) return weight;
    return weight * (1 + (reps / 30));
  }
}
