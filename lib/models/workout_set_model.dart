/// Model for a single set in a workout
class WorkoutSet {
  final int setNumber;
  double? weight;
  int? reps;
  bool isCompleted;
  DateTime? completedAt;
  String? notes;
  SetType type;

  WorkoutSet({
    required this.setNumber,
    this.weight,
    this.reps,
    this.isCompleted = false,
    this.completedAt,
    this.notes,
    this.type = SetType.normal,
  });

  WorkoutSet copyWith({
    int? setNumber,
    double? weight,
    int? reps,
    bool? isCompleted,
    DateTime? completedAt,
    String? notes,
    SetType? type,
  }) {
    return WorkoutSet(
      setNumber: setNumber ?? this.setNumber,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      notes: notes ?? this.notes,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'setNumber': setNumber,
      'weight': weight,
      'reps': reps,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
      'notes': notes,
      'type': type.name,
    };
  }

  factory WorkoutSet.fromJson(Map<String, dynamic> json) {
    return WorkoutSet(
      setNumber: json['setNumber'] as int,
      weight: json['weight'] as double?,
      reps: json['reps'] as int?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt'] as String)
          : null,
      notes: json['notes'] as String?,
      type: SetType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => SetType.normal,
      ),
    );
  }
}

enum SetType {
  normal,
  warmup,
  drop,
  failure,
}

