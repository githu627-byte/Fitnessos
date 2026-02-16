import 'package:flutter/foundation.dart';
import '../models/workout_data.dart';
import '../models/workout_schedule.dart';
import '../models/user_model.dart';

/// Generates a personalized 2-week workout schedule based on onboarding responses
class WorkoutScheduleGenerator {
  /// Generate 2-week schedule from onboarding data
  static List<WorkoutSchedule> generateTwoWeekSchedule({
    required UserModel user,
    required List<int> availableDays, // 1=Monday, 7=Sunday
  }) {
    debugPrint('🗓️  Generating 2-week schedule...');
    debugPrint('   Goal: ${user.goalMode}');
    debugPrint('   Equipment: ${user.equipmentMode}');
    debugPrint('   Experience: ${user.fitnessExperience}');
    debugPrint('   Days available: $availableDays');
    
    final schedules = <WorkoutSchedule>[];
    final workoutPlan = _selectWorkoutPlan(user);
    
    // Generate schedules for 2 weeks
    final startDate = DateTime.now();
    
    for (int week = 0; week < 2; week++) {
      int workoutIndex = 0;
      
      for (final dayOfWeek in availableDays) {
        // Calculate actual date
        final daysToAdd = (dayOfWeek - startDate.weekday + 7) % 7 + (week * 7);
        final scheduleDate = startDate.add(Duration(days: daysToAdd));
        
        // Skip if date is in the past
        if (scheduleDate.isBefore(DateTime.now().subtract(const Duration(hours: 1)))) {
          continue;
        }
        
        // Get workout for this day (rotate through plan)
        final workout = workoutPlan[workoutIndex % workoutPlan.length];
        workoutIndex++;
        
        schedules.add(WorkoutSchedule(
          id: '${scheduleDate.millisecondsSinceEpoch}',
          workoutId: workout.id,
          workoutName: workout.name,
          scheduledDate: scheduleDate,
          scheduledTime: null, // User can set later
          hasAlarm: false,
          createdAt: DateTime.now(),
        ));
        
        debugPrint('   ✓ ${_getDayName(dayOfWeek)} Week ${week + 1}: ${workout.name}');
      }
    }
    
    debugPrint('✅ Generated ${schedules.length} workout schedules');
    return schedules;
  }
  
  /// Select appropriate workout plan based on user profile
  static List<dynamic> _selectWorkoutPlan(UserModel user) {
    final goal = user.goalMode.toString();
    final equipment = user.equipmentMode.toString();
    final experience = user.fitnessExperience ?? 'beginner';
    
    // Get all available workouts
    final allWorkouts = WorkoutData.allWorkoutPresets;
    
    // Filter by equipment mode
    final filteredWorkouts = allWorkouts.where((workout) {
      if (equipment.contains('gym')) {
        return workout.name.toLowerCase().contains('gym') || 
               !workout.name.toLowerCase().contains('home');
      } else {
        return workout.name.toLowerCase().contains('home') ||
               workout.name.toLowerCase().contains('bodyweight');
      }
    }).toList();
    
    // If no workouts found, return first 3 from all workouts
    if (filteredWorkouts.isEmpty) {
      return allWorkouts.take(3).toList();
    }
    
    // Return first 3-5 workouts based on experience
    final count = experience == 'beginner' ? 3 : 
                  experience == 'intermediate' ? 4 : 5;
    
    return filteredWorkouts.take(count).toList();
  }
  
  /// Generate a smart 2-week schedule from V3 onboarding parameters.
  /// Uses location, daysPerWeek, focus, and difficulty to pick workouts
  /// and spread them across the next 14 days with no same-date overlap.
  static List<WorkoutSchedule> generateSmartSchedule({
    required String location,   // 'gym' or 'home'
    required int daysPerWeek,   // 2-5
    required String focus,      // 'muscle', 'fitness', 'booty', 'fullbody'
    required String difficulty,  // 'beginner', 'intermediate', 'advanced'
  }) {
    debugPrint('🗓️  Generating smart schedule...');
    debugPrint('   Location: $location');
    debugPrint('   Days/week: $daysPerWeek');
    debugPrint('   Focus: $focus');
    debugPrint('   Difficulty: $difficulty');

    final allWorkouts = WorkoutData.allWorkoutPresets;

    // Step 1: Filter by location (category)
    final byLocation = allWorkouts.where((w) {
      return w.category == location;
    }).toList();

    // Step 2: Score by focus relevance
    final scored = (byLocation.isNotEmpty ? byLocation : allWorkouts).map((w) {
      int score = 0;
      final name = w.name.toLowerCase();
      final sub = w.subcategory.toLowerCase();

      switch (focus) {
        case 'muscle':
          if (sub.contains('muscle') || name.contains('chest') ||
              name.contains('back') || name.contains('arms') ||
              name.contains('shoulder')) score += 3;
          if (!w.isCircuit) score += 1;
          break;
        case 'fitness':
          if (w.isCircuit || sub.contains('circuit') || sub.contains('hiit') ||
              name.contains('hiit') || name.contains('cardio')) score += 3;
          break;
        case 'booty':
          if (sub.contains('booty') || sub.contains('girl') ||
              name.contains('glute') || name.contains('leg') ||
              name.contains('booty')) score += 3;
          break;
        case 'fullbody':
        default:
          if (name.contains('full') || name.contains('total')) score += 2;
          score += 1; // all workouts have some relevance
          break;
      }

      return (workout: w, score: score);
    }).toList();

    // Sort by score descending, then take enough for rotation
    scored.sort((a, b) => b.score.compareTo(a.score));

    final planSize = difficulty == 'beginner' ? 3 :
                     difficulty == 'intermediate' ? 4 : 5;
    final plan = scored.take(planSize.clamp(1, scored.length)).map((e) => e.workout).toList();

    if (plan.isEmpty) {
      debugPrint('⚠️ No workouts matched filters, using first 3 presets');
      plan.addAll(allWorkouts.take(3));
    }

    debugPrint('   Selected ${plan.length} workouts for rotation:');
    for (final w in plan) {
      debugPrint('     • ${w.name} (${w.category}/${w.subcategory})');
    }

    // Step 3: Pick which weekdays to train (spread evenly)
    final trainingDays = _spreadDays(daysPerWeek);

    // Step 4: Generate 2 weeks of schedules
    final schedules = <WorkoutSchedule>[];
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    int workoutIndex = 0;

    for (int week = 0; week < 2; week++) {
      for (final dayOfWeek in trainingDays) {
        // dayOfWeek is 1=Mon..7=Sun
        final daysToAdd = (dayOfWeek - today.weekday + 7) % 7 + (week * 7);
        final scheduleDate = today.add(Duration(days: daysToAdd));

        // Skip dates in the past
        if (scheduleDate.isBefore(today)) continue;

        final workout = plan[workoutIndex % plan.length];
        workoutIndex++;

        final id = 'smart_${scheduleDate.millisecondsSinceEpoch}_$workoutIndex';

        schedules.add(WorkoutSchedule(
          id: id,
          workoutId: workout.id,
          workoutName: workout.name,
          scheduledDate: scheduleDate,
          scheduledTime: null,
          hasAlarm: false,
          createdAt: now,
          priority: 'main',
        ));

        debugPrint('   ✓ ${_getDayName(dayOfWeek)} Week ${week + 1}: ${workout.name}');
      }
    }

    debugPrint('✅ Generated ${schedules.length} smart schedules');
    return schedules;
  }

  /// Spread N training days evenly across Mon-Sun (1-7).
  static List<int> _spreadDays(int count) {
    if (count <= 0) return [];
    if (count >= 7) return [1, 2, 3, 4, 5, 6, 7];

    // Common layouts for even spacing
    switch (count) {
      case 2: return [1, 4];           // Mon, Thu
      case 3: return [1, 3, 5];        // Mon, Wed, Fri
      case 4: return [1, 2, 4, 5];     // Mon, Tue, Thu, Fri
      case 5: return [1, 2, 3, 5, 6];  // Mon-Wed, Fri-Sat
      case 6: return [1, 2, 3, 4, 5, 6]; // Mon-Sat
      default: return [1, 3, 5];
    }
  }

  /// Helper to get day name
  static String _getDayName(int dayOfWeek) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[dayOfWeek - 1];
  }
}
