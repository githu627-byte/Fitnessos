/// Exercise Difficulty Progressions Database
/// Maps exercises by difficulty level with proper progressions
/// Based on NASM/ACSM standards and real-world programming principles

class ExerciseProgression {
  final String beginner;
  final String intermediate;
  final String advanced;
  final String muscleGroup;
  final String movementPattern; // 'push', 'pull', 'squat', 'hinge', 'carry', 'isolation'

  const ExerciseProgression({
    required this.beginner,
    required this.intermediate,
    required this.advanced,
    required this.muscleGroup,
    required this.movementPattern,
  });
}

class ExerciseDifficultyMapping {
  
  // CHEST PROGRESSIONS
  static const List<ExerciseProgression> chestProgressions = [
    // Horizontal Press Pattern
    ExerciseProgression(
      beginner: 'push_ups',
      intermediate: 'dumbbell_bench_press',
      advanced: 'barbell_bench_press',
      muscleGroup: 'chest',
      movementPattern: 'push',
    ),
    ExerciseProgression(
      beginner: 'incline_push_ups',
      intermediate: 'incline_dumbbell_press',
      advanced: 'incline_barbell_press',
      muscleGroup: 'chest',
      movementPattern: 'push',
    ),
    ExerciseProgression(
      beginner: 'machine_chest_press',
      intermediate: 'decline_dumbbell_press',
      advanced: 'decline_barbell_press',
      muscleGroup: 'chest',
      movementPattern: 'push',
    ),
    // Fly Pattern
    ExerciseProgression(
      beginner: 'cable_chest_fly',
      intermediate: 'dumbbell_chest_fly',
      advanced: 'cable_crossover',
      muscleGroup: 'chest',
      movementPattern: 'isolation',
    ),
  ];

  // BACK PROGRESSIONS
  static const List<ExerciseProgression> backProgressions = [
    // Vertical Pull Pattern
    ExerciseProgression(
      beginner: 'lat_pulldown',
      intermediate: 'assisted_pull_up',
      advanced: 'pull_up',
      muscleGroup: 'back',
      movementPattern: 'pull',
    ),
    ExerciseProgression(
      beginner: 'neutral_grip_lat_pulldown',
      intermediate: 'chin_up',
      advanced: 'weighted_pull_up',
      muscleGroup: 'back',
      movementPattern: 'pull',
    ),
    // Horizontal Pull Pattern
    ExerciseProgression(
      beginner: 'seated_cable_row',
      intermediate: 'dumbbell_row',
      advanced: 'barbell_bent_over_row',
      muscleGroup: 'back',
      movementPattern: 'pull',
    ),
    ExerciseProgression(
      beginner: 'machine_row',
      intermediate: 'chest_supported_row',
      advanced: 't_bar_row',
      muscleGroup: 'back',
      movementPattern: 'pull',
    ),
    // Hinge Pattern (Lower Back)
    ExerciseProgression(
      beginner: 'rack_pull',
      intermediate: 'barbell_romanian_deadlift',
      advanced: 'conventional_deadlift',
      muscleGroup: 'back',
      movementPattern: 'hinge',
    ),
    // Isolation
    ExerciseProgression(
      beginner: 'face_pull',
      intermediate: 'reverse_fly',
      advanced: 'rear_delt_fly',
      muscleGroup: 'back',
      movementPattern: 'isolation',
    ),
  ];

  // SHOULDER PROGRESSIONS
  static const List<ExerciseProgression> shoulderProgressions = [
    // Vertical Press Pattern
    ExerciseProgression(
      beginner: 'seated_dumbbell_press',
      intermediate: 'standing_dumbbell_press',
      advanced: 'barbell_overhead_press',
      muscleGroup: 'shoulders',
      movementPattern: 'push',
    ),
    ExerciseProgression(
      beginner: 'machine_shoulder_press',
      intermediate: 'arnold_press',
      advanced: 'push_press',
      muscleGroup: 'shoulders',
      movementPattern: 'push',
    ),
    // Lateral Raises
    ExerciseProgression(
      beginner: 'cable_lateral_raise',
      intermediate: 'dumbbell_lateral_raise',
      advanced: 'leaning_lateral_raise',
      muscleGroup: 'shoulders',
      movementPattern: 'isolation',
    ),
    // Front Raises
    ExerciseProgression(
      beginner: 'plate_front_raise',
      intermediate: 'dumbbell_front_raise',
      advanced: 'barbell_front_raise',
      muscleGroup: 'shoulders',
      movementPattern: 'isolation',
    ),
    // Rear Delts
    ExerciseProgression(
      beginner: 'face_pull',
      intermediate: 'rear_delt_fly',
      advanced: 'reverse_pec_deck',
      muscleGroup: 'shoulders',
      movementPattern: 'isolation',
    ),
  ];

  // LEG PROGRESSIONS
  static const List<ExerciseProgression> legProgressions = [
    // Squat Pattern
    ExerciseProgression(
      beginner: 'goblet_squat',
      intermediate: 'barbell_full_squat',
      advanced: 'front_squat',
      muscleGroup: 'legs',
      movementPattern: 'squat',
    ),
    ExerciseProgression(
      beginner: 'leg_press',
      intermediate: 'hack_squat',
      advanced: 'sissy_squat',
      muscleGroup: 'legs',
      movementPattern: 'squat',
    ),
    // Hinge Pattern
    ExerciseProgression(
      beginner: 'dumbbell_rdl',
      intermediate: 'barbell_romanian_deadlift',
      advanced: 'deficit_deadlift',
      muscleGroup: 'legs',
      movementPattern: 'hinge',
    ),
    // Lunge Pattern
    ExerciseProgression(
      beginner: 'static_lunge',
      intermediate: 'walking_lunge_male',
      advanced: 'bulgarian_split_squat',
      muscleGroup: 'legs',
      movementPattern: 'squat',
    ),
    ExerciseProgression(
      beginner: 'step_up',
      intermediate: 'reverse_lunge',
      advanced: 'deficit_reverse_lunge',
      muscleGroup: 'legs',
      movementPattern: 'squat',
    ),
    // Quad Isolation
    ExerciseProgression(
      beginner: 'leg_extension',
      intermediate: 'sissy_squat',
      advanced: 'spanish_squat',
      muscleGroup: 'legs',
      movementPattern: 'isolation',
    ),
    // Hamstring Isolation
    ExerciseProgression(
      beginner: 'seated_leg_curl',
      intermediate: 'lying_leg_curl',
      advanced: 'nordic_curl',
      muscleGroup: 'legs',
      movementPattern: 'isolation',
    ),
    // Calf
    ExerciseProgression(
      beginner: 'seated_calf_raise',
      intermediate: 'standing_calf_raise',
      advanced: 'single_leg_calf_raise',
      muscleGroup: 'legs',
      movementPattern: 'isolation',
    ),
  ];

  // GLUTE PROGRESSIONS (for booty-focused workouts)
  static const List<ExerciseProgression> gluteProgressions = [
    // Hip Thrust Pattern
    ExerciseProgression(
      beginner: 'glute_bridge',
      intermediate: 'hip_thrusts',
      advanced: 'elevated_glute_bridge',
      muscleGroup: 'glutes',
      movementPattern: 'hinge',
    ),
    // Abduction Pattern
    // ExerciseProgression(
    //   beginner: 'clamshell',
    //   intermediate: 'side_lying_leg_lift',
    //   advanced: 'fire_hydrant_pulse',
    //   muscleGroup: 'glutes',
    //   movementPattern: 'isolation',
    // ),
    // Kickback Pattern
    ExerciseProgression(
      beginner: 'standing_glute_kickback',
      intermediate: 'donkey_kick',
      advanced: 'donkey_kick_pulse',
      muscleGroup: 'glutes',
      movementPattern: 'isolation',
    ),
    // Lunge Variations (glute emphasis)
    ExerciseProgression(
      beginner: 'reverse_lunge',
      intermediate: 'curtsy_lunge',
      advanced: 'pulse_curtsy_lunge',
      muscleGroup: 'glutes',
      movementPattern: 'squat',
    ),
    // Squat Variations (glute emphasis)
    ExerciseProgression(
      beginner: 'sumo_squat',
      intermediate: 'sumo_squat_pulse',
      advanced: 'sumo_squat_hold_pulse',
      muscleGroup: 'glutes',
      movementPattern: 'squat',
    ),
    // Hip Extension
    ExerciseProgression(
      beginner: 'bird_dog',
      intermediate: 'quadruped_hip_extension',
      advanced: 'quadruped_hip_extension_pulse',
      muscleGroup: 'glutes',
      movementPattern: 'hinge',
    ),
    // Frog Pump Pattern
    ExerciseProgression(
      beginner: 'frog_pump',
      intermediate: 'frog_pump_pulse',
      advanced: 'frog_pump_hold_pulse',
      muscleGroup: 'glutes',
      movementPattern: 'hinge',
    ),
    // Romanian Deadlift Pattern (bodyweight)
    ExerciseProgression(
      beginner: 'standing_glute_squeeze',
      intermediate: 'single_leg_rdl',
      advanced: 'single_leg_rdl_pulse',
      muscleGroup: 'glutes',
      movementPattern: 'hinge',
    ),
  ];

  // ARM PROGRESSIONS
  static const List<ExerciseProgression> bicepProgressions = [
    ExerciseProgression(
      beginner: 'cable_bicep_curl',
      intermediate: 'dumbbell_bicep_curl',
      advanced: 'barbell_bicep_curl',
      muscleGroup: 'arms',
      movementPattern: 'isolation',
    ),
    ExerciseProgression(
      beginner: 'preacher_curl_machine',
      intermediate: 'preacher_curl',
      advanced: 'spider_curl',
      muscleGroup: 'arms',
      movementPattern: 'isolation',
    ),
    ExerciseProgression(
      beginner: 'seated_hammer_curl',
      intermediate: 'standing_hammer_curl',
      advanced: 'cross_body_hammer_curl',
      muscleGroup: 'arms',
      movementPattern: 'isolation',
    ),
  ];

  static const List<ExerciseProgression> tricepProgressions = [
    ExerciseProgression(
      beginner: 'cable_pushdown',
      intermediate: 'overhead_tricep_extension',
      advanced: 'skull_crusher',
      muscleGroup: 'arms',
      movementPattern: 'isolation',
    ),
    ExerciseProgression(
      beginner: 'bench_dip',
      intermediate: 'dip_machine',
      advanced: 'weighted_dip',
      muscleGroup: 'arms',
      movementPattern: 'push',
    ),
    ExerciseProgression(
      beginner: 'close_grip_push_up',
      intermediate: 'close_grip_bench_press',
      advanced: 'jm_press',
      muscleGroup: 'arms',
      movementPattern: 'push',
    ),
  ];

  // CORE PROGRESSIONS
  static const List<ExerciseProgression> coreProgressions = [
    // Anti-Extension
    // ExerciseProgression(
    //   beginner: 'plank',
    //   intermediate: 'ab_wheel_kneeling',
    //   advanced: 'ab_wheel_standing',
    //   muscleGroup: 'core',
    //   movementPattern: 'isolation',
    // ),
    // Anti-Rotation
    ExerciseProgression(
      beginner: 'pallof_press_kneeling',
      intermediate: 'pallof_press_standing',
      advanced: 'pallof_press_split_stance',
      muscleGroup: 'core',
      movementPattern: 'isolation',
    ),
    // Flexion
    ExerciseProgression(
      beginner: 'crunch',
      intermediate: 'cable_crunch',
      advanced: 'decline_weighted_sit_up',
      muscleGroup: 'core',
      movementPattern: 'isolation',
    ),
    // Lower Abs
    ExerciseProgression(
      beginner: 'dead_bug',
      intermediate: 'lying_leg_raise',
      advanced: 'hanging_leg_raise',
      muscleGroup: 'core',
      movementPattern: 'isolation',
    ),
    // Obliques
    ExerciseProgression(
      beginner: 'side_plank',
      intermediate: 'russian_twist',
      advanced: 'landmine_rotation',
      muscleGroup: 'core',
      movementPattern: 'isolation',
    ),
  ];

  // BODYWEIGHT PROGRESSIONS (for home workouts)
  static const List<ExerciseProgression> bodyweightProgressions = [
    // Push Pattern
    ExerciseProgression(
      beginner: 'incline_push_up',
      intermediate: 'push_up',
      advanced: 'decline_push_up',
      muscleGroup: 'chest',
      movementPattern: 'push',
    ),
    ExerciseProgression(
      beginner: 'wall_push_up',
      intermediate: 'diamond_push_up',
      advanced: 'archer_push_up',
      muscleGroup: 'chest',
      movementPattern: 'push',
    ),
    // Pull Pattern
    ExerciseProgression(
      beginner: 'inverted_row',
      intermediate: 'chin_up',
      advanced: 'pull_up',
      muscleGroup: 'back',
      movementPattern: 'pull',
    ),
    // Squat Pattern
    ExerciseProgression(
      beginner: 'air_squat',
      intermediate: 'jump_squat',
      advanced: 'pistol_squat',
      muscleGroup: 'legs',
      movementPattern: 'squat',
    ),
    // Lunge Pattern
    ExerciseProgression(
      beginner: 'static_lunge',
      intermediate: 'walking_lunge_male',
      advanced: 'jumping_lunge',
      muscleGroup: 'legs',
      movementPattern: 'squat',
    ),
    // Core
    ExerciseProgression(
      beginner: 'plank',
      intermediate: 'mountain_climber',
      advanced: 'burpee',
      muscleGroup: 'core',
      movementPattern: 'isolation',
    ),
  ];

  // HIIT/CIRCUIT PROGRESSIONS (expanded for variety)
  static const List<ExerciseProgression> hiitProgressions = [
    // Cardio Bursts
    ExerciseProgression(
      beginner: 'marching_in_place',
      intermediate: 'high_knee',
      advanced: 'high_knee_sprint',
      muscleGroup: 'full_body',
      movementPattern: 'cardio',
    ),
    ExerciseProgression(
      beginner: 'step_touch',
      intermediate: 'jumping_jack',
      advanced: 'star_jump',
      muscleGroup: 'full_body',
      movementPattern: 'cardio',
    ),
    ExerciseProgression(
      beginner: 'knee_tap',
      intermediate: 'butt_kick',
      advanced: 'butt_kick_sprint',
      muscleGroup: 'legs',
      movementPattern: 'cardio',
    ),
    // Full Body Explosive
    ExerciseProgression(
      beginner: 'squat_reach',
      intermediate: 'jump_squat',
      advanced: 'tuck_jump',
      muscleGroup: 'legs',
      movementPattern: 'cardio',
    ),
    ExerciseProgression(
      beginner: 'step_up',
      intermediate: 'box_step_up',
      advanced: 'box_jump',
      muscleGroup: 'legs',
      movementPattern: 'cardio',
    ),
    // ExerciseProgression(
    //   beginner: 'plank_walk_out',
    //   intermediate: 'inchworm',
    //   advanced: 'burpee',
    //   muscleGroup: 'full_body',
    //   movementPattern: 'cardio',
    // ),
    ExerciseProgression(
      beginner: 'modified_burpee',
      intermediate: 'burpee',
      advanced: 'burpee_tuck_jump',
      muscleGroup: 'full_body',
      movementPattern: 'cardio',
    ),
    // Core + Cardio
    ExerciseProgression(
      beginner: 'standing_oblique_crunch',
      intermediate: 'mountain_climber',
      advanced: 'mountain_climber_crossover',
      muscleGroup: 'core',
      movementPattern: 'cardio',
    ),
    ExerciseProgression(
      beginner: 'plank_tap',
      intermediate: 'plank_jack',
      advanced: 'burpee_sprawl',
      muscleGroup: 'core',
      movementPattern: 'cardio',
    ),
    // Lateral Movement
    ExerciseProgression(
      beginner: 'side_step',
      intermediate: 'lateral_shuffle',
      advanced: 'skater_hop',
      muscleGroup: 'legs',
      movementPattern: 'cardio',
    ),
  ];

  /// Get all progressions for a specific muscle group
  static List<ExerciseProgression> getProgressionsForMuscleGroup(String muscleGroup) {
    switch (muscleGroup.toLowerCase()) {
      case 'chest':
        return chestProgressions;
      case 'back':
        return backProgressions;
      case 'shoulders':
        return shoulderProgressions;
      case 'legs':
        return legProgressions;
      case 'glutes':
        return gluteProgressions;
      case 'biceps':
        return bicepProgressions;
      case 'triceps':
        return tricepProgressions;
      case 'arms':
        return [...bicepProgressions, ...tricepProgressions];
      case 'core':
        return coreProgressions;
      case 'bodyweight':
        return bodyweightProgressions;
      case 'hiit':
      case 'cardio':
        return hiitProgressions;
      default:
        return [];
    }
  }

  /// Get exercise ID for specific difficulty level
  static String getExerciseForDifficulty(String exerciseId, String difficulty) {
    // Search through all progressions to find matching exercise
    final allProgressions = [
      ...chestProgressions,
      ...backProgressions,
      ...shoulderProgressions,
      ...legProgressions,
      ...gluteProgressions,
      ...bicepProgressions,
      ...tricepProgressions,
      ...coreProgressions,
      ...bodyweightProgressions,
      ...hiitProgressions,
    ];

    for (final progression in allProgressions) {
      if (progression.beginner == exerciseId ||
          progression.intermediate == exerciseId ||
          progression.advanced == exerciseId) {
        switch (difficulty.toLowerCase()) {
          case 'beginner':
            return progression.beginner;
          case 'intermediate':
            return progression.intermediate;
          case 'advanced':
            return progression.advanced;
          default:
            return exerciseId; // Return original if difficulty not recognized
        }
      }
    }

    return exerciseId; // Return original if no progression found
  }

  /// Get all exercises for a difficulty level and muscle group
  static List<String> getExercisesForDifficultyAndMuscle({
    required String difficulty,
    required String muscleGroup,
  }) {
    final progressions = getProgressionsForMuscleGroup(muscleGroup);
    final exercises = <String>[];

    for (final progression in progressions) {
      switch (difficulty.toLowerCase()) {
        case 'beginner':
          exercises.add(progression.beginner);
          break;
        case 'intermediate':
          exercises.add(progression.intermediate);
          break;
        case 'advanced':
          exercises.add(progression.advanced);
          break;
      }
    }

    return exercises;
  }
}
