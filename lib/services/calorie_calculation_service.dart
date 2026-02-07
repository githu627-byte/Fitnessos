/// ═══════════════════════════════════════════════════════════════════════════
/// CALORIE CALCULATION SERVICE - Science-Based Accurate Calorie Tracking
/// ═══════════════════════════════════════════════════════════════════════════
/// Uses MET (Metabolic Equivalent of Task) values from Compendium of Physical
/// Activities for accurate calorie burn estimates.
///
/// Formula: Calories = MET × bodyweight_kg × duration_hours
///
/// References:
/// - Ainsworth BE et al. (2011) Compendium of Physical Activities
/// - American College of Sports Medicine guidelines
/// ═══════════════════════════════════════════════════════════════════════════

import '../models/workout_models.dart';
import '../models/exercise_set_data.dart';

class CalorieCalculationService {
  /// ═══════════════════════════════════════════════════════════════════════════
  /// ESTIMATE CALORIES (Before Workout)
  /// ═══════════════════════════════════════════════════════════════════════════
  /// Used for: Hero card on home, workout preset cards
  /// Estimates based on planned workout without actual weights
  
  static int estimateCalories({
    required WorkoutPreset workout,
    required double userWeightKg,
  }) {
    if (userWeightKg <= 0) userWeightKg = 70.0; // Default to 70kg
    
    double totalCalories = 0.0;
    
    // Estimate duration based on sets and exercises
    final estimatedDurationMinutes = _estimateWorkoutDuration(workout);
    final durationHours = estimatedDurationMinutes / 60.0;
    
    // Calculate MET-hours for each exercise
    for (final exercise in workout.exercises) {
      if (!exercise.included) continue;
      
      // Get base MET value for this exercise type
      final baseMET = _getExerciseMET(exercise.name, null, exercise.reps);
      
      // Estimate time spent on this exercise (sets × 30 seconds per set)
      final exerciseMinutes = exercise.sets * 0.5; // 30 seconds per set
      final exerciseHours = exerciseMinutes / 60.0;
      
      // Add calories for this exercise
      totalCalories += baseMET * userWeightKg * exerciseHours;
    }
    
    // Add rest period calories (time between sets at MET 1.5)
    final restMinutes = workout.exercises
        .where((e) => e.included)
        .fold<int>(0, (sum, e) => sum + e.sets) * 1.5; // 1.5 min rest per set
    final restHours = restMinutes / 60.0;
    totalCalories += 1.5 * userWeightKg * restHours;
    
    return totalCalories.round().clamp(10, 9999);
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// CALCULATE ACTUAL CALORIES (After Workout)
  /// ═══════════════════════════════════════════════════════════════════════════
  /// Used for: Workout completion screen, database storage
  /// Calculates based on actual weights used and duration
  
  static int calculateActualCalories({
    required List<ExerciseSetData> exerciseSets,
    required Duration duration,
    required double userWeightKg,
  }) {
    if (userWeightKg <= 0) userWeightKg = 70.0; // Default to 70kg
    if (exerciseSets.isEmpty) return 0;
    
    double totalCalories = 0.0;
    final durationHours = duration.inMinutes / 60.0;
    
    // Calculate average MET across all sets
    double totalMETMinutes = 0.0;
    
    for (final set in exerciseSets) {
      // Get MET value with intensity adjustments based on actual weight/reps
      final met = _getExerciseMET(
        set.exerciseName,
        set.weight,
        set.repsCompleted,
      );
      
      // Assume 30 seconds active work per set
      final setMinutes = 0.5;
      totalMETMinutes += met * setMinutes;
    }
    
    // Convert MET-minutes to calories
    final workingCalories = (totalMETMinutes / 60.0) * userWeightKg;
    
    // Add rest period calories (total duration minus working time)
    final workingMinutes = exerciseSets.length * 0.5;
    final restMinutes = duration.inMinutes - workingMinutes;
    final restCalories = (1.5 * userWeightKg * restMinutes) / 60.0;
    
    totalCalories = workingCalories + restCalories;
    
    return totalCalories.round().clamp(10, 9999);
  }
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// PRIVATE HELPERS
  /// ═══════════════════════════════════════════════════════════════════════════
  
  /// Get MET value for an exercise with intensity adjustments
  static double _getExerciseMET(String exerciseName, double? weight, int reps) {
    final name = exerciseName.toLowerCase();
    
    // Base MET values by exercise type
    double baseMET;
    
    // Heavy compound lifts (squat, deadlift, clean, snatch)
    if (name.contains('squat') || 
        name.contains('deadlift') ||
        name.contains('clean') ||
        name.contains('snatch') ||
        name.contains('thruster')) {
      baseMET = 6.0;
    }
    // Medium compound (bench press, overhead press, rows, pull-ups)
    else if (name.contains('bench') ||
             name.contains('press') && !name.contains('leg') ||
             name.contains('row') ||
             name.contains('pull') ||
             name.contains('chin') ||
             name.contains('dip') ||
             name.contains('lunge')) {
      baseMET = 5.0;
    }
    // Bodyweight exercises
    else if (name.contains('push-up') ||
             name.contains('pushup') ||
             name.contains('burpee') ||
             name.contains('mountain climber') ||
             name.contains('plank')) {
      baseMET = 4.5;
    }
    // HIIT/Circuit exercises
    else if (name.contains('hiit') ||
             name.contains('circuit') ||
             name.contains('jump') ||
             name.contains('sprint') ||
             name.contains('battle rope')) {
      baseMET = 8.0;
    }
    // Isolation exercises (curls, extensions, raises)
    else if (name.contains('curl') ||
             name.contains('extension') ||
             name.contains('raise') ||
             name.contains('fly') ||
             name.contains('cable') ||
             name.contains('machine')) {
      baseMET = 3.5;
    }
    // Default moderate resistance training
    else {
      baseMET = 5.0;
    }
    
    // Apply intensity multiplier based on weight and reps
    final intensityMultiplier = _calculateIntensityMultiplier(weight, reps);
    
    return baseMET * intensityMultiplier;
  }
  
  /// Calculate intensity multiplier based on weight used and rep range
  static double _calculateIntensityMultiplier(double? weight, int reps) {
    // If bodyweight exercise (no weight specified)
    if (weight == null || weight == 0) {
      return 0.9;
    }
    
    // Heavy weight (1-5 reps) - high intensity
    if (reps <= 5) {
      return 1.3;
    }
    // Medium weight (6-12 reps) - moderate intensity
    else if (reps <= 12) {
      return 1.0;
    }
    // Light weight (13+ reps) - lower intensity
    else {
      return 0.85;
    }
  }
  
  /// Estimate workout duration based on exercises and sets
  static double _estimateWorkoutDuration(WorkoutPreset workout) {
    final totalSets = workout.exercises
        .where((e) => e.included)
        .fold<int>(0, (sum, e) => sum + e.sets);
    
    // Estimate:
    // - 30 seconds per set (working time)
    // - 90 seconds rest between sets
    // - 2 minutes transition between exercises
    
    final workingMinutes = totalSets * 0.5;
    final restMinutes = totalSets * 1.5;
    final transitionMinutes = workout.exercises.where((e) => e.included).length * 2.0;
    
    return workingMinutes + restMinutes + transitionMinutes;
  }
}
