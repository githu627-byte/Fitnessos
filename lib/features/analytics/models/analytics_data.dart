import 'package:fl_chart/fl_chart.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// ANALYTICS DATA MODEL - The Brain of Your Progress
/// ═══════════════════════════════════════════════════════════════════════════
/// This model holds ALL analytics data for the dashboard.
/// Power Level = Your total fitness score calculated from multiple factors.
/// ═══════════════════════════════════════════════════════════════════════════

class AnalyticsData {
  // ═══════════════════════════════════════════════════════════════════════════
  // HERO STATS - The Big Numbers
  // ═══════════════════════════════════════════════════════════════════════════
  final int powerLevel;
  final int currentStreak;
  final int longestStreak;
  final int totalWorkouts;
  final int totalReps;
  final double totalVolumeKg;
  final double totalHours;
  final int totalCalories;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // VOLUME DATA - For Charts
  // ═══════════════════════════════════════════════════════════════════════════
  final List<FlSpot> dailyVolumeData;
  final List<double> weeklyVolumes;
  final Map<String, double> monthlyVolumes;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // WORKOUT FREQUENCY - Heatmap Data
  // ═══════════════════════════════════════════════════════════════════════════
  final Map<DateTime, double> workoutIntensityMap; // date -> intensity (0-1)
  final Map<int, int> weekdayDistribution; // 0=Mon -> count
  final double weeklyAverage;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // PERSONAL RECORDS
  // ═══════════════════════════════════════════════════════════════════════════
  final List<PersonalRecord> recentPRs;
  final List<PersonalRecord> allTimePRs;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // BODY PART ANALYSIS - Radar Chart
  // ═══════════════════════════════════════════════════════════════════════════
  final Map<String, double> bodyPartVolumes;
  final Map<String, double> bodyPartPercentages;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // TOP EXERCISES
  // ═══════════════════════════════════════════════════════════════════════════
  final List<ExerciseVolume> topExercises;
  final Map<String, int> exerciseFrequency;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // PROGRESSION DATA - Multi-line Charts
  // ═══════════════════════════════════════════════════════════════════════════
  final Map<String, List<FlSpot>> exerciseProgressions;
  final Map<String, double> exerciseProgressPercentages; // % improvement
  
  // ═══════════════════════════════════════════════════════════════════════════
  // FORM DATA - Camera Mode Analytics
  // ═══════════════════════════════════════════════════════════════════════════
  final List<FlSpot> formScoreData;
  final int perfectReps;
  final int goodReps;
  final int missReps;
  final int formIQ;
  final double avgFormScore;
  final int longestPerfectStreak;
  
  // ═══════════════════════════════════════════════════════════════════════════
  // BODY MEASUREMENTS
  // ═══════════════════════════════════════════════════════════════════════════
  final List<BodyMeasurement> measurements;
  final List<FlSpot> weightData;
  final List<ProgressPhoto> progressPhotos;
  final Map<String, double> measurementChanges; // bodyPart -> change since start

  AnalyticsData({
    required this.powerLevel,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalWorkouts,
    required this.totalReps,
    required this.totalVolumeKg,
    required this.totalHours,
    required this.totalCalories,
    required this.dailyVolumeData,
    required this.weeklyVolumes,
    required this.monthlyVolumes,
    required this.workoutIntensityMap,
    required this.weekdayDistribution,
    required this.weeklyAverage,
    required this.recentPRs,
    required this.allTimePRs,
    required this.bodyPartVolumes,
    required this.bodyPartPercentages,
    required this.topExercises,
    required this.exerciseFrequency,
    required this.exerciseProgressions,
    required this.exerciseProgressPercentages,
    required this.formScoreData,
    required this.perfectReps,
    required this.goodReps,
    required this.missReps,
    required this.formIQ,
    required this.avgFormScore,
    required this.longestPerfectStreak,
    required this.measurements,
    required this.weightData,
    required this.progressPhotos,
    required this.measurementChanges,
  });
  
  /// ═══════════════════════════════════════════════════════════════════════════
  /// POWER LEVEL CALCULATION
  /// ═══════════════════════════════════════════════════════════════════════════
  /// Formula: Volume Score + Consistency Score + Streak Bonus + Form Bonus
  /// Max possible: 999 (but most people will be 100-400)
  /// ═══════════════════════════════════════════════════════════════════════════
  static int calculatePowerLevel({
    required double totalVolume,
    required int workoutCount,
    required int streak,
    required double avgFormScore,
    required int totalReps,
  }) {
    // Volume component (0-400 points)
    // 1 point per 500kg lifted, capped at 400
    double volumeScore = (totalVolume / 500).clamp(0, 400);
    
    // Consistency component (0-300 points)
    // 3 points per workout, capped at 300 (100 workouts)
    double consistencyScore = (workoutCount * 3).clamp(0, 300).toDouble();
    
    // Streak component (0-100 points)
    // 5 points per day streak, capped at 100 (20 day streak)
    double streakBonus = (streak * 5).clamp(0, 100).toDouble();
    
    // Form component (0-100 points)
    // Direct percentage of form score
    double formBonus = avgFormScore.clamp(0, 100);
    
    // Rep volume bonus (0-99 points)
    // 1 point per 100 reps, capped at 99
    double repBonus = (totalReps / 100).clamp(0, 99).toDouble();
    
    return (volumeScore + consistencyScore + streakBonus + formBonus + repBonus).toInt();
  }
  
  /// Get power level tier name
  static String getPowerLevelTier(int powerLevel) {
    if (powerLevel >= 800) return 'LEGENDARY';
    if (powerLevel >= 600) return 'ELITE';
    if (powerLevel >= 400) return 'ADVANCED';
    if (powerLevel >= 200) return 'INTERMEDIATE';
    if (powerLevel >= 100) return 'BEGINNER';
    return 'ROOKIE';
  }
  
  /// Get power level tier color
  static int getPowerLevelColor(int powerLevel) {
    if (powerLevel >= 800) return 0xFFFFD700; // Gold
    if (powerLevel >= 600) return 0xFFBF40FF; // Purple
    if (powerLevel >= 400) return 0xFFCCFF00; // Cyan
    if (powerLevel >= 200) return 0xFFCCFF00; // Lime
    if (powerLevel >= 100) return 0xFFFF8C00; // Orange
    return 0xFF64748B; // Gray
  }
  
  /// Empty state factory
  factory AnalyticsData.empty() {
    return AnalyticsData(
      powerLevel: 0,
      currentStreak: 0,
      longestStreak: 0,
      totalWorkouts: 0,
      totalReps: 0,
      totalVolumeKg: 0,
      totalHours: 0,
      totalCalories: 0,
      dailyVolumeData: [],
      weeklyVolumes: [],
      monthlyVolumes: {},
      workoutIntensityMap: {},
      weekdayDistribution: {},
      weeklyAverage: 0,
      recentPRs: [],
      allTimePRs: [],
      bodyPartVolumes: {},
      bodyPartPercentages: {},
      topExercises: [],
      exerciseFrequency: {},
      exerciseProgressions: {},
      exerciseProgressPercentages: {},
      formScoreData: [],
      perfectReps: 0,
      goodReps: 0,
      missReps: 0,
      formIQ: 0,
      avgFormScore: 0,
      longestPerfectStreak: 0,
      measurements: [],
      weightData: [],
      progressPhotos: [],
      measurementChanges: {},
    );
  }
  
  /// Check if there's any data
  bool get hasData => totalWorkouts > 0 || totalReps > 0;
  
  /// Check if form data exists (camera mode was used)
  bool get hasFormData => formScoreData.isNotEmpty || perfectReps > 0;
  
  /// Check if body measurements exist
  bool get hasMeasurements => measurements.isNotEmpty;
  
  /// Get total rep quality distribution
  int get totalQualityReps => perfectReps + goodReps + missReps;
  
  /// Get perfect rep percentage
  double get perfectRepPercentage {
    if (totalQualityReps == 0) return 0;
    return (perfectReps / totalQualityReps) * 100;
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// PERSONAL RECORD MODEL
/// ═══════════════════════════════════════════════════════════════════════════

class PersonalRecord {
  final String exerciseName;
  final double weight;
  final int reps;
  final DateTime date;
  final String? thumbnailPath;
  final double? e1RM; // Estimated 1 Rep Max
  final bool isAllTime;

  PersonalRecord({
    required this.exerciseName,
    required this.weight,
    required this.reps,
    required this.date,
    this.thumbnailPath,
    this.e1RM,
    this.isAllTime = false,
  });
  
  /// Calculate estimated 1 Rep Max using Epley formula
  double get estimated1RM {
    if (e1RM != null) return e1RM!;
    if (reps == 1) return weight;
    return weight * (1 + (reps / 30));
  }
  
  /// Format weight with unit
  String get formattedWeight => '${weight.toStringAsFixed(1)} kg';
  
  /// Format as "weight x reps"
  String get displayString => '${weight.toStringAsFixed(1)} kg × $reps';
  
  Map<String, dynamic> toJson() => {
    'exerciseName': exerciseName,
    'weight': weight,
    'reps': reps,
    'date': date.toIso8601String(),
    'thumbnailPath': thumbnailPath,
    'e1RM': e1RM,
    'isAllTime': isAllTime,
  };
  
  factory PersonalRecord.fromJson(Map<String, dynamic> json) {
    return PersonalRecord(
      exerciseName: json['exerciseName'] ?? '',
      weight: (json['weight'] ?? 0).toDouble(),
      reps: json['reps'] ?? 0,
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      thumbnailPath: json['thumbnailPath'],
      e1RM: json['e1RM']?.toDouble(),
      isAllTime: json['isAllTime'] ?? false,
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// EXERCISE VOLUME MODEL
/// ═══════════════════════════════════════════════════════════════════════════

class ExerciseVolume {
  final String exerciseName;
  final double totalVolume;
  final int setCount;
  final int totalReps;
  final double avgWeight;
  final String category;

  ExerciseVolume({
    required this.exerciseName,
    required this.totalVolume,
    required this.setCount,
    required this.totalReps,
    this.avgWeight = 0,
    this.category = 'Other',
  });
  
  /// Format volume with K suffix
  String get formattedVolume {
    if (totalVolume >= 1000) {
      return '${(totalVolume / 1000).toStringAsFixed(1)}K';
    }
    return totalVolume.toStringAsFixed(0);
  }
  
  /// Get volume per set
  double get volumePerSet => setCount > 0 ? totalVolume / setCount : 0;
  
  Map<String, dynamic> toJson() => {
    'exerciseName': exerciseName,
    'totalVolume': totalVolume,
    'setCount': setCount,
    'totalReps': totalReps,
    'avgWeight': avgWeight,
    'category': category,
  };
  
  factory ExerciseVolume.fromJson(Map<String, dynamic> json) {
    return ExerciseVolume(
      exerciseName: json['exerciseName'] ?? '',
      totalVolume: (json['totalVolume'] ?? 0).toDouble(),
      setCount: json['setCount'] ?? 0,
      totalReps: json['totalReps'] ?? 0,
      avgWeight: (json['avgWeight'] ?? 0).toDouble(),
      category: json['category'] ?? 'Other',
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// BODY MEASUREMENT MODEL
/// ═══════════════════════════════════════════════════════════════════════════

class BodyMeasurement {
  final String id;
  final DateTime date;
  final double? weight;
  final double? bodyFat;
  final double? chest;
  final double? arms;
  final double? forearms;
  final double? waist;
  final double? hips;
  final double? thighs;
  final double? calves;
  final double? shoulders;
  final double? neck;
  final String? notes;

  BodyMeasurement({
    required this.id,
    required this.date,
    this.weight,
    this.bodyFat,
    this.chest,
    this.arms,
    this.forearms,
    this.waist,
    this.hips,
    this.thighs,
    this.calves,
    this.shoulders,
    this.neck,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'weight': weight,
    'body_fat': bodyFat,
    'chest': chest,
    'arms': arms,
    'forearms': forearms,
    'waist': waist,
    'hips': hips,
    'thighs': thighs,
    'calves': calves,
    'shoulders': shoulders,
    'neck': neck,
    'notes': notes,
  };

  factory BodyMeasurement.fromJson(Map<String, dynamic> json) {
    return BodyMeasurement(
      id: json['id'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      weight: json['weight']?.toDouble(),
      bodyFat: json['body_fat']?.toDouble(),
      chest: json['chest']?.toDouble(),
      arms: json['arms']?.toDouble(),
      forearms: json['forearms']?.toDouble(),
      waist: json['waist']?.toDouble(),
      hips: json['hips']?.toDouble(),
      thighs: json['thighs']?.toDouble(),
      calves: json['calves']?.toDouble(),
      shoulders: json['shoulders']?.toDouble(),
      neck: json['neck']?.toDouble(),
      notes: json['notes'],
    );
  }
  
  /// Get change from previous measurement
  Map<String, double?> getChanges(BodyMeasurement? previous) {
    if (previous == null) return {};
    
    return {
      'weight': _calculateChange(weight, previous.weight),
      'bodyFat': _calculateChange(bodyFat, previous.bodyFat),
      'chest': _calculateChange(chest, previous.chest),
      'arms': _calculateChange(arms, previous.arms),
      'forearms': _calculateChange(forearms, previous.forearms),
      'waist': _calculateChange(waist, previous.waist),
      'hips': _calculateChange(hips, previous.hips),
      'thighs': _calculateChange(thighs, previous.thighs),
      'calves': _calculateChange(calves, previous.calves),
      'shoulders': _calculateChange(shoulders, previous.shoulders),
      'neck': _calculateChange(neck, previous.neck),
    };
  }
  
  double? _calculateChange(double? current, double? previous) {
    if (current == null || previous == null) return null;
    return current - previous;
  }
  
  /// Get all non-null measurements as a map
  Map<String, double> get allMeasurements {
    final map = <String, double>{};
    if (weight != null) map['Weight'] = weight!;
    if (bodyFat != null) map['Body Fat'] = bodyFat!;
    if (chest != null) map['Chest'] = chest!;
    if (arms != null) map['Arms'] = arms!;
    if (forearms != null) map['Forearms'] = forearms!;
    if (waist != null) map['Waist'] = waist!;
    if (hips != null) map['Hips'] = hips!;
    if (thighs != null) map['Thighs'] = thighs!;
    if (calves != null) map['Calves'] = calves!;
    if (shoulders != null) map['Shoulders'] = shoulders!;
    if (neck != null) map['Neck'] = neck!;
    return map;
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// PROGRESS PHOTO MODEL
/// ═══════════════════════════════════════════════════════════════════════════

class ProgressPhoto {
  final String id;
  final DateTime date;
  final String imagePath;
  final String type; // 'front', 'side', 'back', 'flexed'
  final String? associatedMeasurementId;
  final String? notes;
  final Map<String, dynamic>? metadata;

  ProgressPhoto({
    required this.id,
    required this.date,
    required this.imagePath,
    required this.type,
    this.associatedMeasurementId,
    this.notes,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'imagePath': imagePath,
    'type': type,
    'associatedMeasurementId': associatedMeasurementId,
    'notes': notes,
    'metadata': metadata,
  };

  factory ProgressPhoto.fromJson(Map<String, dynamic> json) {
    return ProgressPhoto(
      id: json['id'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      imagePath: json['imagePath'] ?? '',
      type: json['type'] ?? 'front',
      associatedMeasurementId: json['associatedMeasurementId'],
      notes: json['notes'],
      metadata: json['metadata'],
    );
  }
  
  /// Get display name for type
  String get typeDisplayName {
    switch (type) {
      case 'front': return 'Front';
      case 'side': return 'Side';
      case 'back': return 'Back';
      case 'flexed': return 'Flexed';
      default: return type;
    }
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// TIME PERIOD ENUM
/// ═══════════════════════════════════════════════════════════════════════════

enum AnalyticsPeriod {
  week,
  month,
  threeMonths,
  sixMonths,
  year,
  allTime,
}

extension AnalyticsPeriodExtension on AnalyticsPeriod {
  String get displayName {
    switch (this) {
      case AnalyticsPeriod.week: return '7D';
      case AnalyticsPeriod.month: return '30D';
      case AnalyticsPeriod.threeMonths: return '3M';
      case AnalyticsPeriod.sixMonths: return '6M';
      case AnalyticsPeriod.year: return '1Y';
      case AnalyticsPeriod.allTime: return 'ALL';
    }
  }
  
  int get days {
    switch (this) {
      case AnalyticsPeriod.week: return 7;
      case AnalyticsPeriod.month: return 30;
      case AnalyticsPeriod.threeMonths: return 90;
      case AnalyticsPeriod.sixMonths: return 180;
      case AnalyticsPeriod.year: return 365;
      case AnalyticsPeriod.allTime: return 9999;
    }
  }
}

