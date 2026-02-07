/// Standardized exercise set data model
/// Used by all 3 workout modes (Auto, Visual Guide, Pro Logger)
class ExerciseSetData {
  final String exerciseName;
  final int setNumber;
  final double? weight; // null for bodyweight exercises
  final int repsCompleted;
  final int repsTarget;
  final double formScore; // 0-100, only from camera mode
  final int perfectReps; // only from camera mode
  final int goodReps; // only from camera mode
  final int missedReps; // only from camera mode
  final int maxCombo; // only from camera mode
  final Duration? restTime; // time between sets
  final DateTime timestamp;
  final int? durationSeconds; // how long the set took
  final String? notes;
  final List<String> primaryMuscles; // muscles targeted by this exercise

  ExerciseSetData({
    required this.exerciseName,
    required this.setNumber,
    this.weight,
    required this.repsCompleted,
    required this.repsTarget,
    this.formScore = 0.0,
    this.perfectReps = 0,
    this.goodReps = 0,
    this.missedReps = 0,
    this.maxCombo = 0,
    this.restTime,
    required this.timestamp,
    this.durationSeconds,
    this.notes,
    this.primaryMuscles = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'exercise_name': exerciseName,
      'set_number': setNumber,
      'weight': weight ?? 0.0,
      'reps_completed': repsCompleted,
      'reps_target': repsTarget,
      'form_score': formScore,
      'perfect_reps': perfectReps,
      'good_reps': goodReps,
      'missed_reps': missedReps,
      'max_combo': maxCombo,
      'timestamp': timestamp.toIso8601String(),
      'duration_seconds': durationSeconds ?? 0,
      'rest_time_seconds': restTime?.inSeconds ?? 0,
      'notes': notes,
      // NOTE: primaryMuscles is NOT persisted to DB - used only at runtime for MuscleRecoveryService
    };
  }

  factory ExerciseSetData.fromMap(Map<String, dynamic> map) {
    return ExerciseSetData(
      exerciseName: map['exercise_name'] as String,
      setNumber: map['set_number'] as int,
      weight: (map['weight'] as num?)?.toDouble(),
      repsCompleted: map['reps_completed'] as int,
      repsTarget: map['reps_target'] as int,
      formScore: (map['form_score'] as num?)?.toDouble() ?? 0.0,
      perfectReps: map['perfect_reps'] as int? ?? 0,
      goodReps: map['good_reps'] as int? ?? 0,
      missedReps: map['missed_reps'] as int? ?? 0,
      maxCombo: map['max_combo'] as int? ?? 0,
      timestamp: DateTime.parse(map['timestamp'] as String),
      durationSeconds: map['duration_seconds'] as int?,
      restTime: map['rest_time_seconds'] != null
          ? Duration(seconds: map['rest_time_seconds'] as int)
          : null,
      notes: map['notes'] as String?,
      // NOTE: primaryMuscles is NOT loaded from DB - only used at runtime
    );
  }
}
