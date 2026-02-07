import 'workout_set_model.dart';
import 'workout_models.dart';

/// Model for an exercise within a workout session
/// Includes sets, rest time, and previous performance data
class ExerciseInWorkout {
  final String exerciseId;
  final String name;
  final List<WorkoutSet> sets;
  final int defaultRestSeconds;
  bool isExpanded;
  List<WorkoutSet>? previousSets; // For displaying "Previous: 185×8"
  final List<String> primaryMuscles;
  final List<String> secondaryMuscles;
  final String? gifUrl;
  final List<String>? instructions;
  final String? formTip;

  ExerciseInWorkout({
    required this.exerciseId,
    required this.name,
    required this.sets,
    this.defaultRestSeconds = 90,
    this.isExpanded = false,
    this.previousSets,
    this.primaryMuscles = const [],
    this.secondaryMuscles = const [],
    this.gifUrl,
    this.instructions,
    this.formTip,
  });

  ExerciseInWorkout copyWith({
    String? exerciseId,
    String? name,
    List<WorkoutSet>? sets,
    int? defaultRestSeconds,
    bool? isExpanded,
    List<WorkoutSet>? previousSets,
    List<String>? primaryMuscles,
    List<String>? secondaryMuscles,
    String? gifUrl,
    List<String>? instructions,
    String? formTip,
  }) {
    return ExerciseInWorkout(
      exerciseId: exerciseId ?? this.exerciseId,
      name: name ?? this.name,
      sets: sets ?? this.sets,
      defaultRestSeconds: defaultRestSeconds ?? this.defaultRestSeconds,
      isExpanded: isExpanded ?? this.isExpanded,
      previousSets: previousSets ?? this.previousSets,
      primaryMuscles: primaryMuscles ?? this.primaryMuscles,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      gifUrl: gifUrl ?? this.gifUrl,
      instructions: instructions ?? this.instructions,
      formTip: formTip ?? this.formTip,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'name': name,
      'sets': sets.map((s) => s.toJson()).toList(),
      'defaultRestSeconds': defaultRestSeconds,
      'isExpanded': isExpanded,
      'previousSets': previousSets?.map((s) => s.toJson()).toList(),
      'primaryMuscles': primaryMuscles,
      'secondaryMuscles': secondaryMuscles,
      'gifUrl': gifUrl,
      'instructions': instructions,
      'formTip': formTip,
    };
  }

  factory ExerciseInWorkout.fromJson(Map<String, dynamic> json) {
    return ExerciseInWorkout(
      exerciseId: json['exerciseId'] as String,
      name: json['name'] as String,
      sets: (json['sets'] as List)
          .map((s) => WorkoutSet.fromJson(s as Map<String, dynamic>))
          .toList(),
      defaultRestSeconds: json['defaultRestSeconds'] as int? ?? 90,
      isExpanded: json['isExpanded'] as bool? ?? false,
      previousSets: json['previousSets'] != null
          ? (json['previousSets'] as List)
              .map((s) => WorkoutSet.fromJson(s as Map<String, dynamic>))
              .toList()
          : null,
      primaryMuscles: (json['primaryMuscles'] as List?)?.cast<String>() ?? [],
      secondaryMuscles: (json['secondaryMuscles'] as List?)?.cast<String>() ?? [],
      gifUrl: json['gifUrl'] as String?,
      instructions: (json['instructions'] as List?)?.cast<String>(),
      formTip: json['formTip'] as String?,
    );
  }

  /// Factory constructor to create from WorkoutExercise
  factory ExerciseInWorkout.fromWorkoutExercise(WorkoutExercise exercise) {
    return ExerciseInWorkout(
      exerciseId: exercise.id,
      name: exercise.name,
      sets: List.generate(
        exercise.sets,
        (index) => WorkoutSet(setNumber: index + 1),
      ),
      defaultRestSeconds: exercise.restSeconds ?? 90,
      isExpanded: true,
      previousSets: null, // Will be populated from history if available
      primaryMuscles: exercise.primaryMuscles,
      secondaryMuscles: exercise.secondaryMuscles,
      gifUrl: null, // GIF is resolved dynamically using ExerciseGifService
      instructions: exercise.instructions,
      formTip: exercise.formTip,
    );
  }

  /// Get the first incomplete set index (for auto-focusing)
  int getFirstIncompleteSetIndex() {
    for (int i = 0; i < sets.length; i++) {
      if (!sets[i].isCompleted) {
        return i;
      }
    }
    return sets.length - 1;
  }

  /// Check if all sets are completed
  bool get allSetsCompleted {
    return sets.every((set) => set.isCompleted);
  }

  /// Get total volume for this exercise (weight × reps sum)
  double get totalVolume {
    return sets.fold(0.0, (sum, set) {
      if (set.isCompleted && set.weight != null && set.reps != null) {
        return sum + (set.weight! * set.reps!);
      }
      return sum;
    });
  }

  /// Get completed sets count
  int get completedSetsCount {
    return sets.where((set) => set.isCompleted).length;
  }
}

