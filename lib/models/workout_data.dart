import 'workout_models.dart';
import '../services/workout_template_service.dart';

// Force rebuild - removed isGym parameter (auto-determined from category)
class Exercise {
  final String id;
  final String name;
  final String difficulty; // 'beginner', 'intermediate', 'advanced'
  final String equipment; // 'weights', 'bodyweight', 'none'

  const Exercise({
    required this.id,
    required this.name,
    required this.difficulty,
    required this.equipment,
  });
}

class CircuitExercise {
  final String name;
  final int timeSeconds;
  final int restSeconds;

  const CircuitExercise({
    required this.name,
    required this.timeSeconds,
    required this.restSeconds,
  });
}

class CircuitWorkout {
  final String id;
  final String name;
  final String duration;
  final List<CircuitExercise> exercises;
  final int rounds;
  final String difficulty;

  const CircuitWorkout({
    required this.id,
    required this.name,
    required this.duration,
    required this.exercises,
    required this.rounds,
    required this.difficulty,
  });
}

class TrainingSplitDay {
  final String name;
  final List<String> exercises;

  const TrainingSplitDay({
    required this.name,
    required this.exercises,
  });
}

class TrainingSplit {
  final String id;
  final String name;
  final String icon;
  final List<TrainingSplitDay> days;

  const TrainingSplit({
    required this.id,
    required this.name,
    required this.icon,
    required this.days,
  });
}

class WorkoutCategory {
  final String id;
  final String name;
  final String icon;
  final String description;

  const WorkoutCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
  });
}

// Complete Exercise Database
class WorkoutData {
  // Muscle Split Categories
  static const Map<String, List<Exercise>> muscleSplits = {
    'chest': [
      Exercise(id: 'barbell_bench_press', name: 'Bench Press', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'barbell_incline_bench_press', name: 'Incline Press', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'barbell_decline_bench_press', name: 'Decline Press', difficulty: 'intermediate', equipment: 'weights'),
      //Exercise(id: 'dumbbell_fly', name: 'Chest Flys', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use chest_fly
      //Exercise(id: 'push_up_m', name: 'Push-ups', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use pushup
      //Exercise(id: 'chest_dip', name: 'Dips (Chest)', difficulty: 'advanced', equipment: 'bodyweight'),  // DUPLICATE - use chest_dips
      Exercise(id: 'cable_crossover_variation', name: 'Cable Crossovers', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'barbell_standing_military_press', name: 'Landmine Press', difficulty: 'intermediate', equipment: 'weights'),
    ],
    'back': [
      Exercise(id: 'barbell_deadlift', name: 'Deadlift', difficulty: 'advanced', equipment: 'weights'),
      //Exercise(id: 'barbell_bent_over_row', name: 'Bent-Over Rows', difficulty: 'intermediate', equipment: 'weights'),  // DUPLICATE - use bent_over_row
      //Exercise(id: 'pull_up', name: 'Pull-ups', difficulty: 'advanced', equipment: 'bodyweight'),  // DUPLICATE - use pullup
      Exercise(id: 'cable_bar_lateral_pulldown', name: 'Lat Pulldowns', difficulty: 'beginner', equipment: 'weights'),
      //Exercise(id: 'cable_seated_row', name: 'Cable Rows', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use cable_row
      //Exercise(id: 'lever_t_bar_row_plate_loaded', name: 'T-Bar Rows', difficulty: 'intermediate', equipment: 'weights'),  // DUPLICATE - use tbar_row
      //Exercise(id: 'cable_cross_over_revers_fly', name: 'Face Pulls', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use face_pull
      //Exercise(id: 'dumbbell_rear_fly', name: 'Reverse Flys', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use reverse_fly
      //Exercise(id: 'barbell_shrug', name: 'Shrugs', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use shrug
    ],
    'shoulders': [
      Exercise(id: 'barbell_standing_military_press', name: 'Overhead Press', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'dumbbell_arnold_press', name: 'Arnold Press', difficulty: 'intermediate', equipment: 'weights'),
      //Exercise(id: 'dumbbell_lateral_raise', name: 'Lateral Raises', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use lateral_raise
      //Exercise(id: 'dumbbell_front_raise', name: 'Front Raises', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use front_raise
      //Exercise(id: 'dumbbell_rear_fly', name: 'Rear Delt Flys', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use rear_delt_fly
      //Exercise(id: 'barbell_upright_row', name: 'Upright Rows', difficulty: 'intermediate', equipment: 'weights'),  // DUPLICATE - use upright_row
      //Exercise(id: 'decline_push_up_m', name: 'Pike Push-ups', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use pike_pushup
    ],
    'legs': [
      //Exercise(id: 'squat_m', name: 'Squats', difficulty: 'intermediate', equipment: 'weights'),  // DUPLICATE - use squat
      Exercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', difficulty: 'intermediate', equipment: 'weights'),
      //Exercise(id: 'dumbbell_lunge', name: 'Lunges', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use lunge
      //Exercise(id: 'dumbbell_single_leg_split_squat', name: 'Bulgarian Split Squats', difficulty: 'advanced', equipment: 'weights'),  // DUPLICATE - use bulgarian_split_squat
      Exercise(id: 'lever_seated_leg_press', name: 'Leg Press', difficulty: 'beginner', equipment: 'weights'),
      //Exercise(id: 'lever_leg_extension', name: 'Leg Extensions', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use leg_extension
      //Exercise(id: 'lever_lying_leg_curl', name: 'Leg Curls', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use leg_curl
      //Exercise(id: 'lever_standing_calf_raise', name: 'Calf Raises', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use calf_raise
      //Exercise(id: 'dumbbell_step_up', name: 'Step-ups', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use step_up
      //Exercise(id: 'dumbbell_goblet_squat', name: 'Goblet Squats', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use goblet_squat
      //Exercise(id: 'squat_m', name: 'Wall Sits', difficulty: 'beginner', equipment: 'bodyweight'),
      //Exercise(id: 'squat_m', name: 'Jump Squats', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use jump_squat
    ],
    'arms': [
      //Exercise(id: 'dumbbell_biceps_curl', name: 'Bicep Curls', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use bicep_curl
      //Exercise(id: 'dumbbell_hammer_curl', name: 'Hammer Curls', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use hammer_curl
      //Exercise(id: 'barbell_preacher_curl', name: 'Preacher Curls', difficulty: 'intermediate', equipment: 'weights'),  // DUPLICATE - use preacher_curl
      //Exercise(id: 'lever_triceps_extension', name: 'Tricep Extensions', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use tricep_extension
      //Exercise(id: 'barbell_lying_close_grip_triceps_extension', name: 'Skull Crushers', difficulty: 'intermediate', equipment: 'weights'),  // DUPLICATE - use skull_crusher
      //Exercise(id: 'barbell_standing_overhead_triceps_extension', name: 'Overhead Tricep Extension', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use overhead_tricep_extension
      //Exercise(id: 'close_grip_push_up', name: 'Close-grip Push-ups', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use close_grip_pushup
      //Exercise(id: 'dumbbell_concentration_curl', name: 'Concentration Curls', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use concentration_curl
      //Exercise(id: 'cable_curl_male', name: 'Cable Curls', difficulty: 'beginner', equipment: 'weights'),  // DUPLICATE - use cable_curl
      //Exercise(id: 'close_grip_push_up', name: 'Diamond Push-ups', difficulty: 'advanced', equipment: 'bodyweight'),  // DUPLICATE - use diamond_pushup
    ],
    'core': [
      //Exercise(id: 'sit_up_ii', name: 'Sit-ups', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use situp
      //Exercise(id: 'crunch_floor_m', name: 'Crunches', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use crunch
      //Exercise(id: 'front_plank', name: 'Planks', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use plank
      //Exercise(id: 'side_plank_male', name: 'Side Planks', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use side_plank
      //Exercise(id: 'lying_leg_raise', name: 'Leg Raises', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use leg_raise
      //Exercise(id: 'russian_twist_with_medicine_ball', name: 'Russian Twists', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use russian_twist
      //Exercise(id: 'burpee', name: 'Mountain Climbers', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use mountain_climber
      //Exercise(id: 'cross_body_crunch', name: 'Bicycle Crunches', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use bicycle_crunch
    ],
  };

  // Circuit Workouts
  static const List<CircuitWorkout> circuits = [
    CircuitWorkout(
      id: 'full_body_hiit',
      name: 'FULL BODY HIIT',
      duration: '20 min',
      difficulty: 'intermediate',
      rounds: 3,
      exercises: [
        CircuitExercise(name: 'Burpees', timeSeconds: 45, restSeconds: 15),
        CircuitExercise(name: 'Jump Squats', timeSeconds: 45, restSeconds: 15),
        CircuitExercise(name: 'Push-ups', timeSeconds: 45, restSeconds: 15),
        CircuitExercise(name: 'Mountain Climbers', timeSeconds: 45, restSeconds: 15),
      ],
    ),
    CircuitWorkout(
      id: 'upper_blast',
      name: 'UPPER BODY BURNER',
      duration: '15 min',
      difficulty: 'intermediate',
      rounds: 3,
      exercises: [
        CircuitExercise(name: 'Burpees', timeSeconds: 40, restSeconds: 20),
        CircuitExercise(name: 'Pike Push-ups', timeSeconds: 40, restSeconds: 20),
        //CircuitExercise(name: 'Superman Raises', timeSeconds: 40, restSeconds: 20),
        CircuitExercise(name: 'Diamond Push-ups', timeSeconds: 40, restSeconds: 20),
        CircuitExercise(name: 'Plank Hold', timeSeconds: 40, restSeconds: 20),
      ],
    ),
    CircuitWorkout(
      id: 'leg_burner',
      name: 'LEG BURNER',
      duration: '18 min',
      difficulty: 'advanced',
      rounds: 3,
      exercises: [
        CircuitExercise(name: 'Jump Squats', timeSeconds: 50, restSeconds: 10),
        CircuitExercise(name: 'Lunges', timeSeconds: 50, restSeconds: 10),
        //CircuitExercise(name: 'Wall Sits', timeSeconds: 50, restSeconds: 10),
        CircuitExercise(name: 'Calf Raises', timeSeconds: 50, restSeconds: 10),
      ],
    ),
    CircuitWorkout(
      id: 'cardio_blast',
      name: 'CARDIO BLAST',
      duration: '25 min',
      difficulty: 'intermediate',
      rounds: 4,
      exercises: [
        CircuitExercise(name: 'Jumping Jacks', timeSeconds: 45, restSeconds: 15),
        CircuitExercise(name: 'High Knees', timeSeconds: 45, restSeconds: 15),
        CircuitExercise(name: 'Butt Kicks', timeSeconds: 45, restSeconds: 15),
        CircuitExercise(name: 'Burpees', timeSeconds: 45, restSeconds: 15),
      ],
    ),
    CircuitWorkout(
      id: 'core_destroyer',
      name: 'CORE DESTROYER',
      duration: '12 min',
      difficulty: 'beginner',
      rounds: 3,
      exercises: [
        CircuitExercise(name: 'Planks', timeSeconds: 45, restSeconds: 15),
        CircuitExercise(name: 'Russian Twists', timeSeconds: 45, restSeconds: 15),
        CircuitExercise(name: 'Leg Raises', timeSeconds: 45, restSeconds: 15),
        CircuitExercise(name: 'Bicycle Crunches', timeSeconds: 45, restSeconds: 15),
        CircuitExercise(name: 'Mountain Climbers', timeSeconds: 45, restSeconds: 15),
      ],
    ),
    CircuitWorkout(
      id: 'arms_arsenal',
      name: 'ARMS ANNIHILATOR',
      duration: '18 min',
      difficulty: 'intermediate',
      rounds: 3,
      exercises: [
        CircuitExercise(name: 'Diamond Push-ups', timeSeconds: 40, restSeconds: 20),
        CircuitExercise(name: 'Inverted Rows', timeSeconds: 40, restSeconds: 20),
        CircuitExercise(name: 'Tricep Dips', timeSeconds: 40, restSeconds: 20),
        CircuitExercise(name: 'Chin-up Hold (door frame)', timeSeconds: 40, restSeconds: 20),
        CircuitExercise(name: 'Close-grip Push-ups', timeSeconds: 40, restSeconds: 20),
        CircuitExercise(name: 'Towel Bicep Curls', timeSeconds: 40, restSeconds: 20),
      ],
    ),
    CircuitWorkout(
      id: 'endurance_builder',
      name: 'ENDURANCE BUILDER',
      duration: '30 min',
      difficulty: 'advanced',
      rounds: 4,
      exercises: [
        CircuitExercise(name: 'Burpees', timeSeconds: 50, restSeconds: 10),
        CircuitExercise(name: 'Jump Squats', timeSeconds: 50, restSeconds: 10),
        CircuitExercise(name: 'Mountain Climbers', timeSeconds: 50, restSeconds: 10),
        CircuitExercise(name: 'High Knees', timeSeconds: 50, restSeconds: 10),
        //CircuitExercise(name: 'Bear Crawls', timeSeconds: 50, restSeconds: 10),
      ],
    ),
  ];

  // Training Splits
  static const List<TrainingSplit> trainingSplits = [
    TrainingSplit(
      id: 'ppl',
      name: 'PUSH/PULL/LEGS',
      icon: 'splits',
      days: [
        TrainingSplitDay(
          name: 'PUSH DAY',
          exercises: ['Bench Press', 'Overhead Press', 'Tricep Extensions', 'Lateral Raises', 'Dips'],
        ),
        TrainingSplitDay(
          name: 'PULL DAY',
          exercises: ['Deadlift', 'Pull-ups', 'Bent Rows', 'Face Pulls', 'Bicep Curls'],
        ),
        TrainingSplitDay(
          name: 'LEG DAY',
          exercises: ['Squats', 'Romanian Deadlift', 'Leg Press', 'Leg Curls', 'Calf Raises'],
        ),
      ],
    ),
    TrainingSplit(
      id: 'upper_lower',
      name: 'UPPER/LOWER',
      icon: 'splits',
      days: [
        TrainingSplitDay(
          name: 'UPPER BODY',
          exercises: ['Bench Press', 'Bent Rows', 'Overhead Press', 'Pull-ups', 'Dips'],
        ),
        TrainingSplitDay(
          name: 'LOWER BODY',
          exercises: ['Squats', 'Romanian Deadlift', 'Lunges', 'Leg Curls', 'Calf Raises'],
        ),
      ],
    ),
    TrainingSplit(
      id: 'full_body',
      name: 'FULL BODY',
      icon: 'splits',
      days: [
        TrainingSplitDay(
          name: 'FULL BODY A',
          exercises: ['Squats', 'Bench Press', 'Bent Rows', 'Overhead Press', 'Planks'],
        ),
        TrainingSplitDay(
          name: 'FULL BODY B',
          exercises: ['Deadlift', 'Pull-ups', 'Dips', 'Lunges', 'Russian Twists'],
        ),
      ],
    ),
  ];

  // At Home Exercises
  static const List<Exercise> atHomeExercises = [
    //Exercise(id: 'push_up_m', name: 'Push-ups', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use pushup
    //Exercise(id: 'pull_up', name: 'Pull-ups', difficulty: 'advanced', equipment: 'bodyweight'),  // DUPLICATE - use pullup
    //Exercise(id: 'chest_dip', name: 'Dips', difficulty: 'advanced', equipment: 'bodyweight'),  // DUPLICATE - use chest_dips
    //Exercise(id: 'dumbbell_lunge', name: 'Lunges', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use lunge
    //Exercise(id: 'squat_m', name: 'Bodyweight Squats', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use squat
    //Exercise(id: 'front_plank', name: 'Planks', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use plank
    //Exercise(id: 'burpee', name: 'Mountain Climbers', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use mountain_climber
    //Exercise(id: 'burpee', name: 'Burpees', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use burpee
    //Exercise(id: 'decline_push_up_m', name: 'Pike Push-ups', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use pike_pushup
    //Exercise(id: 'squat_m', name: 'Wall Sits', difficulty: 'beginner', equipment: 'bodyweight'),
  ];

  // Cardio Only Exercises
  static const List<Exercise> cardioExercises = [
    //Exercise(id: 'burpee', name: 'Burpees', difficulty: 'intermediate', equipment: 'none'),  // DUPLICATE - use burpee
    //Exercise(id: 'stationary_bike_run_version_3', name: 'Jumping Jacks', difficulty: 'beginner', equipment: 'none'),  // DUPLICATE - use jumping_jack
    //Exercise(id: 'stationary_bike_run_version_3', name: 'High Knees', difficulty: 'beginner', equipment: 'none'),  // DUPLICATE - use high_knee
    //Exercise(id: 'stationary_bike_run_version_3', name: 'Butt Kicks', difficulty: 'beginner', equipment: 'none'),  // DUPLICATE - use butt_kick
    //Exercise(id: 'squat_m', name: 'Box Jumps', difficulty: 'advanced', equipment: 'none'),  // DUPLICATE - use box_jump
    Exercise(id: 'stationary_bike_run_version_3', name: 'Jump Rope', difficulty: 'intermediate', equipment: 'none'),
    // Exercise(id: 'front_plank', name: 'Bear Crawls', difficulty: 'intermediate', equipment: 'none'),
    //Exercise(id: 'burpee', name: 'Sprawls', difficulty: 'advanced', equipment: 'none'),  // DUPLICATE - use sprawl
    //Exercise(id: 'squat_m', name: 'Skaters', difficulty: 'intermediate', equipment: 'none'),  // DUPLICATE - use skater
    //Exercise(id: 'squat_m', name: 'Tuck Jumps', difficulty: 'advanced', equipment: 'none'),  // DUPLICATE - use tuck_jump
    //Exercise(id: 'squat_m', name: 'Star Jumps', difficulty: 'beginner', equipment: 'none'),  // DUPLICATE - use star_jump
    //Exercise(id: 'squat_m', name: 'Lateral Hops', difficulty: 'intermediate', equipment: 'none'),  // DUPLICATE - use lateral_hop
  ];

  // Main Categories
  static const List<WorkoutCategory> categories = [
    WorkoutCategory(
      id: 'splits',
      name: 'MUSCLE SPLITS',
      icon: 'arms',
      description: 'Target specific muscle groups',
    ),
    WorkoutCategory(
      id: 'circuits',
      name: 'CIRCUITS',
      icon: 'circuits',
      description: 'High-intensity timed workouts',
    ),
    WorkoutCategory(
      id: 'training_splits',
      name: 'TRAINING SPLITS',
      icon: 'splits',
      description: 'Classic workout splits',
    ),
    WorkoutCategory(
      id: 'at_home',
      name: 'AT HOME',
      icon: 'bodyweight',
      description: 'No equipment needed',
    ),
    WorkoutCategory(
      id: 'cardio',
      name: 'CARDIO ONLY',
      icon: 'circuits',
      description: 'Pure cardio exercises',
    ),
  ];

  static const Map<String, String> muscleSplitInfo = {
    'chest': 'CHEST',
    'back': 'BACK',
    'shoulders': 'SHOULDERS',
    'legs': 'LEGS',
    'arms': 'ARMS',
    'core': 'CORE',
  };

  // ==================== WORKOUT PRESETS ====================
  
  // DYNAMIC WORKOUT GENERATION
  // Generate workouts based on difficulty level using WorkoutTemplateService
  
  // GYM MODE - MUSCLE SPLITS (Individual body parts)
  static List<WorkoutPreset> getGymMuscleSplits(String difficulty) {
    return [
      _getGymChestWorkout(difficulty),
      _getGymBackWorkout(difficulty),
      _getGymShouldersWorkout(difficulty),
      _getGymLegsWorkout(difficulty),
      _getGymArmsWorkout(difficulty),
      _getGymCoreWorkout(difficulty),
    ];
  }

  // CHEST WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymChestWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'lever_chest_press',
            name: 'Chest Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_standing_fly',
            name: 'Chest Fly (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Bench Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_incline_bench_press',
            name: 'Incline Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_decline_bench_press',
            name: 'Decline Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_fly',
            name: 'Chest Fly (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_standing_fly',
            name: 'Cable Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Bench Press (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_incline_bench_press',
            name: 'Incline Bench (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_decline_bench_press',
            name: 'Decline Bench (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_fly',
            name: 'Chest Fly (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_crossover_variation',
            name: 'Cable Crossover',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'chest_dip',
            name: 'Chest Dip',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_chest',
      name: 'CHEST',
      category: 'gym',
      subcategory: 'muscle_splits',
      exercises: exercises,
      isCircuit: false,
      icon: 'chest',
    );
  }

  // BACK WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymBackWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_seated_row',
            name: 'Seated Row (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Bent Over Row (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_seated_row',
            name: 'Seated Row (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'lever_t_bar_row_plate_loaded',
            name: 'T-Bar Row (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_deadlift',
            name: 'Deadlift (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['hamstrings', 'glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_bent_over_row',
            name: 'Bent Over Row (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'pull_up',
            name: 'Pull-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_seated_row',
            name: 'Seated Row (Cable)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'lever_seated_reverse_fly',
            name: 'Reverse Fly (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'lever_t_bar_row_plate_loaded',
            name: 'T-Bar Row (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_back',
      name: 'BACK',
      category: 'gym',
      subcategory: 'muscle_splits',
      exercises: exercises,
      isCircuit: false,
      icon: 'back',
    );
  }

  // SHOULDERS WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymShouldersWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_seated_shoulder_press',
            name: 'Shoulder Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_front_raise',
            name: 'Front Raise (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Shoulder Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_front_raise',
            name: 'Front Raise (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'barbell_upright_row',
            name: 'Upright Row (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['traps'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Military Press (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_arnold_press',
            name: 'Arnold Press (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_lateral_raise',
            name: 'Cable Lateral Raise',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'barbell_upright_row',
            name: 'Upright Row (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['traps'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_shoulders',
      name: 'SHOULDERS',
      category: 'gym',
      subcategory: 'muscle_splits',
      exercises: exercises,
      isCircuit: false,
      icon: 'arms',
    );
  }

  // LEGS WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymLegsWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_curl',
            name: 'Leg Curl (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Lunge (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_front_squat',
            name: 'Front Squat (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_legs',
      name: 'LEGS',
      category: 'gym',
      subcategory: 'muscle_splits',
      exercises: exercises,
      isCircuit: false,
      icon: 'legs',
    );
  }

  // ARMS WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymArmsWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'dumbbell_biceps_curl',
            name: 'Bicep Curl (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_triceps_pushdown_v_bar_attachment',
            name: 'Tricep Pushdown (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_hammer_curl',
            name: 'Hammer Curl (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['biceps'],
            secondaryMuscles: ['forearms'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_lying_close_grip_triceps_extension',
            name: 'Skull Crusher (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_hammer_curl',
            name: 'Hammer Curl (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: ['forearms'],
          ),
          WorkoutExercise(
            id: 'cable_triceps_pushdown_v_bar_attachment',
            name: 'Tricep Pushdown (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_concentration_curl',
            name: 'Concentration Curl (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_lying_close_grip_triceps_extension',
            name: 'Skull Crusher (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_cross_body_hammer_curl',
            name: 'Cross Body Hammer Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['biceps'],
            secondaryMuscles: ['forearms'],
          ),
          WorkoutExercise(
            id: 'chest_dip',
            name: 'Weighted Dip',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
          WorkoutExercise(
            id: 'barbell_preacher_curl',
            name: 'Preacher Curl (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_close_grip_bench_press',
            name: 'Close Grip Bench (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
          WorkoutExercise(
            id: 'cable_overhead_triceps_extension',
            name: 'Overhead Extension (Cable)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_arms',
      name: 'ARMS',
      category: 'gym',
      subcategory: 'muscle_splits',
      exercises: exercises,
      isCircuit: false,
      icon: 'arms',
    );
  }

  // CORE WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymCoreWorkout(String difficulty) {
    // Core returns the same exercises regardless of difficulty
    List<WorkoutExercise> exercises = [
      WorkoutExercise(
        id: 'cross_body_crunch',
        name: 'Crunch',
        sets: 3,
        reps: 15,
        primaryMuscles: ['core'],
        secondaryMuscles: [],
      ),
      WorkoutExercise(
        id: 'lying_leg_raise_flat_bench',
        name: 'Lying Leg Raise',
        sets: 3,
        reps: 12,
        primaryMuscles: ['core'],
        secondaryMuscles: [],
      ),
      WorkoutExercise(
        id: 'russian_twist_with_medicine_ball',
        name: 'Russian Twist',
        sets: 3,
        reps: 20,
        primaryMuscles: ['core'],
        secondaryMuscles: [],
      ),
      WorkoutExercise(
        id: 'cable_standing_crunch_with_rope_attachment',
        name: 'Cable Crunch',
        sets: 3,
        reps: 15,
        primaryMuscles: ['core'],
        secondaryMuscles: [],
      ),
    ];

    return WorkoutPreset(
      id: 'gym_core',
      name: 'CORE',
      category: 'gym',
      subcategory: 'muscle_splits',
      exercises: exercises,
      isCircuit: false,
      icon: 'core',
    );
  }

  // GYM MODE - MUSCLE GROUPINGS (Pre-built combinations)
  static List<WorkoutPreset> getGymMuscleGroupings(String difficulty) {
    return [
      _getGymUpperBodyWorkout(difficulty),
      _getGymLowerBodyWorkout(difficulty),
      _getGymPushDayWorkout(difficulty),
      _getGymPullDayWorkout(difficulty),
      _getGymFullBodyWorkout(difficulty),
      _getGymGlutesLegsWorkout(difficulty),
    ];
  }

  // UPPER BODY - Research-backed muscle grouping
  static WorkoutPreset _getGymUpperBodyWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps', 'shoulders'],
          ),
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Shoulder Press (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Bench Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Bent Over Row (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Shoulder Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_biceps_curl',
            name: 'Bicep Curl (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_triceps_pushdown_v_bar_attachment',
            name: 'Tricep Pushdown (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Bench Press (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_bent_over_row',
            name: 'Bent Over Row (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Military Press (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_lying_close_grip_triceps_extension',
            name: 'Skull Crusher (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_upper_body',
      name: 'UPPER BODY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      exercises: exercises,
      isCircuit: false,
      icon: 'arms',
    );
  }

  // LOWER BODY - Research-backed muscle grouping
  static WorkoutPreset _getGymLowerBodyWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_curl',
            name: 'Leg Curl (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_lower_body',
      name: 'LOWER BODY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      exercises: exercises,
      isCircuit: false,
      icon: 'legs',
    );
  }

  // PUSH DAY - Research-backed muscle grouping
  static WorkoutPreset _getGymPushDayWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_chest_press',
            name: 'Chest Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'lever_seated_shoulder_press',
            name: 'Shoulder Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_triceps_pushdown_v_bar_attachment',
            name: 'Tricep Pushdown (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Bench Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_incline_bench_press',
            name: 'Incline Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Shoulder Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_triceps_pushdown_v_bar_attachment',
            name: 'Tricep Pushdown (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Bench Press (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_incline_bench_press',
            name: 'Incline Bench (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Military Press (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_lying_close_grip_triceps_extension',
            name: 'Skull Crusher (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'chest_dip',
            name: 'Weighted Dip',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_push_day',
      name: 'PUSH DAY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      exercises: exercises,
      isCircuit: false,
      icon: 'circuits',
    );
  }

  // PULL DAY - Research-backed muscle grouping
  static WorkoutPreset _getGymPullDayWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_seated_row',
            name: 'Seated Row (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_biceps_curl',
            name: 'Bicep Curl (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Bent Over Row (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_seated_row',
            name: 'Seated Row (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'pull_up',
            name: 'Pull-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_bent_over_row',
            name: 'Bent Over Row (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_seated_row',
            name: 'Seated Row (Cable)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_seated_reverse_fly',
            name: 'Reverse Fly (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'cable_straight_arm_pulldown',
            name: 'Straight Arm Pulldown (Cable)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_pull_day',
      name: 'PULL DAY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      exercises: exercises,
      isCircuit: false,
      icon: 'arms',
    );
  }

  // FULL BODY - Research-backed muscle grouping
  static WorkoutPreset _getGymFullBodyWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_chest_press',
            name: 'Chest Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'lever_seated_shoulder_press',
            name: 'Shoulder Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Bench Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Bent Over Row (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Shoulder Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Bench Press (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_deadlift',
            name: 'Deadlift (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['hamstrings', 'glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Military Press (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_bent_over_row',
            name: 'Bent Over Row (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_full_body',
      name: 'FULL BODY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      exercises: exercises,
      isCircuit: false,
      icon: 'circuits',
    );
  }

  // GLUTES & LEGS - Research-backed muscle grouping
  static WorkoutPreset _getGymGlutesLegsWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'hip_raise_bent_knee',
            name: 'Glute Bridge',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Lunge (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_calf_raise',
            name: 'Standing Calf Raise (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_calf_raise',
            name: 'Standing Calf Raise (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_glutes_legs',
      name: 'GLUTES & LEGS',
      category: 'gym',
      subcategory: 'muscle_groupings',
      exercises: exercises,
      isCircuit: false,
      icon: 'glutes',
    );
  }

  // GYM MODE - GYM CIRCUITS
  // GYM MODE - GYM CIRCUITS
  static List<WorkoutPreset> getGymCircuits(String difficulty) {
    return [
      _getFullBodyBlastCircuit(difficulty),
      _getUpperBodyBurnerCircuit(difficulty),
      _getLowerBodyTorchCircuit(difficulty),
    ];
  }

  // FULL BODY BLAST - Gym circuit exercises
  static WorkoutPreset _getFullBodyBlastCircuit(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_chest_press',
            name: 'Chest Press (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_seated_row',
            name: 'Seated Row (Cable)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_triceps_pushdown_v_bar_attachment',
            name: 'Tricep Pushdown (Cable)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Squat (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Bench Press (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_bent_over_row',
            name: 'Bent Over Row (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Military Press (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Squat (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Bench Press (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_bent_over_row',
            name: 'Bent Over Row (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Military Press (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_lying_close_grip_triceps_extension',
            name: 'Skull Crusher (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise (Dumbbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_full_body_blast',
      name: 'FULL BODY BLAST',
      category: 'gym',
      subcategory: 'gym_circuits',
      exercises: exercises,
      rounds: difficulty == 'beginner' ? 3 : difficulty == 'intermediate' ? 4 : 5,
      duration: difficulty == 'beginner' ? '8 min' : difficulty == 'intermediate' ? '18 min' : '24 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // UPPER BODY BURNER - Gym circuit exercises
  static WorkoutPreset _getUpperBodyBurnerCircuit(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_chest_press',
            name: 'Chest Press (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown (Cable)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'lever_seated_shoulder_press',
            name: 'Shoulder Press (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_biceps_curl',
            name: 'Bicep Curl (Dumbbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Bench Press (Dumbbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Bent Over Row (Dumbbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Shoulder Press (Dumbbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_triceps_pushdown_v_bar_attachment',
            name: 'Tricep Pushdown (Cable)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise (Dumbbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Bench Press (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_bent_over_row',
            name: 'Bent Over Row (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Military Press (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_lying_close_grip_triceps_extension',
            name: 'Skull Crusher',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_crossover_variation',
            name: 'Cable Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_upper_burner',
      name: 'UPPER BODY BURNER',
      category: 'gym',
      subcategory: 'gym_circuits',
      exercises: exercises,
      rounds: difficulty == 'beginner' ? 3 : difficulty == 'intermediate' ? 4 : 5,
      duration: difficulty == 'beginner' ? '8 min' : difficulty == 'intermediate' ? '15 min' : '20 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // LOWER BODY TORCH - Gym circuit exercises
  static WorkoutPreset _getLowerBodyTorchCircuit(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_curl',
            name: 'Leg Curl (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_calf_raise',
            name: 'Calf Raise (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Squat (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'RDL (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Lunge (Dumbbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_calf_raise',
            name: 'Calf Raise (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Squat (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'RDL (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_calf_raise',
            name: 'Calf Raise',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_lower_torch',
      name: 'LOWER BODY TORCH',
      category: 'gym',
      subcategory: 'gym_circuits',
      exercises: exercises,
      rounds: difficulty == 'beginner' ? 3 : difficulty == 'intermediate' ? 4 : 5,
      duration: difficulty == 'beginner' ? '10 min' : difficulty == 'intermediate' ? '20 min' : '28 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // GYM MODE - BOOTY BUILDER
  // GYM MODE - BOOTY BUILDER
  static List<WorkoutPreset> getGymBootyBuilder(String difficulty) {
    return [
      _getGymGluteSculptWorkout(difficulty),
      _getGymPeachPumpWorkout(difficulty),
      _getGymLowerBodyBurnWorkout(difficulty),
    ];
  }

  // GLUTE SCULPT - Gym booty builder exercises
  static WorkoutPreset _getGymGluteSculptWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'hip_raise_bent_knee',
            name: 'Glute Bridge',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Lunge (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'walking_lunge_male',
            name: 'Walking Lunge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_step_up',
            name: 'Step Up (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_sumo_squat',
            name: 'Sumo Squat (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_glute_sculpt',
      name: 'GLUTE SCULPT',
      category: 'gym',
      subcategory: 'booty_builder',
      exercises: exercises,
      isCircuit: false,
      icon: 'glutes',
    );
  }

  // PEACH PUMP - Gym booty builder exercises
  static WorkoutPreset _getGymPeachPumpWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'hip_raise_bent_knee',
            name: 'Glute Bridge',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press - Feet High (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_sumo_squat',
            name: 'Sumo Squat (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press - Feet High (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_sumo_squat',
            name: 'Sumo Squat (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_sumo_deadlift',
            name: 'Sumo Deadlift (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press - Feet High (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_rear_kick',
            name: 'Glute Kickback (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_peach_pump',
      name: 'PEACH PUMP',
      category: 'gym',
      subcategory: 'booty_builder',
      exercises: exercises,
      isCircuit: false,
      icon: 'glutes',
    );
  }

  // LOWER BODY BURN - Gym booty builder exercises
  static WorkoutPreset _getGymLowerBodyBurnWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'hip_raise_bent_knee',
            name: 'Glute Bridge',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_calf_raise',
            name: 'Calf Raise (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'walking_lunge_male',
            name: 'Walking Lunge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_calf_raise',
            name: 'Calf Raise (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_step_up',
            name: 'Step Up (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_lower_body_burn',
      name: 'LOWER BODY BURN',
      category: 'gym',
      subcategory: 'booty_builder',
      exercises: exercises,
      isCircuit: false,
      icon: 'glutes',
    );
  }

  // GYM MODE - GIRL POWER
  // GYM MODE - GIRL POWER
  static List<WorkoutPreset> getGymGirlPower(String difficulty) {
    return [
      _getGymGirlGluteSpecialization(difficulty),
      _getGymGirlUpperBody(difficulty),
      _getGymGirlPPL(difficulty),
      _getGymGirlFullBodyCircuit(difficulty),
    ];
  }

  // GIRL POWER - GLUTE SPECIALIZATION
  static WorkoutPreset _getGymGirlGluteSpecialization(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'hip_raise_bent_knee',
            name: 'Glute Bridge',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Lunge (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_romanian_deadlift',
            name: 'Romanian Deadlift (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'walking_lunge_male',
            name: 'Walking Lunge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_sumo_squat',
            name: 'Sumo Squat (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_standing_rear_kick',
            name: 'Glute Kickback (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press - Feet High (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_step_up',
            name: 'Step Up (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_girl_glute_specialization',
      name: 'GLUTE SPECIALIZATION',
      category: 'gym',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'glutes',
    );
  }

  // GIRL POWER - UPPER BODY (Upper/Lower Split)
  static WorkoutPreset _getGymGirlUpperBody(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Shoulder Press (Dumbbell)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Bench Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Bent Over Row (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Shoulder Press (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_biceps_curl',
            name: 'Bicep Curl (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Bench Press (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_bent_over_row',
            name: 'Bent Over Row (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Military Press (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_triceps_pushdown_v_bar_attachment',
            name: 'Tricep Pushdown (Cable)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_girl_upper_body',
      name: 'UPPER BODY',
      category: 'gym',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'arms',
    );
  }

  // GIRL POWER - PUSH/PULL/LEGS (Glute-focused leg day)
  static WorkoutPreset _getGymGirlPPL(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'hip_raise_bent_knee',
            name: 'Glute Bridge',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'lever_leg_extension',
            name: 'Leg Extension (Machine)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Lunge (Dumbbell)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_calf_raise',
            name: 'Calf Raise (Machine)',
            sets: 4,
            reps: 10,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Back Squat (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat (Dumbbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift (Barbell)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_rear_kick',
            name: 'Glute Kickback (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_calf_raise',
            name: 'Calf Raise (Machine)',
            sets: 4,
            reps: 8,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_girl_ppl',
      name: 'PUSH/PULL/LEGS',
      category: 'gym',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'legs',
    );
  }

  // GIRL POWER - FULL BODY CIRCUIT
  static WorkoutPreset _getGymGirlFullBodyCircuit(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_chest_press',
            name: 'Chest Press (Machine)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown (Cable)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Squat (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Bench Press (Dumbbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Row (Dumbbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Lateral Raise',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Squat (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_hip_thrust',
            name: 'Hip Thrust (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Bench Press (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_bent_over_row',
            name: 'Row (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Military Press (Barbell)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_standing_hip_extension',
            name: 'Glute Kickback (Cable)',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_bulgarian_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'walking_lunge_male',
            name: 'Walking Lunge',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_girl_full_body_circuit',
      name: 'FULL BODY CIRCUIT',
      category: 'gym',
      subcategory: 'girl_power',
      exercises: exercises,
      rounds: difficulty == 'beginner' ? 3 : difficulty == 'intermediate' ? 4 : 5,
      duration: difficulty == 'beginner' ? '8 min' : difficulty == 'intermediate' ? '18 min' : '24 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // HOME MODE - BODYWEIGHT BASICS
  // HOME MODE - BODYWEIGHT BASICS
  static List<WorkoutPreset> getHomeBodyweightBasics(String difficulty) {
    return [
      _getHomeFullBodyWorkout(difficulty),
      _getHomeUpperBodyWorkout(difficulty),
      _getHomeLowerBodyWorkout(difficulty),
      _getHomeCoreWorkout(difficulty),
      _getHomeBroSplitCircuit(difficulty),
    ];
  }

  // HOME BODYWEIGHT BASICS - FULL BODY
  static WorkoutPreset _getHomeFullBodyWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank (30s)',
            sets: 3,
            reps: 0,
            timeSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers (30s)',
            sets: 4,
            reps: 0,
            timeSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'triceps_dips_floor',
            name: 'Chair Dip',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank (45s)',
            sets: 4,
            reps: 0,
            timeSeconds: 45,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 4,
            reps: 8,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'pike_push_up',
            name: 'Pike Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cross_body_crunch',
            name: 'Crunch',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_full_body',
      name: 'FULL BODY',
      category: 'home',
      subcategory: 'bodyweight_basics',
      exercises: exercises,
      isCircuit: false,
      icon: 'circuits',
    );
  }

  // HOME BODYWEIGHT BASICS - UPPER BODY
  static WorkoutPreset _getHomeUpperBodyWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank (30s)',
            sets: 3,
            reps: 0,
            timeSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'triceps_dips_floor',
            name: 'Chair Dip',
            sets: 3,
            reps: 12,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
          WorkoutExercise(
            id: 'superman',
            name: 'Superman (30s)',
            sets: 3,
            reps: 0,
            timeSeconds: 30,
            primaryMuscles: ['back'],
            secondaryMuscles: ['core'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cross_body_crunch',
            name: 'Crunch',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank (45s)',
            sets: 4,
            reps: 0,
            timeSeconds: 45,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'pike_push_up',
            name: 'Pike Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'triceps_dips_floor',
            name: 'Chair Dip',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'decline_push_up_m',
            name: 'Decline Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'lying_leg_raise_flat_bench',
            name: 'Leg Raise',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'russian_twist_with_medicine_ball',
            name: 'Russian Twist',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'pike_push_up',
            name: 'Pike Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'triceps_dips_floor',
            name: 'Chair Dip',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_upper_body',
      name: 'UPPER BODY',
      category: 'home',
      subcategory: 'bodyweight_basics',
      exercises: exercises,
      isCircuit: false,
      icon: 'arms',
    );
  }

  // HOME BODYWEIGHT BASICS - LOWER BODY
  static WorkoutPreset _getHomeLowerBodyWorkout(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 3,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 3,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'bodyweight_standing_calf_raise',
            name: 'Calf Raise',
            sets: 3,
            reps: 15,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'step_up',
            name: 'Step Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'bodyweight_standing_calf_raise',
            name: 'Calf Raise',
            sets: 4,
            reps: 12,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'step_up',
            name: 'Step Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'bodyweight_standing_calf_raise',
            name: 'Calf Raise',
            sets: 4,
            reps: 10,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_lower_body',
      name: 'LOWER BODY',
      category: 'home',
      subcategory: 'bodyweight_basics',
      exercises: exercises,
      isCircuit: false,
      icon: 'legs',
    );
  }

  // HOME BODYWEIGHT BASICS - CORE
  static WorkoutPreset _getHomeCoreWorkout(String difficulty) {
    // Core returns the same exercises regardless of difficulty
    List<WorkoutExercise> exercises = [
      WorkoutExercise(
        id: 'cross_body_crunch',
        name: 'Crunch',
        sets: 3,
        reps: 15,
        primaryMuscles: ['core'],
        secondaryMuscles: [],
      ),
      WorkoutExercise(
        id: 'lying_leg_raise_flat_bench',
        name: 'Leg Raise',
        sets: 3,
        reps: 12,
        primaryMuscles: ['core'],
        secondaryMuscles: [],
      ),
      WorkoutExercise(
        id: 'russian_twist_with_medicine_ball',
        name: 'Russian Twist',
        sets: 3,
        reps: 20,
        primaryMuscles: ['core'],
        secondaryMuscles: [],
      ),
      WorkoutExercise(
        id: 'front_plank',
        name: 'Plank',
        sets: 1,
        reps: 0,
        timeSeconds: 30,
        primaryMuscles: ['core'],
        secondaryMuscles: [],
      ),
    ];

    return WorkoutPreset(
      id: 'home_core',
      name: 'CORE',
      category: 'home',
      subcategory: 'bodyweight_basics',
      exercises: exercises,
      isCircuit: false,
      icon: 'core',
    );
  }

  // HOME BODYWEIGHT BASICS - FULL BODY CIRCUIT
  static WorkoutPreset _getHomeBroSplitCircuit(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'triceps_dips_floor',
            name: 'Chair Dip',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
            name: 'Diamond Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'pike_push_up',
            name: 'Pike Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_bro_split',
      name: 'FULL BODY CIRCUIT',
      category: 'home',
      subcategory: 'bodyweight_basics',
      exercises: exercises,
      rounds: difficulty == 'beginner' ? 3 : difficulty == 'intermediate' ? 4 : 5,
      duration: difficulty == 'beginner' ? '8 min' : difficulty == 'intermediate' ? '18 min' : '24 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // HOME MODE - HIIT CIRCUITS
  // HOME MODE - HIIT CIRCUITS
  static List<WorkoutPreset> getHomeHIITCircuits(String difficulty) {
    return [
      _getHomeTabataBurn(difficulty),
      _getHomeCardioBlast(difficulty),
      _getHomeSweatStorm(difficulty),
    ];
  }

  // HOME HIIT - TABATA BURN
  static WorkoutPreset _getHomeTabataBurn(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'butt_kick',
            name: 'Butt Kicks',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'butt_kick',
            name: 'Butt Kicks',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'star_jump',
            name: 'Star Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'butt_kick',
            name: 'Butt Kicks',
            sets: 1,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_tabata_burn',
      name: 'TABATA BURN',
      category: 'home',
      subcategory: 'hiit_circuits',
      exercises: exercises,
      rounds: difficulty == 'beginner' ? 4 : difficulty == 'intermediate' ? 6 : 8,
      duration: difficulty == 'beginner' ? '8 min' : difficulty == 'intermediate' ? '12 min' : '16 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }


  // HOME HIIT - CARDIO BLAST
  static WorkoutPreset _getHomeCardioBlast(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'jumping_jack',
            name: 'Jumping Jacks',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['full_body'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'butt_kick',
            name: 'Butt Kicks',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'skater',
            name: 'Skaters',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'jumping_jack',
            name: 'Jumping Jacks',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['full_body'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'butt_kick',
            name: 'Butt Kicks',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'skater',
            name: 'Skaters',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'star_jump',
            name: 'Star Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'skater',
            name: 'Skaters',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'butt_kick',
            name: 'Butt Kicks',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_cardio_blast',
      name: 'CARDIO BLAST',
      category: 'home',
      subcategory: 'hiit_circuits',
      exercises: exercises,
      rounds: difficulty == 'beginner' ? 3 : difficulty == 'intermediate' ? 4 : 5,
      duration: difficulty == 'beginner' ? '12 min' : difficulty == 'intermediate' ? '18 min' : '24 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // HOME HIIT - SWEAT STORM
  static WorkoutPreset _getHomeSweatStorm(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'jumping_jack',
            name: 'Jumping Jacks',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['full_body'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
            name: 'Diamond Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'star_jump',
            name: 'Star Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'pike_push_up',
            name: 'Pike Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_sweat_storm',
      name: 'SWEAT STORM',
      category: 'home',
      subcategory: 'hiit_circuits',
      exercises: exercises,
      rounds: difficulty == 'beginner' ? 3 : difficulty == 'intermediate' ? 4 : 5,
      duration: difficulty == 'beginner' ? '12 min' : difficulty == 'intermediate' ? '18 min' : '24 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // HOME MODE - HOME BOOTY
  // HOME MODE - HOME BOOTY
  static List<WorkoutPreset> getHomeBooty(String difficulty) {
    return [
      _getHomeGluteActivation(difficulty),
      _getHomeBootyBurner(difficulty),
      _getHomeBootyHIIT(difficulty),
    ];
  }

  // HOME BOOTY - GLUTE ACTIVATION
  static WorkoutPreset _getHomeGluteActivation(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 3,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 3,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 3,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'quadruped_hip_extension',
            name: 'Quadruped Hip Extension',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'quadruped_hip_extension',
            name: 'Quadruped Hip Extension',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_glute_activation',
      name: 'GLUTE ACTIVATION',
      category: 'home',
      subcategory: 'home_booty',
      exercises: exercises,
      isCircuit: false,
      icon: 'glutes',
    );
  }

  // HOME BOOTY - BOOTY BURNER
  static WorkoutPreset _getHomeBootyBurner(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 3,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 3,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 3,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'step_up',
            name: 'Step Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'step_up',
            name: 'Step Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_booty_burner',
      name: 'BOOTY BURNER',
      category: 'home',
      subcategory: 'home_booty',
      exercises: exercises,
      isCircuit: false,
      icon: 'glutes',
    );
  }

  // HOME BOOTY - BOOTY HIIT
  static WorkoutPreset _getHomeBootyHIIT(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'butt_kick',
            name: 'Butt Kicks',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_booty_hiit',
      name: 'BOOTY HIIT',
      category: 'home',
      subcategory: 'home_booty',
      exercises: exercises,
      rounds: difficulty == 'beginner' ? 3 : difficulty == 'intermediate' ? 4 : 5,
      duration: difficulty == 'beginner' ? '8 min' : difficulty == 'intermediate' ? '18 min' : '24 min',
      isCircuit: true,
      icon: 'glutes',
    );
  }

  // HOME MODE - GIRL POWER
  // HOME MODE - GIRL POWER
  static List<WorkoutPreset> getHomeGirlPower(String difficulty) {
    return [
      _getHomeGirlGluteSculpt(difficulty),
      _getHomeGirlUpperBody(difficulty),
      _getHomeGirlPPL(difficulty),
      _getHomeGirlFullBodyCircuit(difficulty),
    ];
  }

  // HOME GIRL POWER - GLUTE SCULPT
  static WorkoutPreset _getHomeGirlGluteSculpt(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 3,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 3,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 3,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'step_up',
            name: 'Step Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'quadruped_hip_extension',
            name: 'Quadruped Hip Extension',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_girl_glute_sculpt',
      name: 'GLUTE SCULPT',
      category: 'home',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'glutes',
    );
  }

  // HOME GIRL POWER - UPPER BODY
  static WorkoutPreset _getHomeGirlUpperBody(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank (30s)',
            sets: 3,
            reps: 0,
            timeSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'triceps_dips_floor',
            name: 'Chair Dip',
            sets: 3,
            reps: 12,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cross_body_crunch',
            name: 'Crunch',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'pike_push_up',
            name: 'Pike Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers (30s)',
            sets: 4,
            reps: 0,
            timeSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'decline_push_up_m',
            name: 'Decline Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'lying_leg_raise_flat_bench',
            name: 'Leg Raise',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'russian_twist_with_medicine_ball',
            name: 'Russian Twist',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'pike_push_up',
            name: 'Pike Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'triceps_dips_floor',
            name: 'Chair Dip',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_girl_upper_body',
      name: 'UPPER BODY',
      category: 'home',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'arms',
    );
  }

  // HOME GIRL POWER - PUSH/PULL/LEGS
  static WorkoutPreset _getHomeGirlPPL(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'decline_push_up_m',
            name: 'Decline Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'pike_push_up',
            name: 'Pike Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_girl_ppl',
      name: 'PUSH/PULL/LEGS',
      category: 'home',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'legs',
    );
  }

  // HOME GIRL POWER - FULL BODY CIRCUIT
  static WorkoutPreset _getHomeGirlFullBodyCircuit(String difficulty) {
    List<WorkoutExercise> exercises;

    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Air Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knees',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'butt_kick',
            name: 'Butt Kicks',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: ['legs'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
            name: 'Diamond Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'mountain_climbers',
            name: 'Mountain Climbers',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'star_jump',
            name: 'Star Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_girl_full_body_circuit',
      name: 'FULL BODY CIRCUIT',
      category: 'home',
      subcategory: 'girl_power',
      exercises: exercises,
      rounds: difficulty == 'beginner' ? 3 : difficulty == 'intermediate' ? 4 : 5,
      duration: difficulty == 'beginner' ? '8 min' : difficulty == 'intermediate' ? '18 min' : '24 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // HOME MODE - RECOVERY & MOBILITY (not difficulty-dependent)
  static List<WorkoutPreset> getHomeRecovery() {
    return homeRecovery;
  }

  // LEGACY STATIC LISTS (kept for backward compatibility, but should use dynamic methods above)
  @Deprecated('Use getGymMuscleSplits(difficulty) instead')
  static final List<WorkoutPreset> gymMuscleSplits = [
    WorkoutPreset(
      id: 'gym_chest',
      name: 'CHEST',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: 'chest',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'barbell_bench_press', name: 'Barbell Bench Press', sets: 4, reps: 8),
        WorkoutExercise(id: 'dumbbell_incline_bench_press', name: 'Incline Dumbbell Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'barbell_decline_bench_press', name: 'Decline Bench Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_crossover_variation', name: 'Cable Crossover', sets: 3, reps: 12),
        //WorkoutExercise(id: 'lever_chest_press', name: 'Machine Chest Fly', sets: 3, reps: 12, included: true),  // DUPLICATE - use machine_fly
        //WorkoutExercise(id: 'dumbbell_fly', name: 'Dumbbell Flyes', sets: 3, reps: 12, included: true),  // DUPLICATE - use dumbbell_fly
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 3, reps: 15, included: true),  // DUPLICATE - use pushup
        WorkoutExercise(id: 'chest_dip', name: 'Chest Dips', sets: 3, reps: 10, included: true),
      ],
    ),
    WorkoutPreset(
      id: 'gym_back',
      name: 'BACK',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: 'back',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'barbell_deadlift', name: 'Deadlift', sets: 4, reps: 5),
        WorkoutExercise(id: 'barbell_bent_over_row', name: 'Barbell Row', sets: 4, reps: 8),
        WorkoutExercise(id: 'cable_bar_lateral_pulldown', name: 'Lat Pulldown', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_seated_row', name: 'Seated Cable Row', sets: 3, reps: 10),
        WorkoutExercise(id: 'lever_t_bar_row_plate_loaded', name: 'T-Bar Row', sets: 3, reps: 10, included: true),
        WorkoutExercise(id: 'dumbbell_one_arm_row_rack_support', name: 'Single Arm Dumbbell Row', sets: 3, reps: 10, included: true),
        //WorkoutExercise(id: 'cable_cross_over_revers_fly', name: 'Face Pulls', sets: 3, reps: 15, included: true),  // DUPLICATE - use face_pull
        //WorkoutExercise(id: 'pull_up', name: 'Pull-Ups', sets: 3, reps: 8, included: true),  // DUPLICATE - use pullup
      ],
    ),
    WorkoutPreset(
      id: 'gym_shoulders',
      name: 'SHOULDERS',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: 'arms',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'barbell_standing_military_press', name: 'Overhead Press', sets: 4, reps: 8),
        //WorkoutExercise(id: 'dumbbell_seated_shoulder_press', name: 'Seated Dumbbell Press', sets: 3, reps: 10),  // DUPLICATE - use seated_dumbbell_press
        WorkoutExercise(id: 'dumbbell_arnold_press', name: 'Arnold Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'dumbbell_lateral_raise', name: 'Lateral Raise', sets: 3, reps: 12),
        WorkoutExercise(id: 'dumbbell_lateral_raise', name: 'Front Raise', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'dumbbell_rear_fly', name: 'Reverse Fly', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'cable_lateral_raise', name: 'Cable Lateral Raise', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'barbell_shrug', name: 'Barbell Shrugs', sets: 3, reps: 12, included: true),
      ],
    ),
    WorkoutPreset(
      id: 'gym_legs',
      name: 'LEGS',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: 'legs',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'barbell_full_squat', name: 'Back Squat', sets: 4, reps: 8),
        WorkoutExercise(id: 'barbell_front_squat', name: 'Front Squat', sets: 4, reps: 6),
        WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10),
        WorkoutExercise(id: 'lever_seated_leg_press', name: 'Leg Press', sets: 3, reps: 12),
        WorkoutExercise(id: 'dumbbell_single_leg_split_squat', name: 'Bulgarian Split Squat', sets: 3, reps: 10, included: true),
        WorkoutExercise(id: 'lever_leg_extension', name: 'Leg Extension', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'lever_lying_leg_curl', name: 'Leg Curl', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'barbell_hip_thrust', name: 'Hip Thrust (GLUTE FOCUS)', sets: 4, reps: 10, included: true),
        WorkoutExercise(id: 'cable_kickback', name: 'Glute Kickback Machine (GLUTE FOCUS)', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'lever_standing_calf_raise', name: 'Standing Calf Raise', sets: 4, reps: 15, included: true),
      ],
    ),
    WorkoutPreset(
      id: 'gym_arms',
      name: 'ARMS',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: 'arms',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'barbell_curl', name: 'Barbell Curl', sets: 3, reps: 10),
        WorkoutExercise(id: 'dumbbell_hammer_curl', name: 'Hammer Curl', sets: 3, reps: 10),
        WorkoutExercise(id: 'barbell_preacher_curl', name: 'Preacher Curl', sets: 3, reps: 10),
        //WorkoutExercise(id: 'barbell_lying_close_grip_triceps_extension', name: 'Skull Crushers', sets: 3, reps: 10),  // DUPLICATE - use skull_crusher
        WorkoutExercise(id: 'dumbbell_concentration_curl', name: 'Concentration Curl', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'cable_triceps_pushdown_v_bar_attachment', name: 'Tricep Pushdown', sets: 3, reps: 12, included: true),
        //WorkoutExercise(id: 'dumbbell_standing_triceps_extension', name: 'Overhead Tricep Extension', sets: 3, reps: 12, included: true),  // DUPLICATE - use overhead_tricep_extension
        //WorkoutExercise(id: 'barbell_close_grip_bench_press', name: 'Close Grip Bench Press', sets: 3, reps: 10, included: true),  // DUPLICATE - use close_grip_bench_press
        WorkoutExercise(id: 'cable_curl_male', name: 'Cable Curl', sets: 3, reps: 12, included: true),
        //WorkoutExercise(id: 'triceps_dip', name: 'Tricep Dips', sets: 3, reps: 10, included: true),  // DUPLICATE - use tricep_dip
      ],
    ),
    WorkoutPreset(
      id: 'gym_core',
      name: 'CORE',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: 'core',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'cable_kneeling_crunch', name: 'Cable Crunch', sets: 3, reps: 15),
        WorkoutExercise(id: 'hanging_leg_hip_raise', name: 'Hanging Leg Raise', sets: 3, reps: 12),
        //WorkoutExercise(id: 'front_plank', name: 'Ab Wheel Rollout', sets: 3, reps: 10),
        WorkoutExercise(id: 'russian_twist_with_medicine_ball', name: 'Russian Twist (weighted)', sets: 3, reps: 20),
        //WorkoutExercise(id: 'barbell_standing_twist', name: 'Woodchoppers', sets: 3, reps: 12, included: true),  // DUPLICATE - use wood_chop
        WorkoutExercise(id: 'extra_decline_sit_up', name: 'Decline Sit-Up', sets: 3, reps: 15, included: true),
        WorkoutExercise(id: 'front_plank', name: 'Plank', sets: 3, reps: 45, included: true),
        WorkoutExercise(id: 'side_plank_male', name: 'Side Plank', sets: 3, reps: 30, included: true),
      ],
    ),
  ];

  // GYM MODE - MUSCLE GROUPINGS (Pre-built combinations)
  @Deprecated('Use getGymMuscleGroupings(difficulty) instead')
  static final List<WorkoutPreset> gymMuscleGroupings = [
    WorkoutPreset(
      id: 'gym_upper_body',
      name: 'UPPER BODY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: 'arms',
      isCircuit: false,
      duration: '~45 min',
      exercises: [
        WorkoutExercise(id: 'barbell_bench_press', name: 'Barbell Bench Press', sets: 4, reps: 8),
        WorkoutExercise(id: 'barbell_bent_over_row', name: 'Barbell Row', sets: 4, reps: 8),
        WorkoutExercise(id: 'barbell_standing_military_press', name: 'Overhead Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_bar_lateral_pulldown', name: 'Lat Pulldown', sets: 3, reps: 10),
        WorkoutExercise(id: 'dumbbell_lateral_raise', name: 'Lateral Raise', sets: 3, reps: 12),
        WorkoutExercise(id: 'barbell_curl', name: 'Barbell Curl', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_triceps_pushdown_v_bar_attachment', name: 'Tricep Pushdown', sets: 3, reps: 12),
      ],
    ),
    WorkoutPreset(
      id: 'gym_lower_body',
      name: 'LOWER BODY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: 'legs',
      isCircuit: false,
      duration: '~50 min',
      exercises: [
        WorkoutExercise(id: 'barbell_full_squat', name: 'Back Squat', sets: 4, reps: 8),
        WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10),
        WorkoutExercise(id: 'lever_seated_leg_press', name: 'Leg Press', sets: 3, reps: 12),
        WorkoutExercise(id: 'barbell_hip_thrust', name: 'Hip Thrust', sets: 4, reps: 10),
        WorkoutExercise(id: 'lever_leg_extension', name: 'Leg Extension', sets: 3, reps: 12),
        WorkoutExercise(id: 'lever_lying_leg_curl', name: 'Leg Curl', sets: 3, reps: 12),
        WorkoutExercise(id: 'lever_standing_calf_raise', name: 'Standing Calf Raise', sets: 4, reps: 15),
      ],
    ),
    WorkoutPreset(
      id: 'gym_push_day',
      name: 'PUSH DAY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: 'chest',
      isCircuit: false,
      duration: '~40 min',
      exercises: [
        WorkoutExercise(id: 'barbell_bench_press', name: 'Barbell Bench Press', sets: 4, reps: 8),
        WorkoutExercise(id: 'dumbbell_incline_bench_press', name: 'Incline Dumbbell Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'barbell_standing_military_press', name: 'Overhead Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'dumbbell_lateral_raise', name: 'Lateral Raise', sets: 3, reps: 12),
        WorkoutExercise(id: 'cable_triceps_pushdown_v_bar_attachment', name: 'Tricep Pushdown', sets: 3, reps: 12),
        //WorkoutExercise(id: 'dumbbell_standing_triceps_extension', name: 'Overhead Tricep Extension', sets: 3, reps: 12),  // DUPLICATE - use overhead_tricep_extension
      ],
    ),
    WorkoutPreset(
      id: 'gym_pull_day',
      name: 'PULL DAY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: 'legs',
      isCircuit: false,
      duration: '~45 min',
      exercises: [
        WorkoutExercise(id: 'barbell_deadlift', name: 'Deadlift', sets: 4, reps: 5),
        WorkoutExercise(id: 'barbell_bent_over_row', name: 'Barbell Row', sets: 4, reps: 8),
        WorkoutExercise(id: 'cable_bar_lateral_pulldown', name: 'Lat Pulldown', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_seated_row', name: 'Seated Cable Row', sets: 3, reps: 10),
        //WorkoutExercise(id: 'cable_cross_over_revers_fly', name: 'Face Pulls', sets: 3, reps: 15),  // DUPLICATE - use face_pull
        WorkoutExercise(id: 'barbell_curl', name: 'Barbell Curl', sets: 3, reps: 10),
        WorkoutExercise(id: 'dumbbell_hammer_curl', name: 'Hammer Curl', sets: 3, reps: 10),
      ],
    ),
    WorkoutPreset(
      id: 'gym_full_body',
      name: 'FULL BODY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: 'splits',
      isCircuit: false,
      duration: '~50 min',
      exercises: [
        WorkoutExercise(id: 'barbell_full_squat', name: 'Back Squat', sets: 4, reps: 8),
        WorkoutExercise(id: 'barbell_bench_press', name: 'Barbell Bench Press', sets: 4, reps: 8),
        WorkoutExercise(id: 'barbell_bent_over_row', name: 'Barbell Row', sets: 4, reps: 8),
        WorkoutExercise(id: 'barbell_standing_military_press', name: 'Overhead Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10),
        WorkoutExercise(id: 'barbell_curl', name: 'Barbell Curl', sets: 2, reps: 12),
        WorkoutExercise(id: 'cable_triceps_pushdown_v_bar_attachment', name: 'Tricep Pushdown', sets: 2, reps: 12),
      ],
    ),
    WorkoutPreset(
      id: 'gym_glutes_legs',
      name: 'GLUTES & LEGS',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: 'glutes',
      isCircuit: false,
      duration: '~50 min',
      exercises: [
        WorkoutExercise(id: 'barbell_hip_thrust', name: 'Hip Thrust', sets: 4, reps: 10),
        WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', sets: 4, reps: 10),
        WorkoutExercise(id: 'dumbbell_single_leg_split_squat', name: 'Bulgarian Split Squat', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_kickback', name: 'Glute Kickback Machine', sets: 3, reps: 12),
        WorkoutExercise(id: 'barbell_sumo_deadlift', name: 'Sumo Squat', sets: 3, reps: 12),
        //WorkoutExercise(id: 'cable_pull_through', name: 'Cable Pull-Through', sets: 3, reps: 12),  // DUPLICATE - use cable_pull_through
        WorkoutExercise(id: 'lever_lying_leg_curl', name: 'Leg Curl', sets: 3, reps: 12),
      ],
    ),
  ];

  // GYM MODE - GYM CIRCUITS
  @Deprecated('Use getGymCircuits(difficulty) instead')
  static final List<WorkoutPreset> gymCircuits = [
    WorkoutPreset(
      id: 'gym_full_body_blast',
      name: 'FULL BODY BLAST',
      category: 'gym',
      subcategory: 'gym_circuits',
      icon: 'circuits',
      isCircuit: true,
      rounds: 4,
      duration: '~20 min',
      exercises: [
        WorkoutExercise(id: 'barbell_full_squat', name: 'Barbell Squat to Press', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
        //WorkoutExercise(id: 'dumbbell_bent_over_row', name: 'Renegade Rows', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),  // DUPLICATE - use renegade_row
        //WorkoutExercise(id: 'squat_m', name: 'Box Jumps', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),  // DUPLICATE - use box_jump
        WorkoutExercise(id: 'stationary_bike_run_version_3', name: 'Battle Ropes', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
        //WorkoutExercise(id: 'burpee', name: 'Burpees', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),  // DUPLICATE - use burpee
      ],
    ),
    WorkoutPreset(
      id: 'gym_upper_burner',
      name: 'UPPER BODY BURNER',
      category: 'gym',
      subcategory: 'gym_circuits',
      icon: 'circuits',
      isCircuit: true,
      rounds: 4,
      duration: '~16 min',
      exercises: [
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use pushup
        WorkoutExercise(id: 'dumbbell_bent_over_row', name: 'Dumbbell Row', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'dumbbell_seated_shoulder_press', name: 'Shoulder Press', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        //WorkoutExercise(id: 'dumbbell_biceps_curl', name: 'Bicep Curls', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use bicep_curl
        //WorkoutExercise(id: 'triceps_dip', name: 'Tricep Dips', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use tricep_dip
      ],
    ),
    WorkoutPreset(
      id: 'gym_lower_torch',
      name: 'LOWER BODY TORCH',
      category: 'gym',
      subcategory: 'gym_circuits',
      icon: 'circuits',
      isCircuit: true,
      rounds: 4,
      duration: '~16 min',
      exercises: [
        //WorkoutExercise(id: 'dumbbell_goblet_squat', name: 'Goblet Squats', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use goblet_squat
        WorkoutExercise(id: 'walking_lunge_male', name: 'Walking Lunges', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        //WorkoutExercise(id: 'dumbbell_lunge', name: 'Box Step-Ups', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use box_step_up
        //WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Kettlebell Swings', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use kettlebell_swing
      ],
    ),
    WorkoutPreset(
      id: 'gym_core_destroyer',
      name: 'CORE DESTROYER',
      category: 'gym',
      subcategory: 'gym_circuits',
      icon: 'circuits',
      isCircuit: true,
      rounds: 3,
      duration: '~10 min',
      exercises: [
        WorkoutExercise(id: 'cable_kneeling_crunch', name: 'Cable Crunch', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        WorkoutExercise(id: 'hanging_leg_hip_raise', name: 'Hanging Leg Raise', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        WorkoutExercise(id: 'russian_twist_with_medicine_ball', name: 'Russian Twist', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        //WorkoutExercise(id: 'burpee', name: 'Mountain Climbers', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),  // DUPLICATE - use mountain_climber
        //WorkoutExercise(id: 'front_plank', name: 'Plank Hold', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),  // DUPLICATE - use plank
      ],
    ),
  ];

  // GYM MODE - BOOTY BUILDER
  @Deprecated('Use getGymBootyBuilder(difficulty) instead')
  static final List<WorkoutPreset> gymBootyBuilder = [
    WorkoutPreset(
      id: 'gym_glute_sculpt',
      name: 'GLUTE SCULPT',
      category: 'gym',
      subcategory: 'booty_builder',
      icon: 'glutes',
      isCircuit: false,
      duration: '~45 min',
      exercises: [
        WorkoutExercise(id: 'barbell_hip_thrust', name: 'Hip Thrust', sets: 4, reps: 12),
        WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 12),
        WorkoutExercise(id: 'cable_kickback', name: 'Cable Kickback', sets: 3, reps: 15),
        WorkoutExercise(id: 'barbell_sumo_deadlift', name: 'Sumo Squat', sets: 3, reps: 12),
        WorkoutExercise(id: 'hip_thrusts', name: 'Glute Bridge (single leg)', sets: 3, reps: 10),
        //WorkoutExercise(id: 'cable_pull_through', name: 'Cable Pull-Through', sets: 3, reps: 15),  // DUPLICATE - use cable_pull_through
      ],
    ),
    WorkoutPreset(
      id: 'gym_peach_pump',
      name: 'PEACH PUMP',
      category: 'gym',
      subcategory: 'booty_builder',
      icon: 'glutes',
      isCircuit: false,
      duration: '~40 min',
      exercises: [
        WorkoutExercise(id: 'barbell_hip_thrust', name: 'Barbell Hip Thrust', sets: 4, reps: 10),
        WorkoutExercise(id: 'dumbbell_single_leg_split_squat', name: 'Bulgarian Split Squat', sets: 3, reps: 10),
        WorkoutExercise(id: 'barbell_sumo_deadlift', name: 'Sumo Deadlift', sets: 3, reps: 12),
        WorkoutExercise(id: 'lever_seated_leg_press', name: 'Leg Press (feet high)', sets: 3, reps: 12),
        WorkoutExercise(id: 'cable_kickback', name: 'Donkey Kicks (cable)', sets: 3, reps: 15),
      ],
    ),
  ];

  // GYM MODE - GIRL POWER
  @Deprecated('Use getGymGirlPower(difficulty) instead')
  static final List<WorkoutPreset> gymGirlPower = [
    WorkoutPreset(
      id: 'gym_girl_glute_specialization',
      name: 'GLUTE SPECIALIZATION',
      category: 'gym',
      subcategory: 'girl_power',
      icon: 'glutes',
      isCircuit: false,
      duration: '~50 min',
      exercises: [
        WorkoutExercise(id: 'barbell_hip_thrust', name: 'Barbell Hip Thrust', sets: 4, reps: 10),
        WorkoutExercise(id: 'dumbbell_single_leg_split_squat', name: 'Bulgarian Split Squat', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_kickback', name: 'Cable Kickback', sets: 3, reps: 15),
        WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 12),
        WorkoutExercise(id: 'barbell_sumo_deadlift', name: 'Sumo Deadlift', sets: 3, reps: 10, included: true),
        //WorkoutExercise(id: 'cable_pull_through', name: 'Cable Pull-Through', sets: 3, reps: 15, included: true),  // DUPLICATE - use cable_pull_through
        WorkoutExercise(id: 'lever_seated_leg_press', name: 'Leg Press (feet high)', sets: 3, reps: 12, included: true),
      ],
    ),
    WorkoutPreset(
      id: 'gym_girl_upper_lower',
      name: 'UPPER/LOWER SPLIT',
      category: 'gym',
      subcategory: 'girl_power',
      icon: 'splits',
      isCircuit: false,
      duration: '~45 min',
      exercises: [
        // Upper Day
        WorkoutExercise(id: 'dumbbell_bench_press', name: 'Dumbbell Bench Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_seated_row', name: 'Cable Row', sets: 3, reps: 12),
        WorkoutExercise(id: 'dumbbell_seated_shoulder_press', name: 'Shoulder Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_bar_lateral_pulldown', name: 'Lat Pulldown', sets: 3, reps: 12),
        // Lower Day
        WorkoutExercise(id: 'dumbbell_goblet_squat', name: 'Goblet Squat', sets: 4, reps: 12, included: true),
        WorkoutExercise(id: 'walking_lunge_male', name: 'Walking Lunges', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'lever_lying_leg_curl', name: 'Leg Curl', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'barbell_hip_thrust', name: 'Hip Thrust', sets: 4, reps: 12, included: true),
      ],
    ),
    WorkoutPreset(
      id: 'gym_girl_full_body',
      name: 'FULL BODY',
      category: 'gym',
      subcategory: 'girl_power',
      icon: 'splits',
      isCircuit: false,
      duration: '~50 min',
      exercises: [
        WorkoutExercise(id: 'dumbbell_goblet_squat', name: 'Goblet Squat', sets: 3, reps: 12),
        WorkoutExercise(id: 'dumbbell_bench_press', name: 'Dumbbell Bench Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10),
        WorkoutExercise(id: 'dumbbell_seated_shoulder_press', name: 'Shoulder Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'barbell_hip_thrust', name: 'Hip Thrust', sets: 3, reps: 12),
        WorkoutExercise(id: 'cable_bar_lateral_pulldown', name: 'Lat Pulldown', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'cable_seated_row', name: 'Cable Row', sets: 3, reps: 12, included: true),
      ],
    ),
    WorkoutPreset(
      id: 'gym_girl_push_pull_legs',
      name: 'PUSH/PULL/LEGS',
      category: 'gym',
      subcategory: 'girl_power',
      icon: 'girlpower',
      isCircuit: false,
      duration: '~40 min',
      exercises: [
        // Push exercises
        WorkoutExercise(id: 'dumbbell_bench_press', name: 'Dumbbell Bench Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'dumbbell_incline_bench_press', name: 'Incline Dumbbell Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'dumbbell_lateral_raise', name: 'Lateral Raise', sets: 3, reps: 12),
        WorkoutExercise(id: 'cable_triceps_pushdown_v_bar_attachment', name: 'Tricep Pushdown', sets: 3, reps: 12),
        // Pull exercises (included: true for rotation)
        WorkoutExercise(id: 'cable_bar_lateral_pulldown', name: 'Lat Pulldown', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'cable_seated_row', name: 'Cable Row', sets: 3, reps: 12, included: true),
        WorkoutExercise(id: 'cable_cross_over_revers_fly', name: 'Face Pull', sets: 3, reps: 15, included: true),
        // Leg exercises (included: true for rotation)
        WorkoutExercise(id: 'barbell_full_squat', name: 'Squat', sets: 4, reps: 10, included: true),
        WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10, included: true),
        WorkoutExercise(id: 'lever_seated_leg_press', name: 'Leg Press', sets: 3, reps: 12, included: true),
      ],
    ),
    WorkoutPreset(
      id: 'gym_girl_bro_split',
      name: 'BRO SPLIT (MODIFIED)',
      category: 'gym',
      subcategory: 'girl_power',
      icon: 'girlpower',
      isCircuit: false,
      duration: '~45 min',
      exercises: [
        WorkoutExercise(id: 'dumbbell_incline_bench_press', name: 'Incline Dumbbell Press', sets: 4, reps: 10),
        //WorkoutExercise(id: 'cable_standing_fly', name: 'Cable Flye', sets: 3, reps: 12),  // DUPLICATE - use cable_fly
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 2, reps: 15),  // DUPLICATE - use pushup
        WorkoutExercise(id: 'dumbbell_standing_triceps_extension', name: 'Overhead Tricep Extension', sets: 3, reps: 12),
        WorkoutExercise(id: 'dumbbell_lateral_raise', name: 'Lateral Raise', sets: 3, reps: 15, included: true),
        WorkoutExercise(id: 'barbell_lying_close_grip_triceps_extension', name: 'Skull Crushers', sets: 3, reps: 10, included: true),
      ],
    ),
  ];

  // HOME MODE - BODYWEIGHT BASICS
  @Deprecated('Use getHomeBodyweightBasics(difficulty) instead')
  static final List<WorkoutPreset> homeBodyweightBasics = [
    WorkoutPreset(
      id: 'home_full_body',
      name: 'FULL BODY',
      category: 'home',
      subcategory: 'bodyweight_basics',
      icon: 'arms',
      isCircuit: false,
      duration: '~30 min',
      exercises: [
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 3, reps: 15),  // DUPLICATE - use pushup
        //WorkoutExercise(id: 'squat_m', name: 'Air Squats', sets: 3, reps: 20),  // DUPLICATE - use air_squat
        //WorkoutExercise(id: 'dumbbell_lunge', name: 'Lunges', sets: 3, reps: 12),  // DUPLICATE - use lunge
        //WorkoutExercise(id: 'reverse_hyper_on_flat_bench', name: 'Superman Raises', sets: 3, reps: 15),
        WorkoutExercise(id: 'hip_thrusts', name: 'Glute Bridge', sets: 3, reps: 15),
        WorkoutExercise(id: 'front_plank', name: 'Plank', sets: 3, reps: 45),
        //WorkoutExercise(id: 'burpee', name: 'Mountain Climbers', sets: 3, reps: 20),  // DUPLICATE - use mountain_climber
      ],
    ),
    WorkoutPreset(
      id: 'home_upper_body',
      name: 'BALANCED UPPER BODY',
      category: 'home',
      subcategory: 'bodyweight_basics',
      icon: 'chest',
      isCircuit: false,
      duration: '~25 min',
      exercises: [
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 3, reps: 15),  // DUPLICATE - use pushup
        //WorkoutExercise(id: 'reverse_hyper_on_flat_bench', name: 'Superman Raises', sets: 3, reps: 15),
        //WorkoutExercise(id: 'decline_push_up_m', name: 'Pike Push-Ups', sets: 3, reps: 10),  // DUPLICATE - use pike_pushup
        //WorkoutExercise(id: 'inverted_row', name: 'Inverted Rows (table)', sets: 3, reps: 12),  // DUPLICATE - use inverted_row
        WorkoutExercise(id: 'triceps_dips_floor', name: 'Tricep Dips (chair)', sets: 3, reps: 12),
        //WorkoutExercise(id: 'front_plank', name: 'Plank Shoulder Taps', sets: 3, reps: 20),
      ],
    ),
    WorkoutPreset(
      id: 'home_lower_body',
      name: 'LOWER BODY',
      category: 'home',
      subcategory: 'bodyweight_basics',
      icon: 'legs',
      isCircuit: false,
      duration: '~30 min',
      exercises: [
        //WorkoutExercise(id: 'squat_m', name: 'Air Squats', sets: 4, reps: 20),  // DUPLICATE - use air_squat
        //WorkoutExercise(id: 'dumbbell_lunge', name: 'Lunges', sets: 3, reps: 12),  // DUPLICATE - use lunge
        WorkoutExercise(id: 'hip_thrusts', name: 'Glute Bridge', sets: 4, reps: 15),
        WorkoutExercise(id: 'hip_thrusts', name: 'Single Leg Glute Bridge', sets: 3, reps: 10),
        //WorkoutExercise(id: 'dumbbell_lunge', name: 'Step-Ups (chair)', sets: 3, reps: 12),  // DUPLICATE - use box_step_up
        //WorkoutExercise(id: 'squat_m', name: 'Wall Sit', sets: 3, reps: 45),
        //WorkoutExercise(id: 'lever_standing_calf_raise', name: 'Calf Raises', sets: 3, reps: 20),  // DUPLICATE - use calf_raise
      ],
    ),
    WorkoutPreset(
      id: 'home_core',
      name: 'CORE',
      category: 'home',
      subcategory: 'bodyweight_basics',
      icon: 'core',
      isCircuit: false,
      duration: '~20 min',
      exercises: [
        WorkoutExercise(id: 'front_plank', name: 'Plank', sets: 3, reps: 45),
        WorkoutExercise(id: 'side_plank_male', name: 'Side Plank', sets: 3, reps: 30),
        //WorkoutExercise(id: 'cross_body_crunch', name: 'Bicycle Crunches', sets: 3, reps: 20),  // DUPLICATE - use bicycle_crunch
        //WorkoutExercise(id: 'lying_leg_raise', name: 'Leg Raises', sets: 3, reps: 15),  // DUPLICATE - use leg_raise
        WorkoutExercise(id: 'russian_twist_with_medicine_ball', name: 'Russian Twist', sets: 3, reps: 20),
        //WorkoutExercise(id: 'burpee', name: 'Mountain Climbers', sets: 3, reps: 20),  // DUPLICATE - use mountain_climber
        WorkoutExercise(id: 'front_plank', name: 'Dead Bug', sets: 3, reps: 12),
      ],
    ),
  ];

  // HOME MODE - HIIT CIRCUITS
  @Deprecated('Use getHomeHIITCircuits(difficulty) instead')
  static final List<WorkoutPreset> homeHIITCircuits = [
    WorkoutPreset(
      id: 'home_10min_quick_burn',
      name: '10 MIN QUICK BURN',
      category: 'home',
      subcategory: 'hiit_circuits',
      icon: 'circuits',
      isCircuit: true,
      rounds: 2,
      duration: '10 min',
      exercises: [
        //WorkoutExercise(id: 'burpee', name: 'Burpees', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),  // DUPLICATE - use burpee
        //WorkoutExercise(id: 'squat_m', name: 'Jump Squats', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),  // DUPLICATE - use jump_squat
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),  // DUPLICATE - use pushup
        //WorkoutExercise(id: 'stationary_bike_run_version_3', name: 'High Knees', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),  // DUPLICATE - use high_knee
        //WorkoutExercise(id: 'burpee', name: 'Mountain Climbers', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),  // DUPLICATE - use mountain_climber
      ],
    ),
    WorkoutPreset(
      id: 'home_20min_destroyer',
      name: '20 MIN DESTROYER',
      category: 'home',
      subcategory: 'hiit_circuits',
      icon: 'circuits',
      isCircuit: true,
      rounds: 4,
      duration: '20 min',
      exercises: [
        //WorkoutExercise(id: 'burpee', name: 'Burpees', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use burpee
        //WorkoutExercise(id: 'dumbbell_lunge', name: 'Jump Lunges', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use jump_lunge
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use pushup
        //WorkoutExercise(id: 'squat_m', name: 'Squat Jumps', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use squat_jump
        //WorkoutExercise(id: 'front_plank', name: 'Plank Jacks', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),  // DUPLICATE - use plank_jack
      ],
    ),
    WorkoutPreset(
      id: 'home_tabata_torture',
      name: 'TABATA TORTURE',
      category: 'home',
      subcategory: 'hiit_circuits',
      icon: 'circuits',
      isCircuit: true,
      rounds: 8,
      duration: '16 min',
      exercises: [
        //WorkoutExercise(id: 'burpee', name: 'Burpees', sets: 1, reps: 1, timeSeconds: 20, restSeconds: 10),  // DUPLICATE - use burpee
        //WorkoutExercise(id: 'burpee', name: 'Mountain Climbers', sets: 1, reps: 1, timeSeconds: 20, restSeconds: 10),  // DUPLICATE - use mountain_climber
        //WorkoutExercise(id: 'squat_m', name: 'Jump Squats', sets: 1, reps: 1, timeSeconds: 20, restSeconds: 10),  // DUPLICATE - use jump_squat
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 1, reps: 1, timeSeconds: 20, restSeconds: 10),  // DUPLICATE - use pushup
      ],
    ),
    WorkoutPreset(
      id: 'home_cardio_blast',
      name: 'CARDIO BLAST',
      category: 'home',
      subcategory: 'hiit_circuits',
      icon: 'circuits',
      isCircuit: true,
      rounds: 3,
      duration: '15 min',
      exercises: [
        //WorkoutExercise(id: 'stationary_bike_run_version_3', name: 'Jumping Jacks', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),  // DUPLICATE - use jumping_jack
        //WorkoutExercise(id: 'stationary_bike_run_version_3', name: 'High Knees', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),  // DUPLICATE - use high_knee
        //WorkoutExercise(id: 'stationary_bike_run_version_3', name: 'Butt Kicks', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),  // DUPLICATE - use butt_kick
        //WorkoutExercise(id: 'squat_m', name: 'Skaters', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),  // DUPLICATE - use skater
        //WorkoutExercise(id: 'burpee', name: 'Burpees', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),  // DUPLICATE - use burpee
      ],
    ),
  ];

  // HOME MODE - HOME BOOTY
  @Deprecated('Use getHomeBooty(difficulty) instead')
  static final List<WorkoutPreset> homeBooty = [
    WorkoutPreset(
      id: 'home_glute_activation',
      name: 'GLUTE ACTIVATION',
      category: 'home',
      subcategory: 'home_booty',
      icon: 'glutes',
      isCircuit: false,
      duration: '~25 min',
      exercises: [
        WorkoutExercise(id: 'hip_thrusts', name: 'Glute Bridge', sets: 3, reps: 20),
        WorkoutExercise(id: 'hip_thrusts', name: 'Single Leg Glute Bridge', sets: 3, reps: 12),
        //WorkoutExercise(id: 'lever_standing_rear_kick', name: 'Donkey Kicks', sets: 3, reps: 15),  // DUPLICATE - use donkey_kick
        //WorkoutExercise(id: 'lever_seated_hip_abduction', name: 'Fire Hydrants', sets: 3, reps: 15),  // DUPLICATE - use fire_hydrant
        //WorkoutExercise(id: 'lever_seated_hip_abduction', name: 'Clamshells', sets: 3, reps: 15),  // DUPLICATE - use clamshell
        //WorkoutExercise(id: 'hip_thrusts', name: 'Frog Pumps', sets: 3, reps: 20),  // DUPLICATE - use frog_pump
      ],
    ),
    WorkoutPreset(
      id: 'home_booty_burner',
      name: 'BOOTY BURNER',
      category: 'home',
      subcategory: 'home_booty',
      icon: 'circuits',
      isCircuit: false,
      duration: '~30 min',
      exercises: [
        //WorkoutExercise(id: 'squat_m', name: 'Sumo Squat Pulse', sets: 3, reps: 20),  // DUPLICATE - use squat_pulse
        //WorkoutExercise(id: 'dumbbell_lunge', name: 'Curtsy Lunges', sets: 3, reps: 12),  // DUPLICATE - use curtsy_lunge
        WorkoutExercise(id: 'hip_thrusts', name: 'Glute Bridge Hold', sets: 3, reps: 30),
        //WorkoutExercise(id: 'lever_standing_rear_kick', name: 'Donkey Kick Pulses', sets: 3, reps: 20),  // DUPLICATE - use donkey_kick_pulse
        WorkoutExercise(id: 'squat_m', name: 'Squat to Kick Back', sets: 3, reps: 12),
        WorkoutExercise(id: 'dumbbell_romanian_deadlift', name: 'Single Leg Deadlift', sets: 3, reps: 10),
      ],
    ),
    WorkoutPreset(
      id: 'home_band_booty',
      name: 'BAND BOOTY',
      category: 'home',
      subcategory: 'home_booty',
      icon: 'glutes',
      isCircuit: false,
      duration: '~30 min',
      exercises: [
        WorkoutExercise(id: 'squat_m', name: 'Banded Squat', sets: 3, reps: 15),
        WorkoutExercise(id: 'hip_thrusts', name: 'Banded Glute Bridge', sets: 3, reps: 15),
        WorkoutExercise(id: 'lever_seated_hip_abduction', name: 'Banded Clamshell', sets: 3, reps: 15),
        WorkoutExercise(id: 'cable_kickback', name: 'Banded Kickback', sets: 3, reps: 15),
        WorkoutExercise(id: 'lever_seated_hip_abduction', name: 'Banded Lateral Walk', sets: 3, reps: 12),
        WorkoutExercise(id: 'lever_seated_hip_abduction', name: 'Banded Fire Hydrant', sets: 3, reps: 12),
      ],
    ),
  ];

  // HOME MODE - GIRL POWER
  @Deprecated('Use getHomeGirlPower(difficulty) instead')
  static final List<WorkoutPreset> homeGirlPower = [
    WorkoutPreset(
      id: 'home_girl_glute_sculpt',
      name: 'GLUTE SCULPT',
      category: 'home',
      subcategory: 'girl_power',
      icon: 'glutes',
      isCircuit: false,
      duration: '~35 min',
      exercises: [
        WorkoutExercise(id: 'hip_thrusts', name: 'Glute Bridge', sets: 4, reps: 15),
        WorkoutExercise(id: 'hip_thrusts', name: 'Single Leg Glute Bridge', sets: 3, reps: 10),
        WorkoutExercise(id: 'lever_standing_rear_kick', name: 'Donkey Kick', sets: 3, reps: 15),
        WorkoutExercise(id: 'lever_seated_hip_abduction', name: 'Fire Hydrant', sets: 3, reps: 15),
        //WorkoutExercise(id: 'dumbbell_single_leg_split_squat', name: 'Bulgarian Split Squat', sets: 3, reps: 10, included: true),  // DUPLICATE - use bulgarian_split_squat
        WorkoutExercise(id: 'lying_leg_raise', name: 'Side-Lying Leg Raise', sets: 3, reps: 15, included: true),
      ],
    ),
    WorkoutPreset(
      id: 'home_girl_upper_lower',
      name: 'UPPER/LOWER SPLIT',
      category: 'home',
      subcategory: 'girl_power',
      icon: 'splits',
      isCircuit: false,
      duration: '~40 min',
      exercises: [
        // Upper
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 3, reps: 12),  // DUPLICATE - use pushup
        //WorkoutExercise(id: 'decline_push_up_m', name: 'Pike Push-Ups', sets: 3, reps: 10),  // DUPLICATE - use pike_pushup
        //WorkoutExercise(id: 'reverse_hyper_on_flat_bench', name: 'Superman Raises', sets: 3, reps: 15),
        WorkoutExercise(id: 'triceps_dips_floor', name: 'Tricep Dips (chair)', sets: 3, reps: 12),
        // Lower
        //WorkoutExercise(id: 'squat_m', name: 'Air Squats', sets: 4, reps: 20, included: true),  // DUPLICATE - use air_squat
        //WorkoutExercise(id: 'dumbbell_lunge', name: 'Lunges', sets: 3, reps: 12, included: true),  // DUPLICATE - use lunge
        WorkoutExercise(id: 'hip_thrusts', name: 'Glute Bridge', sets: 4, reps: 15, included: true),
      ],
    ),
    WorkoutPreset(
      id: 'home_girl_full_body',
      name: 'FULL BODY',
      category: 'home',
      subcategory: 'girl_power',
      icon: 'splits',
      isCircuit: false,
      duration: '~35 min',
      exercises: [
        //WorkoutExercise(id: 'squat_m', name: 'Air Squats', sets: 3, reps: 20),  // DUPLICATE - use air_squat
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 3, reps: 12),  // DUPLICATE - use pushup
        WorkoutExercise(id: 'hip_thrusts', name: 'Glute Bridge', sets: 3, reps: 15),
        //WorkoutExercise(id: 'reverse_hyper_on_flat_bench', name: 'Superman Raises', sets: 3, reps: 15),
        //WorkoutExercise(id: 'dumbbell_lunge', name: 'Lunges', sets: 3, reps: 12),  // DUPLICATE - use lunge
        WorkoutExercise(id: 'front_plank', name: 'Plank', sets: 2, reps: 45, included: true),
        //WorkoutExercise(id: 'burpee', name: 'Mountain Climbers', sets: 3, reps: 20, included: true),  // DUPLICATE - use mountain_climber
      ],
    ),
    WorkoutPreset(
      id: 'home_girl_push_pull_legs',
      name: 'PUSH/PULL/LEGS',
      category: 'home',
      subcategory: 'girl_power',
      icon: 'girlpower',
      isCircuit: false,
      duration: '~35 min',
      exercises: [
        // Push
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 3, reps: 12),  // DUPLICATE - use pushup
        //WorkoutExercise(id: 'decline_push_up_m', name: 'Pike Push-Ups', sets: 3, reps: 10),  // DUPLICATE - use pike_pushup
        //WorkoutExercise(id: 'close_grip_push_up', name: 'Diamond Push-Ups', sets: 2, reps: 10),  // DUPLICATE - use diamond_pushup
        // Pull
        //WorkoutExercise(id: 'reverse_hyper_on_flat_bench', name: 'Superman Raises', sets: 3, reps: 15, included: true),
        //WorkoutExercise(id: 'inverted_row', name: 'Inverted Rows (table)', sets: 3, reps: 10, included: true),  // DUPLICATE - use inverted_row
        // Legs
        //WorkoutExercise(id: 'squat_m', name: 'Air Squats', sets: 4, reps: 20, included: true),  // DUPLICATE - use air_squat
        WorkoutExercise(id: 'hip_thrusts', name: 'Glute Bridge', sets: 3, reps: 15, included: true),
      ],
    ),
    WorkoutPreset(
      id: 'home_girl_full_body_circuit',
      name: 'FULL BODY CIRCUIT',
      category: 'home',
      subcategory: 'girl_power',
      icon: 'circuits',
      isCircuit: false,
      duration: '~30 min',
      exercises: [
        //WorkoutExercise(id: 'push_up_m', name: 'Push-Ups', sets: 4, reps: 12),  // DUPLICATE - use pushup
        //WorkoutExercise(id: 'wide_hand_push_up', name: 'Wide Push-Ups', sets: 3, reps: 12),  // DUPLICATE - use wide_pushup
        //WorkoutExercise(id: 'decline_push_up_m', name: 'Pike Push-Ups', sets: 3, reps: 10),  // DUPLICATE - use pike_pushup
        WorkoutExercise(id: 'triceps_dips_floor', name: 'Tricep Dips (chair)', sets: 3, reps: 12),
        //WorkoutExercise(id: 'close_grip_push_up', name: 'Diamond Push-Ups', sets: 2, reps: 10, included: true),  // DUPLICATE - use diamond_pushup
      ],
    ),
  ];

  // HOME MODE - RECOVERY & MOBILITY
  static final List<WorkoutPreset> homeRecovery = [
    WorkoutPreset(
      id: 'home_full_body_stretch',
      name: 'FULL BODY STRETCH',
      category: 'home',
      subcategory: 'recovery',
      icon: 'bodyweight',
      isCircuit: false,
      duration: '~20 min',
      exercises: [
        //WorkoutExercise(id: 'cat_cow', name: 'Cat-Cow', sets: 2, reps: 10),
        //WorkoutExercise(id: 'worlds_greatest_stretch', name: "World's Greatest Stretch", sets: 2, reps: 5),
        //WorkoutExercise(id: 'pigeon_pose', name: 'Pigeon Pose', sets: 2, reps: 30),
        //WorkoutExercise(id: 'hamstring_stretch', name: 'Hamstring Stretch', sets: 2, reps: 30),
        //WorkoutExercise(id: 'quad_stretch', name: 'Quad Stretch', sets: 2, reps: 30),
        //WorkoutExercise(id: 'chest_doorway_stretch', name: 'Chest Doorway Stretch', sets: 2, reps: 30),
        //WorkoutExercise(id: 'childs_pose', name: "Child's Pose", sets: 2, reps: 30),
      ],
    ),
    WorkoutPreset(
      id: 'home_hip_opener',
      name: 'HIP OPENER',
      category: 'home',
      subcategory: 'recovery',
      icon: 'bodyweight',
      isCircuit: false,
      duration: '~15 min',
      exercises: [
        //WorkoutExercise(id: '90_90_stretch', name: '90/90 Stretch', sets: 2, reps: 30),
        //WorkoutExercise(id: 'pigeon_pose', name: 'Pigeon Pose', sets: 2, reps: 30),
        //WorkoutExercise(id: 'frog_stretch', name: 'Frog Stretch', sets: 2, reps: 30),
        //WorkoutExercise(id: 'hip_flexor_stretch', name: 'Hip Flexor Stretch', sets: 2, reps: 30),
        //WorkoutExercise(id: 'happy_baby', name: 'Happy Baby', sets: 2, reps: 30),
        //WorkoutExercise(id: 'butterfly_stretch', name: 'Butterfly Stretch', sets: 2, reps: 30),
      ],
    ),
  ];

  // Combined list of all workout presets
  static List<WorkoutPreset> get allWorkoutPresets => [
    ...gymMuscleSplits,
    ...gymMuscleGroupings,
    ...gymCircuits,
    ...gymBootyBuilder,
    ...gymGirlPower,
    ...homeBodyweightBasics,
    ...homeHIITCircuits,
    ...homeBooty,
    ...homeGirlPower,
    ...homeRecovery,
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // ALL EXERCISES - 755 exercises for AI mode custom workout builder
  // Every ID in this list exists in movement_engine.dart
  // GIF key IDs display videos directly; home IDs use overrides for video
  // ═══════════════════════════════════════════════════════════════════════════

  static const List<Exercise> allMovementEngineExercises = [
    Exercise(id: 'sled_calf_press_on_leg_press', name: '45° Calf Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_45°_calf_press', name: '45° Calf Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_hack_squat', name: '45° Leg Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_45°_leg_press', name: '45° Leg Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_45°_narrow_stance_leg_press', name: '45° Narrow Leg Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_45°_leg_wide_press', name: '45° Wide Leg Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'squat_m', name: 'Air Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_alternate_biceps_curl', name: 'Alternate Bicep Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_alternate_biceps_curl', name: 'Alternate Bicep Curl (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'cable_alternate_triceps_extension', name: 'Alternate Tricep Extension (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'sled_forward_angled_calf_raise', name: 'Angled Calf Raise (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'archer_push_up', name: 'Archer Push-Up', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_arnold_press', name: 'Arnold Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_arnold_press_ii', name: 'Arnold Press V2 (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'hyperextension', name: 'Back Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hyperextension_on_bench', name: 'Back Extension (Bench)', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hyperextension_version_2', name: 'Back Extension V2', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_full_squat', name: 'Back Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_curl', name: 'Barbell Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_seated_behind_head_military_press', name: 'Behind Neck Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'smith_behind_neck_press', name: 'Behind Neck Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_standing_behind_head_military_press', name: 'Behind Neck Press - Standing (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'weighted_bench_dip', name: 'Bench Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'triceps_dips_floor', name: 'Bench Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bench_dip_knees_bent', name: 'Bench Dip Knees Bent', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'barbell_bench_front_squat', name: 'Bench Front Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_bench_press', name: 'Bench Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_bench_press', name: 'Bench Press (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_bench_press', name: 'Bench Press (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'smith_bench_press', name: 'Bench Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'barbell_bench_squat', name: 'Bench Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_bench_squat', name: 'Bench Squat (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'bent_knee_glute_bridge', name: 'Bent Knee Glute Bridge', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'barbell_bent_over_row', name: 'Bent Over Row (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_bent_over_row', name: 'Bent Over Row (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'smith_bent_over_narrow_supinated_grip_row', name: 'Bent Over Row - Narrow Supinated (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_bent_over_pronated_grip_row', name: 'Bent Over Row - Pronated (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'dumbbell_standing_bent_over_two_arm_triceps_extension', name: 'Bent Over Tricep Extension (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_biceps_curl', name: 'Bicep Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_curl_male', name: 'Bicep Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_bicep_curl', name: 'Bicep Curl (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_machine_bicep_curl', name: 'Bicep Curl (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'cable_biceps_curl_sz_bar', name: 'Bicep Curl - EZ Bar (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_curl_with_multipurpose_v_bar', name: 'Bicep Curl - V Bar (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'bicycle_crunch', name: 'Bicycle Crunch', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'bird_dog', name: 'Bird Dog', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'jump_on_fit_box', name: 'Box Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bulgarian_split_squat', name: 'Bulgarian Split Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_single_leg_split_squat', name: 'Bulgarian Split Squat (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'smith_single_leg_split_squat', name: 'Bulgarian Split Squat (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'bulgarian_split_sumo_squat', name: 'Bulgarian Split Sumo Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'burpee_jump_box', name: 'Burpee Box Jump', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'butt_kicks', name: 'Butt Kicks', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'butt_ups', name: 'Butt Ups', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_crossover_variation', name: 'Cable Crossover (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_kneeling_crunch', name: 'Cable Crunch (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_calf_press_plate_loaded', name: 'Calf Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_calf_raise_bench_press_machine', name: 'Calf Raise (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_calf_raise_version_2', name: 'Calf Raise (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'lever_chair_squat', name: 'Chair Squat (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_chair_squat', name: 'Chair Squat (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'chest_dip', name: 'Chest Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_fly', name: 'Chest Fly', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_standing_fly', name: 'Chest Fly (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_chest_press', name: 'Chest Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_chest_press_plate_loaded', name: 'Chest Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_chest_press_version_4', name: 'Chest Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_chest_press_version_2', name: 'Chest Press - Wide (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'dumbbell_row_with_chest_supported', name: 'Chest Supported Row (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'chin_up', name: 'Chin-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_close_grip_bench_press', name: 'Close Grip Bench Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'smith_close_grip_bench_press', name: 'Close Grip Bench Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'close_grip_chin_up', name: 'Close Grip Chin-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'ez_barbell_close_grip_curl', name: 'Close Grip Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_close_grip_curl', name: 'Close Grip Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_close_grip_front_lat_pulldown', name: 'Close Grip Lat Pulldown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_standing_close_grip_military_press', name: 'Close Grip Military Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'ez_barbell_close_grip_preacher_curl', name: 'Close Grip Preacher Curl (EZ Bar)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_close_grip_press', name: 'Close Grip Press (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cocoons', name: 'Cocoons', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_concentration_curl', name: 'Concentration Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_concentration_curl', name: 'Concentration Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_concentration_extension_on_knee', name: 'Concentration Extension (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cross_body_crunch', name: 'Cross Body Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_cross_body_hammer_curl', name: 'Cross Body Hammer Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_cross_body_hammer_curl_version_2', name: 'Cross Body Hammer Curl V2 (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'crossover_high_knee', name: 'Crossover High Knee', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'cable_cross_over_lateral_pulldown', name: 'Crossover Lat Pulldown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'crunch_floor_m', name: 'Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'crunch_on_stability_ball', name: 'Crunch on Stability Ball', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'ez_barbell_curl', name: 'Curl (EZ Bar)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'single_curtsy_lunge', name: 'Curtsy Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_deadlift', name: 'Deadlift (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_deadlift', name: 'Deadlift (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_deadlift_plate_loaded', name: 'Deadlift (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_deadlift', name: 'Deadlift (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'barbell_decline_bench_press', name: 'Decline Bench Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'smith_decline_bench_press', name: 'Decline Bench Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'lever_decline_chest_press', name: 'Decline Chest Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_decline_chest_press_version_2', name: 'Decline Chest Press - Wide (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_machine_decline_close_grip_bench_press', name: 'Decline Close Grip Bench Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'barbell_decline_close_grip_to_skull_press', name: 'Decline Close Grip Skull Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_decline_bench_press', name: 'Decline Dumbbell Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_decline_fly', name: 'Decline Fly (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_decline_fly', name: 'Decline Fly (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_decline_hammer_press', name: 'Decline Hammer Press (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_decline_press', name: 'Decline Press (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_decline_bent_arm_pullover', name: 'Decline Pullover (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_decline_pullover', name: 'Decline Pullover (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'decline_push_up_m', name: 'Decline Push-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'smith_decline_reverse_grip_press', name: 'Decline Reverse Grip Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'dumbbell_decline_shrug', name: 'Decline Shrug (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_decline_triceps_extension', name: 'Decline Tricep Extension (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'ez_barbell_decline_triceps_extension', name: 'Decline Tricep Extension (EZ Bar)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_decline_wide_grip_press', name: 'Decline Wide Grip Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_decline_wide_grip_pullover', name: 'Decline Wide Grip Pullover (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'close_grip_push_up', name: 'Diamond Push-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_seated_dip', name: 'Dip (Machine)', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'lever_donkey_calf_raise', name: 'Donkey Calf Raise (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'donkey_kick_leg_straight', name: 'Donkey Kick Leg Straight', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'cable_donkey_kickback', name: 'Donkey Kickback (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_drag_curl', name: 'Drag Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_drag_curl', name: 'Drag Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'elbow_to_knee', name: 'Elbow to Knee', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_elevated_row', name: 'Elevated Row (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_rope_elevated_seated_row', name: 'Elevated Seated Row - Rope (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_cross_over_revers_fly', name: 'Face Pull (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_floor_calf_raise', name: 'Floor Calf Raise (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'flutter_kicks', name: 'Flutter Kick', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'flutter_kicks_version_2', name: 'Flutter Kicks V2', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'flutter_kicks_version_3', name: 'Flutter Kicks V3', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'smith_frankenstein_squat', name: 'Frankenstein Squat (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'barbell_front_chest_squat', name: 'Front Chest Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'lever_front_pulldown', name: 'Front Pulldown (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'barbell_front_raise', name: 'Front Raise (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_front_raise', name: 'Front Raise (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_front_raise', name: 'Front Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'barbell_front_raise_and_pullover', name: 'Front Raise and Pullover (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_front_shoulder_raise', name: 'Front Shoulder Raise (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_front_squat', name: 'Front Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'smith_front_squat', name: 'Front Squat (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_front_squat_clean_grip', name: 'Front Squat - Clean Grip (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'lever_full_squat', name: 'Full Squat (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'rear_decline_bridge', name: 'Glute Bridge (Decline)', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'resistance_band_glute_bridge_abduction', name: 'Glute Bridge Abduction (Band)', difficulty: 'beginner', equipment: 'bands'),
    Exercise(id: 'glute_bridge_hold', name: 'Glute Bridge Hold', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'glutes_bridge_lift_the_hip_high', name: 'Glute Bridge Lift High', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'lever_standing_rear_kick', name: 'Glute Kickback (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'dumbbell_goblet_squat', name: 'Goblet Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_goblet_sumo_squat', name: 'Goblet Sumo Squat (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'barbell_good_morning', name: 'Good Morning (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'hack_calf_raise', name: 'Hack Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sled_full_hack_squat', name: 'Hack Squat (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'dumbbell_hammer_curl', name: 'Hammer Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_hammer_curl_with_rope_attachment_male', name: 'Hammer Curl - Rope (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_hammer_curl_ii', name: 'Hammer Curl V2 (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'hammer_grip_pull_up_on_dip_cage', name: 'Hammer Grip Pull Up on Dip Cage', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hanging_leg_hip_raise', name: 'Hanging Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_high_bar_squat', name: 'High Bar Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_high_curl', name: 'High Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'high_knee_step_up', name: 'High Knee Step-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_high_pulley_overhead_tricep_extension', name: 'High Pulley Tricep Extension (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_standing_cross_over_high_reverse_fly', name: 'High Reverse Fly (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_high_row_plate_loaded', name: 'High Row (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_hip_abduction', name: 'Hip Abduction (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_side_hip_abduction', name: 'Hip Abduction - Standing (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_hip_abduction_version_2', name: 'Hip Abduction V2 (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'cable_hip_adduction', name: 'Hip Adduction (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_seated_hip_adduction', name: 'Hip Adduction (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_side_hip_adduction', name: 'Hip Adduction - Standing (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_hip_adduction_version_2', name: 'Hip Adduction V2 (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_hip_extension_version_2', name: 'Hip Extension (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_standing_hip_extension', name: 'Hip Extension (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'hip_raise_bent_knee', name: 'Hip Raise Bent Knee', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hip_thrusts', name: 'Hip Thrust', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_hip_thrust', name: 'Hip Thrust (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_incline_bench_press', name: 'Incline Bench Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_incline_bench_press', name: 'Incline Bench Press (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_incline_bench_press', name: 'Incline Bench Press (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'smith_incline_bench_press', name: 'Incline Bench Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'leverage_incline_chest_press', name: 'Incline Chest Press (Leverage)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_incline_chest_press', name: 'Incline Chest Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'barbell_incline_close_grip_bench_press', name: 'Incline Close Grip Bench Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_incline_fly', name: 'Incline Fly (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_incline_fly', name: 'Incline Fly (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_incline_front_raise', name: 'Incline Front Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_incline_hammer_chest_press', name: 'Incline Hammer Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'dumbbell_incline_inner_biceps_curl', name: 'Incline Inner Bicep Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_palms_in_incline_bench_press', name: 'Incline Press - Neutral Grip (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_incline_pushdown', name: 'Incline Pushdown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_incline_raise', name: 'Incline Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_incline_rear_lateral_raise', name: 'Incline Rear Lateral Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_incline_reverse_grip_30_degrees_bench_press', name: 'Incline Reverse Grip Bench Press (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'barbell_incline_reverse_grip_press', name: 'Incline Reverse Grip Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'smith_incline_reverse_grip_press', name: 'Incline Reverse Grip Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'incline_reverse_grip_push_up', name: 'Incline Reverse Grip Push-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_incline_row', name: 'Incline Row (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_incline_row', name: 'Incline Row (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_incline_shrug', name: 'Incline Shrug (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_incline_triceps_extension', name: 'Incline Tricep Extension (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_incline_triceps_extension', name: 'Incline Tricep Extension (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'ez_barbell_incline_triceps_extension', name: 'Incline Tricep Extension (EZ Bar)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'smith_machine_incline_tricep_extension', name: 'Incline Tricep Extension (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'cable_rope_incline_tricep_extension', name: 'Incline Tricep Extension - Rope (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_incline_wide_reverse_grip_bench_press', name: 'Incline Wide Reverse Grip Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'machine_inner_chest_press', name: 'Inner Chest Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'inverse_leg_curl_on_pull_up_cable_machine', name: 'Inverse Leg Curl on Pull Up Cable Machine', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'inverted_row', name: 'Inverted Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'inverted_row_bent_knees', name: 'Inverted Row (Bent Knee)', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jump_squat', name: 'Jump Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bodyweight_jump_squat_wide_leg', name: 'Jump Squat Wide Leg', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jumping_jack', name: 'Jumping Jack', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'cable_kickback', name: 'Kickback (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_kickback', name: 'Kickback (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_kneeling_leg_curl_plate_loaded', name: 'Kneeling Leg Curl (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'kneeling_straight_leg_kickback', name: 'Kneeling Straight Leg Kickback', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'cable_kneeling_triceps_extension', name: 'Kneeling Tricep Extension (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_kneeling_triceps_extension_version_2', name: 'Kneeling Tricep Extension V2 (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_bar_lateral_pulldown', name: 'Lat Pulldown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_lateral_pulldown_plate_loaded', name: 'Lat Pulldown (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'cable_lat_pulldown_full_range_of_motion', name: 'Lat Pulldown - Full ROM (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_lateral_raise', name: 'Lateral Raise (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_lateral_raise', name: 'Lateral Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_lateral_raise', name: 'Lateral Raise (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_lateral_raise_plate_loaded', name: 'Lateral Raise (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_lateral_step_up', name: 'Lateral Step-Up (Smith)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_leg_extension', name: 'Leg Extension (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_leg_extension_plate_loaded', name: 'Leg Extension (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_leg_press', name: 'Leg Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_leg_press', name: 'Leg Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'lying_leg_raise', name: 'Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lying_leg_raise_and_hold', name: 'Leg Raise and Hold', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_low_bar_squat', name: 'Low Bar Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'smith_low_bar_squat', name: 'Low Bar Squat (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'barbell_low_bar_squat_with_rack', name: 'Low Bar Squat with Rack (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_low_fly', name: 'Low Fly (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_low_seated_row', name: 'Low Seated Row (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_lunge', name: 'Lunge (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_lunge', name: 'Lunge (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lying_bicycle_crunch', name: 'Lying Bicycle Crunch', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'lever_lying_chest_press_plate_loaded', name: 'Lying Chest Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'cable_lying_close_»rip_curl', name: 'Lying Close Grip Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_lying_close_grip_press', name: 'Lying Close Grip Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_lying_elbow_press', name: 'Lying Elbow Press (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'barbell_lying_extension', name: 'Lying Extension (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_lying_fly', name: 'Lying Fly (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_lying_hammer_press', name: 'Lying Hammer Press (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_lying_hammer_press_version_2', name: 'Lying Hammer Press V2 (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_lying_femoral', name: 'Lying Hamstring Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'barbell_lying_lifting_on_hip', name: 'Lying Hip Lift (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'lever_lying_leg_curl', name: 'Lying Leg Curl (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_lying_squat', name: 'Lying Leg Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lying_leg_raise_flat_bench', name: 'Lying Leg Raise (Flat Bench)', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_lying_extension_pullover_with_rope_attachment', name: 'Lying Pullover - Rope (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_lying_rear_delt_row', name: 'Lying Rear Delt Row (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_lying_single_extension', name: 'Lying Single Arm Extension (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_lying_t_bar_row', name: 'Lying T-Bar Row (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'barbell_lying_back_of_the_head_tricep_extension', name: 'Lying Tricep Extension (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_lying_triceps_extension', name: 'Lying Tricep Extension (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_lying_triceps_extension', name: 'Lying Tricep Extension (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_medius_kickback', name: 'Medius Kickback (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_middle_fly', name: 'Mid Fly (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_standing_military_press', name: 'Military Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'lever_military_press_plate_loaded', name: 'Military Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_standing_military_press', name: 'Military Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'burpee', name: 'Mountain Climber', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'mountain_climber', name: 'Mountain Climber', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'chin_ups_narrow_parallel_grip', name: 'Narrow Grip Chin-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pull_up_neutral_grip', name: 'Neutral Grip Pullup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_neutral_grip_seated_row_plate_loaded', name: 'Neutral Grip Seated Row (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'nordic_hamstring_curl', name: 'Nordic Hamstring Curl', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'barbell_olympic_squat', name: 'Olympic Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_overhead_curl', name: 'Overhead Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_overhead_triceps_extension_rope_attachment', name: 'Overhead Tricep Extension (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_horizontal_pallof_press', name: 'Pallof Press (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_palm_rotational_bent_over_row', name: 'Palm Rotation Row (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_parallel_chest_press', name: 'Parallel Chest Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_pec_deck_fly', name: 'Pec Deck (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'pike_push_ups', name: 'Pike Push-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'single_leg_squat_with_support_pistol', name: 'Pistol Squat (Assisted)', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'barbell_one_leg_squat', name: 'Pistol Squat (Barbell)', difficulty: 'advanced', equipment: 'barbell'),
    Exercise(id: 'lever_pistol_squat', name: 'Pistol Squat (Machine)', difficulty: 'advanced', equipment: 'machine'),
    Exercise(id: 'front_plank', name: 'Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'barbell_preacher_curl', name: 'Preacher Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_preacher_curl', name: 'Preacher Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_preacher_curl', name: 'Preacher Curl (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_preacher_curl_plate_loaded', name: 'Preacher Curl (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_preacher_curl_version_2', name: 'Preacher Curl (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_hammer_grip_preacher_curl', name: 'Preacher Curl - Hammer (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'dumbbell_peacher_hammer_curl', name: 'Preacher Hammer Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'barbell_prone_incline_curl', name: 'Prone Incline Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_pull_through', name: 'Pull Through (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'pull_up', name: 'Pull-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_pulldown', name: 'Pulldown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_bent_arm_pullover', name: 'Pullover (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_pullover', name: 'Pullover (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_pullover_plate_loaded', name: 'Pullover (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'bodyweight_pulse_goblet_squat', name: 'Pulse Goblet Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'push_up_m', name: 'Push-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'push_up_on_forearms', name: 'Push-Up on Forearms', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_quarter_squat', name: 'Quarter Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_rear_fly', name: 'Rear Delt Fly (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_rear_delt_raise', name: 'Rear Delt Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_rear_lateral_raise', name: 'Rear Delt Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'barbell_rear_delt_row', name: 'Rear Delt Row (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_rear_delt_row', name: 'Rear Delt Row (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'rear_pull_up', name: 'Rear Pull Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_rear_pulldown', name: 'Rear Pulldown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_reverse_bench_press', name: 'Reverse Bench Press (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_biceps_curl_reverse', name: 'Reverse Bicep Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'smith_reverse_calf_raises', name: 'Reverse Calf Raise (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'barbell_reverse_close_grip_bench_press', name: 'Reverse Close Grip Bench Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'reverse_crunch_m', name: 'Reverse Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_reverse_curl', name: 'Reverse Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_standing_reverse_curl_sz_bar', name: 'Reverse Curl - EZ Bar (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'smith_machine_reverse_decline_close_grip_bench_press', name: 'Reverse Decline Close Grip Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'reverse_dip', name: 'Reverse Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_seated_reverse_fly', name: 'Reverse Fly (Machine)', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'barbell_reverse_grip_bent_over_row', name: 'Reverse Grip Bent Over Row (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'ez_bar_reverse_grip_bent_over_row', name: 'Reverse Grip Bent Over Row (EZ Bar)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'smith_reverse_grip_bent_over_row', name: 'Reverse Grip Bent Over Row (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'dumbbell_revers_grip_biceps_curl', name: 'Reverse Grip Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'ez_barbell_reverse_grip_curl', name: 'Reverse Grip Curl (EZ Bar)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_grip_decline_bench_press', name: 'Reverse Grip Decline Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_reverse_grip_straight_back_seated_high_row', name: 'Reverse Grip High Row (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_reverse_grip_incline_bench_press', name: 'Reverse Grip Incline Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_grip_incline_bench_row', name: 'Reverse Grip Incline Row (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_reverse_grip_incline_bench_two_arm_row', name: 'Reverse Grip Incline Row (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'reverse_grip_machine_lat_pulldown', name: 'Reverse Grip Machine Lat Pulldown', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'ez_barbell_reverse_grip_preacher_curl', name: 'Reverse Grip Preacher Curl (EZ Bar)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'lever_reverse_grip_preacher_curl', name: 'Reverse Grip Preacher Curl (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_reverse_grip_press', name: 'Reverse Grip Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'cable_reverse_grip_triceps_pushdown_sz_bar', name: 'Reverse Grip Pushdown - EZ Bar (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_reverse_grip_skullcrusher', name: 'Reverse Grip Skull Crusher (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'lever_reverse_grip_vertical_row', name: 'Reverse Grip Vertical Row (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_reverse_hack_squat', name: 'Reverse Hack Squat (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'reverse_hyper_on_flat_bench', name: 'Reverse Hyper', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_rear_lunge', name: 'Reverse Lunge (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_rear_lunge', name: 'Reverse Lunge (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_reverse_lunge_from_deficit', name: 'Reverse Lunge from Deficit (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_reverse_preacher_curl', name: 'Reverse Preacher Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_reverse_preacher_curl', name: 'Reverse Preacher Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_romanian_deadlift', name: 'Romanian Deadlift (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_rotary_calf', name: 'Rotary Calf (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_row_plate_loaded', name: 'Row (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'russian_twist_with_medicine_ball', name: 'Russian Twist', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'russian_twist', name: 'Russian Twist', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_seated_close_grip_behind_neck_triceps_extension', name: 'Seated Behind Neck Tricep Extension (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_seated_bench_extension', name: 'Seated Bench Extension (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_bench_seated_press', name: 'Seated Bench Press (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_bent_arm_lateral_raise', name: 'Seated Bent Arm Lateral Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_bicep_curl', name: 'Seated Bicep Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_seated_calf_press', name: 'Seated Calf Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'barbell_seated_calf_raise', name: 'Seated Calf Raise (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'lever_seated_calf_raise_plate_loaded', name: 'Seated Calf Raise (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'cable_seated_chest_press', name: 'Seated Chest Press (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_seated_close_grip_concentration_curl', name: 'Seated Concentration Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'ez_bar_seated_close_grip_concentration_curl', name: 'Seated Concentration Curl (EZ Bar)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_seated_curl', name: 'Seated Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'ez_barbell_seated_curls', name: 'Seated Curl (EZ Bar)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'lever_seated_fly', name: 'Seated Fly (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'dumbbell_seated_front_raise', name: 'Seated Front Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'barbell_seated_good_morning', name: 'Seated Good Morning (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_seated_hammer_curl', name: 'Seated Hammer Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_seated_high_row_v_bar', name: 'Seated High Row - V Bar (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_seated_kickback', name: 'Seated Kickback (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_lateral_raise', name: 'Seated Lateral Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_seated_leg_curl', name: 'Seated Leg Curl (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'seated_leg_raise', name: 'Seated Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_seated_military_press_inside_squat_cage', name: 'Seated Military Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'lever_seated_one_leg_calf_raise', name: 'Seated One Leg Calf Raise (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'barbell_seated_overhead_triceps_extension', name: 'Seated Overhead Tricep Extension (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_seated_preacher_curl', name: 'Seated Preacher Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_seated_rear_lateral_raise', name: 'Seated Rear Lateral Raise (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_seated_revers_grip_concentration_curl', name: 'Seated Reverse Grip Concentration Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_seated_row', name: 'Seated Row (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_seated_row', name: 'Seated Row (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'cable_seated_row_bent_bar', name: 'Seated Row - Bent Bar (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_rope_seated_row', name: 'Seated Row - Rope (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'smith_seated_shoulder_press', name: 'Seated Shoulder Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'lever_seated_squat', name: 'Seated Squat (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'dumbbell_seated_triceps_extension', name: 'Seated Tricep Extension (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbells_seated_triceps_extension', name: 'Seated Tricep Extension (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'ez_barbell_seated_triceps_extension', name: 'Seated Tricep Extension (EZ Bar)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_seated_wide_grip_row', name: 'Seated Wide Grip Row (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_seated_wide_squat', name: 'Seated Wide Squat (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'shoulder_grip_pull_up', name: 'Shoulder Grip Pull Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_shoulder_press', name: 'Shoulder Press (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_seated_shoulder_press', name: 'Shoulder Press (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_seated_shoulder_press', name: 'Shoulder Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_shoulder_press_plate_loaded_ii', name: 'Shoulder Press (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_shoulder_press', name: 'Shoulder Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'lever_shoulder_press_plate_loaded_version_3', name: 'Shoulder Press V3 (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'barbell_shrug', name: 'Shrug (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'lever_shrug_bench_press_machine', name: 'Shrug (Bench Press Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'cable_shrug', name: 'Shrug (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_shrug', name: 'Shrug (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_shrug_plate_loaded', name: 'Shrug (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_shrug', name: 'Shrug (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'side_plank_male', name: 'Side Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'barbell_side_split_squat_ii', name: 'Side Split Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_standing_one_arm_concentration_curl', name: 'Single Arm Concentration Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_one_arm_curl', name: 'Single Arm Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_standing_one_arm_extension', name: 'Single Arm Extension (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_one_arm_inner_biceps_curl', name: 'Single Arm Inner Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_one_arm_kickback', name: 'Single Arm Kickback (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_one_arm_lateral_raise', name: 'Single Arm Lateral Raise (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_one_arm_row_rack_support', name: 'Single Arm Row (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_single_arm_neutral_grip_seated_row_plate_loaded', name: 'Single Arm Row (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_unilateral_row', name: 'Single Arm Row (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'cable_one_arm_side_triceps_pushdown', name: 'Single Arm Tricep Pushdown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_alternate_leg_extension_plate_loaded', name: 'Single Leg Extension (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'single_leg_glute_bridge', name: 'Single Leg Glute Bridge', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'single_straight_leg_glute_bridge_hold', name: 'Single Straight Leg Glute Bridge Hold', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'sit_squat', name: 'Sit Squat', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: '3_4_sit_up', name: 'Sit-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sit_up_ii', name: 'Sit-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'skater_hops', name: 'Skater Hops', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_lying_close_grip_triceps_extension', name: 'Skull Crusher (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'split_squats', name: 'Split Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'smith_split_squat', name: 'Split Squat (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'dumbbell_squat', name: 'Squat (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_squat_plate_loaded', name: 'Squat (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_squat', name: 'Squat (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_squat_to_bench', name: 'Squat to Bench (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'dumbbell_standing_alternate_raise', name: 'Standing Alternate Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_biceps_curl', name: 'Standing Bicep Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'bodyweight_standing_calf_raise', name: 'Standing Calf Raise', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'barbell_standing_leg_calf_raise', name: 'Standing Calf Raise (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_standing_calf_raise', name: 'Standing Calf Raise (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_standing_calf_raise', name: 'Standing Calf Raise (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'lever_standing_calf_raise', name: 'Standing Calf Raise (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'barbell_standing_concentration_curl', name: 'Standing Concentration Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_standing_concentration_curl', name: 'Standing Concentration Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_standing_up_straight_crossovers', name: 'Standing Crossover (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_standing_hip_extension', name: 'Standing Hip Extension (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_standing_inner_biceps_curl', name: 'Standing Inner Bicep Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_inner_biceps_curl_version_2', name: 'Standing Inner Bicep Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_standing_inner_curl', name: 'Standing Inner Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_standing_kickback', name: 'Standing Kickback (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_standing_leg_curl', name: 'Standing Leg Curl (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_standing_leg_raise', name: 'Standing Leg Raise (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'barbell_standing_overhead_triceps_extension', name: 'Standing Overhead Tricep Extension (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_standing_reverse_grip_curl', name: 'Standing Reverse Grip Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_standing_triceps_extension', name: 'Standing Tricep Extension (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'star_jump', name: 'Star Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_step_up', name: 'Step Up (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_step_up', name: 'Step Up (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'barbell_straight_leg_deadlift', name: 'Stiff Leg Deadlift (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'dumbbell_stiff_leg_deadlift', name: 'Stiff Leg Deadlift (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'smith_stiff_legged_deadlift', name: 'Stiff Leg Deadlift (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'barbell_stiff_leg_good_morning', name: 'Stiff Leg Good Morning (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_straight_arm_pulldown', name: 'Straight Arm Pulldown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_straight_arm_pullover', name: 'Straight Arm Pullover (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'cable_pushdown_straight_arm_ii', name: 'Straight Arm Pushdown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_straight_back_seated_row', name: 'Straight Back Seated Row (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'smith_sumo_chair_squat', name: 'Sumo Chair Squat (Smith)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'barbell_sumo_deadlift', name: 'Sumo Deadlift (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_sumo_romanian_deadlift', name: 'Sumo Romanian Deadlift (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'sumo_squat', name: 'Sumo Squat', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'cable_supine_reverse_fly', name: 'Supine Reverse Fly (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_t_bar_row_plate_loaded', name: 'T-Bar Row (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_reverse_t_bar_row', name: 'T-Bar Row - Reverse Grip (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_t_bar_reverse_grip_row', name: 'T-Bar Row - Reverse Grip (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_toe_raise', name: 'Toe Raise (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'triceps_dip', name: 'Tricep Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_triceps_dip_plate_loaded', name: 'Tricep Dip (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_overhand_triceps_dip', name: 'Tricep Dip - Overhand (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_triceps_extension', name: 'Tricep Extension (Machine)', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'cable_two_arm_tricep_kickback', name: 'Tricep Kickback (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_triceps_pushdown_sz_bar', name: 'Tricep Pushdown - EZ Bar (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_triceps_pushdown_v_bar_attachment', name: 'Tricep Pushdown - Rope (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'tuck_crunch', name: 'Tuck Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'twin_handle_parallel_grip_lat_pulldown', name: 'Twin Handle Parallel Grip Lat Pulldown', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'underhand_grip_inverted_back_row', name: 'Underhand Grip Inverted Back Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_underhand_pulldown', name: 'Underhand Pulldown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_upper_chest_crossovers', name: 'Upper Chest Crossover (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_upper_row', name: 'Upper Row (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_upright_row', name: 'Upright Row (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_upright_row', name: 'Upright Row (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'dumbbell_upright_row', name: 'Upright Row (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_upright_row_back_pov', name: 'Upright Row (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'smith_upright_row', name: 'Upright Row (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'cable_vertical_pallof_press', name: 'Vertical Pallof Press (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'walking_lunge_male', name: 'Walking Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'weighted_frog_pump', name: 'Weighted Frog Pump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wide_grip_chest_dip_on_high_parallel_bars', name: 'Wide Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_wide_grip_behind_neck_pulldown', name: 'Wide Grip Behind Neck Pulldown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'smith_wide_grip_bench_press', name: 'Wide Grip Bench Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'barbell_standing_wide_grip_biceps_curl', name: 'Wide Grip Bicep Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_standing_wide_grip_curl', name: 'Wide Grip Curl (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'smith_wide_grip_decline_bench_press', name: 'Wide Grip Decline Bench Press (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'wide_grip_pull_up_on_dip_cage', name: 'Wide Grip Pull Up on Dip Cage', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wide_grip_pull_up', name: 'Wide Grip Pull-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wide_grip_rear_pull_up', name: 'Wide Grip Rear Pull Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_standing_wide_military_press', name: 'Wide Military Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_wide_pulldown', name: 'Wide Pulldown (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'wide_hand_push_up', name: 'Wide Push-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_wide_reverse_grip_bench_press', name: 'Wide Reverse Grip Bench Press (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_twist', name: 'Wood Chop (Cable)', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'barbell_full_zercher_squat', name: 'Zercher Squat (Barbell)', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'smith_zercher_squat', name: 'Zercher Squat (Smith Machine)', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'dumbbell_zottman_curl', name: 'Zottman Curl (Dumbbell)', difficulty: 'intermediate', equipment: 'dumbbell'),
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // GET ALL EXERCISES - For Custom Workouts
  // Extracts exercises from ALL sources: muscleSplits, atHomeExercises,
  // cardioExercises, AND all WorkoutPreset lists
  // ═══════════════════════════════════════════════════════════════════════════
  
  static List<Exercise> getAllExercises() {
    final Map<String, Exercise> uniqueExercises = {};
    
    // 0. Add ALL movement engine exercises FIRST (complete set of 371 singular forms)
    for (final exercise in allMovementEngineExercises) {
      uniqueExercises[exercise.id] = exercise;
    }
    
    // 1. From muscleSplits map (these will override allMovementEngineExercises if better metadata)
    muscleSplits.forEach((category, exercises) {
      for (final exercise in exercises) {
        uniqueExercises[exercise.id] = exercise;
      }
    });
    
    // 2. From atHomeExercises
    for (final exercise in atHomeExercises) {
      uniqueExercises[exercise.id] = exercise;
    }
    
    // 3. From cardioExercises
    for (final exercise in cardioExercises) {
      uniqueExercises[exercise.id] = exercise;
    }
    
    // 4. Extract from ALL WorkoutPreset lists - this is where the other 120+ exercises are
    final List<WorkoutPreset> allPresets = [];
    
    // Gym presets
    try { allPresets.addAll(gymMuscleSplits); } catch (_) {}
    try { allPresets.addAll(gymMuscleGroupings); } catch (_) {}
    try { allPresets.addAll(gymCircuits); } catch (_) {}
    try { allPresets.addAll(gymBootyBuilder); } catch (_) {}
    try { allPresets.addAll(gymGirlPower); } catch (_) {}
    
    // Home presets
    try { allPresets.addAll(homeBodyweightBasics); } catch (_) {}
    try { allPresets.addAll(homeHIITCircuits); } catch (_) {}
    try { allPresets.addAll(homeBooty); } catch (_) {}
    try { allPresets.addAll(homeGirlPower); } catch (_) {}
    try { allPresets.addAll(homeRecovery); } catch (_) {}
    
    // Loop through every preset and extract exercises
    for (final preset in allPresets) {
      for (final workoutExercise in preset.exercises) {
        if (!uniqueExercises.containsKey(workoutExercise.id)) {
          uniqueExercises[workoutExercise.id] = Exercise(
            id: workoutExercise.id,
            name: workoutExercise.name,
            difficulty: _inferDifficulty(workoutExercise.name),
            equipment: _inferEquipmentFromName(workoutExercise.name, preset.category),
          );
        }
      }
    }
    
    // Sort alphabetically by name and return
    final result = uniqueExercises.values.toList();
    result.sort((a, b) => a.name.compareTo(b.name));
    return result;
  }
  
  static String _inferDifficulty(String name) {
    final nameLower = name.toLowerCase();
    if (nameLower.contains('advanced') || nameLower.contains('pistol') || 
        nameLower.contains('muscle up') || nameLower.contains('nordic')) {
      return 'advanced';
    }
    if (nameLower.contains('beginner') || nameLower.contains('assisted') ||
        nameLower.contains('wall') || nameLower.contains('stretch')) {
      return 'beginner';
    }
    return 'intermediate';
  }
  
  static String _inferEquipmentFromName(String name, String category) {
    final nameLower = name.toLowerCase();
    
    // Bodyweight indicators
    if (nameLower.contains('push-up') || nameLower.contains('pushup') ||
        nameLower.contains('pull-up') || nameLower.contains('pullup') ||
        nameLower.contains('dip') || nameLower.contains('plank') ||
        nameLower.contains('burpee') || nameLower.contains('climber') ||
        nameLower.contains('bridge') || nameLower.contains('kick') ||
        nameLower.contains('hydrant') || nameLower.contains('stretch') ||
        nameLower.contains('pose') || nameLower.contains('crunch') ||
        nameLower.contains('sit-up') || nameLower.contains('situp') ||
        nameLower.contains('lunge') && !nameLower.contains('dumbbell') ||
        nameLower.contains('squat') && !nameLower.contains('barbell') && !nameLower.contains('goblet')) {
      return 'bodyweight';
    }
    
    // Weight/gym equipment indicators
    if (nameLower.contains('barbell') || nameLower.contains('dumbbell') ||
        nameLower.contains('cable') || nameLower.contains('machine') ||
        nameLower.contains('pulldown') || nameLower.contains('kettlebell') ||
        nameLower.contains('ez bar') || nameLower.contains('smith') ||
        nameLower.contains('bench press') || nameLower.contains('deadlift') ||
        nameLower.contains('leg press') || nameLower.contains('hip thrust')) {
      return 'weights';
    }
    
    // Default based on category
    return category == 'gym' ? 'weights' : 'bodyweight';
  }
}

