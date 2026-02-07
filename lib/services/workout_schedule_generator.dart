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
  
  /// Helper to get day name
  static String _getDayName(int dayOfWeek) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[dayOfWeek - 1];
  }
}
