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
      Exercise(id: 'bench_press', name: 'Bench Press', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'incline_press', name: 'Incline Press', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'decline_press', name: 'Decline Press', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'chest_flys', name: 'Chest Flys', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'pushups', name: 'Push-ups', difficulty: 'beginner', equipment: 'bodyweight'),
      Exercise(id: 'dips_chest', name: 'Dips (Chest)', difficulty: 'advanced', equipment: 'bodyweight'),
      Exercise(id: 'cable_crossover', name: 'Cable Crossovers', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'landmine_press', name: 'Landmine Press', difficulty: 'intermediate', equipment: 'weights'),
    ],
    'back': [
      Exercise(id: 'deadlift', name: 'Deadlift', difficulty: 'advanced', equipment: 'weights'),
      Exercise(id: 'bent_rows', name: 'Bent-Over Rows', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'pullups', name: 'Pull-ups', difficulty: 'advanced', equipment: 'bodyweight'),
      Exercise(id: 'lat_pulldown', name: 'Lat Pulldowns', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'cable_rows', name: 'Cable Rows', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'tbar_rows', name: 'T-Bar Rows', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'face_pulls', name: 'Face Pulls', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'reverse_flys', name: 'Reverse Flys', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'shrugs', name: 'Shrugs', difficulty: 'beginner', equipment: 'weights'),
    ],
    'shoulders': [
      Exercise(id: 'overhead_press', name: 'Overhead Press', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'arnold_press', name: 'Arnold Press', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'lateral_raises', name: 'Lateral Raises', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'front_raises', name: 'Front Raises', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'rear_delt_flys', name: 'Rear Delt Flys', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'upright_rows', name: 'Upright Rows', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'pike_pushups', name: 'Pike Push-ups', difficulty: 'intermediate', equipment: 'bodyweight'),
    ],
    'legs': [
      Exercise(id: 'squats', name: 'Squats', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'lunges', name: 'Lunges', difficulty: 'beginner', equipment: 'bodyweight'),
      Exercise(id: 'bulgarian_split', name: 'Bulgarian Split Squats', difficulty: 'advanced', equipment: 'weights'),
      Exercise(id: 'leg_press', name: 'Leg Press', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'leg_extensions', name: 'Leg Extensions', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'leg_curls', name: 'Leg Curls', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'calf_raises', name: 'Calf Raises', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'step_ups', name: 'Step-ups', difficulty: 'beginner', equipment: 'bodyweight'),
      Exercise(id: 'goblet_squats', name: 'Goblet Squats', difficulty: 'beginner', equipment: 'weights'),
      //Exercise(id: 'wall_sits', name: 'Wall Sits', difficulty: 'beginner', equipment: 'bodyweight'),
      Exercise(id: 'jump_squats', name: 'Jump Squats', difficulty: 'intermediate', equipment: 'bodyweight'),
    ],
    'arms': [
      Exercise(id: 'bicep_curls', name: 'Bicep Curls', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'hammer_curls', name: 'Hammer Curls', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'preacher_curls', name: 'Preacher Curls', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'tricep_extensions', name: 'Tricep Extensions', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'skull_crushers', name: 'Skull Crushers', difficulty: 'intermediate', equipment: 'weights'),
      Exercise(id: 'overhead_tricep', name: 'Overhead Tricep Extension', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'close_grip_pushups', name: 'Close-grip Push-ups', difficulty: 'intermediate', equipment: 'bodyweight'),
      Exercise(id: 'concentration_curls', name: 'Concentration Curls', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'cable_curls', name: 'Cable Curls', difficulty: 'beginner', equipment: 'weights'),
      Exercise(id: 'diamond_pushups', name: 'Diamond Push-ups', difficulty: 'advanced', equipment: 'bodyweight'),
    ],
    'core': [
      Exercise(id: 'situps', name: 'Sit-ups', difficulty: 'beginner', equipment: 'bodyweight'),
      Exercise(id: 'crunches', name: 'Crunches', difficulty: 'beginner', equipment: 'bodyweight'),
      Exercise(id: 'planks', name: 'Planks', difficulty: 'beginner', equipment: 'bodyweight'),
      Exercise(id: 'side_planks', name: 'Side Planks', difficulty: 'intermediate', equipment: 'bodyweight'),
      Exercise(id: 'leg_raises', name: 'Leg Raises', difficulty: 'intermediate', equipment: 'bodyweight'),
      Exercise(id: 'russian_twists', name: 'Russian Twists', difficulty: 'beginner', equipment: 'bodyweight'),
      Exercise(id: 'mountain_climbers', name: 'Mountain Climbers', difficulty: 'intermediate', equipment: 'bodyweight'),
      Exercise(id: 'bicycle_crunches', name: 'Bicycle Crunches', difficulty: 'beginner', equipment: 'bodyweight'),
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
      icon: '🔄',
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
      icon: '⬆️⬇️',
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
      icon: '💯',
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
    Exercise(id: 'pushups', name: 'Push-ups', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'pullups', name: 'Pull-ups', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'dips_chest', name: 'Dips', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'lunges', name: 'Lunges', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'squats_bw', name: 'Bodyweight Squats', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'planks', name: 'Planks', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'mountain_climbers', name: 'Mountain Climbers', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'burpees', name: 'Burpees', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pike_pushups', name: 'Pike Push-ups', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'wall_sits', name: 'Wall Sits', difficulty: 'beginner', equipment: 'bodyweight'),
  ];

  // Cardio Only Exercises
  static const List<Exercise> cardioExercises = [
    Exercise(id: 'burpees', name: 'Burpees', difficulty: 'intermediate', equipment: 'none'),
    Exercise(id: 'jumping_jacks', name: 'Jumping Jacks', difficulty: 'beginner', equipment: 'none'),
    Exercise(id: 'high_knees', name: 'High Knees', difficulty: 'beginner', equipment: 'none'),
    Exercise(id: 'butt_kicks', name: 'Butt Kicks', difficulty: 'beginner', equipment: 'none'),
    Exercise(id: 'box_jumps', name: 'Box Jumps', difficulty: 'advanced', equipment: 'none'),
    Exercise(id: 'jump_rope', name: 'Jump Rope', difficulty: 'intermediate', equipment: 'none'),
    // Exercise(id: 'bear_crawls', name: 'Bear Crawls', difficulty: 'intermediate', equipment: 'none'),
    Exercise(id: 'sprawls', name: 'Sprawls', difficulty: 'advanced', equipment: 'none'),
    Exercise(id: 'skaters', name: 'Skaters', difficulty: 'intermediate', equipment: 'none'),
    Exercise(id: 'tuck_jumps', name: 'Tuck Jumps', difficulty: 'advanced', equipment: 'none'),
    Exercise(id: 'star_jumps', name: 'Star Jumps', difficulty: 'beginner', equipment: 'none'),
    Exercise(id: 'lateral_hops', name: 'Lateral Hops', difficulty: 'intermediate', equipment: 'none'),
  ];

  // Main Categories
  static const List<WorkoutCategory> categories = [
    WorkoutCategory(
      id: 'splits',
      name: 'MUSCLE SPLITS',
      icon: '💪',
      description: 'Target specific muscle groups',
    ),
    WorkoutCategory(
      id: 'circuits',
      name: 'CIRCUITS',
      icon: '⚡',
      description: 'High-intensity timed workouts',
    ),
    WorkoutCategory(
      id: 'training_splits',
      name: 'TRAINING SPLITS',
      icon: '🏋️',
      description: 'Classic workout splits',
    ),
    WorkoutCategory(
      id: 'at_home',
      name: 'AT HOME',
      icon: '🏠',
      description: 'No equipment needed',
    ),
    WorkoutCategory(
      id: 'cardio',
      name: 'CARDIO ONLY',
      icon: '🏃',
      description: 'Pure cardio exercises',
    ),
  ];

  static const Map<String, String> muscleSplitInfo = {
    'chest': 'CHEST 🦾',
    'back': 'BACK 🔙',
    'shoulders': 'SHOULDERS 💪',
    'legs': 'LEGS 🦵',
    'arms': 'ARMS 💪',
    'core': 'CORE 🎯',
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
            id: 'push_up',
            name: 'Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'incline_push_up',
            name: 'Incline Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_chest_fly',
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
            id: 'incline_dumbbell_press',
            name: 'Incline Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'decline_dumbbell_press',
            name: 'Decline Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_chest_fly',
            name: 'Dumbbell Chest Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_chest_fly',
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
            id: 'incline_barbell_press',
            name: 'Incline Barbell Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'decline_barbell_press',
            name: 'Decline Barbell Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_crossover',
            name: 'Cable Crossover',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dumbbell_chest_fly',
            name: 'Dumbbell Chest Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_chest_fly',
            name: 'Cable Chest Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'push_up',
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
      icon: '🦾',
    );
  }

  // BACK WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymBackWorkout(String difficulty) {
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
            id: 'face_pull',
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
            id: 'assisted_pull_up',
            name: 'Assisted Pull-Up',
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
            id: 'chin_up',
            name: 'Chin-Up',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'chest_supported_row',
            name: 'Chest Supported Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'romanian_deadlift',
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
            id: 'conventional_deadlift',
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
            id: 'weighted_pull_up',
            name: 'Weighted Pull-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 't_bar_row',
            name: 'T-Bar Row',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'rear_delt_fly',
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
      icon: '🔙',
    );
  }

  // SHOULDERS WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymShouldersWorkout(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'seated_dumbbell_press',
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
            id: 'face_pull',
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
            id: 'standing_dumbbell_press',
            name: 'Standing Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'arnold_press',
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
            id: 'rear_delt_fly',
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
            id: 'barbell_overhead_press',
            name: 'Barbell Overhead Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'push_press',
            name: 'Push Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps', 'legs'],
          ),
          WorkoutExercise(
            id: 'leaning_lateral_raise',
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
            id: 'reverse_pec_deck',
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
            id: 'rear_delt_fly',
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
      icon: '💪',
    );
  }

  // LEGS WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymLegsWorkout(String difficulty) {
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
            id: 'leg_press',
            name: 'Leg Press',
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
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_back_squat',
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
            id: 'hack_squat',
            name: 'Hack Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'lying_leg_curl',
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
            id: 'front_squat',
            name: 'Front Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'deficit_deadlift',
            name: 'Deficit Deadlift',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['back', 'glutes'],
          ),
          WorkoutExercise(
            id: 'bulgarian_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'sissy_squat',
            name: 'Sissy Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'nordic_curl',
            name: 'Nordic Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'spanish_squat',
            name: 'Spanish Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'single_leg_calf_raise',
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
      icon: '🦵',
    );
  }

  // ARMS WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymArmsWorkout(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'cable_bicep_curl',
            name: 'Cable Bicep Curl',
            sets: 3,
            reps: 12,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_pushdown',
            name: 'Cable Pushdown',
            sets: 3,
            reps: 12,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'seated_hammer_curl',
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
            id: 'dumbbell_bicep_curl',
            name: 'Dumbbell Bicep Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'overhead_tricep_extension',
            name: 'Overhead Tricep Extension',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_hammer_curl',
            name: 'Standing Hammer Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: ['forearms'],
          ),
          WorkoutExercise(
            id: 'preacher_curl',
            name: 'Preacher Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dip_machine',
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
            id: 'barbell_bicep_curl',
            name: 'Barbell Bicep Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'skull_crusher',
            name: 'Skull Crusher',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cross_body_hammer_curl',
            name: 'Cross Body Hammer Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['biceps'],
            secondaryMuscles: ['forearms'],
          ),
          WorkoutExercise(
            id: 'weighted_dip',
            name: 'Weighted Dip',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
          WorkoutExercise(
            id: 'spider_curl',
            name: 'Spider Curl',
            sets: 4,
            reps: 10,
            primaryMuscles: ['biceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'jm_press',
            name: 'JM Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['triceps'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'close_grip_bench_press',
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
      icon: '💪',
    );
  }

  // CORE WORKOUT - Research-backed muscle split
  static WorkoutPreset _getGymCoreWorkout(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'crunch',
            name: 'Crunch',
            sets: 3,
            reps: 12,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dead_bug',
            name: 'Dead Bug',
            sets: 3,
            reps: 12,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'pallof_press_kneeling',
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
            id: 'cable_crunch',
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
            id: 'pallof_press_standing',
            name: 'Pallof Press Standing',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'russian_twist',
            name: 'Russian Twist',
            sets: 4,
            reps: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'side_plank',
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
            id: 'decline_weighted_sit_up',
            name: 'Decline Weighted Sit-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'hanging_leg_raise',
            name: 'Hanging Leg Raise',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'pallof_press_split_stance',
            name: 'Pallof Press Split Stance',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'landmine_rotation',
            name: 'Landmine Rotation',
            sets: 4,
            reps: 8,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'russian_twist',
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
            id: 'cable_crunch',
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
      icon: '🎯',
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
            id: 'push_up',
            name: 'Push-Ups',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps', 'shoulders'],
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
            id: 'dumbbell_row',
            name: 'Dumbbell Row',
            sets: 4,
            reps: 10,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'standing_dumbbell_press',
            name: 'Standing Dumbbell Press',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'assisted_pull_up',
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
            id: 'barbell_overhead_press',
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
            id: 'incline_dumbbell_press',
            name: 'Incline Dumbbell Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_crossover',
            name: 'Cable Crossover',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'rear_delt_fly',
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
      icon: '💪',
    );
  }

  // LOWER BODY - Research-backed muscle grouping
  static WorkoutPreset _getGymLowerBodyWorkout(String difficulty) {
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
            id: 'leg_press',
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
            id: 'barbell_back_squat',
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
            id: 'leg_extension',
            name: 'Leg Extension',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'lying_leg_curl',
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
            id: 'front_squat',
            name: 'Front Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'deficit_deadlift',
            name: 'Deficit Deadlift',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['back', 'glutes'],
          ),
          WorkoutExercise(
            id: 'bulgarian_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'hack_squat',
            name: 'Hack Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'nordic_curl',
            name: 'Nordic Curl',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'sissy_squat',
            name: 'Sissy Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
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
      id: 'gym_lower_body',
      name: 'LOWER BODY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      exercises: exercises,
      isCircuit: false,
      icon: '🦵',
    );
  }

  // PUSH DAY - Research-backed muscle grouping
  static WorkoutPreset _getGymPushDayWorkout(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up',
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
            id: 'standing_dumbbell_press',
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
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'overhead_tricep_extension',
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
            id: 'barbell_overhead_press',
            name: 'Barbell Overhead Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'incline_barbell_press',
            name: 'Incline Barbell Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'weighted_dip',
            name: 'Weighted Dip',
            sets: 4,
            reps: 8,
            primaryMuscles: ['triceps'],
            secondaryMuscles: ['chest'],
          ),
          WorkoutExercise(
            id: 'leaning_lateral_raise',
            name: 'Leaning Lateral Raise',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'cable_crossover',
            name: 'Cable Crossover',
            sets: 4,
            reps: 10,
            primaryMuscles: ['chest'],
            secondaryMuscles: [],
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
      id: 'gym_push_day',
      name: 'PUSH DAY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      exercises: exercises,
      isCircuit: false,
      icon: '🚀',
    );
  }

  // PULL DAY - Research-backed muscle grouping
  static WorkoutPreset _getGymPullDayWorkout(String difficulty) {
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
            id: 'cable_bicep_curl',
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
            id: 'assisted_pull_up',
            name: 'Assisted Pull-Up',
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
            id: 'romanian_deadlift',
            name: 'Romanian Deadlift',
            sets: 4,
            reps: 10,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['back', 'glutes'],
          ),
          WorkoutExercise(
            id: 'reverse_fly',
            name: 'Reverse Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'dumbbell_bicep_curl',
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
            id: 'conventional_deadlift',
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
            id: 'weighted_pull_up',
            name: 'Weighted Pull-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 't_bar_row',
            name: 'T-Bar Row',
            sets: 4,
            reps: 8,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'rear_delt_fly',
            name: 'Rear Delt Fly',
            sets: 4,
            reps: 10,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['back'],
          ),
          WorkoutExercise(
            id: 'barbell_bicep_curl',
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
      icon: '💪',
    );
  }

  // FULL BODY - Research-backed muscle grouping
  static WorkoutPreset _getGymFullBodyWorkout(String difficulty) {
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
            id: 'push_up',
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
        ];
        break;
      case 'intermediate':
        exercises = [
          WorkoutExercise(
            id: 'barbell_back_squat',
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
            secondaryMuscles: ['glutes', 'back'],
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
            id: 'standing_dumbbell_press',
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
            id: 'front_squat',
            name: 'Front Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'conventional_deadlift',
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
            id: 'barbell_overhead_press',
            name: 'Barbell Overhead Press',
            sets: 4,
            reps: 8,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'bulgarian_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'hanging_leg_raise',
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
      icon: '⚡',
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
            id: 'goblet_squat',
            name: 'Goblet Squat',
            sets: 3,
            reps: 12,
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
            reps: 10,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'barbell_back_squat',
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
            id: 'curtsy_lunge',
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
            id: 'front_squat',
            name: 'Front Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'deficit_deadlift',
            name: 'Deficit Deadlift',
            sets: 4,
            reps: 8,
            primaryMuscles: ['hamstrings'],
            secondaryMuscles: ['back', 'glutes'],
          ),
          WorkoutExercise(
            id: 'pulse_curtsy_lunge',
            name: 'Pulse Curtsy Lunge',
            sets: 4,
            reps: 8,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['legs'],
          ),
          WorkoutExercise(
            id: 'bulgarian_split_squat',
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
      name: 'GLUTES & LEGS 🍑',
      category: 'gym',
      subcategory: 'muscle_groupings',
      exercises: exercises,
      isCircuit: false,
      icon: '🍑',
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
            id: 'marching_in_place',
            name: 'Marching In Place',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'push_up',
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
            id: 'plank',
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
            id: 'high_knee',
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
            id: 'goblet_squat',
            name: 'Goblet Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'dumbbell_row',
            name: 'Dumbbell Row',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'walking_lunge',
            name: 'Walking Lunge',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
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
        exercises = [
          WorkoutExercise(
            id: 'high_knee_sprint',
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
            id: 'bulgarian_split_squat',
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
      icon: '💥',
    );
  }

  // UPPER BODY BURNER - Research-backed circuit exercises  
  static WorkoutPreset _getUpperBodyBurnerCircuit(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'step_touch',
            name: 'Step Touch',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'incline_push_up',
            name: 'Incline Push-Ups',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'lat_pulldown',
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
            id: 'jumping_jack',
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
            id: 'cable_row',
            name: 'Cable Row',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['back'],
            secondaryMuscles: ['biceps'],
          ),
          WorkoutExercise(
            id: 'standing_dumbbell_press',
            name: 'Standing Dumbbell Press',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'dumbbell_chest_fly',
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
            id: 'barbell_overhead_press',
            name: 'Barbell Overhead Press',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['shoulders'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'incline_dumbbell_press',
            name: 'Incline Dumbbell Press',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'cable_crossover',
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
      icon: '🔥',
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
            id: 'static_lunge',
            name: 'Static Lunge',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'wall_sit',
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
            id: 'goblet_squat',
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
            id: 'walking_lunge',
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
            id: 'calf_raise',
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
            id: 'jumping_lunge',
            name: 'Jumping Lunge',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'bulgarian_split_squat',
            name: 'Bulgarian Split Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'single_leg_calf_raise',
            name: 'Single Leg Calf Raise',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['calves'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'squat_jump_180',
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
      icon: '⚡',
    );
  }

  // CORE DESTROYER - Research-backed circuit exercises
  static WorkoutPreset _getCoreDestroyerCircuit(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'plank',
            name: 'Plank',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'dead_bug',
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
            id: 'modified_side_plank',
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
            id: 'mountain_climber',
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'bicycle_crunch',
            name: 'Bicycle Crunch',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'russian_twist',
            name: 'Russian Twist',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'side_plank',
            name: 'Side Plank',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'leg_raise',
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
            id: 'mountain_climber_crossover',
            name: 'Mountain Climber Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'v_up',
            name: 'V-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'weighted_russian_twist',
            name: 'Weighted Russian Twist',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'side_plank_rotation',
            name: 'Side Plank Rotation',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'hanging_leg_raise',
            name: 'Hanging Leg Raise',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'plank_up_down',
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
      icon: '🎯',
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
            id: 'sumo_squat_pulse',
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
      icon: '🍑',
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
            id: 'sumo_squat_hold_pulse',
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
      icon: '🍑',
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
            id: 'sumo_squat_pulse',
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
      icon: '🍑',
    );
  }

  // GIRL POWER - UPPER BODY (Upper/Lower Split)
  static WorkoutPreset _getGymGirlUpperBody(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up',
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
            id: 'standing_dumbbell_press',
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
            id: 'barbell_overhead_press',
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
      icon: '💪',
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
            id: 'barbell_back_squat',
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
            id: 'barbell_back_squat',
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
      icon: '🦵',
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
            id: 'push_up',
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
            id: 'barbell_back_squat',
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
            id: 'standing_dumbbell_press',
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
      icon: '⚡',
    );
  }

  // GIRL POWER - PPL PUSH DAY
  static WorkoutPreset _getGymGirlPPLPush(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up',
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
            id: 'standing_dumbbell_press',
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
            id: 'barbell_overhead_press',
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
      icon: '🚀',
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
            id: 'cable_bicep_curl',
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
            id: 'dumbbell_bicep_curl',
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
            id: 'barbell_bent_over_row',
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
            id: 'cable_bicep_curl',
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
      icon: '💪',
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
            id: 'barbell_back_squat',
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
            id: 'barbell_back_squat',
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
      icon: '🦵',
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
            id: 'push_up',
            name: 'Push-Up',
            sets: 3,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
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
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up',
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
            id: 'static_lunge',
            name: 'Static Lunge',
            sets: 4,
            reps: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
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
            id: 'pistol_squat',
            name: 'Pistol Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'decline_push_up',
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
            id: 'jumping_lunge',
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
            id: 'mountain_climber',
            name: 'Mountain Climber',
            sets: 4,
            reps: 0,
            timeSeconds: 40,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'plank',
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
      icon: '⚡',
    );
  }

  // HOME BODYWEIGHT BASICS - BALANCED UPPER BODY
  static WorkoutPreset _getHomeBalancedUpperBodyWorkout(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'incline_push_up',
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
            id: 'push_up',
            name: 'Push-Up',
            sets: 4,
            reps: 12,
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
            id: 'decline_push_up',
            name: 'Decline Push-Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'archer_push_up',
            name: 'Archer Push-Up',
            sets: 4,
            reps: 8,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
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
            id: 'plank',
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
      icon: '💪',
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
            id: 'static_lunge',
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
            id: 'single_leg_glute_bridge',
            name: 'Single Leg Glute Bridge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['glutes'],
            secondaryMuscles: ['hamstrings'],
          ),
          WorkoutExercise(
            id: 'static_lunge',
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
            id: 'pistol_squat',
            name: 'Pistol Squat',
            sets: 4,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'jumping_lunge',
            name: 'Jumping Lunge',
            sets: 4,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
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
            id: 'walking_lunge',
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
      icon: '🦵',
    );
  }

  // HOME BODYWEIGHT BASICS - CORE
  static WorkoutPreset _getHomeCoreWorkout(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'crunch',
            name: 'Crunch',
            sets: 3,
            reps: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
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
          WorkoutExercise(
            id: 'bicycle_crunch',
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
            id: 'crunch',
            name: 'Crunch',
            sets: 4,
            reps: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'mountain_climber',
            name: 'Mountain Climber',
            sets: 4,
            reps: 0,
            timeSeconds: 40,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'bicycle_crunch',
            name: 'Bicycle Crunch',
            sets: 4,
            reps: 20,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
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
          WorkoutExercise(
            id: 'russian_twist',
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
            id: 'v_up',
            name: 'V-Up',
            sets: 4,
            reps: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'mountain_climber_crossover',
            name: 'Mountain Climber Crossover',
            sets: 4,
            reps: 0,
            timeSeconds: 45,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'bicycle_crunch',
            name: 'Bicycle Crunch',
            sets: 4,
            reps: 25,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'plank',
            name: 'Plank',
            sets: 4,
            reps: 0,
            timeSeconds: 60,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'russian_twist',
            name: 'Russian Twist',
            sets: 4,
            reps: 30,
            primaryMuscles: ['core'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'side_plank',
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
      icon: '🎯',
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
            id: 'push_up',
            name: 'Push-Up',
            sets: 1,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'mountain_climber',
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
            id: 'jump_squat',
            name: 'Jump Squat',
            sets: 1,
            reps: 12,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'push_up',
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
            id: 'static_lunge',
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
            id: 'pistol_squat',
            name: 'Pistol Squat',
            sets: 1,
            reps: 8,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'decline_push_up',
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
            id: 'jumping_lunge',
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
            id: 'mountain_climber',
            name: 'Mountain Climber',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'plank',
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
      icon: '💪',
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
            id: 'marching_in_place',
            name: 'Marching In Place',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'squat_reach',
            name: 'Squat Reach',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'incline_push_up',
            name: 'Incline Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'standing_oblique_crunch',
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
            id: 'high_knee',
            name: 'High Knee',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
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
            id: 'push_up',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
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
          WorkoutExercise(
            id: 'butt_kick',
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
            id: 'high_knee_sprint',
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
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'mountain_climber_crossover',
            name: 'Mountain Climber Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'star_jump',
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
            id: 'butt_kick_sprint',
            name: 'Butt Kick Sprint',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'mountain_climber',
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
      icon: '⚡',
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
            id: 'step_touch',
            name: 'Step Touch',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'squat_reach',
            name: 'Squat Reach',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'incline_push_up',
            name: 'Incline Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'plank_tap',
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
            id: 'jumping_jack',
            name: 'Jumping Jack',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
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
            id: 'push_up',
            name: 'Push-Up',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
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
          WorkoutExercise(
            id: 'high_knee',
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
            id: 'star_jump',
            name: 'Star Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'burpee_tuck_jump',
            name: 'Burpee Tuck Jump',
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
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'mountain_climber_crossover',
            name: 'Mountain Climber Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'high_knee_sprint',
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
            id: 'skater_hop',
            name: 'Skater Hop',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'burpee_sprawl',
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
      icon: '🔥',
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
            id: 'marching_in_place',
            name: 'Marching In Place',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'squat_reach',
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
            id: 'high_knee',
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
            id: 'mountain_climber',
            name: 'Mountain Climber',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'jump_squat',
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
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'mountain_climber_crossover',
            name: 'Mountain Climber Crossover',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'star_jump',
            name: 'Star Jump',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'burpee_tuck_jump',
            name: 'Burpee Tuck Jump',
            sets: 8,
            reps: 0,
            timeSeconds: 20,
            restSeconds: 10,
            primaryMuscles: ['full_body'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'high_knee_sprint',
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
      icon: '💥',
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
            id: 'step_touch',
            name: 'Step Touch',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'marching_in_place',
            name: 'Marching In Place',
            sets: 1,
            reps: 0,
            timeSeconds: 30,
            restSeconds: 30,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'standing_oblique_crunch',
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
            id: 'jumping_jack',
            name: 'Jumping Jack',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'high_knee',
            name: 'High Knee',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'butt_kick',
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
            id: 'star_jump',
            name: 'Star Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['cardio'],
            secondaryMuscles: [],
          ),
          WorkoutExercise(
            id: 'high_knee_sprint',
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
            id: 'tuck_jump',
            name: 'Tuck Jump',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'mountain_climber_crossover',
            name: 'Mountain Climber Crossover',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['core'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'skater_hop',
            name: 'Skater Hop',
            sets: 1,
            reps: 0,
            timeSeconds: 45,
            restSeconds: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['cardio'],
          ),
          WorkoutExercise(
            id: 'burpee_tuck_jump',
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
      icon: '💨',
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
      icon: '🍑',
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
            id: 'sumo_squat_pulse',
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
      icon: '🔥',
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
            id: 'sumo_squat_hold_pulse',
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
      icon: '💪',
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
            id: 'jumping_lunge',
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
      icon: '🍑',
    );
  }

  // HOME GIRL POWER - UPPER BODY
  static WorkoutPreset _getHomeGirlUpperBody(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'incline_push_up',
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
            id: 'push_up',
            name: 'Push-Up',
            sets: 4,
            reps: 12,
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
            id: 'decline_push_up',
            name: 'Decline Push-Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
            name: 'Diamond Push-Up',
            sets: 4,
            reps: 12,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'archer_push_up',
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
      icon: '💪',
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
            id: 'air_squat',
            name: 'Air Squat',
            sets: 3,
            reps: 15,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'incline_push_up',
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
            id: 'push_up',
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
            id: 'decline_push_up',
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
            id: 'jumping_lunge',
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
      icon: '⚡',
    );
  }

  // HOME GIRL POWER - PPL (Modified for home)
  static WorkoutPreset _getHomeGirlPPL(String difficulty) {
    List<WorkoutExercise> exercises;
    
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        exercises = [
          WorkoutExercise(
            id: 'push_up',
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
            id: 'air_squat',
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
            id: 'push_up',
            name: 'Push-Up',
            sets: 4,
            reps: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'diamond_push_up',
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
            id: 'decline_push_up',
            name: 'Decline Push-Up',
            sets: 4,
            reps: 15,
            primaryMuscles: ['chest'],
            secondaryMuscles: ['triceps'],
          ),
          WorkoutExercise(
            id: 'archer_push_up',
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
            id: 'jumping_lunge',
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
      icon: '🚀',
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
            id: 'air_squat',
            name: 'Air Squat',
            sets: 1,
            reps: 0,
            timeSeconds: 40,
            restSeconds: 20,
            primaryMuscles: ['legs'],
            secondaryMuscles: ['glutes'],
          ),
          WorkoutExercise(
            id: 'incline_push_up',
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
            id: 'push_up',
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
            id: 'decline_push_up',
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
            id: 'jumping_lunge',
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
      icon: '🔥',
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
      icon: '🦾',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'barbell_bench_press', name: 'Barbell Bench Press', sets: 4, reps: 8),
        WorkoutExercise(id: 'incline_db_press', name: 'Incline Dumbbell Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'decline_bench_press', name: 'Decline Bench Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_crossover', name: 'Cable Crossover', sets: 3, reps: 12),
        WorkoutExercise(id: 'machine_chest_fly', name: 'Machine Chest Fly', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'dumbbell_flyes', name: 'Dumbbell Flyes', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 3, reps: 15, included: false),
        WorkoutExercise(id: 'chest_dips', name: 'Chest Dips', sets: 3, reps: 10, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'gym_back',
      name: 'BACK',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: '🔙',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'deadlift', name: 'Deadlift', sets: 4, reps: 5),
        WorkoutExercise(id: 'barbell_row', name: 'Barbell Row', sets: 4, reps: 8),
        WorkoutExercise(id: 'lat_pulldown', name: 'Lat Pulldown', sets: 3, reps: 10),
        WorkoutExercise(id: 'seated_cable_row', name: 'Seated Cable Row', sets: 3, reps: 10),
        WorkoutExercise(id: 'tbar_row', name: 'T-Bar Row', sets: 3, reps: 10, included: false),
        WorkoutExercise(id: 'single_arm_db_row', name: 'Single Arm Dumbbell Row', sets: 3, reps: 10, included: false),
        WorkoutExercise(id: 'face_pulls', name: 'Face Pulls', sets: 3, reps: 15, included: false),
        WorkoutExercise(id: 'pullups', name: 'Pull-Ups', sets: 3, reps: 8, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'gym_shoulders',
      name: 'SHOULDERS',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: '💪',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'overhead_press', name: 'Overhead Press', sets: 4, reps: 8),
        WorkoutExercise(id: 'seated_db_press', name: 'Seated Dumbbell Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'arnold_press', name: 'Arnold Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'lateral_raise', name: 'Lateral Raise', sets: 3, reps: 12),
        WorkoutExercise(id: 'front_raise', name: 'Front Raise', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'reverse_fly', name: 'Reverse Fly', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'cable_lateral_raise', name: 'Cable Lateral Raise', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'barbell_shrugs', name: 'Barbell Shrugs', sets: 3, reps: 12, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'gym_legs',
      name: 'LEGS',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: '🦵',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'back_squat', name: 'Back Squat', sets: 4, reps: 8),
        WorkoutExercise(id: 'front_squat', name: 'Front Squat', sets: 4, reps: 6),
        WorkoutExercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10),
        WorkoutExercise(id: 'leg_press', name: 'Leg Press', sets: 3, reps: 12),
        WorkoutExercise(id: 'bulgarian_split_squat', name: 'Bulgarian Split Squat', sets: 3, reps: 10, included: false),
        WorkoutExercise(id: 'leg_extension', name: 'Leg Extension', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'leg_curl', name: 'Leg Curl', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'hip_thrust', name: 'Hip Thrust (GLUTE FOCUS 🍑)', sets: 4, reps: 10, included: false),
        WorkoutExercise(id: 'glute_kickback', name: 'Glute Kickback Machine (GLUTE FOCUS 🍑)', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'standing_calf_raise', name: 'Standing Calf Raise', sets: 4, reps: 15, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'gym_arms',
      name: 'ARMS',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: '💪',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'barbell_curl', name: 'Barbell Curl', sets: 3, reps: 10),
        WorkoutExercise(id: 'hammer_curl', name: 'Hammer Curl', sets: 3, reps: 10),
        WorkoutExercise(id: 'preacher_curl', name: 'Preacher Curl', sets: 3, reps: 10),
        WorkoutExercise(id: 'skull_crushers', name: 'Skull Crushers', sets: 3, reps: 10),
        WorkoutExercise(id: 'concentration_curl', name: 'Concentration Curl', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'tricep_pushdown', name: 'Tricep Pushdown', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'overhead_tricep_ext', name: 'Overhead Tricep Extension', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'close_grip_bench', name: 'Close Grip Bench Press', sets: 3, reps: 10, included: false),
        WorkoutExercise(id: 'cable_curl', name: 'Cable Curl', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'tricep_dips', name: 'Tricep Dips', sets: 3, reps: 10, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'gym_core',
      name: 'CORE',
      category: 'gym',
      subcategory: 'muscle_splits',
      icon: '🎯',
      isCircuit: false,
      exercises: [
        WorkoutExercise(id: 'cable_crunch', name: 'Cable Crunch', sets: 3, reps: 15),
        WorkoutExercise(id: 'hanging_leg_raise', name: 'Hanging Leg Raise', sets: 3, reps: 12),
        //WorkoutExercise(id: 'ab_wheel_rollout', name: 'Ab Wheel Rollout', sets: 3, reps: 10),
        WorkoutExercise(id: 'russian_twist', name: 'Russian Twist (weighted)', sets: 3, reps: 20),
        WorkoutExercise(id: 'woodchoppers', name: 'Woodchoppers', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'decline_situp', name: 'Decline Sit-Up', sets: 3, reps: 15, included: false),
        WorkoutExercise(id: 'plank', name: 'Plank', sets: 3, reps: 45, included: false),
        WorkoutExercise(id: 'side_plank', name: 'Side Plank', sets: 3, reps: 30, included: false),
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
      icon: '💪',
      isCircuit: false,
      duration: '~45 min',
      exercises: [
        WorkoutExercise(id: 'barbell_bench_press', name: 'Barbell Bench Press', sets: 4, reps: 8),
        WorkoutExercise(id: 'barbell_row', name: 'Barbell Row', sets: 4, reps: 8),
        WorkoutExercise(id: 'overhead_press', name: 'Overhead Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'lat_pulldown', name: 'Lat Pulldown', sets: 3, reps: 10),
        WorkoutExercise(id: 'lateral_raise', name: 'Lateral Raise', sets: 3, reps: 12),
        WorkoutExercise(id: 'barbell_curl', name: 'Barbell Curl', sets: 3, reps: 10),
        WorkoutExercise(id: 'tricep_pushdown', name: 'Tricep Pushdown', sets: 3, reps: 12),
      ],
    ),
    WorkoutPreset(
      id: 'gym_lower_body',
      name: 'LOWER BODY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: '🦵',
      isCircuit: false,
      duration: '~50 min',
      exercises: [
        WorkoutExercise(id: 'back_squat', name: 'Back Squat', sets: 4, reps: 8),
        WorkoutExercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10),
        WorkoutExercise(id: 'leg_press', name: 'Leg Press', sets: 3, reps: 12),
        WorkoutExercise(id: 'hip_thrust', name: 'Hip Thrust', sets: 4, reps: 10),
        WorkoutExercise(id: 'leg_extension', name: 'Leg Extension', sets: 3, reps: 12),
        WorkoutExercise(id: 'leg_curl', name: 'Leg Curl', sets: 3, reps: 12),
        WorkoutExercise(id: 'standing_calf_raise', name: 'Standing Calf Raise', sets: 4, reps: 15),
      ],
    ),
    WorkoutPreset(
      id: 'gym_push_day',
      name: 'PUSH DAY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: '⬆️',
      isCircuit: false,
      duration: '~40 min',
      exercises: [
        WorkoutExercise(id: 'barbell_bench_press', name: 'Barbell Bench Press', sets: 4, reps: 8),
        WorkoutExercise(id: 'incline_db_press', name: 'Incline Dumbbell Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'overhead_press', name: 'Overhead Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'lateral_raise', name: 'Lateral Raise', sets: 3, reps: 12),
        WorkoutExercise(id: 'tricep_pushdown', name: 'Tricep Pushdown', sets: 3, reps: 12),
        WorkoutExercise(id: 'overhead_tricep_ext', name: 'Overhead Tricep Extension', sets: 3, reps: 12),
      ],
    ),
    WorkoutPreset(
      id: 'gym_pull_day',
      name: 'PULL DAY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: '⬇️',
      isCircuit: false,
      duration: '~45 min',
      exercises: [
        WorkoutExercise(id: 'deadlift', name: 'Deadlift', sets: 4, reps: 5),
        WorkoutExercise(id: 'barbell_row', name: 'Barbell Row', sets: 4, reps: 8),
        WorkoutExercise(id: 'lat_pulldown', name: 'Lat Pulldown', sets: 3, reps: 10),
        WorkoutExercise(id: 'seated_cable_row', name: 'Seated Cable Row', sets: 3, reps: 10),
        WorkoutExercise(id: 'face_pulls', name: 'Face Pulls', sets: 3, reps: 15),
        WorkoutExercise(id: 'barbell_curl', name: 'Barbell Curl', sets: 3, reps: 10),
        WorkoutExercise(id: 'hammer_curl', name: 'Hammer Curl', sets: 3, reps: 10),
      ],
    ),
    WorkoutPreset(
      id: 'gym_full_body',
      name: 'FULL BODY',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: '💯',
      isCircuit: false,
      duration: '~50 min',
      exercises: [
        WorkoutExercise(id: 'back_squat', name: 'Back Squat', sets: 4, reps: 8),
        WorkoutExercise(id: 'barbell_bench_press', name: 'Barbell Bench Press', sets: 4, reps: 8),
        WorkoutExercise(id: 'barbell_row', name: 'Barbell Row', sets: 4, reps: 8),
        WorkoutExercise(id: 'overhead_press', name: 'Overhead Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10),
        WorkoutExercise(id: 'barbell_curl', name: 'Barbell Curl', sets: 2, reps: 12),
        WorkoutExercise(id: 'tricep_pushdown', name: 'Tricep Pushdown', sets: 2, reps: 12),
      ],
    ),
    WorkoutPreset(
      id: 'gym_glutes_legs',
      name: 'GLUTES & LEGS 🍑',
      category: 'gym',
      subcategory: 'muscle_groupings',
      icon: '🍑',
      isCircuit: false,
      duration: '~50 min',
      exercises: [
        WorkoutExercise(id: 'hip_thrust', name: 'Hip Thrust', sets: 4, reps: 10),
        WorkoutExercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', sets: 4, reps: 10),
        WorkoutExercise(id: 'bulgarian_split_squat', name: 'Bulgarian Split Squat', sets: 3, reps: 10),
        WorkoutExercise(id: 'glute_kickback', name: 'Glute Kickback Machine', sets: 3, reps: 12),
        WorkoutExercise(id: 'sumo_squat', name: 'Sumo Squat', sets: 3, reps: 12),
        WorkoutExercise(id: 'cable_pullthrough', name: 'Cable Pull-Through', sets: 3, reps: 12),
        WorkoutExercise(id: 'leg_curl', name: 'Leg Curl', sets: 3, reps: 12),
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
      icon: '⚡',
      isCircuit: true,
      rounds: 4,
      duration: '~20 min',
      exercises: [
        WorkoutExercise(id: 'barbell_squat_press', name: 'Barbell Squat to Press', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
        WorkoutExercise(id: 'renegade_rows', name: 'Renegade Rows', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
        WorkoutExercise(id: 'box_jumps', name: 'Box Jumps', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
        WorkoutExercise(id: 'battle_ropes', name: 'Battle Ropes', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
        WorkoutExercise(id: 'burpees', name: 'Burpees', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
      ],
    ),
    WorkoutPreset(
      id: 'gym_upper_burner',
      name: 'UPPER BODY BURNER',
      category: 'gym',
      subcategory: 'gym_circuits',
      icon: '🔥',
      isCircuit: true,
      rounds: 4,
      duration: '~16 min',
      exercises: [
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'dumbbell_row', name: 'Dumbbell Row', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'shoulder_press', name: 'Shoulder Press', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'bicep_curls', name: 'Bicep Curls', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'tricep_dips', name: 'Tricep Dips', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
      ],
    ),
    WorkoutPreset(
      id: 'gym_lower_torch',
      name: 'LOWER BODY TORCH',
      category: 'gym',
      subcategory: 'gym_circuits',
      icon: '🔥',
      isCircuit: true,
      rounds: 4,
      duration: '~16 min',
      exercises: [
        WorkoutExercise(id: 'goblet_squats', name: 'Goblet Squats', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'walking_lunges', name: 'Walking Lunges', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'box_stepups', name: 'Box Step-Ups', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'kettlebell_swings', name: 'Kettlebell Swings', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
      ],
    ),
    WorkoutPreset(
      id: 'gym_core_destroyer',
      name: 'CORE DESTROYER',
      category: 'gym',
      subcategory: 'gym_circuits',
      icon: '💥',
      isCircuit: true,
      rounds: 3,
      duration: '~10 min',
      exercises: [
        WorkoutExercise(id: 'cable_crunch', name: 'Cable Crunch', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        WorkoutExercise(id: 'hanging_leg_raise', name: 'Hanging Leg Raise', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        WorkoutExercise(id: 'russian_twist', name: 'Russian Twist', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        WorkoutExercise(id: 'mountain_climbers', name: 'Mountain Climbers', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        WorkoutExercise(id: 'plank_hold', name: 'Plank Hold', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
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
      icon: '🍑',
      isCircuit: false,
      duration: '~45 min',
      exercises: [
        WorkoutExercise(id: 'hip_thrust', name: 'Hip Thrust', sets: 4, reps: 12),
        WorkoutExercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 12),
        WorkoutExercise(id: 'cable_kickback', name: 'Cable Kickback', sets: 3, reps: 15),
        WorkoutExercise(id: 'sumo_squat', name: 'Sumo Squat', sets: 3, reps: 12),
        WorkoutExercise(id: 'glute_bridge_single', name: 'Glute Bridge (single leg)', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_pullthrough', name: 'Cable Pull-Through', sets: 3, reps: 15),
      ],
    ),
    WorkoutPreset(
      id: 'gym_peach_pump',
      name: 'PEACH PUMP',
      category: 'gym',
      subcategory: 'booty_builder',
      icon: '🍑',
      isCircuit: false,
      duration: '~40 min',
      exercises: [
        WorkoutExercise(id: 'barbell_hip_thrust', name: 'Barbell Hip Thrust', sets: 4, reps: 10),
        WorkoutExercise(id: 'bulgarian_split_squat', name: 'Bulgarian Split Squat', sets: 3, reps: 10),
        WorkoutExercise(id: 'sumo_deadlift', name: 'Sumo Deadlift', sets: 3, reps: 12),
        WorkoutExercise(id: 'leg_press_high', name: 'Leg Press (feet high)', sets: 3, reps: 12),
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
      icon: '🍑',
      isCircuit: false,
      duration: '~50 min',
      exercises: [
        WorkoutExercise(id: 'barbell_hip_thrust', name: 'Barbell Hip Thrust', sets: 4, reps: 10),
        WorkoutExercise(id: 'bulgarian_split_squat', name: 'Bulgarian Split Squat', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_kickback', name: 'Cable Kickback', sets: 3, reps: 15),
        WorkoutExercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 12),
        WorkoutExercise(id: 'sumo_deadlift', name: 'Sumo Deadlift', sets: 3, reps: 10, included: false),
        WorkoutExercise(id: 'cable_pullthrough', name: 'Cable Pull-Through', sets: 3, reps: 15, included: false),
        WorkoutExercise(id: 'leg_press_high', name: 'Leg Press (feet high)', sets: 3, reps: 12, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'gym_girl_upper_lower',
      name: 'UPPER/LOWER SPLIT',
      category: 'gym',
      subcategory: 'girl_power',
      icon: '💎',
      isCircuit: false,
      duration: '~45 min',
      exercises: [
        // Upper Day
        WorkoutExercise(id: 'dumbbell_bench_press', name: 'Dumbbell Bench Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'cable_row', name: 'Cable Row', sets: 3, reps: 12),
        WorkoutExercise(id: 'shoulder_press', name: 'Shoulder Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'lat_pulldown', name: 'Lat Pulldown', sets: 3, reps: 12),
        // Lower Day
        WorkoutExercise(id: 'goblet_squat', name: 'Goblet Squat', sets: 4, reps: 12, included: false),
        WorkoutExercise(id: 'walking_lunges', name: 'Walking Lunges', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'leg_curl', name: 'Leg Curl', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'hip_thrust', name: 'Hip Thrust', sets: 4, reps: 12, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'gym_girl_full_body',
      name: 'FULL BODY',
      category: 'gym',
      subcategory: 'girl_power',
      icon: '✨',
      isCircuit: false,
      duration: '~50 min',
      exercises: [
        WorkoutExercise(id: 'goblet_squat', name: 'Goblet Squat', sets: 3, reps: 12),
        WorkoutExercise(id: 'dumbbell_bench_press', name: 'Dumbbell Bench Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10),
        WorkoutExercise(id: 'shoulder_press', name: 'Shoulder Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'hip_thrust', name: 'Hip Thrust', sets: 3, reps: 12),
        WorkoutExercise(id: 'lat_pulldown', name: 'Lat Pulldown', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'cable_row', name: 'Cable Row', sets: 3, reps: 12, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'gym_girl_push_pull_legs',
      name: 'PUSH/PULL/LEGS',
      category: 'gym',
      subcategory: 'girl_power',
      icon: '🌸',
      isCircuit: false,
      duration: '~40 min',
      exercises: [
        // Push exercises
        WorkoutExercise(id: 'dumbbell_bench_press', name: 'Dumbbell Bench Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'incline_dumbbell_press', name: 'Incline Dumbbell Press', sets: 3, reps: 10),
        WorkoutExercise(id: 'lateral_raise', name: 'Lateral Raise', sets: 3, reps: 12),
        WorkoutExercise(id: 'tricep_pushdown', name: 'Tricep Pushdown', sets: 3, reps: 12),
        // Pull exercises (included: false for rotation)
        WorkoutExercise(id: 'lat_pulldown', name: 'Lat Pulldown', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'cable_row', name: 'Cable Row', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'face_pull', name: 'Face Pull', sets: 3, reps: 15, included: false),
        // Leg exercises (included: false for rotation)
        WorkoutExercise(id: 'squat', name: 'Squat', sets: 4, reps: 10, included: false),
        WorkoutExercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10, included: false),
        WorkoutExercise(id: 'leg_press', name: 'Leg Press', sets: 3, reps: 12, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'gym_girl_bro_split',
      name: 'BRO SPLIT (MODIFIED)',
      category: 'gym',
      subcategory: 'girl_power',
      icon: '👑',
      isCircuit: false,
      duration: '~45 min',
      exercises: [
        WorkoutExercise(id: 'incline_dumbbell_press', name: 'Incline Dumbbell Press', sets: 4, reps: 10),
        WorkoutExercise(id: 'cable_flye', name: 'Cable Flye', sets: 3, reps: 12),
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 2, reps: 15),
        WorkoutExercise(id: 'overhead_tricep_extension', name: 'Overhead Tricep Extension', sets: 3, reps: 12),
        WorkoutExercise(id: 'lateral_raise', name: 'Lateral Raise', sets: 3, reps: 15, included: false),
        WorkoutExercise(id: 'skull_crusher', name: 'Skull Crushers', sets: 3, reps: 10, included: false),
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
      icon: '💪',
      isCircuit: false,
      duration: '~30 min',
      exercises: [
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 3, reps: 15),
        WorkoutExercise(id: 'air_squats', name: 'Air Squats', sets: 3, reps: 20),
        WorkoutExercise(id: 'lunges', name: 'Lunges', sets: 3, reps: 12),
        //WorkoutExercise(id: 'superman_raises', name: 'Superman Raises', sets: 3, reps: 15),
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 3, reps: 15),
        WorkoutExercise(id: 'plank', name: 'Plank', sets: 3, reps: 45),
        WorkoutExercise(id: 'mountain_climbers', name: 'Mountain Climbers', sets: 3, reps: 20),
      ],
    ),
    WorkoutPreset(
      id: 'home_upper_body',
      name: 'BALANCED UPPER BODY',
      category: 'home',
      subcategory: 'bodyweight_basics',
      icon: '🦾',
      isCircuit: false,
      duration: '~25 min',
      exercises: [
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 3, reps: 15),
        //WorkoutExercise(id: 'superman_raises', name: 'Superman Raises', sets: 3, reps: 15),
        WorkoutExercise(id: 'pike_pushups', name: 'Pike Push-Ups', sets: 3, reps: 10),
        WorkoutExercise(id: 'inverted_rows', name: 'Inverted Rows (table)', sets: 3, reps: 12),
        WorkoutExercise(id: 'tricep_dips_chair', name: 'Tricep Dips (chair)', sets: 3, reps: 12),
        //WorkoutExercise(id: 'plank_shoulder_taps', name: 'Plank Shoulder Taps', sets: 3, reps: 20),
      ],
    ),
    WorkoutPreset(
      id: 'home_lower_body',
      name: 'LOWER BODY',
      category: 'home',
      subcategory: 'bodyweight_basics',
      icon: '🦵',
      isCircuit: false,
      duration: '~30 min',
      exercises: [
        WorkoutExercise(id: 'air_squats', name: 'Air Squats', sets: 4, reps: 20),
        WorkoutExercise(id: 'lunges', name: 'Lunges', sets: 3, reps: 12),
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 4, reps: 15),
        WorkoutExercise(id: 'single_leg_glute_bridge', name: 'Single Leg Glute Bridge', sets: 3, reps: 10),
        WorkoutExercise(id: 'stepups_chair', name: 'Step-Ups (chair)', sets: 3, reps: 12),
        //WorkoutExercise(id: 'wall_sit', name: 'Wall Sit', sets: 3, reps: 45),
        WorkoutExercise(id: 'calf_raises', name: 'Calf Raises', sets: 3, reps: 20),
      ],
    ),
    WorkoutPreset(
      id: 'home_core',
      name: 'CORE',
      category: 'home',
      subcategory: 'bodyweight_basics',
      icon: '🎯',
      isCircuit: false,
      duration: '~20 min',
      exercises: [
        WorkoutExercise(id: 'plank', name: 'Plank', sets: 3, reps: 45),
        WorkoutExercise(id: 'side_plank', name: 'Side Plank', sets: 3, reps: 30),
        WorkoutExercise(id: 'bicycle_crunches', name: 'Bicycle Crunches', sets: 3, reps: 20),
        WorkoutExercise(id: 'leg_raises', name: 'Leg Raises', sets: 3, reps: 15),
        WorkoutExercise(id: 'russian_twist', name: 'Russian Twist', sets: 3, reps: 20),
        WorkoutExercise(id: 'mountain_climbers', name: 'Mountain Climbers', sets: 3, reps: 20),
        WorkoutExercise(id: 'dead_bug', name: 'Dead Bug', sets: 3, reps: 12),
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
      icon: '⚡',
      isCircuit: true,
      rounds: 2,
      duration: '10 min',
      exercises: [
        WorkoutExercise(id: 'burpees', name: 'Burpees', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        WorkoutExercise(id: 'jump_squats', name: 'Jump Squats', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        WorkoutExercise(id: 'high_knees', name: 'High Knees', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
        WorkoutExercise(id: 'mountain_climbers', name: 'Mountain Climbers', sets: 1, reps: 1, timeSeconds: 30, restSeconds: 10),
      ],
    ),
    WorkoutPreset(
      id: 'home_20min_destroyer',
      name: '20 MIN DESTROYER',
      category: 'home',
      subcategory: 'hiit_circuits',
      icon: '💥',
      isCircuit: true,
      rounds: 4,
      duration: '20 min',
      exercises: [
        WorkoutExercise(id: 'burpees', name: 'Burpees', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'jump_lunges', name: 'Jump Lunges', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'squat_jumps', name: 'Squat Jumps', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
        WorkoutExercise(id: 'plank_jacks', name: 'Plank Jacks', sets: 1, reps: 1, timeSeconds: 40, restSeconds: 20),
      ],
    ),
    WorkoutPreset(
      id: 'home_tabata_torture',
      name: 'TABATA TORTURE',
      category: 'home',
      subcategory: 'hiit_circuits',
      icon: '🔥',
      isCircuit: true,
      rounds: 8,
      duration: '16 min',
      exercises: [
        WorkoutExercise(id: 'burpees', name: 'Burpees', sets: 1, reps: 1, timeSeconds: 20, restSeconds: 10),
        WorkoutExercise(id: 'mountain_climbers', name: 'Mountain Climbers', sets: 1, reps: 1, timeSeconds: 20, restSeconds: 10),
        WorkoutExercise(id: 'jump_squats', name: 'Jump Squats', sets: 1, reps: 1, timeSeconds: 20, restSeconds: 10),
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 1, reps: 1, timeSeconds: 20, restSeconds: 10),
      ],
    ),
    WorkoutPreset(
      id: 'home_cardio_blast',
      name: 'CARDIO BLAST',
      category: 'home',
      subcategory: 'hiit_circuits',
      icon: '🏃',
      isCircuit: true,
      rounds: 3,
      duration: '15 min',
      exercises: [
        WorkoutExercise(id: 'jumping_jacks', name: 'Jumping Jacks', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
        WorkoutExercise(id: 'high_knees', name: 'High Knees', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
        WorkoutExercise(id: 'butt_kicks', name: 'Butt Kicks', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
        WorkoutExercise(id: 'skaters', name: 'Skaters', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
        WorkoutExercise(id: 'burpees', name: 'Burpees', sets: 1, reps: 1, timeSeconds: 45, restSeconds: 15),
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
      icon: '🍑',
      isCircuit: false,
      duration: '~25 min',
      exercises: [
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 3, reps: 20),
        WorkoutExercise(id: 'single_leg_glute_bridge', name: 'Single Leg Glute Bridge', sets: 3, reps: 12),
        WorkoutExercise(id: 'donkey_kicks', name: 'Donkey Kicks', sets: 3, reps: 15),
        WorkoutExercise(id: 'fire_hydrants', name: 'Fire Hydrants', sets: 3, reps: 15),
        WorkoutExercise(id: 'clamshells', name: 'Clamshells', sets: 3, reps: 15),
        WorkoutExercise(id: 'frog_pumps', name: 'Frog Pumps', sets: 3, reps: 20),
      ],
    ),
    WorkoutPreset(
      id: 'home_booty_burner',
      name: 'BOOTY BURNER',
      category: 'home',
      subcategory: 'home_booty',
      icon: '🔥',
      isCircuit: false,
      duration: '~30 min',
      exercises: [
        WorkoutExercise(id: 'sumo_squat_pulse', name: 'Sumo Squat Pulse', sets: 3, reps: 20),
        WorkoutExercise(id: 'curtsy_lunges', name: 'Curtsy Lunges', sets: 3, reps: 12),
        WorkoutExercise(id: 'glute_bridge_hold', name: 'Glute Bridge Hold', sets: 3, reps: 30),
        WorkoutExercise(id: 'donkey_kick_pulses', name: 'Donkey Kick Pulses', sets: 3, reps: 20),
        WorkoutExercise(id: 'squat_to_kickback', name: 'Squat to Kick Back', sets: 3, reps: 12),
        WorkoutExercise(id: 'single_leg_deadlift', name: 'Single Leg Deadlift', sets: 3, reps: 10),
      ],
    ),
    WorkoutPreset(
      id: 'home_band_booty',
      name: 'BAND BOOTY',
      category: 'home',
      subcategory: 'home_booty',
      icon: '🍑',
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
      icon: '🍑',
      isCircuit: false,
      duration: '~35 min',
      exercises: [
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 4, reps: 15),
        WorkoutExercise(id: 'single_leg_glute_bridge', name: 'Single Leg Glute Bridge', sets: 3, reps: 10),
        WorkoutExercise(id: 'donkey_kick', name: 'Donkey Kick', sets: 3, reps: 15),
        WorkoutExercise(id: 'fire_hydrant', name: 'Fire Hydrant', sets: 3, reps: 15),
        WorkoutExercise(id: 'bulgarian_split_squat_bw', name: 'Bulgarian Split Squat', sets: 3, reps: 10, included: false),
        WorkoutExercise(id: 'side_lying_leg_raise', name: 'Side-Lying Leg Raise', sets: 3, reps: 15, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'home_girl_upper_lower',
      name: 'UPPER/LOWER SPLIT',
      category: 'home',
      subcategory: 'girl_power',
      icon: '💎',
      isCircuit: false,
      duration: '~40 min',
      exercises: [
        // Upper
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 3, reps: 12),
        WorkoutExercise(id: 'pike_pushups', name: 'Pike Push-Ups', sets: 3, reps: 10),
        //WorkoutExercise(id: 'superman_raises', name: 'Superman Raises', sets: 3, reps: 15),
        WorkoutExercise(id: 'tricep_dips_chair', name: 'Tricep Dips (chair)', sets: 3, reps: 12),
        // Lower
        WorkoutExercise(id: 'air_squats', name: 'Air Squats', sets: 4, reps: 20, included: false),
        WorkoutExercise(id: 'lunges', name: 'Lunges', sets: 3, reps: 12, included: false),
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 4, reps: 15, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'home_girl_full_body',
      name: 'FULL BODY',
      category: 'home',
      subcategory: 'girl_power',
      icon: '✨',
      isCircuit: false,
      duration: '~35 min',
      exercises: [
        WorkoutExercise(id: 'air_squats', name: 'Air Squats', sets: 3, reps: 20),
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 3, reps: 12),
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 3, reps: 15),
        //WorkoutExercise(id: 'superman_raises', name: 'Superman Raises', sets: 3, reps: 15),
        WorkoutExercise(id: 'lunges', name: 'Lunges', sets: 3, reps: 12),
        WorkoutExercise(id: 'plank', name: 'Plank', sets: 2, reps: 45, included: false),
        WorkoutExercise(id: 'mountain_climbers', name: 'Mountain Climbers', sets: 3, reps: 20, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'home_girl_push_pull_legs',
      name: 'PUSH/PULL/LEGS',
      category: 'home',
      subcategory: 'girl_power',
      icon: '🌸',
      isCircuit: false,
      duration: '~35 min',
      exercises: [
        // Push
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 3, reps: 12),
        WorkoutExercise(id: 'pike_pushups', name: 'Pike Push-Ups', sets: 3, reps: 10),
        WorkoutExercise(id: 'diamond_pushups', name: 'Diamond Push-Ups', sets: 2, reps: 10),
        // Pull
        //WorkoutExercise(id: 'superman_raises', name: 'Superman Raises', sets: 3, reps: 15, included: false),
        WorkoutExercise(id: 'inverted_rows', name: 'Inverted Rows (table)', sets: 3, reps: 10, included: false),
        // Legs
        WorkoutExercise(id: 'air_squats', name: 'Air Squats', sets: 4, reps: 20, included: false),
        WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 3, reps: 15, included: false),
      ],
    ),
    WorkoutPreset(
      id: 'home_girl_full_body_circuit',
      name: 'FULL BODY CIRCUIT',
      category: 'home',
      subcategory: 'girl_power',
      icon: '🔥',
      isCircuit: false,
      duration: '~30 min',
      exercises: [
        WorkoutExercise(id: 'pushups', name: 'Push-Ups', sets: 4, reps: 12),
        WorkoutExercise(id: 'wide_pushups', name: 'Wide Push-Ups', sets: 3, reps: 12),
        WorkoutExercise(id: 'pike_pushups', name: 'Pike Push-Ups', sets: 3, reps: 10),
        WorkoutExercise(id: 'tricep_dips_chair', name: 'Tricep Dips (chair)', sets: 3, reps: 12),
        WorkoutExercise(id: 'diamond_pushups', name: 'Diamond Push-Ups', sets: 2, reps: 10, included: false),
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
      icon: '🧘',
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
      icon: '🧘',
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
  // ALL MOVEMENT ENGINE EXERCISES - Complete list from movement_engine.dart
  // 371 singular exercise forms (no plurals) for custom workout builder
  // ═══════════════════════════════════════════════════════════════════════════
  
  static const List<Exercise> allMovementEngineExercises = [
    // ===== SQUAT PATTERN =====
    Exercise(id: 'air_squat', name: 'Air Squat', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'back_squat', name: 'Back Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'banded_lateral_walk', name: 'Banded Lateral Walk', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'banded_squat', name: 'Banded Squat', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'barbell_back_squat', name: 'Barbell Back Squat', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'barbell_squat', name: 'Barbell Squat', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'barbell_squat_press', name: 'Barbell Squat Press', difficulty: 'intermediate', equipment: 'weights'),
    //Exercise(id: 'bear_crawl', name: 'Bear Crawl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bodyweight_squat', name: 'Bodyweight Squat', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'box_jump', name: 'Box Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bulgarian_split', name: 'Bulgarian Split', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bulgarian_split_squat', name: 'Bulgarian Split Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bulgarian_split_squat_bw', name: 'Bulgarian Split Squat Bw', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'burpee', name: 'Burpee', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'burpee_sprawl', name: 'Burpee Sprawl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'burpee_tuck_jump', name: 'Burpee Tuck Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_crunch', name: 'Cable Crunch', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_crunches', name: 'Cable Crunches', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'crunch', name: 'Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'crunches', name: 'Crunches', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'curtsy_lunge', name: 'Curtsy Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'decline_situp', name: 'Decline Situp', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'decline_weighted_sit_up', name: 'Decline Weighted Sit Up', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'deficit_reverse_lunge', name: 'Deficit Reverse Lunge', difficulty: 'advanced', equipment: 'bodyweight'),
    //Exercise(id: 'fire_hydrant_pulse', name: 'Fire Hydrant Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'front_squat', name: 'Front Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'goblet_squat', name: 'Goblet Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hack_squat', name: 'Hack Squat', difficulty: 'intermediate', equipment: 'weights'),
    //Exercise(id: 'inchworm', name: 'Inchworm', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jump_lunge', name: 'Jump Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jump_squat', name: 'Jump Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jumping_jack', name: 'Jumping Jack', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jumping_lunge', name: 'Jumping Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lateral_hop', name: 'Lateral Hop', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lateral_lunge', name: 'Lateral Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'leg_press', name: 'Leg Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'leg_press_high', name: 'Leg Press High', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'lunge', name: 'Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'modified_burpee', name: 'Modified Burpee', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'overhead_squat', name: 'Overhead Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pistol_squat', name: 'Pistol Squat', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'pulse_curtsy_lunge', name: 'Pulse Curtsy Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_lunge', name: 'Reverse Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'side_lying_leg_lift', name: 'Side Lying Leg Lift', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sissy_squat', name: 'Sissy Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sit_up', name: 'Sit Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'situp', name: 'Situp', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'skater_hop', name: 'Skater Hop', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'spanish_squat', name: 'Spanish Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'split_squat', name: 'Split Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sprawl', name: 'Sprawl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat', name: 'Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_jump', name: 'Squat Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_press', name: 'Squat Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_pulse', name: 'Squat Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_reach', name: 'Squat Reach', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squat_to_kickback', name: 'Squat To Kickback', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'squats_bw', name: 'Squats Bw', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'standing_oblique_crunch', name: 'Standing Oblique Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'star_jump', name: 'Star Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'static_lunge', name: 'Static Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sumo_squat', name: 'Sumo Squat', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'sumo_squat_hold_pulse', name: 'Sumo Squat Hold Pulse', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'sumo_squat_pulse', name: 'Sumo Squat Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'thruster', name: 'Thruster', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'tuck_jump', name: 'Tuck Jump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'walking_lunge', name: 'Walking Lunge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'zercher_squat', name: 'Zercher Squat', difficulty: 'intermediate', equipment: 'bodyweight'),

    // ===== STEPUP PATTERN =====
    Exercise(id: 'box_step_up', name: 'Box Step Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'box_stepups', name: 'Box Stepups', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'step_up', name: 'Step Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'stepups_chair', name: 'Stepups Chair', difficulty: 'intermediate', equipment: 'bodyweight'),

    // ===== PUSH PATTERN =====
    //Exercise(id: 'ab_wheel', name: 'Ab Wheel', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'ab_wheel_kneeling', name: 'Ab Wheel Kneeling', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'ab_wheel_rollout', name: 'Ab Wheel Rollout', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'ab_wheel_standing', name: 'Ab Wheel Standing', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'archer_push_up', name: 'Archer Push Up', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'archer_pushup', name: 'Archer Pushup', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'arnold_press', name: 'Arnold Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_bench_press', name: 'Barbell Bench Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'barbell_front_raise', name: 'Barbell Front Raise', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'barbell_overhead_press', name: 'Barbell Overhead Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'bench_dip', name: 'Bench Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bench_press', name: 'Bench Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_chest_fly', name: 'Cable Chest Fly', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_crossover', name: 'Cable Crossover', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_fly', name: 'Cable Fly', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_flye', name: 'Cable Flye', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_lateral_raise', name: 'Cable Lateral Raise', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'chest_dips', name: 'Chest Dips', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'chest_fly', name: 'Chest Fly', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'chest_flyes', name: 'Chest Flyes', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'clap_pushup', name: 'Clap Pushup', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'close_grip_bench', name: 'Close Grip Bench', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'close_grip_bench_press', name: 'Close Grip Bench Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'close_grip_push_up', name: 'Close Grip Push Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'close_grip_pushup', name: 'Close Grip Pushup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'db_overhead_press', name: 'DB Overhead Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'decline_barbell_press', name: 'Decline Barbell Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'decline_bench_press', name: 'Decline Bench Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'decline_dumbbell_press', name: 'Decline Dumbbell Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'decline_press', name: 'Decline Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'decline_push_up', name: 'Decline Push Up', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'decline_pushup', name: 'Decline Pushup', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'diamond_push_up', name: 'Diamond Push Up', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'diamond_pushup', name: 'Diamond Pushup', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'dip', name: 'Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dip_machine', name: 'Dip Machine', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dips_chest', name: 'Dips Chest', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_bench_press', name: 'Dumbbell Bench Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_chest_fly', name: 'Dumbbell Chest Fly', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_fly', name: 'Dumbbell Fly', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_flyes', name: 'Dumbbell Flyes', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_front_raise', name: 'Dumbbell Front Raise', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_lateral_raise', name: 'Dumbbell Lateral Raise', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_press', name: 'Dumbbell Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_shoulder_press', name: 'Dumbbell Shoulder Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'front_raise', name: 'Front Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'incline_barbell_press', name: 'Incline Barbell Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'incline_bench_press', name: 'Incline Bench Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'incline_db_press', name: 'Incline DB Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'incline_dumbbell_press', name: 'Incline Dumbbell Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'incline_fly', name: 'Incline Fly', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'incline_press', name: 'Incline Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'incline_push_up', name: 'Incline Push Up', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'incline_pushup', name: 'Incline Pushup', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'jm_press', name: 'JM Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'landmine_press', name: 'Landmine Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'lateral_raise', name: 'Lateral Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'leaning_lateral_raise', name: 'Leaning Lateral Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'machine_chest_fly', name: 'Machine Chest Fly', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'machine_chest_press', name: 'Machine Chest Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'machine_fly', name: 'Machine Fly', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'machine_shoulder_press', name: 'Machine Shoulder Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'military_press', name: 'Military Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'ohp', name: 'OHP', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'overhead_press', name: 'Overhead Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pec_deck', name: 'Pec Deck', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'pike_push_ups', name: 'Pike Push Ups', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'pike_pushup', name: 'Pike Pushup', difficulty: 'advanced', equipment: 'bodyweight'),
    //Exercise(id: 'plank_shoulder_tap', name: 'Plank Shoulder Tap', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'plank_to_pushup', name: 'Plank To Pushup', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'plate_front_raise', name: 'Plate Front Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'push_press', name: 'Push Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'push_up', name: 'Push Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pushup', name: 'Pushup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'ring_dip', name: 'Ring Dip', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'seated_db_press', name: 'Seated DB Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'seated_dumbbell_press', name: 'Seated Dumbbell Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'seated_shoulder_press', name: 'Seated Shoulder Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'shoulder_press', name: 'Shoulder Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'standing_dumbbell_press', name: 'Standing Dumbbell Press', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'standing_ohp', name: 'Standing OHP', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'tricep_dip', name: 'Tricep Dip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'tricep_dips_chair', name: 'Tricep Dips Chair', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wall_push_up', name: 'Wall Push Up', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'weighted_dip', name: 'Weighted Dip', difficulty: 'advanced', equipment: 'weights'),
    Exercise(id: 'wide_pushup', name: 'Wide Pushup', difficulty: 'advanced', equipment: 'bodyweight'),

    // ===== PULL PATTERN =====
    Exercise(id: 'assisted_pull_up', name: 'Assisted Pull Up', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'barbell_bent_over_row', name: 'Barbell Bent Over Row', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'barbell_row', name: 'Barbell Row', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'barbell_shrugs', name: 'Barbell Shrugs', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'bent_over_row', name: 'Bent Over Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bent_rows', name: 'Bent Rows', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_pulldown', name: 'Cable Pulldown', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_row', name: 'Cable Row', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'chest_supported_row', name: 'Chest Supported Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'chin_up', name: 'Chin Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'chinup', name: 'Chinup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'close_grip_pullup', name: 'Close Grip Pullup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_row', name: 'Dumbbell Row', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_shrugs', name: 'Dumbbell Shrugs', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'face_pull', name: 'Face Pull', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'inverted_row', name: 'Inverted Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lat_pulldown', name: 'Lat Pulldown', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'machine_row', name: 'Machine Row', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'muscle_up', name: 'Muscle Up', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'neutral_grip_lat_pulldown', name: 'Neutral Grip Lat Pulldown', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'neutral_grip_pullup', name: 'Neutral Grip Pullup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'one_arm_row', name: 'One Arm Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pendlay_row', name: 'Pendlay Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pull_up', name: 'Pull Up', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pullup', name: 'Pullup', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'rear_delt_fly', name: 'Rear Delt Fly', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'renegade_row', name: 'Renegade Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_fly', name: 'Reverse Fly', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_flyes', name: 'Reverse Flyes', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_pec_deck', name: 'Reverse Pec Deck', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'row', name: 'Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'seated_cable_row', name: 'Seated Cable Row', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'seated_row', name: 'Seated Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'shrug', name: 'Shrug', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'single_arm_db_row', name: 'Single Arm DB Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'straight_arm_pulldown', name: 'Straight Arm Pulldown', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 't_bar_row', name: 'T-Bar Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'tbar_row', name: 'Tbar Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'upright_row', name: 'Upright Row', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'weighted_pull_up', name: 'Weighted Pull Up', difficulty: 'advanced', equipment: 'weights'),
    Exercise(id: 'wide_grip_pullup', name: 'Wide Grip Pullup', difficulty: 'intermediate', equipment: 'bodyweight'),

    // ===== HINGE PATTERN =====
    Exercise(id: 'american_swing', name: 'American Swing', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'back_extension', name: 'Back Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'banded_clamshell', name: 'Banded Clamshell', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'banded_fire_hydrant', name: 'Banded Fire Hydrant', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'banded_glute_bridge', name: 'Banded Glute Bridge', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'banded_kickback', name: 'Banded Kickback', difficulty: 'intermediate', equipment: 'bands'),
    Exercise(id: 'barbell_hip_thrust', name: 'Barbell Hip Thrust', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_kickback', name: 'Cable Kickback', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_pull_through', name: 'Cable Pull Through', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_pullthrough', name: 'Cable Pullthrough', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'conventional_deadlift', name: 'Conventional Deadlift', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'deadlift', name: 'Deadlift', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'deficit_deadlift', name: 'Deficit Deadlift', difficulty: 'advanced', equipment: 'weights'),
    Exercise(id: 'donkey_kick', name: 'Donkey Kick', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'donkey_kick_pulse', name: 'Donkey Kick Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'donkey_kicks_cable', name: 'Donkey Kicks Cable', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_rdl', name: 'Dumbbell RDL', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'elevated_glute_bridge', name: 'Elevated Glute Bridge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'fire_hydrant', name: 'Fire Hydrant', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'frog_pump', name: 'Frog Pump', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'frog_pump_hold_pulse', name: 'Frog Pump Hold Pulse', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'frog_pump_pulse', name: 'Frog Pump Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'glute_bridge', name: 'Glute Bridge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'glute_bridge_single', name: 'Glute Bridge Single', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'glute_kickback', name: 'Glute Kickback', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'good_morning', name: 'Good Morning', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hip_thrust', name: 'Hip Thrust', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hyperextension', name: 'Hyperextension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'kb_swing', name: 'KB Swing', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'kettlebell_swing', name: 'Kettlebell Swing', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'pull_through', name: 'Pull Through', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'quadruped_hip_extension', name: 'Quadruped Hip Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'quadruped_hip_extension_pulse', name: 'Quadruped Hip Extension Pulse', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'rack_pull', name: 'Rack Pull', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'rdl', name: 'RDL', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_hyper', name: 'Reverse Hyper', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'romanian_deadlift', name: 'Romanian Deadlift', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'russian_swing', name: 'Russian Swing', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'side_lying_leg_raise', name: 'Side Lying Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'single_leg_deadlift', name: 'Single Leg Deadlift', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'single_leg_glute_bridge', name: 'Single Leg Glute Bridge', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'single_leg_rdl', name: 'Single Leg RDL', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'single_leg_rdl_pulse', name: 'Single Leg RDL Pulse', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'standing_glute_kickback', name: 'Standing Glute Kickback', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'standing_glute_squeeze', name: 'Standing Glute Squeeze', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'stiff_leg_deadlift', name: 'Stiff Leg Deadlift', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'sumo_deadlift', name: 'Sumo Deadlift', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'trap_bar_deadlift', name: 'Trap Bar Deadlift', difficulty: 'intermediate', equipment: 'weights'),

    // ===== CURL PATTERN =====
    Exercise(id: '21s', name: '21s', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: '21s_curl', name: '21s Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'barbell_bicep_curl', name: 'Barbell Bicep Curl', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'barbell_curl', name: 'Barbell Curl', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'bicep_curl', name: 'Bicep Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cable_bicep_curl', name: 'Cable Bicep Curl', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_curl', name: 'Cable Curl', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_pushdown', name: 'Cable Pushdown', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'cable_tricep_extension', name: 'Cable Tricep Extension', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'concentration_curl', name: 'Concentration Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'cross_body_hammer_curl', name: 'Cross Body Hammer Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'curl', name: 'Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dumbbell_bicep_curl', name: 'Dumbbell Bicep Curl', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_curl', name: 'Dumbbell Curl', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_kickback', name: 'Dumbbell Kickback', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'ez_bar_curl', name: 'EZ Bar Curl', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'hammer_curl', name: 'Hammer Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hamstring_curl', name: 'Hamstring Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'incline_curl', name: 'Incline Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'leg_curl', name: 'Leg Curl', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'leg_extension', name: 'Leg Extension', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'lying_leg_curl', name: 'Lying Leg Curl', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'nordic_curl', name: 'Nordic Curl', difficulty: 'advanced', equipment: 'bodyweight'),
    Exercise(id: 'overhead_tricep', name: 'Overhead Tricep', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'overhead_tricep_ext', name: 'Overhead Tricep Ext', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'overhead_tricep_extension', name: 'Overhead Tricep Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'preacher_curl', name: 'Preacher Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'preacher_curl_machine', name: 'Preacher Curl Machine', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'reverse_curl', name: 'Reverse Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'reverse_wrist_curl', name: 'Reverse Wrist Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'rope_pushdown', name: 'Rope Pushdown', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'rope_tricep_extension', name: 'Rope Tricep Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'seated_hammer_curl', name: 'Seated Hammer Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'seated_leg_curl', name: 'Seated Leg Curl', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'skull_crusher', name: 'Skull Crusher', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'spider_curl', name: 'Spider Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'standing_hammer_curl', name: 'Standing Hammer Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'tricep_extension', name: 'Tricep Extension', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'tricep_kickback', name: 'Tricep Kickback', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'tricep_pushdown', name: 'Tricep Pushdown', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wrist_curl', name: 'Wrist Curl', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'zottman_curl', name: 'Zottman Curl', difficulty: 'intermediate', equipment: 'bodyweight'),

    // ===== KNEE DRIVE PATTERN =====
    Exercise(id: 'a_skip', name: 'A-Skip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'b_skip', name: 'B-Skip', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bicycle_crunch', name: 'Bicycle Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bicycle_crunches', name: 'Bicycle Crunches', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'butt_kick', name: 'Butt Kick', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'butt_kick_sprint', name: 'Butt Kick Sprint', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'dead_bug', name: 'Dead Bug', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'flutter_kick', name: 'Flutter Kick', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'hanging_leg_raise', name: 'Hanging Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'high_knee', name: 'High Knee', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'high_knee_sprint', name: 'High Knee Sprint', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'knee_tap', name: 'Knee Tap', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lateral_shuffle', name: 'Lateral Shuffle', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'leg_raise', name: 'Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'lying_leg_raise', name: 'Lying Leg Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'marching_in_place', name: 'Marching In Place', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'mountain_climber', name: 'Mountain Climber', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'mountain_climber_crossover', name: 'Mountain Climber Crossover', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'running_in_place', name: 'Running In Place', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'scissor_kick', name: 'Scissor Kick', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'side_step', name: 'Side Step', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'skater', name: 'Skater', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'step_touch', name: 'Step Touch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'v_up', name: 'V-Up', difficulty: 'intermediate', equipment: 'bodyweight'),

    // ===== HOLD PATTERN =====
    //Exercise(id: '90_90_stretch', name: '90-90 Stretch', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'active_hang', name: 'Active Hang', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'bird_dog', name: 'Bird Dog', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'butterfly_stretch', name: 'Butterfly Stretch', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'cat_cow', name: 'Cat Cow', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'chest_doorway_stretch', name: 'Chest Doorway Stretch', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'childs_pose', name: 'Childs Pose', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'clamshell', name: 'Clamshell', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'dead_hang', name: 'Dead Hang', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'forearm_plank', name: 'Forearm Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'frog_stretch', name: 'Frog Stretch', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'glute_bridge_hold', name: 'Glute Bridge Hold', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'hamstring_stretch', name: 'Hamstring Stretch', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'hang', name: 'Hang', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'happy_baby', name: 'Happy Baby', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'high_plank', name: 'High Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'hip_flexor_stretch', name: 'Hip Flexor Stretch', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'hollow_body_hold', name: 'Hollow Body Hold', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'l_sit', name: 'L-Sit', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'pigeon_pose', name: 'Pigeon Pose', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'plank', name: 'Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'plank_hold', name: 'Plank Hold', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'plank_jack', name: 'Plank Jack', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'plank_tap', name: 'Plank Tap', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'plank_walk_out', name: 'Plank Walk Out', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'quad_stretch', name: 'Quad Stretch', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'side_plank', name: 'Side Plank', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'side_plank_left', name: 'Side Plank Left', difficulty: 'beginner', equipment: 'bodyweight'),
    Exercise(id: 'side_plank_right', name: 'Side Plank Right', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'superman', name: 'Superman', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'superman_hold', name: 'Superman Hold', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'superman_raises', name: 'Superman Raises', difficulty: 'intermediate', equipment: 'bodyweight'),
    //Exercise(id: 'wall_sit', name: 'Wall Sit', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'wall_squat', name: 'Wall Squat', difficulty: 'beginner', equipment: 'bodyweight'),
    //Exercise(id: 'worlds_greatest_stretch', name: 'Worlds Greatest Stretch', difficulty: 'beginner', equipment: 'bodyweight'),

    // ===== ROTATION PATTERN =====
    Exercise(id: 'cable_wood_chop', name: 'Cable Wood Chop', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'dumbbell_woodchop', name: 'Dumbbell Woodchop', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'landmine_rotation', name: 'Landmine Rotation', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'medicine_ball_woodchop', name: 'Medicine Ball Woodchop', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'oblique_crunch', name: 'Oblique Crunch', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'oblique_crunches', name: 'Oblique Crunches', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pallof_press', name: 'Pallof Press', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pallof_press_kneeling', name: 'Pallof Press Kneeling', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pallof_press_split_stance', name: 'Pallof Press Split Stance', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'pallof_press_standing', name: 'Pallof Press Standing', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'russian_twist', name: 'Russian Twist', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'russian_twist_weighted', name: 'Russian Twist Weighted', difficulty: 'intermediate', equipment: 'weights'),
    Exercise(id: 'seated_twist', name: 'Seated Twist', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'windmill', name: 'Windmill', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'wood_chop', name: 'Wood Chop', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'woodchop', name: 'Woodchop', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'woodchoppers', name: 'Woodchoppers', difficulty: 'intermediate', equipment: 'bodyweight'),

    // ===== CALF PATTERN =====
    Exercise(id: 'calf_raise', name: 'Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'donkey_calf_raise', name: 'Donkey Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'jump_rope', name: 'Jump Rope', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'seated_calf_raise', name: 'Seated Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'single_leg_calf_raise', name: 'Single Leg Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
    Exercise(id: 'standing_calf_raise', name: 'Standing Calf Raise', difficulty: 'intermediate', equipment: 'bodyweight'),
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

