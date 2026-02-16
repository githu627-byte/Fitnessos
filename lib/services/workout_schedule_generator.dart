import 'package:flutter/foundation.dart';
import '../models/workout_data.dart';
import '../models/workout_schedule.dart';
import '../models/user_model.dart';
import '../models/goal_config.dart';

/// ═══════════════════════════════════════════════════════════════════════════════
/// SMART SCHEDULE GENERATOR - Uses REAL preset IDs from WorkoutData
/// ═══════════════════════════════════════════════════════════════════════════════
/// Gender-aware, focus-aware, location-aware.
/// Every workout ID it outputs exists in WorkoutData.allWorkoutPresets.
/// ═══════════════════════════════════════════════════════════════════════════════

class WorkoutScheduleGenerator {

  /// Generate 2-week schedule from V3 onboarding data
  ///
  /// [gender] — 'male' or 'female'
  /// [location] — 'gym' or 'home'
  /// [focus] — 'muscle', 'fitness', 'booty', 'fullbody'
  /// [daysPerWeek] — 2, 3, 4, or 5
  static List<WorkoutSchedule> generateSmartSchedule({
    required String gender,
    required String location,
    required String focus,
    required int daysPerWeek,
  }) {
    debugPrint('🗓️ Smart Schedule Generator');
    debugPrint('   Gender: $gender');
    debugPrint('   Location: $location');
    debugPrint('   Focus: $focus');
    debugPrint('   Days/week: $daysPerWeek');

    // 1. Select the rotation based on gender + location + focus
    final rotation = _getRotation(gender, location, focus, daysPerWeek);

    debugPrint('   Rotation (${rotation.length} workouts):');
    for (final id in rotation) {
      debugPrint('     → $id');
    }

    // 2. Verify all IDs exist in WorkoutData
    final allPresets = WorkoutData.allWorkoutPresets;
    final presetMap = {for (final p in allPresets) p.id: p};

    for (final id in rotation) {
      if (!presetMap.containsKey(id)) {
        debugPrint('   ⚠️ WARNING: Preset "$id" not found in WorkoutData!');
      }
    }

    // 3. Generate 2 weeks of dates
    final schedules = <WorkoutSchedule>[];
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Map daysPerWeek to actual weekdays
    final weekdays = _getWeekdays(daysPerWeek);

    int rotationIndex = 0;

    for (int week = 0; week < 2; week++) {
      for (final dayOfWeek in weekdays) {
        // Calculate date for this weekday
        int daysToAdd = (dayOfWeek - today.weekday + 7) % 7 + (week * 7);
        // If today IS the target weekday and week 0, daysToAdd would be 0 or 7
        if (daysToAdd == 0 && week == 0) daysToAdd = 0; // today
        if (daysToAdd == 7 && week == 0) daysToAdd = 0; // also today

        final scheduleDate = today.add(Duration(days: daysToAdd));

        // Skip past dates (except today)
        if (scheduleDate.isBefore(today)) continue;

        // Get workout ID from rotation
        final workoutId = rotation[rotationIndex % rotation.length];
        rotationIndex++;

        // Look up the preset name
        final preset = presetMap[workoutId];
        final workoutName = preset?.name ?? workoutId.toUpperCase().replaceAll('_', ' ');

        schedules.add(WorkoutSchedule(
          id: 'starter_${scheduleDate.millisecondsSinceEpoch}_main',
          workoutId: workoutId,
          workoutName: workoutName,
          scheduledDate: scheduleDate,
          scheduledTime: null,
          hasAlarm: false,
          createdAt: DateTime.now(),
          priority: 'main',
        ));

        debugPrint('   ✓ ${_getDayName(dayOfWeek)} Week ${week + 1}: $workoutName');
      }
    }

    debugPrint('✅ Generated ${schedules.length} workout schedules');
    return schedules;
  }

  /// Legacy method — wraps new method for backward compatibility with V2 onboarding
  static List<WorkoutSchedule> generateTwoWeekSchedule({
    required UserModel user,
    required List<int> availableDays,
  }) {
    final isHome = user.equipmentMode == EquipmentMode.bodyweight;
    final isFemale = user.gender.toLowerCase() == 'female';

    return generateSmartSchedule(
      gender: isFemale ? 'female' : 'male',
      location: isHome ? 'home' : 'gym',
      focus: isFemale ? 'booty' : 'muscle',
      daysPerWeek: availableDays.length,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ROTATION SELECTION — Returns list of REAL preset IDs
  // ═══════════════════════════════════════════════════════════════════════════

  static List<String> _getRotation(String gender, String location, String focus, int days) {
    final isFemale = gender.toLowerCase() == 'female';
    final isGym = location.toLowerCase() == 'gym';

    // ═══════════════════════════════════════════
    // FEMALE + GYM
    // ═══════════════════════════════════════════
    if (isFemale && isGym) {
      switch (focus) {
        case 'booty':
          return _rotate([
            'gym_glute_sculpt',
            'gym_peach_pump',
            'gym_girl_upper_lower',
            'gym_glute_sculpt',
            'gym_girl_full_body',
          ], days);
        case 'muscle':
          return _rotate([
            'gym_girl_upper_lower',
            'gym_girl_glute_specialization',
            'gym_girl_full_body',
            'gym_glute_sculpt',
            'gym_girl_push_pull_legs',
          ], days);
        case 'fitness':
          return _rotate([
            'gym_girl_full_body',
            'gym_full_body_blast',
            'gym_girl_glute_specialization',
            'gym_core_destroyer',
            'gym_girl_full_body',
          ], days);
        case 'fullbody':
        default:
          return _rotate([
            'gym_girl_full_body',
            'gym_glute_sculpt',
            'gym_girl_upper_lower',
            'gym_girl_push_pull_legs',
            'gym_peach_pump',
          ], days);
      }
    }

    // ═══════════════════════════════════════════
    // FEMALE + HOME
    // ═══════════════════════════════════════════
    if (isFemale && !isGym) {
      switch (focus) {
        case 'booty':
          return _rotate([
            'home_girl_glute_sculpt',
            'home_booty_burner',
            'home_glute_activation',
            'home_girl_glute_sculpt',
            'home_band_booty',
          ], days);
        case 'muscle':
          return _rotate([
            'home_girl_upper_lower',
            'home_girl_push_pull_legs',
            'home_girl_full_body',
            'home_girl_glute_sculpt',
            'home_girl_upper_lower',
          ], days);
        case 'fitness':
          return _rotate([
            'home_girl_full_body',
            'home_10min_quick_burn',
            'home_girl_full_body_circuit',
            'home_tabata_torture',
            'home_girl_full_body',
          ], days);
        case 'fullbody':
        default:
          return _rotate([
            'home_girl_full_body',
            'home_girl_glute_sculpt',
            'home_girl_upper_lower',
            'home_girl_push_pull_legs',
            'home_booty_burner',
          ], days);
      }
    }

    // ═══════════════════════════════════════════
    // MALE + GYM
    // ═══════════════════════════════════════════
    if (!isFemale && isGym) {
      switch (focus) {
        case 'muscle':
          if (days <= 3) {
            return _rotate([
              'gym_push_day',
              'gym_pull_day',
              'gym_legs',
            ], days);
          } else {
            return _rotate([
              'gym_chest',
              'gym_back',
              'gym_legs',
              'gym_shoulders',
              'gym_arms',
            ], days);
          }
        case 'fitness':
          return _rotate([
            'gym_full_body',
            'gym_full_body_blast',
            'gym_upper_body',
            'gym_core_destroyer',
            'gym_lower_body',
          ], days);
        case 'fullbody':
        default:
          return _rotate([
            'gym_full_body',
            'gym_push_day',
            'gym_pull_day',
            'gym_legs',
            'gym_upper_body',
          ], days);
      }
    }

    // ═══════════════════════════════════════════
    // MALE + HOME
    // ═══════════════════════════════════════════
    switch (focus) {
      case 'muscle':
        return _rotate([
          'home_upper_body',
          'home_lower_body',
          'home_full_body',
          'home_upper_body',
          'home_lower_body',
        ], days);
      case 'fitness':
        return _rotate([
          'home_full_body',
          'home_10min_quick_burn',
          'home_20min_destroyer',
          'home_tabata_torture',
          'home_cardio_blast',
        ], days);
      case 'fullbody':
      default:
        return _rotate([
          'home_full_body',
          'home_upper_body',
          'home_lower_body',
          'home_10min_quick_burn',
          'home_full_body',
        ], days);
    }
  }

  /// Take first N items from rotation
  static List<String> _rotate(List<String> pool, int days) {
    return pool.take(days).toList();
  }

  /// Map days per week to actual weekdays (1=Mon ... 7=Sun)
  static List<int> _getWeekdays(int daysPerWeek) {
    switch (daysPerWeek) {
      case 2: return [1, 4]; // Mon, Thu
      case 3: return [1, 3, 5]; // Mon, Wed, Fri
      case 4: return [1, 2, 4, 5]; // Mon, Tue, Thu, Fri
      case 5: return [1, 2, 3, 4, 5]; // Mon-Fri
      case 6: return [1, 2, 3, 4, 5, 6]; // Mon-Sat
      default: return [1, 3, 5]; // Default: Mon, Wed, Fri
    }
  }

  static String _getDayName(int dayOfWeek) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[(dayOfWeek - 1) % 7];
  }
}
