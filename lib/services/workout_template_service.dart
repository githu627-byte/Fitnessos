import 'package:flutter/foundation.dart';
import '../models/workout_models.dart';
import '../models/exercise_difficulty_mapping.dart';

/// Workout Template Service
/// Generates dynamic workout presets based on difficulty, muscle group, and training style
/// Based on NASM/ACSM programming principles

class WorkoutTemplateService {
  
  // Volume guidelines by difficulty
  static const Map<String, Map<String, dynamic>> volumeGuidelines = {
    'beginner': {
      'exerciseCount': 3, // 2-4 exercises
      'sets': 3,          // 2-3 sets
      'reps': 12,         // 10-15 reps
      'restSeconds': 75,  // 60-90 seconds
    },
    'intermediate': {
      'exerciseCount': 5, // 4-6 exercises
      'sets': 4,          // 3-4 sets
      'reps': 10,         // 6-12 reps
      'restSeconds': 105, // 90-120 seconds
    },
    'advanced': {
      'exerciseCount': 7, // 5-8 exercises
      'sets': 4,          // 4-5 sets
      'reps': 8,          // Varied 3-15 reps
      'restSeconds': 150, // 120-180 seconds
    },
  };

  /// Generate a single muscle group workout (e.g., Chest, Back, Legs)
  static List<WorkoutExercise> generateMuscleSplitWorkout({
    required String muscleGroup,
    required String difficulty,
    required bool isGym,
  }) {
    final guidelines = volumeGuidelines[difficulty]!;
    final exerciseCount = guidelines['exerciseCount'] as int;
    final sets = guidelines['sets'] as int;
    final reps = guidelines['reps'] as int;

    // Get progressions for this muscle group
    final progressions = ExerciseDifficultyMapping.getProgressionsForMuscleGroup(
      muscleGroup, // Use the actual muscle group directly
    );

    final exercises = <WorkoutExercise>[];
    
    // For beginners: fewer exercises, focus on compounds
    // For intermediate: balanced mix
    // For advanced: more exercises, include advanced variations
    
    int count = 0;
    for (final progression in progressions) {
      if (count >= exerciseCount) break;
      
      String exerciseId;
      String exerciseName;
      
      switch (difficulty) {
        case 'beginner':
          exerciseId = progression.beginner;
          exerciseName = _formatExerciseName(progression.beginner);
          break;
        case 'intermediate':
          exerciseId = progression.intermediate;
          exerciseName = _formatExerciseName(progression.intermediate);
          break;
        case 'advanced':
          exerciseId = progression.advanced;
          exerciseName = _formatExerciseName(progression.advanced);
          break;
        default:
          continue;
      }

      exercises.add(WorkoutExercise(
        id: exerciseId,
        name: exerciseName,
        sets: sets,
        reps: reps,
        included: true,
        primaryMuscles: [muscleGroup],
      ));

      count++;
    }

    return exercises;
  }

  /// Generate a compound workout (e.g., Push Day, Pull Day, Upper Body)
  static List<WorkoutExercise> generateCompoundWorkout({
    required List<String> muscleGroups,
    required String difficulty,
    required bool isGym,
  }) {
    final guidelines = volumeGuidelines[difficulty]!;
    final totalExerciseCount = guidelines['exerciseCount'] as int;
    final sets = guidelines['sets'] as int;
    final reps = guidelines['reps'] as int;

    final exercises = <WorkoutExercise>[];
    
    // Distribute exercises across muscle groups
    final exercisesPerMuscle = (totalExerciseCount / muscleGroups.length).ceil();

    for (final muscleGroup in muscleGroups) {
      final progressions = ExerciseDifficultyMapping.getProgressionsForMuscleGroup(
        muscleGroup, // Use the actual muscle group directly
      );

      int count = 0;
      for (final progression in progressions) {
        if (count >= exercisesPerMuscle) break;

        String exerciseId;
        String exerciseName;
        
        switch (difficulty) {
          case 'beginner':
            exerciseId = progression.beginner;
            exerciseName = _formatExerciseName(progression.beginner);
            break;
          case 'intermediate':
            exerciseId = progression.intermediate;
            exerciseName = _formatExerciseName(progression.intermediate);
            break;
          case 'advanced':
            exerciseId = progression.advanced;
            exerciseName = _formatExerciseName(progression.advanced);
            break;
          default:
            continue;
        }

        exercises.add(WorkoutExercise(
          id: exerciseId,
          name: exerciseName,
          sets: sets,
          reps: reps,
          included: true,
          primaryMuscles: [muscleGroup],
        ));

        count++;
      }
    }

    // Limit to target count
    return exercises.take(totalExerciseCount + 2).toList();
  }

  /// Generate a circuit workout (HIIT style)
  static List<WorkoutExercise> generateCircuitWorkout({
    required String workoutType, // 'full_body', 'upper', 'lower', 'core'
    required String difficulty,
    required bool isGym,
  }) {
    // Circuit workouts use time-based sets
    final Map<String, int> timings = {
      'beginner': 30,     // 30 seconds work, 30 rest
      'intermediate': 40, // 40 seconds work, 20 rest
      'advanced': 45,     // 45 seconds work, 15 rest
    };

    final Map<String, int> restTimings = {
      'beginner': 30,
      'intermediate': 20,
      'advanced': 15,
    };

    final Map<String, int> exerciseCounts = {
      'beginner': 4,      // 4 exercises
      'intermediate': 6,  // 6 exercises
      'advanced': 8,      // 8 exercises
    };

    final workTime = timings[difficulty]!;
    final restTime = restTimings[difficulty]!;
    final exerciseCount = exerciseCounts[difficulty]!;

    List<String> muscleGroups;
    switch (workoutType) {
      case 'full_body':
        muscleGroups = ['chest', 'back', 'legs', 'core'];
        break;
      case 'upper':
        muscleGroups = ['chest', 'back', 'shoulders'];
        break;
      case 'lower':
        muscleGroups = ['legs', 'glutes'];
        break;
      case 'core':
        muscleGroups = ['core'];
        break;
      default:
        muscleGroups = ['full_body'];
    }

    final exercises = <WorkoutExercise>[];
    final allProgressions = muscleGroups
        .expand((mg) => ExerciseDifficultyMapping.getProgressionsForMuscleGroup(
              isGym ? mg : 'hiit',
            ))
        .toList();

    int count = 0;
    for (final progression in allProgressions) {
      if (count >= exerciseCount) break;

      String exerciseId;
      String exerciseName;

      switch (difficulty) {
        case 'beginner':
          exerciseId = progression.beginner;
          exerciseName = _formatExerciseName(progression.beginner);
          break;
        case 'intermediate':
          exerciseId = progression.intermediate;
          exerciseName = _formatExerciseName(progression.intermediate);
          break;
        case 'advanced':
          exerciseId = progression.advanced;
          exerciseName = _formatExerciseName(progression.advanced);
          break;
        default:
          continue;
      }

      exercises.add(WorkoutExercise(
        id: exerciseId,
        name: exerciseName,
        sets: 1, // Circuit rounds handled separately
        reps: 0, // Time-based
        timeSeconds: workTime,
        restSeconds: restTime,
        included: true,
        primaryMuscles: [progression.muscleGroup],
      ));

      count++;
    }

    return exercises;
  }

  /// Generate a full workout preset
  static WorkoutPreset generateWorkoutPreset({
    required String id,
    required String name,
    required String category,
    required String subcategory,
    required String difficulty,
    required String workoutType, // 'single_muscle', 'compound', 'circuit'
    List<String>? muscleGroups,
    String? icon,
    bool isCircuit = false,
    int? rounds,
  }) {
    final isGym = category == 'gym';
    List<WorkoutExercise> exercises;

    if (workoutType == 'circuit') {
      exercises = generateCircuitWorkout(
        workoutType: muscleGroups?.first ?? 'full_body',
        difficulty: difficulty,
        isGym: isGym,
      );
    } else if (muscleGroups != null && muscleGroups.length > 1) {
      exercises = generateCompoundWorkout(
        muscleGroups: muscleGroups,
        difficulty: difficulty,
        isGym: isGym,
      );
    } else {
      exercises = generateMuscleSplitWorkout(
        muscleGroup: muscleGroups?.first ?? 'full_body',
        difficulty: difficulty,
        isGym: isGym,
      );
    }

    // Calculate estimated duration
    final guidelines = volumeGuidelines[difficulty]!;
    final setsPerExercise = guidelines['sets'] as int;
    final restSeconds = guidelines['restSeconds'] as int;
    
    int durationMinutes;
    if (isCircuit) {
      final workTime = exercises.first.timeSeconds ?? 40;
      final circuitRounds = rounds ?? 3;
      durationMinutes = ((workTime + (exercises.first.restSeconds ?? 20)) * 
                         exercises.length * circuitRounds / 60).round();
    } else {
      // Estimate: 45 seconds per set + rest
      durationMinutes = ((45 + restSeconds) * setsPerExercise * exercises.length / 60).round();
    }

    return WorkoutPreset(
      id: '${id}_$difficulty',
      name: name,
      category: category,
      subcategory: subcategory,
      exercises: exercises,
      isCircuit: isCircuit,
      rounds: rounds,
      duration: '$durationMinutes min',
      icon: icon,
    );
  }

  /// Format exercise ID to display name
  static String _formatExerciseName(String exerciseId) {
    return exerciseId
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  /// Generate all variations (beginner, intermediate, advanced) for a workout
  static List<WorkoutPreset> generateAllDifficultyVariations({
    required String id,
    required String name,
    required String category,
    required String subcategory,
    required String workoutType,
    List<String>? muscleGroups,
    String? icon,
    bool isCircuit = false,
    int? rounds,
  }) {
    return [
      generateWorkoutPreset(
        id: id,
        name: name,
        category: category,
        subcategory: subcategory,
        difficulty: 'beginner',
        workoutType: workoutType,
        muscleGroups: muscleGroups,
        icon: icon,
        isCircuit: isCircuit,
        rounds: rounds,
      ),
      generateWorkoutPreset(
        id: id,
        name: name,
        category: category,
        subcategory: subcategory,
        difficulty: 'intermediate',
        workoutType: workoutType,
        muscleGroups: muscleGroups,
        icon: icon,
        isCircuit: isCircuit,
        rounds: rounds,
      ),
      generateWorkoutPreset(
        id: id,
        name: name,
        category: category,
        subcategory: subcategory,
        difficulty: 'advanced',
        workoutType: workoutType,
        muscleGroups: muscleGroups,
        icon: icon,
        isCircuit: isCircuit,
        rounds: rounds,
      ),
    ];
  }
}
