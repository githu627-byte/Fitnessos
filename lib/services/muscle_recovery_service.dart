import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Service to track muscle recovery based on workout history
/// Recovery calculation: 72 hours = 100% recovery
class MuscleRecoveryService {
  static const String _storageKey = 'muscle_last_trained';
  static const Duration _fullRecoveryTime = Duration(hours: 72);

  /// Map exercise names/IDs to affected muscle groups
  static const Map<String, List<String>> exerciseMuscleMap = {
    // Chest
    'bench_press': ['chest', 'shoulders', 'triceps'],
    'push_up': ['chest', 'shoulders', 'triceps'],
    'dumbbell_press': ['chest', 'shoulders', 'triceps'],
    'chest_fly': ['chest', 'shoulders'],
    'decline_press': ['chest', 'triceps'],
    'incline_press': ['chest', 'shoulders', 'triceps'],

    // Back
    'pull_up': ['lats', 'biceps', 'traps'],
    'lat_pulldown': ['lats', 'biceps'],
    'row': ['lats', 'traps', 'biceps'],
    'deadlift': ['lower_back', 'glutes', 'hamstrings', 'traps'],
    'barbell_row': ['lats', 'traps', 'lower_back'],

    // Shoulders
    'overhead_press': ['shoulders', 'triceps'],
    'shoulder_press': ['shoulders', 'triceps'],
    'lateral_raise': ['shoulders'],
    'front_raise': ['shoulders'],
    'rear_delt_fly': ['shoulders', 'traps'],

    // Arms
    'bicep_curl': ['biceps', 'forearms'],
    'hammer_curl': ['biceps', 'forearms'],
    'tricep_extension': ['triceps'],
    'tricep_dip': ['triceps', 'chest'],
    'skull_crusher': ['triceps'],

    // Legs
    'squat': ['quadriceps', 'glutes', 'hamstrings'],
    'leg_press': ['quadriceps', 'glutes'],
    'lunge': ['quadriceps', 'glutes', 'hamstrings'],
    'leg_extension': ['quadriceps'],
    'leg_curl': ['hamstrings'],
    'calf_raise': ['calves'],
    'romanian_deadlift': ['hamstrings', 'glutes', 'lower_back'],

    // Core
    'plank': ['abs'],
    'crunch': ['abs'],
    'sit_up': ['abs'],
    'russian_twist': ['abs'],
    'leg_raise': ['abs'],

    // ═══════════════════════════════════════════════════════════════════════
    // EXPANDED COVERAGE - Chest
    // ═══════════════════════════════════════════════════════════════════════
    'incline_bench': ['chest', 'shoulders', 'triceps'],
    'decline_bench': ['chest', 'triceps'],
    'dumbbell_bench': ['chest', 'shoulders', 'triceps'],
    'cable_crossover': ['chest'],
    'cable_fly': ['chest'],
    'machine_press': ['chest', 'triceps'],
    'pec_deck': ['chest'],

    // ═══════════════════════════════════════════════════════════════════════
    // EXPANDED COVERAGE - Back
    // ═══════════════════════════════════════════════════════════════════════
    'chin_up': ['lats', 'biceps'],
    'cable_row': ['lats', 'traps', 'biceps'],
    'seated_row': ['lats', 'traps', 'biceps'],
    'dumbbell_row': ['lats', 'traps', 'biceps'],
    't_bar_row': ['lats', 'traps', 'lower_back'],
    'face_pull': ['traps', 'shoulders'],
    'reverse_fly': ['traps', 'shoulders'],
    'shrug': ['traps'],
    'hyperextension': ['lower_back', 'glutes'],
    'good_morning': ['lower_back', 'hamstrings'],

    // ═══════════════════════════════════════════════════════════════════════
    // EXPANDED COVERAGE - Shoulders
    // ═══════════════════════════════════════════════════════════════════════
    'military_press': ['shoulders', 'triceps'],
    'arnold_press': ['shoulders', 'triceps'],
    'side_raise': ['shoulders'],
    'upright_row': ['shoulders', 'traps'],
    'pike_push': ['shoulders', 'triceps'],

    // ═══════════════════════════════════════════════════════════════════════
    // EXPANDED COVERAGE - Legs
    // ═══════════════════════════════════════════════════════════════════════
    'front_squat': ['quadriceps', 'glutes', 'abs'],
    'goblet_squat': ['quadriceps', 'glutes'],
    'bulgarian_split': ['quadriceps', 'glutes'],
    'split_squat': ['quadriceps', 'glutes'],
    'step_up': ['quadriceps', 'glutes'],
    'hack_squat': ['quadriceps', 'glutes'],
    'walking_lunge': ['quadriceps', 'glutes', 'hamstrings'],
    'reverse_lunge': ['quadriceps', 'glutes'],
    'hip_thrust': ['glutes', 'hamstrings'],
    'glute_bridge': ['glutes', 'hamstrings'],
    'kickback': ['glutes'],
    'sumo_squat': ['quadriceps', 'glutes', 'hamstrings'],
    'sumo_deadlift': ['glutes', 'hamstrings', 'lower_back'],
    'stiff_leg': ['hamstrings', 'lower_back'],
    'seated_calf': ['calves'],
    'donkey_calf': ['calves'],

    // ═══════════════════════════════════════════════════════════════════════
    // EXPANDED COVERAGE - Arms
    // ═══════════════════════════════════════════════════════════════════════
    'preacher_curl': ['biceps'],
    'concentration_curl': ['biceps'],
    'incline_curl': ['biceps'],
    'cable_curl': ['biceps'],
    'ez_bar_curl': ['biceps'],
    'rope_curl': ['biceps', 'forearms'],
    'overhead_extension': ['triceps'],
    'rope_pushdown': ['triceps'],
    'cable_pushdown': ['triceps'],
    'close_grip_bench': ['triceps', 'chest'],
    'diamond_push': ['triceps', 'chest'],
    'wrist_curl': ['forearms'],
    'reverse_curl': ['forearms', 'biceps'],

    // ═══════════════════════════════════════════════════════════════════════
    // EXPANDED COVERAGE - Core
    // ═══════════════════════════════════════════════════════════════════════
    'bicycle': ['abs'],
    'mountain_climber': ['abs'],
    'dead_bug': ['abs'],
    'bird_dog': ['abs', 'lower_back'],
    'superman': ['lower_back'],
    'v_up': ['abs'],
    'hanging_leg': ['abs'],
    'cable_crunch': ['abs'],
    'wood_chop': ['abs'],
    'pallof': ['abs'],
    'side_plank': ['abs'],
    'hollow_hold': ['abs'],

    // ═══════════════════════════════════════════════════════════════════════
    // EXPANDED COVERAGE - Full Body / Compound
    // ═══════════════════════════════════════════════════════════════════════
    'burpee': ['chest', 'quadriceps', 'abs'],
    'thruster': ['quadriceps', 'shoulders', 'triceps'],
    'clean': ['quadriceps', 'glutes', 'traps', 'shoulders'],
    'snatch': ['quadriceps', 'glutes', 'traps', 'shoulders'],
    'kettlebell_swing': ['glutes', 'hamstrings', 'shoulders'],
    'battle_rope': ['shoulders', 'abs'],
    'jumping_jack': ['quadriceps', 'calves'],
    'high_knee': ['quadriceps', 'abs'],
    'box_jump': ['quadriceps', 'glutes', 'calves'],
  };

  /// Record that specific muscles were trained now
  static Future<void> recordMusclesTrained(List<String> muscleGroups) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().toIso8601String();

    // Load existing data
    final Map<String, dynamic> lastTrained = _loadLastTrained(prefs);

    // Update each muscle group
    for (final muscle in muscleGroups) {
      lastTrained[muscle] = now;
    }

    // Save back
    await prefs.setString(_storageKey, json.encode(lastTrained));
  }

  /// Record workout completion - automatically maps exercises to muscles
  /// Now accepts optional pre-mapped muscles for better accuracy
  static Future<void> recordWorkout(
    List<String> exerciseNames, {
    Map<String, List<String>>? exerciseMuscleData,
  }) async {
    final Set<String> affectedMuscles = {};

    for (final exercise in exerciseNames) {
      // First: Check if we have pre-mapped muscle data (most accurate)
      if (exerciseMuscleData != null && exerciseMuscleData.containsKey(exercise)) {
        affectedMuscles.addAll(exerciseMuscleData[exercise]!);
        continue;
      }

      final normalizedName = exercise.toLowerCase().replaceAll(' ', '_').replaceAll('-', '_');

      // Second: Try exact match in our map
      if (exerciseMuscleMap.containsKey(normalizedName)) {
        affectedMuscles.addAll(exerciseMuscleMap[normalizedName]!);
        continue;
      }

      // Third: Try fuzzy match (contains)
      bool found = false;
      for (final entry in exerciseMuscleMap.entries) {
        if (normalizedName.contains(entry.key) || entry.key.contains(normalizedName)) {
          affectedMuscles.addAll(entry.value);
          found = true;
          break;
        }
      }

      // Fourth: Try keyword-based inference
      if (!found) {
        affectedMuscles.addAll(_inferMusclesFromName(normalizedName));
      }
    }

    if (affectedMuscles.isNotEmpty) {
      await recordMusclesTrained(affectedMuscles.toList());
      debugPrint('💪 Muscle recovery updated: ${affectedMuscles.join(", ")}');
    } else {
      debugPrint('⚠️ No muscles identified for exercises: ${exerciseNames.join(", ")}');
    }
  }

  /// Infer muscles from exercise name keywords
  static List<String> _inferMusclesFromName(String exerciseName) {
    final muscles = <String>[];

    // Chest keywords
    if (exerciseName.contains('chest') ||
        exerciseName.contains('bench') ||
        exerciseName.contains('fly') ||
        exerciseName.contains('push_up') ||
        exerciseName.contains('pushup')) {
      muscles.addAll(['chest', 'triceps']);
    }

    // Back keywords
    if (exerciseName.contains('row') ||
        exerciseName.contains('pull') ||
        exerciseName.contains('lat') ||
        exerciseName.contains('back')) {
      muscles.addAll(['lats', 'biceps']);
    }

    // Shoulder keywords
    if (exerciseName.contains('shoulder') ||
        exerciseName.contains('delt') ||
        exerciseName.contains('lateral') ||
        exerciseName.contains('overhead') ||
        exerciseName.contains('military')) {
      muscles.add('shoulders');
    }

    // Leg keywords
    if (exerciseName.contains('squat') ||
        exerciseName.contains('leg') ||
        exerciseName.contains('lunge') ||
        exerciseName.contains('quad')) {
      muscles.addAll(['quadriceps', 'glutes']);
    }

    if (exerciseName.contains('hamstring') ||
        (exerciseName.contains('curl') && exerciseName.contains('leg'))) {
      muscles.add('hamstrings');
    }

    if (exerciseName.contains('calf') || exerciseName.contains('calve')) {
      muscles.add('calves');
    }

    if (exerciseName.contains('glute') ||
        exerciseName.contains('hip') ||
        exerciseName.contains('bridge') ||
        exerciseName.contains('thrust')) {
      muscles.add('glutes');
    }

    // Arm keywords
    if (exerciseName.contains('bicep') ||
        (exerciseName.contains('curl') && !exerciseName.contains('leg'))) {
      muscles.add('biceps');
    }

    if (exerciseName.contains('tricep') ||
        exerciseName.contains('extension') ||
        exerciseName.contains('pushdown') ||
        exerciseName.contains('skull')) {
      muscles.add('triceps');
    }

    // Core keywords
    if (exerciseName.contains('ab') ||
        exerciseName.contains('core') ||
        exerciseName.contains('crunch') ||
        exerciseName.contains('plank') ||
        exerciseName.contains('twist') ||
        exerciseName.contains('sit_up')) {
      muscles.add('abs');
    }

    // Deadlift - multiple muscles
    if (exerciseName.contains('deadlift')) {
      muscles.addAll(['lower_back', 'glutes', 'hamstrings']);
    }

    // Dips
    if (exerciseName.contains('dip')) {
      muscles.addAll(['chest', 'triceps']);
    }

    return muscles;
  }

  /// Get recovery percentage for a specific muscle (0.0 = tired, 1.0 = fully recovered)
  static Future<double> getMuscleRecovery(String muscleGroup) async {
    final prefs = await SharedPreferences.getInstance();
    final lastTrained = _loadLastTrained(prefs);

    if (!lastTrained.containsKey(muscleGroup)) {
      return 1.0; // Never trained = fully recovered
    }

    final lastTrainedTime = DateTime.parse(lastTrained[muscleGroup]);
    final timeSince = DateTime.now().difference(lastTrainedTime);

    if (timeSince >= _fullRecoveryTime) {
      return 1.0; // Fully recovered
    }

    // Linear recovery over 72 hours
    return timeSince.inHours / _fullRecoveryTime.inHours;
  }

  /// Get recovery percentages for all muscle groups
  static Future<Map<String, double>> getAllMuscleRecovery() async {
    final allMuscles = [
      'chest',
      'shoulders',
      'biceps',
      'triceps',
      'forearms',
      'abs',
      'lats',
      'traps',
      'lower_back',
      'quadriceps',
      'hamstrings',
      'glutes',
      'calves',
      'neck',
    ];

    final Map<String, double> recoveryMap = {};

    for (final muscle in allMuscles) {
      recoveryMap[muscle] = await getMuscleRecovery(muscle);
    }

    return recoveryMap;
  }

  /// Get hours until a muscle is fully recovered
  static Future<int> getHoursUntilRecovered(String muscleGroup) async {
    final recovery = await getMuscleRecovery(muscleGroup);
    if (recovery >= 1.0) return 0;

    final remainingRecovery = 1.0 - recovery;
    return (remainingRecovery * _fullRecoveryTime.inHours).ceil();
  }

  /// Get the most fatigued muscle group
  static Future<String?> getMostFatiguedMuscle() async {
    final recoveryMap = await getAllMuscleRecovery();

    if (recoveryMap.isEmpty) return null;

    var lowestRecovery = 1.0;
    String? mostFatigued;

    for (final entry in recoveryMap.entries) {
      if (entry.value < lowestRecovery) {
        lowestRecovery = entry.value;
        mostFatigued = entry.key;
      }
    }

    return lowestRecovery < 1.0 ? mostFatigued : null;
  }

  /// Get muscles that are ready to train (>80% recovered)
  static Future<List<String>> getReadyMuscles() async {
    final recoveryMap = await getAllMuscleRecovery();
    return recoveryMap.entries
        .where((entry) => entry.value >= 0.8)
        .map((entry) => entry.key)
        .toList();
  }

  /// Clear all recovery data (for testing)
  static Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

  // Private helper
  static Map<String, dynamic> _loadLastTrained(SharedPreferences prefs) {
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null) return {};

    try {
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }
}
