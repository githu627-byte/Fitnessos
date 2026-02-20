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
            name: 'Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Incline Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_standing_fly',
            name: 'Cable Chest Fly',
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
            name: 'Dumbbell Bench Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_incline_bench_press',
            name: 'Incline Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_decline_bench_press',
            name: 'Decline Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_fly',
            name: 'Dumbbell Chest Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_standing_fly',
            name: 'Cable Chest Fly',
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
            name: 'Barbell Bench Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_incline_bench_press',
            name: 'Incline Barbell Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_decline_bench_press',
            name: 'Decline Barbell Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
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
            id: 'dumbbell_fly',
            name: 'Dumbbell Chest Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_standing_fly',
            name: 'Cable Chest Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Ups',
            sets: 4,
            reps: 15,
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
            name: 'Lat Pulldown',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_seated_row',
            name: 'Seated Cable Row',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_cross_over_revers_fly',
            name: 'Face Pull',
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
            id: 'pull_up',
            name: 'Assisted Pull-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Dumbbell Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'chin_up',
            name: 'Chin-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_incline_row',
            name: 'Chest Supported Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['back', 'glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_deadlift',
            name: 'Conventional Deadlift',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['hamstrings', 'glutes'],
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
            id: 'barbell_bent_over_row',
            name: 'Barbell Bent Over Row',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'pull_up',
            name: 'Weighted Pull-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'lever_t_bar_row_plate_loaded',
            name: 'T-Bar Row',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'chin_up',
            name: 'Chin-Up',
            sets: 4,
            reps: 10,
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
            id: 'dumbbell_seated_shoulder_press',
            name: 'Seated Dumbbell Press',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_lateral_raise',
            name: 'Cable Lateral Raise',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_cross_over_revers_fly',
            name: 'Face Pull',
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
            id: 'dumbbell_seated_shoulder_press',
            name: 'Standing Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_arnold_press',
            name: 'Arnold Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Dumbbell Lateral Raise',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_front_raise',
            name: 'Dumbbell Front Raise',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly',
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
            id: 'barbell_standing_military_press',
            name: 'Barbell Overhead Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Push Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps', 'legs'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Leaning Lateral Raise',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_front_raise',
            name: 'Barbell Front Raise',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_seated_reverse_fly',
            name: 'Reverse Pec Deck',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Dumbbell Lateral Raise',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
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
            id: 'dumbbell_goblet_squat',
            name: 'Goblet Squat',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_romanian_deadlift',
            name: 'Dumbbell RDL',
            sets: 3,
            reps: 12,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Barbell Back Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift',
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
            id: 'lever_chair_squat',
            name: 'Hack Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl',
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
            id: 'barbell_front_squat',
            name: 'Front Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_deadlift',
            name: 'Deficit Deadlift',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['back', 'glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_single_leg_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'sit_squat',
            name: 'Sissy Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_kneeling_leg_curl_plate_loaded',
            name: 'Nordic Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Spanish Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'bodyweight_standing_calf_raise',
            name: 'Single Leg Calf Raise',
            sets: 4,
            reps: 15,
            primaryMuscles: ['calves'],
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
            id: 'cable_curl_male',
            name: 'Cable Bicep Curl',
            sets: 3,
            reps: 12,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_pushdown_straight_arm_ii',
            name: 'Cable Pushdown',
            sets: 3,
            reps: 12,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_hammer_curl',
            name: 'Seated Hammer Curl',
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
            id: 'dumbbell_biceps_curl',
            name: 'Dumbbell Bicep Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_standing_triceps_extension',
            name: 'Overhead Tricep Extension',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_hammer_curl',
            name: 'Standing Hammer Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: ['forearms'],
          ),
          WorkoutExercise(
            id: 'barbell_preacher_curl',
            name: 'Preacher Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_seated_dip',
            name: 'Dip Machine',
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
            id: 'barbell_curl',
            name: 'Barbell Bicep Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_lying_close_grip_triceps_extension',
            name: 'Skull Crusher',
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
            name: 'Spider Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_lying_close_grip_press',
            name: 'JM Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_close_grip_bench_press',
            name: 'Close Grip Bench Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
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
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'crunch_floor_m',
            name: 'Crunch',
            sets: 3,
            reps: 12,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Dead Bug',
            sets: 3,
            reps: 12,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_vertical_pallof_press',
            name: 'Pallof Press Kneeling',
            sets: 3,
            reps: 12,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'cable_kneeling_crunch',
            name: 'Cable Crunch',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lying_leg_raise',
            name: 'Lying Leg Raise',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_vertical_pallof_press',
            name: 'Pallof Press Standing',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'russian_twist_with_medicine_ball',
            name: 'Russian Twist',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'side_plank_male',
            name: 'Side Plank',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'extra_decline_sit_up',
            name: 'Decline Weighted Sit-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'hanging_leg_hip_raise',
            name: 'Hanging Leg Raise',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_vertical_pallof_press',
            name: 'Pallof Press Split Stance',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_standing_twist',
            name: 'Landmine Rotation',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'russian_twist_with_medicine_ball',
            name: 'Russian Twist',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lying_leg_raise',
            name: 'Lying Leg Raise',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_kneeling_crunch',
            name: 'Cable Crunch',
            sets: 4,
            reps: 12,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

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
            name: 'Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps', 'shoulders'],
          ),
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Seated Dumbbell Press',
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
            name: 'Dumbbell Bench Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Dumbbell Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Standing Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'pull_up',
            name: 'Assisted Pull-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Dumbbell Lateral Raise',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Barbell Bench Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_bent_over_row',
            name: 'Barbell Bent Over Row',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Barbell Overhead Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
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
            id: 'dumbbell_incline_bench_press',
            name: 'Incline Dumbbell Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_crossover_variation',
            name: 'Cable Crossover',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
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
            id: 'dumbbell_goblet_squat',
            name: 'Goblet Squat',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_romanian_deadlift',
            name: 'Dumbbell RDL',
            sets: 3,
            reps: 12,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_seated_leg_press',
            name: 'Leg Press',
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
            id: 'barbell_full_squat',
            name: 'Barbell Back Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift',
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
            id: 'lever_leg_extension',
            name: 'Leg Extension',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_lying_leg_curl',
            name: 'Lying Leg Curl',
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
            id: 'barbell_front_squat',
            name: 'Front Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_deadlift',
            name: 'Deficit Deadlift',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['back', 'glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_single_leg_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_chair_squat',
            name: 'Hack Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lever_kneeling_leg_curl_plate_loaded',
            name: 'Nordic Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'sit_squat',
            name: 'Sissy Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lever_standing_calf_raise',
            name: 'Standing Calf Raise',
            sets: 4,
            reps: 15,
            primaryMuscles: ['calves'],
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
            id: 'push_up_m',
            name: 'Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Seated Dumbbell Press',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_pushdown_straight_arm_ii',
            name: 'Cable Pushdown',
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
            name: 'Dumbbell Bench Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Standing Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_incline_bench_press',
            name: 'Incline Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Dumbbell Lateral Raise',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_standing_triceps_extension',
            name: 'Overhead Tricep Extension',
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
            name: 'Barbell Bench Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Barbell Overhead Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_incline_bench_press',
            name: 'Incline Barbell Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
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
            id: 'dumbbell_lateral_raise',
            name: 'Leaning Lateral Raise',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_crossover_variation',
            name: 'Cable Crossover',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_lying_close_grip_triceps_extension',
            name: 'Skull Crusher',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
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
            name: 'Lat Pulldown',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_seated_row',
            name: 'Seated Cable Row',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_curl_male',
            name: 'Cable Bicep Curl',
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
            id: 'pull_up',
            name: 'Assisted Pull-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Dumbbell Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['back', 'glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Reverse Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'dumbbell_biceps_curl',
            name: 'Dumbbell Bicep Curl',
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
            id: 'barbell_deadlift',
            name: 'Conventional Deadlift',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['hamstrings', 'glutes'],
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
            id: 'barbell_bent_over_row',
            name: 'Barbell Bent Over Row',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'pull_up',
            name: 'Weighted Pull-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'lever_t_bar_row_plate_loaded',
            name: 'T-Bar Row',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_rear_fly',
            name: 'Rear Delt Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'barbell_curl',
            name: 'Barbell Bicep Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
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
            id: 'dumbbell_goblet_squat',
            name: 'Goblet Squat',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Barbell Back Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Dumbbell Bench Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes', 'back'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Dumbbell Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Standing Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_front_squat',
            name: 'Front Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_deadlift',
            name: 'Conventional Deadlift',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['hamstrings', 'glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Barbell Bench Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
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
            id: 'barbell_standing_military_press',
            name: 'Barbell Overhead Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_single_leg_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'hanging_leg_hip_raise',
            name: 'Hanging Leg Raise',
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
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 3,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_goblet_squat',
            name: 'Goblet Squat',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_rear_lunge',
            name: 'Reverse Lunge',
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
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'barbell_full_squat',
            name: 'Barbell Back Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_romanian_deadlift',
            name: 'Romanian Deadlift',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Curtsy Lunge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
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
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'barbell_front_squat',
            name: 'Front Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'barbell_deadlift',
            name: 'Deficit Deadlift',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['back', 'glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Pulse Curtsy Lunge',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'dumbbell_single_leg_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'sumo_squat_hold_pulse',
            name: 'Sumo Squat Hold Pulse',
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
  static List<WorkoutPreset> getGymCircuits(String difficulty) {
    return [
      _getFullBodyBlastCircuit(difficulty),
      _getUpperBodyBurnerCircuit(difficulty),
      _getLowerBodyTorchCircuit(difficulty),
      _getCoreDestroyerCircuit(difficulty),
    ];
  }

  // FULL BODY BLAST - Research-backed circuit exercises
  static WorkoutPreset _getFullBodyBlastCircuit(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Marching In Place',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Ups',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'air_squat',
            name: 'Air Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'High Knee',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Dumbbell Bench Press',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_goblet_squat',
            name: 'Goblet Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bent_over_row',
            name: 'Dumbbell Row',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'walking_lunge_male',
            name: 'Walking Lunge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'High Knee Sprint',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'barbell_bench_press',
            name: 'Barbell Bench Press',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'pull_up',
            name: 'Pull-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_single_leg_split_squat',
            name: 'Bulgarian Split Squat',
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
            id: 'barbell_bent_over_row',
            name: 'Barbell Bent Over Row',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
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
      rounds: 3,
      duration: difficulty == 'beginner' ? '8 min' : difficulty == 'intermediate' ? '18 min' : '24 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // UPPER BODY BURNER - Research-backed circuit exercises  
  static WorkoutPreset _getUpperBodyBurnerCircuit(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Step Touch',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Incline Push-Ups',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_bar_lateral_pulldown',
            name: 'Lat Pulldown',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_lateral_raise',
            name: 'Cable Lateral Raise',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Jumping Jack',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Dumbbell Bench Press',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_seated_row',
            name: 'Cable Row',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_seated_shoulder_press',
            name: 'Standing Dumbbell Press',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_fly',
            name: 'Dumbbell Chest Fly',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
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
            id: 'barbell_bench_press',
            name: 'Barbell Bench Press',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'pull_up',
            name: 'Pull-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'barbell_standing_military_press',
            name: 'Barbell Overhead Press',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_incline_bench_press',
            name: 'Incline Dumbbell Press',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
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
      rounds: 3,
      duration: difficulty == 'beginner' ? '8 min' : difficulty == 'intermediate' ? '15 min' : '20 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // LOWER BODY TORCH - Research-backed circuit exercises
  static WorkoutPreset _getLowerBodyTorchCircuit(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'air_squat',
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
            id: 'dumbbell_lunge',
            name: 'Static Lunge',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Wall Sit',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'dumbbell_goblet_squat',
            name: 'Goblet Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'walking_lunge_male',
            name: 'Walking Lunge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
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
            id: 'bodyweight_standing_calf_raise',
            name: 'Calf Raise',
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
            id: 'squat_m',
            name: 'Jump Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Jumping Lunge',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_single_leg_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'bodyweight_standing_calf_raise',
            name: 'Single Leg Calf Raise',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Squat Jump 180',
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
      id: 'gym_lower_torch',
      name: 'LOWER BODY TORCH',
      category: 'gym',
      subcategory: 'gym_circuits',
      exercises: exercises,
      rounds: 4,
      duration: difficulty == 'beginner' ? '10 min' : difficulty == 'intermediate' ? '20 min' : '28 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // CORE DESTROYER - Research-backed circuit exercises
  static WorkoutPreset _getCoreDestroyerCircuit(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Dead Bug',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['core'],
          ),
          WorkoutExercise(
            id: 'side_plank_male',
            name: 'Modified Side Plank',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'cross_body_crunch',
            name: 'Bicycle Crunch',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'russian_twist_with_medicine_ball',
            name: 'Russian Twist',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'side_plank_male',
            name: 'Side Plank',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lying_leg_raise',
            name: 'Leg Raise',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'jackknife_sit_up',
            name: 'V-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'russian_twist_with_medicine_ball',
            name: 'Weighted Russian Twist',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'side_plank_male',
            name: 'Side Plank Rotation',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'hanging_leg_hip_raise',
            name: 'Hanging Leg Raise',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank Up Down',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['shoulders'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_core_destroyer',
      name: 'CORE DESTROYER',
      category: 'gym',
      subcategory: 'gym_circuits',
      exercises: exercises,
      rounds: 3,
      duration: difficulty == 'beginner' ? '8 min' : difficulty == 'intermediate' ? '15 min' : '22 min',
      isCircuit: true,
      icon: 'core',
    );
  }

  // GYM MODE - BOOTY BUILDER
  static List<WorkoutPreset> getGymBootyBuilder(String difficulty) {
    return [
      _getGymGluteSculptWorkout(difficulty),
      _getGymPeachPumpWorkout(difficulty),
    ];
  }

  // GLUTE SCULPT - Instagram-famous exercises for shape + definition
  static WorkoutPreset _getGymGluteSculptWorkout(String difficulty) {
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
            id: 'reverse_lunge',
            name: 'Reverse Lunge',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
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
            id: 'curtsy_lunge',
            name: 'Curtsy Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
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
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'bird_dog',
            name: 'Bird Dog',
            sets: 4,
            reps: 12,
            primaryMuscles: ['core'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'pulse_curtsy_lunge',
            name: 'Pulse Curtsy Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'squat_pulse',
            name: 'Sumo Squat Pulse',
            sets: 4,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 15,
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
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'single_leg_rdl',
            name: 'Single Leg RDL',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
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

  // PEACH PUMP - Maximum pump using popular gym machines + cables
  static WorkoutPreset _getGymPeachPumpWorkout(String difficulty) {
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
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'bird_dog',
            name: 'Bird Dog',
            sets: 3,
            reps: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['glutes'],
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
            id: 'reverse_lunge',
            name: 'Reverse Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
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
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'curtsy_lunge',
            name: 'Curtsy Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'squat_pulse',
            name: 'Sumo Squat Hold Pulse',
            sets: 4,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'quadruped_hip_extension_pulse',
            name: 'Quadruped Hip Extension Pulse',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump_pulse',
            name: 'Frog Pump Pulse',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'single_leg_rdl',
            name: 'Single Leg RDL',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
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

  // GYM MODE - GIRL POWER
  static List<WorkoutPreset> getGymGirlPower(String difficulty) {
    return [
      _getGymGirlGluteSpecialization(difficulty),
      _getGymGirlUpperBody(difficulty),
      _getGymGirlLowerBody(difficulty),
      _getGymGirlFullBody(difficulty),
      _getGymGirlPPLPush(difficulty),
      _getGymGirlPPLPull(difficulty),
      _getGymGirlPPLLegs(difficulty),
    ];
  }

  // GIRL POWER - GLUTE SPECIALIZATION
  static WorkoutPreset _getGymGirlGluteSpecialization(String difficulty) {
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
            id: 'reverse_lunge',
            name: 'Reverse Lunge',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
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
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'reverse_lunge',
            name: 'Reverse Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'curtsy_lunge',
            name: 'Curtsy Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
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
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
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
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'bulgarian_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'curtsy_lunge',
            name: 'Curtsy Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'squat_pulse',
            name: 'Sumo Squat Pulse',
            sets: 4,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'single_leg_rdl',
            name: 'Single Leg RDL',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
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
            id: 'pushup',
            name: 'Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'lat_pulldown',
            name: 'Lat Pulldown',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'seated_dumbbell_press',
            name: 'Seated Dumbbell Press',
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
            name: 'Dumbbell Bench Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'seated_cable_row',
            name: 'Seated Cable Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_shoulder_press',
            name: 'Standing Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'lat_pulldown',
            name: 'Lat Pulldown',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Dumbbell Lateral Raise',
            sets: 4,
            reps: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'incline_dumbbell_press',
            name: 'Incline Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_row',
            name: 'Dumbbell Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'overhead_press',
            name: 'Barbell Overhead Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
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
            id: 'dumbbell_lateral_raise',
            name: 'Dumbbell Lateral Raise',
            sets: 4,
            reps: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_crossover',
            name: 'Cable Crossover',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'reverse_fly',
            name: 'Reverse Fly',
            sets: 4,
            reps: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
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

  // GIRL POWER - LOWER BODY (Upper/Lower Split)
  static WorkoutPreset _getGymGirlLowerBody(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'goblet_squat',
            name: 'Goblet Squat',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_rdl',
            name: 'Dumbbell RDL',
            sets: 3,
            reps: 12,
            primaryMuscles: ['hamstrings'],
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
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_squat',
            name: 'Barbell Back Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'romanian_deadlift',
            name: 'Romanian Deadlift',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'walking_lunge',
            name: 'Walking Lunge',
            sets: 4,
            reps: 10,
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
            id: 'lying_leg_curl',
            name: 'Lying Leg Curl',
            sets: 4,
            reps: 12,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_squat',
            name: 'Barbell Back Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'romanian_deadlift',
            name: 'Romanian Deadlift',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'bulgarian_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'walking_lunge',
            name: 'Walking Lunge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'lying_leg_curl',
            name: 'Lying Leg Curl',
            sets: 4,
            reps: 12,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_calf_raise',
            name: 'Standing Calf Raise',
            sets: 4,
            reps: 15,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_girl_lower_body',
      name: 'LOWER BODY',
      category: 'gym',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'legs',
    );
  }

  // GIRL POWER - FULL BODY
  static WorkoutPreset _getGymGirlFullBody(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'goblet_squat',
            name: 'Goblet Squat',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'pushup',
            name: 'Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 3,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'goblet_squat',
            name: 'Goblet Squat',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Dumbbell Bench Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_rdl',
            name: 'Dumbbell RDL',
            sets: 4,
            reps: 12,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'seated_cable_row',
            name: 'Seated Cable Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_squat',
            name: 'Barbell Back Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Dumbbell Bench Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'romanian_deadlift',
            name: 'Romanian Deadlift',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
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
            id: 'bulgarian_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_shoulder_press',
            name: 'Standing Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'plank',
            name: 'Plank',
            sets: 4,
            reps: 0,
            timeSeconds: 45,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_girl_full_body',
      name: 'FULL BODY',
      category: 'gym',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'circuits',
    );
  }

  // GIRL POWER - PPL PUSH DAY
  static WorkoutPreset _getGymGirlPPLPush(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'pushup',
            name: 'Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'seated_dumbbell_press',
            name: 'Seated Dumbbell Press',
            sets: 3,
            reps: 12,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_pushdown',
            name: 'Cable Pushdown',
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
            name: 'Dumbbell Bench Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_shoulder_press',
            name: 'Standing Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'incline_dumbbell_press',
            name: 'Incline Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Dumbbell Lateral Raise',
            sets: 4,
            reps: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'overhead_tricep_extension',
            name: 'Overhead Tricep Extension',
            sets: 4,
            reps: 12,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'incline_barbell_press',
            name: 'Incline Barbell Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'overhead_press',
            name: 'Barbell Overhead Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bench_press',
            name: 'Dumbbell Bench Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lateral_raise',
            name: 'Dumbbell Lateral Raise',
            sets: 4,
            reps: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_crossover',
            name: 'Cable Crossover',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'reverse_fly',
            name: 'Reverse Fly',
            sets: 4,
            reps: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'skull_crusher',
            name: 'Skull Crusher',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_girl_ppl_push',
      name: 'PPL - PUSH DAY',
      category: 'gym',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'circuits',
    );
  }

  // GIRL POWER - PPL PULL DAY
  static WorkoutPreset _getGymGirlPPLPull(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'lat_pulldown',
            name: 'Lat Pulldown',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'seated_cable_row',
            name: 'Seated Cable Row',
            sets: 3,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'cable_curl',
            name: 'Cable Bicep Curl',
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
            id: 'lat_pulldown',
            name: 'Lat Pulldown',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'seated_cable_row',
            name: 'Seated Cable Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_row',
            name: 'Dumbbell Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'reverse_fly',
            name: 'Reverse Fly',
            sets: 4,
            reps: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'dumbbell_curl',
            name: 'Dumbbell Bicep Curl',
            sets: 4,
            reps: 12,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
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
            id: 'barbell_row',
            name: 'Barbell Bent Over Row',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'lat_pulldown',
            name: 'Lat Pulldown',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_row',
            name: 'Dumbbell Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'reverse_fly',
            name: 'Reverse Fly',
            sets: 4,
            reps: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'cable_curl',
            name: 'Cable Bicep Curl',
            sets: 4,
            reps: 12,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'hanging_leg_raise',
            name: 'Hanging Leg Raise',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_girl_ppl_pull',
      name: 'PPL - PULL DAY',
      category: 'gym',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'arms',
    );
  }

  // GIRL POWER - PPL LEG DAY
  static WorkoutPreset _getGymGirlPPLLegs(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'goblet_squat',
            name: 'Goblet Squat',
            sets: 3,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_rdl',
            name: 'Dumbbell RDL',
            sets: 3,
            reps: 12,
            primaryMuscles: ['hamstrings'],
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
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_squat',
            name: 'Barbell Back Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'romanian_deadlift',
            name: 'Romanian Deadlift',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'walking_lunge',
            name: 'Walking Lunge',
            sets: 4,
            reps: 10,
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
            id: 'lying_leg_curl',
            name: 'Lying Leg Curl',
            sets: 4,
            reps: 12,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'barbell_squat',
            name: 'Barbell Back Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'romanian_deadlift',
            name: 'Romanian Deadlift',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'bulgarian_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'walking_lunge',
            name: 'Walking Lunge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'lying_leg_curl',
            name: 'Lying Leg Curl',
            sets: 4,
            reps: 12,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_calf_raise',
            name: 'Standing Calf Raise',
            sets: 4,
            reps: 15,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'gym_girl_ppl_legs',
      name: 'PPL - LEG DAY',
      category: 'gym',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'legs',
    );
  }

  // HOME MODE - BODYWEIGHT BASICS
  static List<WorkoutPreset> getHomeBodyweightBasics(String difficulty) {
    return [
      _getHomeFullBodyWorkout(difficulty),
      _getHomeBalancedUpperBodyWorkout(difficulty),
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
            id: 'air_squat',
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
            id: 'front_plank',
            name: 'Plank',
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
            id: 'squat_m',
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
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Static Lunge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber',
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
            id: 'single_leg_squat_with_support_pistol',
            name: 'Pistol Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'decline_push_up_m',
            name: 'Decline Push-Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
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
            id: 'dumbbell_lunge',
            name: 'Jumping Lunge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 4,
            reps: 10,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber',
            sets: 4,
            reps: 0,
            timeSeconds: 40,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank',
            sets: 4,
            reps: 0,
            timeSeconds: 60,
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

  // HOME BODYWEIGHT BASICS - BALANCED UPPER BODY
  static WorkoutPreset _getHomeBalancedUpperBodyWorkout(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Incline Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 3,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank',
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
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'close_grip_push_up',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 4,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'chin_up',
            name: 'Chin-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber',
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
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'wide_hand_push_up',
            name: 'Archer Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'close_grip_push_up',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'pull_up',
            name: 'Pull-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'chin_up',
            name: 'Chin-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 4,
            reps: 12,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank',
            sets: 4,
            reps: 0,
            timeSeconds: 60,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_upper_body',
      name: 'BALANCED UPPER BODY',
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
            id: 'air_squat',
            name: 'Air Squat',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Static Lunge',
            sets: 3,
            reps: 12,
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
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Jump Squat',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'walking_lunge_male',
            name: 'Walking Lunge',
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
            id: 'dumbbell_lunge',
            name: 'Static Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'air_squat',
            name: 'Air Squat',
            sets: 4,
            reps: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'single_leg_squat_with_support_pistol',
            name: 'Pistol Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Jumping Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Jump Squat',
            sets: 4,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'walking_lunge_male',
            name: 'Walking Lunge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'air_squat',
            name: 'Air Squat',
            sets: 4,
            reps: 25,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
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
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'crunch_floor_m',
            name: 'Crunch',
            sets: 3,
            reps: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank',
            sets: 3,
            reps: 0,
            timeSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cross_body_crunch',
            name: 'Bicycle Crunch',
            sets: 3,
            reps: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'crunch_floor_m',
            name: 'Crunch',
            sets: 4,
            reps: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber',
            sets: 4,
            reps: 0,
            timeSeconds: 40,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'cross_body_crunch',
            name: 'Bicycle Crunch',
            sets: 4,
            reps: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank',
            sets: 4,
            reps: 0,
            timeSeconds: 45,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'russian_twist_with_medicine_ball',
            name: 'Russian Twist',
            sets: 4,
            reps: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'jackknife_sit_up',
            name: 'V-Up',
            sets: 4,
            reps: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber Crossover',
            sets: 4,
            reps: 0,
            timeSeconds: 45,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'cross_body_crunch',
            name: 'Bicycle Crunch',
            sets: 4,
            reps: 25,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank',
            sets: 4,
            reps: 0,
            timeSeconds: 60,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'russian_twist_with_medicine_ball',
            name: 'Russian Twist',
            sets: 4,
            reps: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'side_plank_male',
            name: 'Side Plank',
            sets: 4,
            reps: 0,
            timeSeconds: 45,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 4,
            reps: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

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

  // HOME BODYWEIGHT BASICS - BRO SPLIT (CIRCUIT)
  static WorkoutPreset _getHomeBroSplitCircuit(String difficulty) {
    List<WorkoutExercise> exercises;
    int rounds;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        rounds = 3;
        exercises = [
          WorkoutExercise(
            id: 'air_squat',
            name: 'Air Squat',
            sets: 1,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      case 'intermediate':
        rounds = 4;
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Jump Squat',
            sets: 1,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Push-Up',
            sets: 1,
            reps: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 1,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Static Lunge',
            sets: 1,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 1,
            reps: 10,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      case 'advanced':
        rounds = 4;
        exercises = [
          WorkoutExercise(
            id: 'single_leg_squat_with_support_pistol',
            name: 'Pistol Squat',
            sets: 1,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'decline_push_up_m',
            name: 'Decline Push-Up',
            sets: 1,
            reps: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'pull_up',
            name: 'Pull-Up',
            sets: 1,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_lunge',
            name: 'Jumping Lunge',
            sets: 1,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 1,
            reps: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank',
            sets: 1,
            reps: 0,
            timeSeconds: 60,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        rounds = 3;
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_bro_split',
      name: 'BRO SPLIT (CIRCUIT)',
      category: 'home',
      subcategory: 'bodyweight_basics',
      exercises: exercises,
      rounds: rounds,
      isCircuit: true,
      icon: 'arms',
    );
  }

  // HOME MODE - HIIT CIRCUITS
  static List<WorkoutPreset> getHomeHIITCircuits(String difficulty) {
    return [
      _getHome10MinQuickBurn(difficulty),
      _getHome20MinDestroyer(difficulty),
      _getHomeTabataTorture(difficulty),
      _getHomeCardioBlast(difficulty),
    ];
  }

  // HOME HIIT - 10 MIN QUICK BURN
  static WorkoutPreset _getHome10MinQuickBurn(String difficulty) {
    List<WorkoutExercise> exercises;
    int rounds;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        rounds = 2;
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Marching In Place',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Squat Reach',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Incline Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cross_body_crunch',
            name: 'Standing Oblique Crunch',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        rounds = 2;
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'High Knee',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'squat_m',
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
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Butt Kick',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
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
        rounds = 2;
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'High Knee Sprint',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
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
            id: 'squat_m',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Star Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
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
            id: 'stationary_bike_run_version_3',
            name: 'Butt Kick Sprint',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      default:
        rounds = 2;
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_10min_quick_burn',
      name: '10 MIN QUICK BURN',
      category: 'home',
      subcategory: 'hiit_circuits',
      exercises: exercises,
      rounds: rounds,
      duration: '10 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // HOME HIIT - 20 MIN DESTROYER
  static WorkoutPreset _getHome20MinDestroyer(String difficulty) {
    List<WorkoutExercise> exercises;
    int rounds;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        rounds = 3;
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Step Touch',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Squat Reach',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up_m',
            name: 'Incline Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'front_plank',
            name: 'Plank Tap',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        rounds = 3;
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Jumping Jack',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'squat_m',
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
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'High Knee',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
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
        rounds = 3;
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Star Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'High Knee Sprint',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
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
            id: 'squat_m',
            name: 'Skater Hop',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee Sprawl',
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
        rounds = 3;
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_20min_destroyer',
      name: '20 MIN DESTROYER',
      category: 'home',
      subcategory: 'hiit_circuits',
      exercises: exercises,
      rounds: rounds,
      duration: '20 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // HOME HIIT - TABATA TORTURE
  static WorkoutPreset _getHomeTabataTorture(String difficulty) {
    List<WorkoutExercise> exercises;
    int rounds;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        rounds = 8; // Tabata = 8 rounds per exercise
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Marching In Place',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Squat Reach',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'intermediate':
        rounds = 8;
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'High Knee',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Jump Squat',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'advanced':
        rounds = 8;
        exercises = [
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Tuck Jump',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber Crossover',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Star Jump',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee Tuck Jump',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'High Knee Sprint',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        rounds = 8;
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_tabata_torture',
      name: 'TABATA TORTURE',
      category: 'home',
      subcategory: 'hiit_circuits',
      exercises: exercises,
      rounds: 1, // Already doing 8 sets per exercise
      duration: '15-20 min',
      isCircuit: false, // Not a circuit, each exercise done 8 times
      icon: 'circuits',
    );
  }

  // HOME HIIT - CARDIO BLAST
  static WorkoutPreset _getHomeCardioBlast(String difficulty) {
    List<WorkoutExercise> exercises;
    int rounds;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        rounds = 3;
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Step Touch',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Marching In Place',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cross_body_crunch',
            name: 'Standing Oblique Crunch',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'intermediate':
        rounds = 4;
        exercises = [
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Jumping Jack',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'High Knee',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'Butt Kick',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
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
            id: 'burpee',
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      case 'advanced':
        rounds = 4;
        exercises = [
          WorkoutExercise(
            id: 'squat_m',
            name: 'Star Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'stationary_bike_run_version_3',
            name: 'High Knee Sprint',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
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
            id: 'squat_m',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Mountain Climber Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'squat_m',
            name: 'Skater Hop',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee Tuck Jump',
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
        rounds = 3;
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_cardio_blast',
      name: 'CARDIO BLAST',
      category: 'home',
      subcategory: 'hiit_circuits',
      exercises: exercises,
      rounds: rounds,
      duration: '15-20 min',
      isCircuit: true,
      icon: 'circuits',
    );
  }

  // HOME MODE - HOME BOOTY
  static List<WorkoutPreset> getHomeBooty(String difficulty) {
    return [
      _getHomeGluteActivation(difficulty),
      _getHomeBootyBurner(difficulty),
      _getHomeBandBooty(difficulty),
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
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 4,
            reps: 20,
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
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'curtsy_lunge',
            name: 'Curtsy Lunge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'frog_pump_pulse',
            name: 'Frog Pump Pulse',
            sets: 4,
            reps: 25,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'quadruped_hip_extension_pulse',
            name: 'Quadruped Hip Extension Pulse',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'single_leg_rdl',
            name: 'Single Leg RDL',
            sets: 4,
            reps: 12,
            primaryMuscles: ['hamstrings'],
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
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 3,
            reps: 25,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 3,
            reps: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'reverse_lunge',
            name: 'Reverse Lunge',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
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
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 4,
            reps: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'reverse_lunge',
            name: 'Reverse Lunge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'donkey_kick',
            name: 'Donkey Kick',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 4,
            reps: 25,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'squat_pulse',
            name: 'Sumo Squat Pulse',
            sets: 4,
            reps: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'curtsy_lunge',
            name: 'Curtsy Lunge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 25,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump_pulse',
            name: 'Frog Pump Pulse',
            sets: 4,
            reps: 30,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 4,
            reps: 25,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'quadruped_hip_extension_pulse',
            name: 'Quadruped Hip Extension Pulse',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
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
      icon: 'circuits',
    );
  }

  // HOME BOOTY - BAND BOOTY
  static WorkoutPreset _getHomeBandBooty(String difficulty) {
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
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 3,
            reps: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
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
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 4,
            reps: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
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
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'frog_pump',
            name: 'Frog Pump',
            sets: 4,
            reps: 25,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'squat_pulse',
            name: 'Sumo Squat Hold Pulse',
            sets: 4,
            reps: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 25,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'curtsy_lunge',
            name: 'Curtsy Lunge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'frog_pump_pulse',
            name: 'Frog Pump Pulse',
            sets: 4,
            reps: 30,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'quadruped_hip_extension_pulse',
            name: 'Quadruped Hip Extension Pulse',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_glute_kickback',
            name: 'Standing Glute Kickback',
            sets: 4,
            reps: 25,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_band_booty',
      name: 'BAND BOOTY',
      category: 'home',
      subcategory: 'home_booty',
      exercises: exercises,
      isCircuit: false,
      icon: 'arms',
    );
  }

  // HOME MODE - GIRL POWER
  static List<WorkoutPreset> getHomeGirlPower(String difficulty) {
    return [
      _getHomeGirlGluteSculpt(difficulty),
      _getHomeGirlUpperBody(difficulty),
      _getHomeGirlFullBody(difficulty),
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
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'sumo_squat',
            name: 'Sumo Squat',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'reverse_lunge',
            name: 'Reverse Lunge',
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
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'walking_lunge',
            name: 'Walking Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'curtsy_lunge',
            name: 'Curtsy Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'mountain_climber',
            name: 'Mountain Climber',
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
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 4,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'curtsy_lunge',
            name: 'Curtsy Lunge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'donkey_kick_pulse',
            name: 'Donkey Kick Pulse',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'jump_lunge',
            name: 'Jumping Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'frog_pump_pulse',
            name: 'Frog Pump Pulse',
            sets: 4,
            reps: 25,
            primaryMuscles: ['glutes'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'mountain_climber_crossover',
            name: 'Mountain Climber Crossover',
            sets: 4,
            reps: 0,
            timeSeconds: 40,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
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
            id: 'incline_pushup',
            name: 'Incline Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 3,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'plank',
            name: 'Plank',
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
            id: 'pushup',
            name: 'Push-Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'diamond_pushup',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 4,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'plank_tap',
            name: 'Plank Tap',
            sets: 4,
            reps: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['shoulders'],
          ),
          WorkoutExercise(
            id: 'mountain_climber',
            name: 'Mountain Climber',
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
            id: 'decline_pushup',
            name: 'Decline Push-Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'diamond_pushup',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'archer_pushup',
            name: 'Archer Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 4,
            reps: 15,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'plank_jack',
            name: 'Plank Jack',
            sets: 4,
            reps: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'mountain_climber_crossover',
            name: 'Mountain Climber Crossover',
            sets: 4,
            reps: 0,
            timeSeconds: 40,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'burpee',
            name: 'Burpee',
            sets: 4,
            reps: 12,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_girl_upper_lower',
      name: 'UPPER BODY',
      category: 'home',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'arms',
    );
  }

  // HOME GIRL POWER - FULL BODY (Chloe Ting format)
  static WorkoutPreset _getHomeGirlFullBody(String difficulty) {
    List<WorkoutExercise> exercises;
    bool isCircuit;
    int? rounds;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        isCircuit = false;
        exercises = [
          WorkoutExercise(
            id: 'squat',
            name: 'Air Squat',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'incline_pushup',
            name: 'Incline Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'mountain_climber',
            name: 'Mountain Climber',
            sets: 3,
            reps: 0,
            timeSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      case 'intermediate':
        isCircuit = true;
        rounds = 4;
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
            id: 'pushup',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
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
        isCircuit = true;
        rounds = 4;
        exercises = [
          WorkoutExercise(
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'decline_pushup',
            name: 'Decline Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'pull_up',
            name: 'Pull-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'jump_lunge',
            name: 'Jumping Lunge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
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
            id: 'mountain_climber_crossover',
            name: 'Mountain Climber Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      default:
        isCircuit = false;
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_girl_full_body',
      name: 'FULL BODY',
      category: 'home',
      subcategory: 'girl_power',
      exercises: exercises,
      rounds: rounds,
      isCircuit: isCircuit,
      duration: difficulty == 'beginner' ? '15 min' : '20-25 min',
      icon: 'circuits',
    );
  }

  // HOME GIRL POWER - PPL (Modified for home)
  static WorkoutPreset _getHomeGirlPPL(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'pushup',
            name: 'Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 3,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'squat',
            name: 'Air Squat',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'pushup',
            name: 'Push-Up',
            sets: 4,
            reps: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'diamond_pushup',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 4,
            reps: 12,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'glute_bridge',
            name: 'Glute Bridge',
            sets: 4,
            reps: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
        ];
        break;
      case 'advanced':
        exercises = [
          WorkoutExercise(
            id: 'decline_pushup',
            name: 'Decline Push-Up',
            sets: 4,
            reps: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'archer_pushup',
            name: 'Archer Push-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
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
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 4,
            reps: 15,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'pistol_squat',
            name: 'Pistol Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'jump_lunge',
            name: 'Jumping Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 4,
            reps: 15,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
        ];
        break;
      default:
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_girl_push_pull_legs',
      name: 'PUSH/PULL/LEGS',
      category: 'home',
      subcategory: 'girl_power',
      exercises: exercises,
      isCircuit: false,
      icon: 'circuits',
    );
  }

  // HOME GIRL POWER - BRO SPLIT (Circuit)
  static WorkoutPreset _getHomeGirlFullBodyCircuit(String difficulty) {
    List<WorkoutExercise> exercises;
    int rounds;
    bool isCircuit = true;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        rounds = 3;
        exercises = [
          WorkoutExercise(
            id: 'squat',
            name: 'Air Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'incline_pushup',
            name: 'Incline Push-Up',
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
        ];
        break;
      case 'intermediate':
        rounds = 4;
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
            id: 'pushup',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'inverted_row',
            name: 'Inverted Row',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'mountain_climber',
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      case 'advanced':
        rounds = 4;
        exercises = [
          WorkoutExercise(
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'decline_pushup',
            name: 'Decline Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'elevated_glute_bridge',
            name: 'Elevated Glute Bridge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'pull_up',
            name: 'Pull-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'jump_lunge',
            name: 'Jumping Lunge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
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
            id: 'mountain_climber_crossover',
            name: 'Mountain Climber Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
        ];
        break;
      default:
        rounds = 3;
        isCircuit = false;
        exercises = [];
    }

    return WorkoutPreset(
      id: 'home_girl_full_body_circuit',
      name: 'FULL BODY CIRCUIT',
      category: 'home',
      subcategory: 'girl_power',
      exercises: exercises,
      rounds: rounds,
      isCircuit: isCircuit,
      duration: difficulty == 'beginner' ? '15 min' : '20-25 min',
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
        WorkoutExercise(id: 'glute_kickback', name: 'Glute Kickback Machine (GLUTE FOCUS)', sets: 3, reps: 12, included: true),
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
        WorkoutExercise(id: 'glute_kickback', name: 'Glute Kickback Machine', sets: 3, reps: 12),
        WorkoutExercise(id: 'sumo_squat', name: 'Sumo Squat', sets: 3, reps: 12),
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
        WorkoutExercise(id: 'sumo_squat', name: 'Sumo Squat', sets: 3, reps: 12),
        WorkoutExercise(id: 'single_leg_glute_bridge', name: 'Glute Bridge (single leg)', sets: 3, reps: 10),
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
        WorkoutExercise(id: 'sumo_deadlift', name: 'Sumo Deadlift', sets: 3, reps: 12),
        WorkoutExercise(id: 'lever_seated_leg_press', name: 'Leg Press (feet high)', sets: 3, reps: 12),
        WorkoutExercise(id: 'donkey_kicks_cable', name: 'Donkey Kicks (cable)', sets: 3, reps: 15),
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
        WorkoutExercise(id: 'sumo_deadlift', name: 'Sumo Deadlift', sets: 3, reps: 10, included: true),
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
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 3, reps: 15),
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
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 4, reps: 15),
        WorkoutExercise(id: 'single_leg_glute_bridge', name: 'Single Leg Glute Bridge', sets: 3, reps: 10),
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
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 3, reps: 20),
        WorkoutExercise(id: 'single_leg_glute_bridge', name: 'Single Leg Glute Bridge', sets: 3, reps: 12),
        //WorkoutExercise(id: 'donkey_kicks', name: 'Donkey Kicks', sets: 3, reps: 15),  // DUPLICATE - use donkey_kick
        //WorkoutExercise(id: 'fire_hydrants', name: 'Fire Hydrants', sets: 3, reps: 15),  // DUPLICATE - use fire_hydrant
        //WorkoutExercise(id: 'clamshells', name: 'Clamshells', sets: 3, reps: 15),  // DUPLICATE - use clamshell
        //WorkoutExercise(id: 'frog_pumps', name: 'Frog Pumps', sets: 3, reps: 20),  // DUPLICATE - use frog_pump
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
        //WorkoutExercise(id: 'sumo_squat_pulse', name: 'Sumo Squat Pulse', sets: 3, reps: 20),  // DUPLICATE - use squat_pulse
        //WorkoutExercise(id: 'dumbbell_lunge', name: 'Curtsy Lunges', sets: 3, reps: 12),  // DUPLICATE - use curtsy_lunge
        WorkoutExercise(id: 'glute_bridge_hold', name: 'Glute Bridge Hold', sets: 3, reps: 30),
        //WorkoutExercise(id: 'donkey_kick_pulses', name: 'Donkey Kick Pulses', sets: 3, reps: 20),  // DUPLICATE - use donkey_kick_pulse
        WorkoutExercise(id: 'squat_to_kickback', name: 'Squat to Kick Back', sets: 3, reps: 12),
        WorkoutExercise(id: 'single_leg_deadlift', name: 'Single Leg Deadlift', sets: 3, reps: 10),
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
        WorkoutExercise(id: 'banded_squat', name: 'Banded Squat', sets: 3, reps: 15),
        WorkoutExercise(id: 'banded_glute_bridge', name: 'Banded Glute Bridge', sets: 3, reps: 15),
        WorkoutExercise(id: 'banded_clamshell', name: 'Banded Clamshell', sets: 3, reps: 15),
        WorkoutExercise(id: 'banded_kickback', name: 'Banded Kickback', sets: 3, reps: 15),
        WorkoutExercise(id: 'banded_lateral_walk', name: 'Banded Lateral Walk', sets: 3, reps: 12),
        WorkoutExercise(id: 'banded_fire_hydrant', name: 'Banded Fire Hydrant', sets: 3, reps: 12),
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
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 4, reps: 15),
        WorkoutExercise(id: 'single_leg_glute_bridge', name: 'Single Leg Glute Bridge', sets: 3, reps: 10),
        WorkoutExercise(id: 'donkey_kick', name: 'Donkey Kick', sets: 3, reps: 15),
        WorkoutExercise(id: 'fire_hydrant', name: 'Fire Hydrant', sets: 3, reps: 15),
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
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 4, reps: 15, included: true),
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
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 3, reps: 15),
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
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 3, reps: 15, included: true),
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
  // ALL EXERCISES - 696 exercises for AI mode custom workout builder
  // Every ID in this list exists in movement_engine.dart
  // GIF key IDs display videos directly; home IDs use overrides for video
  // ═══════════════════════════════════════════════════════════════════════════

  static const List<Exercise> allMovementEngineExercises = [
    Exercise(id: '3_4_sit_up', name: '3/4 Sit-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'a_skip', name: 'A Skip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'air_bike_m', name: 'Air Bike', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'air_squat', name: 'Air Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'archer_pushup', name: 'Archer Pushup', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_arnold_press', name: 'Arnold Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'b_skip', name: 'B Skip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hyperextension', name: 'Back Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_full_squat', name: 'Back Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'banded_clamshell', name: 'Banded Clamshell', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'banded_fire_hydrant', name: 'Banded Fire Hydrant', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'banded_glute_bridge', name: 'Banded Glute Bridge', difficulty: 'beginner', equipment: 'bands'),
    Exercise(id: 'banded_kickback', name: 'Banded Kickback', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'banded_lateral_walk', name: 'Banded Lateral Walk', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'banded_squat', name: 'Banded Squat', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'barbell_full_squat', name: 'Barbell Back Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_behind_back_finger_curl', name: 'Barbell Behind Back Finger Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_bench_front_squat', name: 'Barbell Bench Front Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_bench_press', name: 'Barbell Bench Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_bench_squat', name: 'Barbell Bench Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_bent_arm_pullover', name: 'Barbell Bent Arm Pullover', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_bent_over_row', name: 'Barbell Bent Over Row', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_close_grip_bench_press', name: 'Barbell Close Grip Bench Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'ez_barbell_close_grip_curl', name: 'Barbell Close Grip Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_curl', name: 'Barbell Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_deadlift', name: 'Barbell Deadlift', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_decline_bench_press', name: 'Barbell Decline Bench Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_decline_bent_arm_pullover', name: 'Barbell Decline Bent Arm Pullover', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_decline_close_grip_to_skull_press', name: 'Barbell Decline Close Grip to Skull Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_decline_pullover', name: 'Barbell Decline Pullover', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_decline_wide_grip_press', name: 'Barbell Decline Wide Grip Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_decline_wide_grip_pullover', name: 'Barbell Decline Wide Grip Pullover', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_drag_curl', name: 'Barbell Drag Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_floor_calf_raise', name: 'Barbell Floor Calf Raise', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_front_chest_squat', name: 'Barbell Front Chest Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_front_raise', name: 'Barbell Front Raise', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_front_raise_and_pullover', name: 'Barbell Front Raise and Pullover', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_front_squat', name: 'Barbell Front Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_full_squat', name: 'Barbell Full Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_full_zercher_squat', name: 'Barbell Full Zercher Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_good_morning', name: 'Barbell Good Morning', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_high_bar_squat', name: 'Barbell High Bar Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_hip_thrust', name: 'Barbell Hip Thrust', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_incline_bench_press', name: 'Barbell Incline Bench Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_incline_close_grip_bench_press', name: 'Barbell Incline Close Grip Bench Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_incline_reverse_grip_press', name: 'Barbell Incline Reverse Grip Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_incline_row', name: 'Barbell Incline Row', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_incline_wide_reverse_grip_bench_press', name: 'Barbell Incline Wide Reverse Grip Bench Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_lunge', name: 'Barbell Lateral Lunge', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_low_bar_squat', name: 'Barbell Low Bar Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_low_bar_squat_with_rack', name: 'Barbell Low Bar Squat with Rack', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_lunge', name: 'Barbell Lunge', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_lying_back_of_the_head_tricep_extension', name: 'Barbell Lying Back of the Head Tricep Extension', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_lying_close_grip_press', name: 'Barbell Lying Close Grip Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_lying_close_grip_triceps_extension', name: 'Barbell Lying Close Grip Triceps Extension', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_lying_extension', name: 'Barbell Lying Extension', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_lying_lifting_on_hip', name: 'Barbell Lying Lifting on Hip', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_lying_close_grip_triceps_extension', name: 'Barbell Lying Triceps Extension Skull Crusher', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_olympic_squat', name: 'Barbell Olympic Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_one_leg_squat', name: 'Barbell One Leg Squat', difficulty: 'advanced', equipment: 'barbell'),
    Exercise(id: 'barbell_preacher_curl', name: 'Barbell Preacher Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_quarter_squat', name: 'Barbell Quarter Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_rear_delt_row', name: 'Barbell Rear Delt Row', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_rear_lunge', name: 'Barbell Rear Lunge', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_close_grip_bench_press', name: 'Barbell Reverse Close Grip Bench Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_curl', name: 'Barbell Reverse Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_grip_bent_over_row', name: 'Barbell Reverse Grip Bent Over Row', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_grip_decline_bench_press', name: 'Barbell Reverse Grip Decline Bench Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_grip_incline_bench_press', name: 'Barbell Reverse Grip Incline Bench Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_grip_incline_bench_row', name: 'Barbell Reverse Grip Incline Bench Row', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_grip_skullcrusher', name: 'Barbell Reverse Grip Skullcrusher', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_preacher_curl', name: 'Barbell Reverse Preacher Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_reverse_wrist_curl', name: 'Barbell Reverse Wrist Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_romanian_deadlift', name: 'Barbell Romanian Deadlift', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_bent_over_row', name: 'Barbell Row', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_preacher_curl', name: 'Barbell Scott Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_seated_behind_head_military_press', name: 'Barbell Seated Behind Head Military Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_seated_calf_raise', name: 'Barbell Seated Calf Raise', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_seated_close_grip_behind_neck_triceps_extension', name: 'Barbell Seated Close Grip Behind Neck Triceps Extension', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_seated_close_grip_concentration_curl', name: 'Barbell Seated Close Grip Concentration Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_seated_good_morning', name: 'Barbell Seated Good Morning', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_seated_military_press_inside_squat_cage', name: 'Barbell Seated Military Press Inside Squat Cage', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_seated_overhead_triceps_extension', name: 'Barbell Seated Overhead Triceps Extension', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_seated_twist', name: 'Barbell Seated Twist', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_shrug', name: 'Barbell Shrug', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_side_bent_ii', name: 'Barbell Side Bent II', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_side_split_squat_ii', name: 'Barbell Side Split Squat II', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_full_squat', name: 'Barbell Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_standing_close_grip_military_press', name: 'Barbell Standing Close Grip Military Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_standing_concentration_curl', name: 'Barbell Standing Concentration Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_standing_leg_calf_raise', name: 'Barbell Standing Leg Calf Raise', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_standing_military_press', name: 'Barbell Standing Military Press', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_standing_overhead_triceps_extension', name: 'Barbell Standing Overhead Triceps Extension', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_standing_reverse_grip_curl', name: 'Barbell Standing Reverse Grip Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_standing_twist', name: 'Barbell Standing Twist', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_standing_wide_grip_biceps_curl', name: 'Barbell Standing Wide Grip Biceps Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_straight_leg_deadlift', name: 'Barbell Stiff Leg Deadlift', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_sumo_deadlift', name: 'Barbell Sumo Deadlift', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_sumo_deadlift', name: 'Barbell Sumo Squat', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_upright_row', name: 'Barbell Upright Row', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_wrist_curl', name: 'Barbell Wrist Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'barbell_wrist_reverse_curl_version_2', name: 'Barbell Wrist Reverse Curl Version 2', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'weighted_bench_dip', name: 'Bench Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bench_dip_knees_bent', name: 'Bench Dip Knees Bent', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'barbell_bench_press', name: 'Bench Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_biceps_curl', name: 'Bicep Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bicycle_crunch', name: 'Bicycle Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bicycle_crunches', name: 'Bicycle Crunches', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bird_dog', name: 'Bird Dog', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'bodyweight_pulse_goblet_squat', name: 'Bodyweight Pulse Goblet Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_m', name: 'Bodyweight Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bodyweight_standing_calf_raise', name: 'Bodyweight Standing Calf Raise', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'box_jump', name: 'Box Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_m', name: 'Box Jump with Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_single_leg_split_squat', name: 'Bulgarian Split Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bulgarian_split_squat', name: 'Bulgarian Split Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bulgarian_split_sumo_squat', name: 'Bulgarian Split Sumo Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'butt_kick', name: 'Butt Kick', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'butt_kick', name: 'Butt Kick Sprint', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'butt_kick', name: 'Butt Kicks', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'butt_ups', name: 'Butt Ups', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_pec_deck_fly', name: 'Butterfly Machine', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'cable_alternate_triceps_extension', name: 'Cable Alternate Triceps Extension', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_bar_lateral_pulldown', name: 'Cable Bar Lateral Pulldown', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_bench_press', name: 'Cable Bench Press', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_biceps_curl_sz_bar', name: 'Cable Biceps Curl SZ Bar', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_close_grip_curl', name: 'Cable Close Grip Curl', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_close_grip_front_lat_pulldown', name: 'Cable Close Grip Front Lat Pulldown', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_concentration_curl', name: 'Cable Concentration Curl', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_concentration_extension_on_knee', name: 'Cable Concentration Extension on Knee', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_cross_over_lateral_pulldown', name: 'Cable Cross Over Lateral Pulldown', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_cross_over_revers_fly', name: 'Cable Cross Over Revers Fly', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_crossover_variation', name: 'Cable Crossover', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_crossover_variation', name: 'Cable Crossover Variation', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_kneeling_crunch', name: 'Cable Crunch', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_curl_male', name: 'Cable Curl', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_curl_male', name: 'Cable Curl', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_curl_with_multipurpose_v_bar', name: 'Cable Curl with Multipurpose V Bar', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_decline_fly', name: 'Cable Decline Fly', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_decline_press', name: 'Cable Decline Press', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_donkey_kickback', name: 'Cable Donkey Kickback', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_drag_curl', name: 'Cable Drag Curl', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_elevated_row', name: 'Cable Elevated Row', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_standing_fly', name: 'Cable Fly', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_front_raise', name: 'Cable Front Raise', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_front_shoulder_raise', name: 'Cable Front Shoulder Raise', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_hammer_curl_with_rope_attachment_male', name: 'Cable Hammer Curl with Rope Attachment Male', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_high_pulley_overhead_tricep_extension', name: 'Cable High Pulley Overhead Tricep Extension', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_hip_adduction', name: 'Cable Hip Adduction', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_horizontal_pallof_press', name: 'Cable Horizontal Pallof Press', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_incline_bench_press', name: 'Cable Incline Bench Press', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_incline_fly', name: 'Cable Incline Fly', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_incline_pushdown', name: 'Cable Incline Pushdown', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_incline_triceps_extension', name: 'Cable Incline Triceps Extension', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_kickback', name: 'Cable Kickback', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_kneeling_crunch', name: 'Cable Kneeling Crunch', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_kneeling_triceps_extension', name: 'Cable Kneeling Triceps Extension', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_lat_pulldown_full_range_of_motion', name: 'Cable Lat Pulldown Full Range of Motion', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_lateral_raise', name: 'Cable Lateral Raise', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_low_fly', name: 'Cable Low Fly', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_low_seated_row', name: 'Cable Low Seated Row', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_close_grip_curl', name: 'Cable Lying Close Grip Curl', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_lying_extension_pullover_with_rope_attachment', name: 'Cable Lying Extension Pullover with Rope Attachment', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_lying_fly', name: 'Cable Lying Fly', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_lying_triceps_extension', name: 'Cable Lying Triceps Extension', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_medius_kickback', name: 'Cable Medius Kickback', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_middle_fly', name: 'Cable Middle Fly', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_one_arm_curl', name: 'Cable One Arm Curl', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_one_arm_inner_biceps_curl', name: 'Cable One Arm Inner Biceps Curl', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_one_arm_lateral_raise', name: 'Cable One Arm Lateral Raise', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_seated_row', name: 'Cable One Arm Seated Row', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_one_arm_side_triceps_pushdown', name: 'Cable One Arm Side Triceps Pushdown', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_one_arm_side_triceps_pushdown', name: 'Cable One Arm Tricep Extension', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_overhead_curl', name: 'Cable Overhead Curl', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_overhead_triceps_extension_rope_attachment', name: 'Cable Overhead Triceps Extension', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_pull_through', name: 'Cable Pull Through', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_pulldown', name: 'Cable Pulldown', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_pushdown_straight_arm_ii', name: 'Cable Pushdown', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_cross_over_revers_fly', name: 'Cable Rear Delt Fly', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_hammer_curl_with_rope_attachment_male', name: 'Cable Rope Hammer Curl', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_triceps_pushdown_v_bar_attachment', name: 'Cable Rope Pushdown', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_seated_row', name: 'Cable Row', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_seated_neck_extension_with_head_harness', name: 'Cable Seated Neck Extension with Head Harness', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_seated_neck_flexion_with_head_harness', name: 'Cable Seated Neck Flexion with Head Harness', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_seated_rear_lateral_raise', name: 'Cable Seated Rear Lateral Raise', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_seated_row', name: 'Cable Seated Row', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_seated_row_bent_bar', name: 'Cable Seated Row Bent Bar', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_seated_shoulder_internal_rotation', name: 'Cable Seated Shoulder Internal Rotation', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_seated_twist', name: 'Cable Seated Twist', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_seated_wide_grip_row', name: 'Cable Seated Wide Grip Row', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_shoulder_press', name: 'Cable Shoulder Press', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_shrug', name: 'Cable Shrug', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_side_bend', name: 'Cable Side Bend', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'sumo_squat', name: 'Sumo Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'sumo_squat_hold_pulse', name: 'Sumo Squat Hold Pulse', difficulty: 'beginner', equipment: 'bodyweight'),  // DUPLICATE - use squat_pulse
    //Exercise(id: 'sumo_squat_pulse', name: 'Sumo Squat Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use squat_pulse
    Exercise(id: 'barbell_full_squat', name: 'Thruster', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'tuck_jump', name: 'Tuck Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'walking_lunge_male', name: 'Walking Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_full_zercher_squat', name: 'Zercher Squat', difficulty: 'intermediate', equipment: 'bodyweight'),

    // ===== STEPUP PATTERN =====
    Exercise(id: 'dumbbell_step_up', name: 'Box Step Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'dumbbell_lunge', name: 'Box Stepups', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use box_step_up
    Exercise(id: 'cable_shoulder_press', name: 'Cable Twisting Overhead Press', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_two_arm_tricep_kickback', name: 'Cable Two Arm Tricep Kickback', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_underhand_pulldown', name: 'Cable Underhand Pulldown', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_upper_chest_crossovers', name: 'Cable Upper Chest Crossovers', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'cable_twist', name: 'Cable Wood Chop', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'bodyweight_standing_calf_raise', name: 'Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'chest_dip', name: 'Chest Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_fly', name: 'Chest Fly', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'chin_up', name: 'Chin Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'chin_up', name: 'Chinup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'push_up_m', name: 'Clap Pushup', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'barbell_close_grip_bench_press', name: 'Close Grip Bench Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'close_grip_push_up', name: 'Close Grip Push Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'close_grip_push_up', name: 'Close Grip Pushup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cocoons', name: 'Cocoons', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_concentration_curl', name: 'Concentration Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cross_body_crunch', name: 'Cross Body Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'crossover_high_knee', name: 'Crossover High Knee', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'crunch_floor_m', name: 'Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'crunch_floor_m', name: 'Floor Crunch', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'crunch_on_stability_ball', name: 'Crunch on Stability Ball', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_curl', name: 'Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'curtsy_lunge', name: 'Curtsy Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'front_plank', name: 'Dead Bug', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'front_plank', name: 'Dead Bugs', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pull_up', name: 'Dead Hang', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_deadlift', name: 'Deadlift', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_decline_bench_press', name: 'Decline Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'decline_push_up_m', name: 'Decline Push Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'decline_push_up_m', name: 'Decline Push-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'decline_push_up_m', name: 'Decline Pushup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_decline_bench_press', name: 'Decline Bench Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_decline_bench_press', name: 'Decline Dumbbell Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'barbell_decline_bench_press', name: 'Decline Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'decline_push_up_m', name: 'Decline Push-Up', difficulty: 'advanced', equipment: 'bodyweight'),
    //Exercise(id: 'decline_push_up_m', name: 'Decline Pushup', difficulty: 'advanced', equipment: 'bodyweight'),  // DUPLICATE - use decline_push_up
    Exercise(id: 'close_grip_push_up', name: 'Diamond Push-Up', difficulty: 'advanced', equipment: 'bodyweight'),
    //Exercise(id: 'close_grip_push_up', name: 'Diamond Pushup', difficulty: 'advanced', equipment: 'bodyweight'),  // DUPLICATE - use diamond_push_up
    Exercise(id: 'chest_dip', name: 'Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_seated_dip', name: 'Dip Machine', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_incline_bench_press', name: 'Dumbbell Incline Bench Press', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_incline_fly', name: 'Dumbbell Incline Fly', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_incline_row', name: 'Dumbbell Incline Row', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_kickback', name: 'Dumbbell Kickback', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_lunge', name: 'Dumbbell Lateral Lunge', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_lateral_raise', name: 'Dumbbell Lateral Raise', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_lunge', name: 'Dumbbell Lunge', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_one_arm_row_rack_support', name: 'Dumbbell One Arm Bent Over Row', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_one_arm_revers_wrist_curl', name: 'Dumbbell One Arm Reverse Wrist Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_over_bench_one_arm_wrist_curl', name: 'Dumbbell Over Bench One Arm Wrist Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_over_bench_revers_wrist_curl', name: 'Dumbbell Over Bench Revers Wrist Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_over_bench_wrist_curl', name: 'Dumbbell Over Bench Wrist Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_palm_rotational_bent_over_row', name: 'Dumbbell Palm Rotational Bent Over Row', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_palms_in_incline_bench_press', name: 'Dumbbell Palms in Incline Bench Press', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_peacher_hammer_curl', name: 'Dumbbell Peacher Hammer Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_pullover', name: 'Dumbbell Pullover', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_romanian_deadlift', name: 'Dumbbell RDL', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_rear_fly', name: 'Dumbbell Rear Delt Fly', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_rear_delt_raise', name: 'Dumbbell Rear Delt Raise', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_rear_delt_row', name: 'Dumbbell Rear Delt Row', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_rear_fly', name: 'Dumbbell Rear Fly', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_rear_lateral_raise', name: 'Dumbbell Rear Lateral Raise', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_rear_lunge', name: 'Dumbbell Rear Lunge', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_revers_grip_biceps_curl', name: 'Dumbbell Revers Grip Biceps Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_reverse_bench_press', name: 'Dumbbell Reverse Bench Press', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_reverse_grip_incline_bench_two_arm_row', name: 'Dumbbell Reverse Grip Incline Bench Two Arm Row', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_reverse_preacher_curl', name: 'Dumbbell Reverse Preacher Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_reverse_wrist_curl', name: 'Dumbbell Reverse Wrist Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_romanian_deadlift', name: 'Dumbbell Romanian Deadlift', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_bent_over_row', name: 'Dumbbell Row', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_bench_extension', name: 'Dumbbell Seated Bench Extension', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_bent_arm_lateral_raise', name: 'Dumbbell Seated Bent Arm Lateral Raise', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_bicep_curl', name: 'Dumbbell Seated Bicep Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_front_raise', name: 'Dumbbell Seated Front Raise', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_hammer_curl', name: 'Dumbbell Seated Hammer Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_kickback', name: 'Dumbbell Seated Kickback', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_lateral_raise', name: 'Dumbbell Seated Lateral Raise', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_neutral_wrist_curl', name: 'Dumbbell Seated Neutral Wrist Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_palms_up_wrist_curl', name: 'Dumbbell Seated Palms Up Wrist Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_preacher_curl', name: 'Dumbbell Seated Preacher Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_revers_grip_concentration_curl', name: 'Dumbbell Seated Revers Grip Concentration Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_shoulder_press', name: 'Dumbbell Seated Shoulder Press', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_triceps_extension', name: 'Dumbbell Seated Triceps Extension', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_shrug', name: 'Dumbbell Shrug', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_side_bend', name: 'Dumbbell Side Bend', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_stiff_leg_deadlift', name: 'Dumbbell Single Leg Deadlift', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_single_leg_split_squat', name: 'Dumbbell Single Leg Split Squat', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_squat', name: 'Dumbbell Squat', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_alternate_raise', name: 'Dumbbell Standing Alternate Raise', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_bent_over_two_arm_triceps_extension', name: 'Dumbbell Standing Bent Over Two Arm Triceps Extension', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_biceps_curl', name: 'Dumbbell Standing Biceps Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_calf_raise', name: 'Dumbbell Standing Calf Raise', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_concentration_curl', name: 'Dumbbell Standing Concentration Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_inner_biceps_curl', name: 'Dumbbell Standing Inner Biceps Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_inner_biceps_curl_version_2', name: 'DB Standing Inner Biceps Curl V2', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_kickback', name: 'Dumbbell Standing Kickback', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_one_arm_concentration_curl', name: 'Dumbbell Standing One Arm Concentration Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_one_arm_extension', name: 'Dumbbell Standing One Arm Extension', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_seated_shoulder_press', name: 'Dumbbell Standing Overhead Press', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_triceps_extension', name: 'Dumbbell Standing Overhead Triceps Extension', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_standing_triceps_extension', name: 'Dumbbell Standing Triceps Extension', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_step_up', name: 'Dumbbell Step Up', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_stiff_leg_deadlift', name: 'Dumbbell Stiff Leg Deadlift', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_straight_arm_pullover', name: 'Dumbbell Straight Arm Pullover', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_goblet_squat', name: 'Dumbbell Sumo Squat', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_upright_row', name: 'Dumbbell Upright Row', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_upright_row_back_pov', name: 'Dumbbell Upright Row Back POV', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_upright_shoulder_external_rotation', name: 'Dumbbell Upright Shoulder External Rotation', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbell_zottman_curl', name: 'Dumbbell Zottman Curl', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'dumbbells_seated_triceps_extension', name: 'Dumbbells Seated Triceps Extension', difficulty: 'intermediate', equipment: 'dumbbell'),
    Exercise(id: 'elbow_to_knee', name: 'Elbow to Knee', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pull_up_neutral_grip', name: 'Neutral Grip Pullup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_one_arm_row_rack_support', name: 'One Arm Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_bent_over_row', name: 'Pendlay Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pull_up', name: 'Pull Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'pull_up', name: 'Pullup', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use pull_up
    Exercise(id: 'dumbbell_rear_fly', name: 'Rear Delt Fly', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_one_arm_row_rack_support', name: 'Renegade Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_rear_fly', name: 'Reverse Fly', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'dumbbell_rear_fly', name: 'Reverse Flyes', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use reverse_fly
    Exercise(id: 'lever_seated_reverse_fly', name: 'Reverse Pec Deck', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'ez_barbell_reverse_grip_curl', name: 'EZ Barbell Reverse Grip Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'ez_barbell_reverse_grip_preacher_curl', name: 'EZ Barbell Reverse Grip Preacher Curl', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'ez_barbell_seated_curls', name: 'EZ Barbell Seated Curls', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'ez_barbell_seated_triceps_extension', name: 'EZ Barbell Seated Triceps Extension', difficulty: 'intermediate', equipment: 'barbell'),
    Exercise(id: 'cable_cross_over_revers_fly', name: 'Face Pull', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'finger_curls', name: 'Finger Curls', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'fire_hydrant', name: 'Fire Hydrant', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'flutter_kicks', name: 'Flutter Kick', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'flutter_kicks', name: 'Flutter Kicks', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'flutter_kicks_version_2', name: 'Flutter Kicks V2', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'flutter_kicks_version_3', name: 'Flutter Kicks V3', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'front_plank', name: 'Forearm Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'frog_pump', name: 'Frog Pump', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'frog_pump_hold_pulse', name: 'Frog Pump Hold Pulse', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'frog_pump_pulse', name: 'Frog Pump Pulse', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'front_plank', name: 'Front Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_lateral_raise', name: 'Front Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_front_squat', name: 'Front Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'glute_bridge', name: 'Glute Bridge', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'glute_bridge_hold', name: 'Glute Bridge Hold', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'glute_kickback', name: 'Glute Kickback', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_goblet_squat', name: 'Goblet Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_good_morning', name: 'Good Morning', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hack_calf_raise', name: 'Hack Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_chair_squat', name: 'Hack Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'half_wipers_bent_leg', name: 'Half Wipers Bent Leg', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_hammer_curl', name: 'Hammer Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hammer_grip_pull_up_on_dip_cage', name: 'Hammer Grip Pull Up on Dip Cage', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_lying_leg_curl', name: 'Hamstring Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hanging_leg_hip_raise', name: 'Hanging Leg Hip Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hanging_leg_hip_raise', name: 'Hanging Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hanging_leg_hip_raise', name: 'Hanging Leg Raises', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hanging_oblique_knee_raise', name: 'Hanging Oblique Knee Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hanging_straight_leg_hip_raise', name: 'Hanging Straight Leg Hip Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hanging_straight_twisting_leg_hip_raise', name: 'Hanging Straight Twisting Leg Hip Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'high_knee', name: 'High Knee', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'high_knee_run', name: 'High Knee Run', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'high_knee_sprint', name: 'High Knee Sprint', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'high_knees', name: 'High Knees', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'front_plank', name: 'High Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'barbell_romanian_deadlift', name: 'KB Swing', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use kettlebell_swing
    Exercise(id: 'barbell_romanian_deadlift', name: 'Kettlebell Swing', difficulty: 'intermediate', equipment: 'weights'),
    //Exercise(id: 'cable_pull_through', name: 'Pull Through', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use cable_pull_through
    Exercise(id: 'lever_hip_extension_version_2', name: 'Quadruped Hip Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'quadruped_hip_extension_pulse', name: 'Quadruped Hip Extension Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_deadlift', name: 'Rack Pull', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_romanian_deadlift', name: 'RDL', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_hyper_on_flat_bench', name: 'Reverse Hyper', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', difficulty: 'intermediate', equipment: 'weights'),
    //Exercise(id: 'barbell_romanian_deadlift', name: 'Russian Swing', difficulty: 'intermediate', equipment: 'bodyweight'),  // DUPLICATE - use kettlebell_swing
    Exercise(id: 'push_up_m', name: 'Incline Pushup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'incline_reverse_grip_push_up', name: 'Incline Reverse Grip Push Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'incline_twisting_sit_up_version_2', name: 'Incline Twisting Sit-Up V2', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'incline_twisting_situp', name: 'Incline Twisting Situp', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'inverse_leg_curl_on_pull_up_cable_machine', name: 'Inverse Leg Curl on Pull Up Cable Machine', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'inverted_row', name: 'Inverted Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'inverted_row_bent_knees', name: 'Inverted Row Bent Knees', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jackknife_sit_up', name: 'Jackknife Sit Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_lunge', name: 'Jump Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'stationary_bike_run_version_3', name: 'Jump Rope', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jump_squat', name: 'Jump Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jumping_jack', name: 'Jumping Jack', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_romanian_deadlift', name: 'KB Swing', difficulty: 'intermediate', equipment: 'kettlebell'),
    Exercise(id: 'barbell_romanian_deadlift', name: 'Kettlebell Swing', difficulty: 'intermediate', equipment: 'kettlebell'),
    Exercise(id: 'barbell_romanian_deadlift', name: 'Kettlebell Swings', difficulty: 'intermediate', equipment: 'kettlebell'),
    Exercise(id: 'cable_twist', name: 'Kettlebell Windmill', difficulty: 'intermediate', equipment: 'kettlebell'),
    Exercise(id: 'front_plank', name: 'Knee Tap', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'kneeling_straight_leg_kickback', name: 'Kneeling Straight Leg Kickback', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'vertical_leg_raise_on_parallel_bars', name: 'L Sit', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_bar_lateral_pulldown', name: 'Lat Pulldown', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'stationary_bike_run_version_3', name: 'Lateral Hop', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lateral_lunge', name: 'Lateral Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_lateral_raise', name: 'Lateral Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'stationary_bike_run_version_3', name: 'Lateral Shuffle', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_lying_leg_curl', name: 'Leg Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_leg_extension', name: 'Leg Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_seated_leg_press', name: 'Leg Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lying_leg_raise', name: 'Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_alternate_biceps_curl', name: 'Lever Alternate Biceps Curl', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_alternate_leg_extension_plate_loaded', name: 'Lever Alternate Leg Extension Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_bicep_curl', name: 'Lever Bicep Curl', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_calf_press_plate_loaded', name: 'Lever Calf Press Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_calf_raise_bench_press_machine', name: 'Lever Calf Raise Bench Press Machine', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_chair_squat', name: 'Lever Chair Squat', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_chest_press', name: 'Lever Chest Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_chest_press_plate_loaded', name: 'Lever Chest Press Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_chest_press_version_2', name: 'Lever Chest Press V2', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_chest_press_version_4', name: 'Lever Chest Press V4', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_deadlift_plate_loaded', name: 'Lever Deadlift Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_decline_chest_press', name: 'Lever Decline Chest Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_decline_chest_press_version_2', name: 'Lever Decline Chest Press V2', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_donkey_calf_raise', name: 'Lever Donkey Calf Raise', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_front_pulldown', name: 'Lever Front Pulldown', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_full_squat', name: 'Lever Full Squat', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_gripless_shrug', name: 'Lever Gripless Shrug', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_gripless_shrug_version_2', name: 'Lever Gripless Shrug V2', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_gripper_hands_plate_loaded', name: 'Lever Gripper Hands Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_hammer_grip_preacher_curl', name: 'Lever Hammer Grip Preacher Curl', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_high_row_plate_loaded', name: 'Lever High Row Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_hip_extension_version_2', name: 'Lever Hip Extension V2', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_incline_chest_press', name: 'Lever Incline Chest Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_incline_hammer_chest_press', name: 'Lever Incline Hammer Chest Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_kneeling_leg_curl_plate_loaded', name: 'Lever Kneeling Leg Curl Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_lateral_pulldown_plate_loaded', name: 'Lever Lateral Pulldown', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_lateral_raise', name: 'Lever Lateral Raise', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_leg_extension', name: 'Lever Leg Extension', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_leg_press', name: 'Lever Leg Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_lying_leg_curl', name: 'Lever Lying Leg Curl', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_neck_extension_plate_loaded', name: 'Lever Neck Extension Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_neck_left_side_flexion_plate_loaded', name: 'Lever Neck Left Side Flexion Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_neck_right_side_flexion_plate_loaded', name: 'Lever Neck Right Side Flexion Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_neutral_grip_seated_row_plate_loaded', name: 'Lever Neutral Grip Seated Row Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_overhand_triceps_dip', name: 'Lever Overhand Triceps Dip', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_parallel_chest_press', name: 'Lever Parallel Chest Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_pec_deck_fly', name: 'Lever Pec Deck Fly', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_pistol_squat', name: 'Lever Pistol Squat', difficulty: 'advanced', equipment: 'machine'),
    Exercise(id: 'lever_preacher_curl', name: 'Lever Preacher Curl', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_preacher_curl_plate_loaded', name: 'Lever Preacher Curl Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_preacher_curl_version_2', name: 'Lever Preacher Curl V2', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_pullover_plate_loaded', name: 'Lever Pullover Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_reverse_grip_preacher_curl', name: 'Lever Reverse Grip Preacher Curl', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_reverse_grip_vertical_row', name: 'Lever Reverse Grip Vertical Row', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_reverse_t_bar_row', name: 'Lever Reverse T Bar Row', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_rotary_calf', name: 'Lever Rotary Calf', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_row_plate_loaded', name: 'Lever Row Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_calf_press', name: 'Lever Seated Calf Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_calf_raise_plate_loaded', name: 'Lever Seated Calf Raise', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_calf_raise_plate_loaded', name: 'Lever Seated Calf Raise Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_crunch', name: 'Lever Seated Crunch', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_hip_abduction', name: 'Lever Seated Hip Abduction', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_hip_adduction', name: 'Lever Seated Hip Adduction', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_leg_curl', name: 'Lever Seated Leg Curl', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_leg_press', name: 'Lever Seated Leg Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_reverse_fly', name: 'Lever Seated Reverse Fly', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_row', name: 'Lever Seated Row', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_shoulder_press', name: 'Lever Seated Shoulder Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_squat', name: 'Lever Seated Squat', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_seated_twist', name: 'Lever Seated Twist', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_shoulder_press_plate_loaded_ii', name: 'Lever Shoulder Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_shrug_plate_loaded', name: 'Lever Shrug Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_side_hip_abduction', name: 'Lever Side Hip Abduction', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_side_hip_adduction', name: 'Lever Side Hip Adduction', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_single_arm_neutral_grip_seated_row_plate_loaded', name: 'Lever Single Arm Neutral Grip Seated Row Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_squat_plate_loaded', name: 'Lever Squat Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_standing_calf_raise', name: 'Lever Standing Calf Raise', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_standing_hip_extension', name: 'Lever Standing Hip Extension', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_standing_rear_kick', name: 'Lever Standing Rear Kick', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_t_bar_reverse_grip_row', name: 'Lever T Bar Reverse Grip Row', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_t_bar_row_plate_loaded', name: 'Lever T Bar Row', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_triceps_dip_plate_loaded', name: 'Lever Tricep Dip', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_triceps_dip_plate_loaded', name: 'Lever Triceps Dip Plate Loaded', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'lever_triceps_extension', name: 'Lever Triceps Extension', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'dumbbell_lunge', name: 'Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_lying_leg_curl', name: 'Lying Leg Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lying_leg_raise', name: 'Lying Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_chest_press', name: 'Machine Chest Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'stationary_bike_run_version_3', name: 'Marching in Place', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'barbell_standing_military_press', name: 'Military Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'mountain_climber', name: 'Mountain Climber', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'mountain_climber', name: 'Mountain Climber Crossover', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'mountain_climber', name: 'Mountain Climbers', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_kneeling_leg_curl_plate_loaded', name: 'Nordic Curl', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'cross_body_crunch', name: 'Oblique Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_standing_military_press', name: 'Overhead Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_full_squat', name: 'Overhead Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_standing_triceps_extension', name: 'Overhead Tricep Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_horizontal_pallof_press', name: 'Pallof Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_pec_deck_fly', name: 'Pec Deck', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_bent_over_row', name: 'Pendlay Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pike_push_up', name: 'Pike Push Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pike_push_up', name: 'Pike Pushup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'single_leg_squat_with_support_pistol', name: 'Pistol Squat', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'front_plank', name: 'Plank', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'front_plank', name: 'Plank Jack', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'front_plank', name: 'Plank Tap', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'front_plank', name: 'Plank to Pushup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_preacher_curl', name: 'Preacher Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pull_up', name: 'Pull Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pull_up_neutral_grip', name: 'Pull Up Neutral Grip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pull_up', name: 'Pullup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_lunge', name: 'Pulse Curtsy Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_standing_military_press', name: 'Push Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'push_up_m', name: 'Push Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'push_up_m', name: 'Push-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'push_up_on_forearms', name: 'Push-Up on Forearms', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'push_up_m', name: 'Pushup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_hip_extension_version_2', name: 'Quadruped Hip Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'quadruped_hip_extension_pulse', name: 'Quadruped Hip Extension Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_romanian_deadlift', name: 'RDL', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'rear_decline_bridge', name: 'Rear Decline Bridge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'rear_pull_up', name: 'Rear Pull Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_bent_over_row', name: 'Resistance Band Bent Over Row', difficulty: 'beginner', equipment: 'bands'),
    Exercise(id: 'barbell_curl', name: 'Resistance Band Bicep Curl', difficulty: 'beginner', equipment: 'bands'),
    Exercise(id: 'cable_bench_press', name: 'Resistance Band Chest Press', difficulty: 'beginner', equipment: 'bands'),
    Exercise(id: 'resistance_band_glute_kickback', name: 'Resistance Band Glute Kickback', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'cable_lateral_raise', name: 'Resistance Band Lateral Raise', difficulty: 'beginner', equipment: 'bands'),
    Exercise(id: 'squat_m', name: 'Resistance Band Squat', difficulty: 'beginner', equipment: 'bands'),
    Exercise(id: 'reverse_crunch_m', name: 'Reverse Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_reverse_curl', name: 'Reverse Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_dip', name: 'Reverse Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_rear_fly', name: 'Reverse Fly', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_grip_machine_lat_pulldown', name: 'Reverse Grip Machine Lat Pulldown', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'reverse_hyper_on_flat_bench', name: 'Reverse Hyper', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_hyper_on_flat_bench', name: 'Reverse Hyper on Flat Bench', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_rear_lunge', name: 'Reverse Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_triceps_pushdown_v_bar_attachment', name: 'Rope Pushdown', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'stationary_bike_run_version_3', name: 'Running in Place', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'russian_twist', name: 'Russian Twist', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'russian_twist_with_medicine_ball', name: 'Russian Twist with Medicine Ball', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'flutter_kicks', name: 'Scissor Kick', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_seated_row', name: 'Seated Cable Row', difficulty: 'intermediate', equipment: 'cable'),
    Exercise(id: 'lever_seated_calf_raise_plate_loaded', name: 'Seated Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_seated_leg_curl', name: 'Seated Leg Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'seated_leg_raise', name: 'Seated Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_seated_twist', name: 'Seated Twist', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'shoulder_grip_pull_up', name: 'Shoulder Grip Pull Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_seated_shoulder_press', name: 'Shoulder Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_shrug', name: 'Shrug', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lying_leg_raise', name: 'Side Lying Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'side_plank_male', name: 'Side Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'side_plank_male', name: 'Side Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'side_step', name: 'Side Step', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bodyweight_standing_calf_raise', name: 'Single Leg Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'single_leg_deadlift', name: 'Single Leg Deadlift', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'single_leg_glute_bridge', name: 'Single Leg Glute Bridge', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_romanian_deadlift', name: 'Single Leg RDL', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_stiff_leg_deadlift', name: 'Single Leg RDL Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'single_leg_squat_with_support_pistol', name: 'Single Leg Squat with Support Pistol', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'sit_squat', name: 'Sissy Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sit_squat', name: 'Sit Squat', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'sit_up_ii', name: 'Sit Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sit_up_ii', name: 'Sit-Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'skater', name: 'Skater', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'skater_hops', name: 'Skater Hop', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'stationary_bike_run_version_3', name: 'Skipping Rope', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_lying_close_grip_triceps_extension', name: 'Skull Crusher', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sled_calf_press_on_leg_press', name: 'Sled 45 Degree Calf Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_hack_squat', name: 'Sled 45 Degree Leg Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_hack_squat', name: 'Sled 45 Degree Leg Wide Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_hack_squat', name: 'Sled 45 Degree Narrow Stance Leg Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_calf_press_on_leg_press', name: 'Sled Calf Press on Leg Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_forward_angled_calf_raise', name: 'Sled Forward Angled Calf Raise', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_full_hack_squat', name: 'Sled Full Hack Squat', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_hack_squat', name: 'Sled Hack Squat', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_lying_squat', name: 'Sled Lying Leg Press', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_lying_squat', name: 'Sled Lying Squat', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'sled_reverse_hack_squat', name: 'Sled Reverse Hack Squat', difficulty: 'intermediate', equipment: 'machine'),
    Exercise(id: 'smith_behind_neck_press', name: 'Smith Behind Neck Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_bench_press', name: 'Smith Bench Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_bent_over_narrow_supinated_grip_row', name: 'Smith Bent Over Narrow Supinated Grip Row', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_bent_over_pronated_grip_row', name: 'Smith Bent Over Pronated Grip Row', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_calf_raise_version_2', name: 'Smith Calf Raise V2', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_chair_squat', name: 'Smith Chair Squat', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_close_grip_bench_press', name: 'Smith Close Grip Bench Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_deadlift', name: 'Smith Deadlift', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_decline_bench_press', name: 'Smith Decline Bench Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_decline_reverse_grip_press', name: 'Smith Decline Reverse Grip Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_frankenstein_squat', name: 'Smith Frankenstein Squat', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_front_squat', name: 'Smith Front Squat', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_front_squat_clean_grip', name: 'Smith Front Squat Clean Grip', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_incline_bench_press', name: 'Smith Incline Bench Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_incline_reverse_grip_press', name: 'Smith Incline Reverse Grip Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_leg_press', name: 'Smith Leg Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_low_bar_squat', name: 'Smith Low Bar Squat', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_machine_bicep_curl', name: 'Smith Machine Bicep Curl', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_machine_decline_close_grip_bench_press', name: 'Smith Machine Decline Close Grip Bench Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_machine_incline_tricep_extension', name: 'Smith Machine Incline Tricep Extension', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_machine_reverse_decline_close_grip_bench_press', name: 'Smith Machine Reverse Decline Close Grip Bench Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_reverse_calf_raises', name: 'Smith Reverse Calf Raises', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_reverse_grip_bent_over_row', name: 'Smith Reverse Grip Bent Over Row', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_reverse_grip_press', name: 'Smith Reverse Grip Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_seated_shoulder_press', name: 'Smith Seated Shoulder Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_seated_wrist_curl', name: 'Smith Seated Wrist Curl', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_shoulder_press', name: 'Smith Shoulder Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_shrug', name: 'Smith Shrug', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_single_leg_split_squat', name: 'Smith Single Leg Split Squat', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_split_squat', name: 'Smith Split Squat', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_squat', name: 'Smith Squat', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_squat_to_bench', name: 'Smith Squat to Bench', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_standing_behind_head_military_press', name: 'Smith Standing Behind Head Military Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_standing_military_press', name: 'Smith Standing Military Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_stiff_legged_deadlift', name: 'Smith Stiff Legged Deadlift', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_toe_raise', name: 'Smith Toe Raise', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_upright_row', name: 'Smith Upright Row', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_wide_grip_bench_press', name: 'Smith Wide Grip Bench Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_wide_grip_decline_bench_press', name: 'Smith Wide Grip Decline Bench Press', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'smith_zercher_squat', name: 'Smith Zercher Squat', difficulty: 'intermediate', equipment: 'smith'),
    Exercise(id: 'barbell_full_squat', name: 'Spanish Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_preacher_curl', name: 'Spider Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'spine_twist', name: 'Spine Twist', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'split_squats', name: 'Split Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'split_squats', name: 'Split Squats', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_full_squat', name: 'Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_m', name: 'Bodyweight Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_m', name: 'Squat Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_m', name: 'Squat Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_m', name: 'Squat Reach', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_to_kickback', name: 'Squat to Kickback', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_standing_calf_raise', name: 'Standing Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'standing_glute_kickback', name: 'Standing Glute Kickback', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'standing_glute_squeeze', name: 'Standing Glute Squeeze', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_standing_hip_extension', name: 'Standing Hip Flexor', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'front_plank', name: 'Standing Wheel Rollout', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'star_jump', name: 'Star Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_lunge', name: 'Static Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'stationary_bike_run_version_3', name: 'Stationary Bike', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'step_touch', name: 'Step Touch', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_step_up', name: 'Step Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_straight_leg_deadlift', name: 'Stiff Leg Deadlift', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sumo_deadlift', name: 'Sumo Deadlift', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sumo_squat', name: 'Sumo Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sumo_squat_hold_pulse', name: 'Sumo Squat Hold Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sumo_squat_pulse', name: 'Sumo Squat Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_hyper_on_flat_bench', name: 'Superman', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'reverse_hyper_on_flat_bench', name: 'Superman Hold', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'lever_t_bar_row_plate_loaded', name: 'Tbar Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_full_squat', name: 'Thruster', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_deadlift', name: 'Trap Bar Deadlift', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'triceps_dip', name: 'Tricep Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lever_triceps_extension', name: 'Tricep Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_kickback', name: 'Tricep Kickback', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_triceps_pushdown_v_bar_attachment', name: 'Tricep Pushdown', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'triceps_dip', name: 'Triceps Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'triceps_dips_floor', name: 'Triceps Dips Floor', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'tuck_crunch', name: 'Tuck Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'tuck_jump', name: 'Tuck Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'twin_handle_parallel_grip_lat_pulldown', name: 'Twin Handle Parallel Grip Lat Pulldown', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'underhand_grip_inverted_back_row', name: 'Underhand Grip Inverted Back Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_upright_row', name: 'Upright Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jackknife_sit_up', name: 'V Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jackknife_sit_up', name: 'V Ups', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'vertical_leg_raise_on_parallel_bars', name: 'Vertical Leg Raise on Parallel Bars', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'walking_lunge_male', name: 'Walking Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'walking_lunge_male', name: 'Walking Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'push_up_m', name: 'Wall Push Up', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'squat_m', name: 'Wall Sit', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'weighted_bench_dip', name: 'Weighted Bench Dip', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'weighted_hanging_leg_hip_raise', name: 'Weighted Hanging Leg Hip Raise', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'weighted_lying_neck_extension', name: 'Weighted Lying Neck Extension', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'weighted_lying_neck_extension_with_head_harness', name: 'Weighted Lying Neck Extension with Head Harness', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'weighted_lying_neck_flexion', name: 'Weighted Lying Neck Flexion', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'weighted_lying_neck_flexion_with_head_harness', name: 'Weighted Lying Neck Flexion with Head Harness', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'weighted_lying_side_lifting_head_with_head_harness', name: 'Weighted Lying Side Lifting Head with Head Harness', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'weighted_seated_neck_extension_with_head_harness', name: 'Weighted Seated Neck Extension with Head Harness', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'weighted_standing_neck_extension_with_head_harness', name: 'Weighted Standing Neck Extension with Head Harness', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'wide_grip_chest_dip_on_high_parallel_bars', name: 'Wide Grip Chest Dip on High Parallel Bars', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wide_grip_pull_up', name: 'Wide Grip Pull Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wide_grip_pull_up_on_dip_cage', name: 'Wide Grip Pull Up on Dip Cage', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wide_grip_rear_pull_up', name: 'Wide Grip Rear Pull Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wide_hand_push_up', name: 'Wide Hand Push Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wide_hand_push_up', name: 'Wide Pushup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wide_stance_jump_squat_to_narrow', name: 'Wide to Narrow Stance Jump Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_twist', name: 'Windmill', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wipers_straight_leg', name: 'Wipers Straight Leg', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_twist', name: 'Wood Chop', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_wrist_curl', name: 'Wrist Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_full_zercher_squat', name: 'Zercher Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_zottman_curl', name: 'Zottman Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
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

