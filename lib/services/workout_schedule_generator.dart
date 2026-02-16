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
  
  /// Generate a smart 2-week schedule from V3 onboarding preferences
  static List<WorkoutSchedule> generateSmartSchedule({
    required String location,    // 'gym' or 'home'
    required int daysPerWeek,    // 2-5
    required String focus,       // 'muscle', 'fitness', 'booty', 'fullbody'
    required String difficulty,  // 'beginner', 'intermediate', 'advanced'
  }) {
    debugPrint('🗓️  Generating smart schedule...');
    debugPrint('   Location: $location');
    debugPrint('   Days/week: $daysPerWeek');
    debugPrint('   Focus: $focus');
    debugPrint('   Difficulty: $difficulty');

    final allWorkouts = WorkoutData.allWorkoutPresets;

    // Filter by location (category)
    final locationFiltered = allWorkouts.where((w) {
      if (location == 'gym') return w.category == 'gym';
      return w.category == 'home';
    }).toList();

    // Map focus to matching subcategories
    final focusSubcategories = <String>[];
    switch (focus) {
      case 'muscle':
        focusSubcategories.addAll(['muscle_splits', 'muscle_groupings']);
        break;
      case 'fitness':
        focusSubcategories.addAll(['gym_circuits', 'hiit_circuits', 'bodyweight_basics']);
        break;
      case 'booty':
        focusSubcategories.addAll(['booty_builder', 'home_booty', 'girl_power']);
        break;
      case 'fullbody':
      default:
        focusSubcategories.addAll(['muscle_groupings', 'bodyweight_basics', 'gym_circuits', 'hiit_circuits']);
        break;
    }

    // Filter by focus subcategories
    var focusFiltered = locationFiltered.where((w) => focusSubcategories.contains(w.subcategory)).toList();

    // Fallback: if no matches, use all location-filtered workouts
    if (focusFiltered.isEmpty) {
      focusFiltered = locationFiltered;
    }

    // If still empty, use first few from all workouts
    if (focusFiltered.isEmpty) {
      focusFiltered = allWorkouts.take(daysPerWeek).toList();
    }

    // Pick the right number of unique workouts to rotate through
    final workoutPool = focusFiltered.take(daysPerWeek.clamp(2, focusFiltered.length)).toList();

    // Determine which days of the week to schedule (spread evenly)
    final availableDays = _spreadDays(daysPerWeek);

    final schedules = <WorkoutSchedule>[];
    final startDate = DateTime.now();

    for (int week = 0; week < 2; week++) {
      int workoutIndex = 0;

      for (final dayOfWeek in availableDays) {
        final daysToAdd = (dayOfWeek - startDate.weekday + 7) % 7 + (week * 7);
        final scheduleDate = startDate.add(Duration(days: daysToAdd));

        // Skip if date is in the past
        if (scheduleDate.isBefore(DateTime.now().subtract(const Duration(hours: 1)))) {
          continue;
        }

        final workout = workoutPool[workoutIndex % workoutPool.length];
        workoutIndex++;

        schedules.add(WorkoutSchedule(
          id: 'smart_${scheduleDate.millisecondsSinceEpoch}_${workoutIndex}',
          workoutId: workout.id,
          workoutName: workout.name,
          scheduledDate: scheduleDate,
          scheduledTime: null,
          hasAlarm: false,
          createdAt: DateTime.now(),
        ));

        debugPrint('   ✓ ${_getDayName(dayOfWeek)} Week ${week + 1}: ${workout.name}');
      }
    }

    debugPrint('✅ Generated ${schedules.length} smart schedules');
    return schedules;
  }

  /// Spread N days evenly across a week (returns day-of-week numbers 1-7)
  static List<int> _spreadDays(int daysPerWeek) {
    switch (daysPerWeek) {
      case 2: return [1, 4]; // Mon, Thu
      case 3: return [1, 3, 5]; // Mon, Wed, Fri
      case 4: return [1, 2, 4, 5]; // Mon, Tue, Thu, Fri
      case 5: return [1, 2, 3, 5, 6]; // Mon-Wed, Fri, Sat
      default: return [1, 3, 5]; // Default: Mon, Wed, Fri
    }
  }

  /// Helper to get day name
  static String _getDayName(int dayOfWeek) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[dayOfWeek - 1];
  }
}
