import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// =============================================================================
/// FORM CHECK ACHIEVEMENT SERVICE
/// =============================================================================
/// Tracks user achievements and progress for viral share moments.
/// Stores personal bests, streaks, and unlocked achievements.
/// =============================================================================

enum FormAchievement {
  // First-time achievements
  firstFormCheck,        // Completed first form check
  firstPerfectRep,       // First 90%+ score
  firstEliteScore,       // First 95%+ score
  firstFlawless,         // First 98%+ score
  
  // Progress achievements
  tenPerfectReps,        // 10 perfect reps total
  fiftyPerfectReps,      // 50 perfect reps total
  hundredPerfectReps,    // 100 perfect reps total
  
  // Streak achievements
  threeInARow,           // 3 perfect reps in one session
  fiveInARow,            // 5 perfect reps in one session
  tenInARow,             // 10 perfect reps in one session
  
  // Mastery achievements (per exercise)
  squatMaster,           // 10 perfect squats
  deadliftMaster,        // 10 perfect deadlifts
  benchMaster,           // 10 perfect bench presses
  
  // Improvement achievements
  bigImprovement,        // +10% from last week
  hugeImprovement,       // +20% from last week
  
  // Consistency achievements
  threeDayStreak,        // Form check 3 days in a row
  sevenDayStreak,        // Form check 7 days in a row
  thirtyDayStreak,       // Form check 30 days in a row
}

/// User stats for an exercise
class ExerciseStats {
  final String exerciseId;
  int totalChecks;
  int totalReps;
  int perfectReps;
  int bestScore;
  int? lastScore;
  DateTime? lastCheckDate;
  List<int> recentScores; // Last 10 scores for trend
  
  ExerciseStats({
    required this.exerciseId,
    this.totalChecks = 0,
    this.totalReps = 0,
    this.perfectReps = 0,
    this.bestScore = 0,
    this.lastScore,
    this.lastCheckDate,
    this.recentScores = const [],
  });
  
  Map<String, dynamic> toJson() => {
    'exerciseId': exerciseId,
    'totalChecks': totalChecks,
    'totalReps': totalReps,
    'perfectReps': perfectReps,
    'bestScore': bestScore,
    'lastScore': lastScore,
    'lastCheckDate': lastCheckDate?.toIso8601String(),
    'recentScores': recentScores,
  };
  
  factory ExerciseStats.fromJson(Map<String, dynamic> json) => ExerciseStats(
    exerciseId: json['exerciseId'] ?? '',
    totalChecks: json['totalChecks'] ?? 0,
    totalReps: json['totalReps'] ?? 0,
    perfectReps: json['perfectReps'] ?? 0,
    bestScore: json['bestScore'] ?? 0,
    lastScore: json['lastScore'],
    lastCheckDate: json['lastCheckDate'] != null 
        ? DateTime.tryParse(json['lastCheckDate']) 
        : null,
    recentScores: List<int>.from(json['recentScores'] ?? []),
  );
  
  /// Calculate improvement percentage from recent average
  int? get improvementPercent {
    if (recentScores.length < 2) return null;
    final oldAvg = recentScores.take(recentScores.length ~/ 2).reduce((a, b) => a + b) / (recentScores.length ~/ 2);
    final newAvg = recentScores.skip(recentScores.length ~/ 2).reduce((a, b) => a + b) / (recentScores.length - recentScores.length ~/ 2);
    return ((newAvg - oldAvg) / oldAvg * 100).round();
  }
}

/// Overall user stats
class UserFormStats {
  int totalChecks;
  int totalReps;
  int totalPerfectReps;
  int currentDayStreak;
  int longestDayStreak;
  DateTime? lastCheckDate;
  List<FormAchievement> unlockedAchievements;
  Map<String, ExerciseStats> exerciseStats;
  
  UserFormStats({
    this.totalChecks = 0,
    this.totalReps = 0,
    this.totalPerfectReps = 0,
    this.currentDayStreak = 0,
    this.longestDayStreak = 0,
    this.lastCheckDate,
    this.unlockedAchievements = const [],
    this.exerciseStats = const {},
  });
  
  Map<String, dynamic> toJson() => {
    'totalChecks': totalChecks,
    'totalReps': totalReps,
    'totalPerfectReps': totalPerfectReps,
    'currentDayStreak': currentDayStreak,
    'longestDayStreak': longestDayStreak,
    'lastCheckDate': lastCheckDate?.toIso8601String(),
    'unlockedAchievements': unlockedAchievements.map((a) => a.name).toList(),
    'exerciseStats': exerciseStats.map((k, v) => MapEntry(k, v.toJson())),
  };
  
  factory UserFormStats.fromJson(Map<String, dynamic> json) => UserFormStats(
    totalChecks: json['totalChecks'] ?? 0,
    totalReps: json['totalReps'] ?? 0,
    totalPerfectReps: json['totalPerfectReps'] ?? 0,
    currentDayStreak: json['currentDayStreak'] ?? 0,
    longestDayStreak: json['longestDayStreak'] ?? 0,
    lastCheckDate: json['lastCheckDate'] != null 
        ? DateTime.tryParse(json['lastCheckDate']) 
        : null,
    unlockedAchievements: (json['unlockedAchievements'] as List? ?? [])
        .map((name) => FormAchievement.values.firstWhere(
          (a) => a.name == name,
          orElse: () => FormAchievement.firstFormCheck,
        ))
        .toList(),
    exerciseStats: (json['exerciseStats'] as Map? ?? {}).map(
      (k, v) => MapEntry(k as String, ExerciseStats.fromJson(v as Map<String, dynamic>)),
    ),
  );
}

/// Result of a form check session
class FormCheckSessionResult {
  final String exerciseId;
  final String exerciseName;
  final int score;
  final int reps;
  final int perfectReps;
  final bool isPersonalBest;
  final int? previousBest;
  final int? improvementPercent;
  final List<FormAchievement> newAchievements;
  
  FormCheckSessionResult({
    required this.exerciseId,
    required this.exerciseName,
    required this.score,
    required this.reps,
    required this.perfectReps,
    required this.isPersonalBest,
    this.previousBest,
    this.improvementPercent,
    this.newAchievements = const [],
  });
  
  /// Is this result worth sharing? (Psychology-driven)
  bool get isSharableResult {
    if (score < 85) return false;
    if (score >= 95) return true;
    if (isPersonalBest) return true;
    if (newAchievements.isNotEmpty) return true;
    if ((improvementPercent ?? 0) >= 10) return true;
    if (perfectReps >= 3) return true;
    return false;
  }
  
  /// Get share prompt text
  String get sharePromptTitle {
    if (score >= 98) return "FLAWLESS! 💎";
    if (score >= 95) return "PERFECT FORM! ⭐";
    if (isPersonalBest) return "NEW PERSONAL BEST! 🏆";
    if (newAchievements.isNotEmpty) return "ACHIEVEMENT UNLOCKED! 🎯";
    if ((improvementPercent ?? 0) >= 20) return "HUGE IMPROVEMENT! 🚀";
    if ((improvementPercent ?? 0) >= 10) return "GREAT PROGRESS! 📈";
    if (score >= 90) return "ELITE FORM! 🔥";
    return "SOLID SESSION! 💪";
  }
}

class FormCheckAchievementService {
  static const String _statsKey = 'form_check_user_stats';
  
  static UserFormStats? _cachedStats;
  
  /// Load user stats from storage
  static Future<UserFormStats> loadStats() async {
    if (_cachedStats != null) return _cachedStats!;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_statsKey);
      
      if (jsonStr != null) {
        final json = jsonDecode(jsonStr) as Map<String, dynamic>;
        _cachedStats = UserFormStats.fromJson(json);
      } else {
        _cachedStats = UserFormStats();
      }
    } catch (e) {
      debugPrint('Error loading form check stats: $e');
      _cachedStats = UserFormStats();
    }
    
    return _cachedStats!;
  }
  
  /// Save user stats to storage
  static Future<void> _saveStats() async {
    if (_cachedStats == null) return;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_statsKey, jsonEncode(_cachedStats!.toJson()));
    } catch (e) {
      debugPrint('Error saving form check stats: $e');
    }
  }
  
  /// Record a form check session and detect achievements
  static Future<FormCheckSessionResult> recordSession({
    required String exerciseId,
    required String exerciseName,
    required int score,
    required int reps,
    required int perfectReps,
  }) async {
    final stats = await loadStats();
    final newAchievements = <FormAchievement>[];
    
    // Get or create exercise stats
    final exerciseStats = stats.exerciseStats[exerciseId] ?? ExerciseStats(exerciseId: exerciseId);
    
    // Check for personal best
    final isPersonalBest = score > exerciseStats.bestScore;
    final previousBest = exerciseStats.bestScore > 0 ? exerciseStats.bestScore : null;
    
    // Calculate improvement
    final improvementPercent = exerciseStats.improvementPercent;
    
    // Update exercise stats
    exerciseStats.totalChecks++;
    exerciseStats.totalReps += reps;
    exerciseStats.perfectReps += perfectReps;
    if (isPersonalBest) exerciseStats.bestScore = score;
    exerciseStats.lastScore = score;
    exerciseStats.lastCheckDate = DateTime.now();
    
    // Update recent scores (keep last 10)
    final newRecentScores = [...exerciseStats.recentScores, score];
    if (newRecentScores.length > 10) newRecentScores.removeAt(0);
    exerciseStats.recentScores = newRecentScores;
    
    // Update global stats
    stats.totalChecks++;
    stats.totalReps += reps;
    stats.totalPerfectReps += perfectReps;
    
    // Update day streak
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    if (stats.lastCheckDate != null) {
      final lastDate = DateTime(
        stats.lastCheckDate!.year,
        stats.lastCheckDate!.month,
        stats.lastCheckDate!.day,
      );
      
      final daysDiff = today.difference(lastDate).inDays;
      
      if (daysDiff == 1) {
        stats.currentDayStreak++;
      } else if (daysDiff > 1) {
        stats.currentDayStreak = 1;
      }
      // daysDiff == 0 means same day, don't change streak
    } else {
      stats.currentDayStreak = 1;
    }
    
    if (stats.currentDayStreak > stats.longestDayStreak) {
      stats.longestDayStreak = stats.currentDayStreak;
    }
    
    stats.lastCheckDate = now;
    stats.exerciseStats[exerciseId] = exerciseStats;
    
    // Detect new achievements
    newAchievements.addAll(_detectNewAchievements(
      stats: stats,
      exerciseStats: exerciseStats,
      exerciseName: exerciseName,
      sessionScore: score,
      sessionPerfectReps: perfectReps,
      improvementPercent: improvementPercent,
    ));
    
    // Add new achievements to unlocked list
    for (final achievement in newAchievements) {
      if (!stats.unlockedAchievements.contains(achievement)) {
        stats.unlockedAchievements = [...stats.unlockedAchievements, achievement];
      }
    }
    
    // Save updated stats
    _cachedStats = stats;
    await _saveStats();
    
    return FormCheckSessionResult(
      exerciseId: exerciseId,
      exerciseName: exerciseName,
      score: score,
      reps: reps,
      perfectReps: perfectReps,
      isPersonalBest: isPersonalBest,
      previousBest: previousBest,
      improvementPercent: improvementPercent,
      newAchievements: newAchievements,
    );
  }
  
  static List<FormAchievement> _detectNewAchievements({
    required UserFormStats stats,
    required ExerciseStats exerciseStats,
    required String exerciseName,
    required int sessionScore,
    required int sessionPerfectReps,
    int? improvementPercent,
  }) {
    final newAchievements = <FormAchievement>[];
    final unlocked = stats.unlockedAchievements;
    
    // First form check
    if (stats.totalChecks == 1 && !unlocked.contains(FormAchievement.firstFormCheck)) {
      newAchievements.add(FormAchievement.firstFormCheck);
    }
    
    // First perfect rep
    if (sessionScore >= 90 && stats.totalPerfectReps > 0 && 
        stats.totalPerfectReps - sessionPerfectReps == 0 &&
        !unlocked.contains(FormAchievement.firstPerfectRep)) {
      newAchievements.add(FormAchievement.firstPerfectRep);
    }
    
    // First elite score (95%+)
    if (sessionScore >= 95 && !unlocked.contains(FormAchievement.firstEliteScore)) {
      newAchievements.add(FormAchievement.firstEliteScore);
    }
    
    // First flawless (98%+)
    if (sessionScore >= 98 && !unlocked.contains(FormAchievement.firstFlawless)) {
      newAchievements.add(FormAchievement.firstFlawless);
    }
    
    // Total perfect reps milestones
    if (stats.totalPerfectReps >= 10 && !unlocked.contains(FormAchievement.tenPerfectReps)) {
      newAchievements.add(FormAchievement.tenPerfectReps);
    }
    if (stats.totalPerfectReps >= 50 && !unlocked.contains(FormAchievement.fiftyPerfectReps)) {
      newAchievements.add(FormAchievement.fiftyPerfectReps);
    }
    if (stats.totalPerfectReps >= 100 && !unlocked.contains(FormAchievement.hundredPerfectReps)) {
      newAchievements.add(FormAchievement.hundredPerfectReps);
    }
    
    // Streak achievements (in one session)
    if (sessionPerfectReps >= 3 && !unlocked.contains(FormAchievement.threeInARow)) {
      newAchievements.add(FormAchievement.threeInARow);
    }
    if (sessionPerfectReps >= 5 && !unlocked.contains(FormAchievement.fiveInARow)) {
      newAchievements.add(FormAchievement.fiveInARow);
    }
    if (sessionPerfectReps >= 10 && !unlocked.contains(FormAchievement.tenInARow)) {
      newAchievements.add(FormAchievement.tenInARow);
    }
    
    // Exercise mastery
    final normalizedName = exerciseName.toLowerCase();
    if (exerciseStats.perfectReps >= 10) {
      if (normalizedName.contains('squat') && !unlocked.contains(FormAchievement.squatMaster)) {
        newAchievements.add(FormAchievement.squatMaster);
      }
      if (normalizedName.contains('deadlift') && !unlocked.contains(FormAchievement.deadliftMaster)) {
        newAchievements.add(FormAchievement.deadliftMaster);
      }
      if (normalizedName.contains('bench') && !unlocked.contains(FormAchievement.benchMaster)) {
        newAchievements.add(FormAchievement.benchMaster);
      }
    }
    
    // Improvement achievements
    if (improvementPercent != null) {
      if (improvementPercent >= 10 && !unlocked.contains(FormAchievement.bigImprovement)) {
        newAchievements.add(FormAchievement.bigImprovement);
      }
      if (improvementPercent >= 20 && !unlocked.contains(FormAchievement.hugeImprovement)) {
        newAchievements.add(FormAchievement.hugeImprovement);
      }
    }
    
    // Day streak achievements
    if (stats.currentDayStreak >= 3 && !unlocked.contains(FormAchievement.threeDayStreak)) {
      newAchievements.add(FormAchievement.threeDayStreak);
    }
    if (stats.currentDayStreak >= 7 && !unlocked.contains(FormAchievement.sevenDayStreak)) {
      newAchievements.add(FormAchievement.sevenDayStreak);
    }
    if (stats.currentDayStreak >= 30 && !unlocked.contains(FormAchievement.thirtyDayStreak)) {
      newAchievements.add(FormAchievement.thirtyDayStreak);
    }
    
    return newAchievements;
  }
  
  /// Get user's personal best for an exercise
  static Future<int?> getPersonalBest(String exerciseId) async {
    final stats = await loadStats();
    final exerciseStats = stats.exerciseStats[exerciseId];
    return exerciseStats?.bestScore;
  }
  
  /// Get user's stats for an exercise
  static Future<ExerciseStats?> getExerciseStats(String exerciseId) async {
    final stats = await loadStats();
    return stats.exerciseStats[exerciseId];
  }
  
  /// Get all unlocked achievements
  static Future<List<FormAchievement>> getUnlockedAchievements() async {
    final stats = await loadStats();
    return stats.unlockedAchievements;
  }
  
  /// Get achievement display info
  static AchievementInfo getAchievementInfo(FormAchievement achievement) {
    switch (achievement) {
      case FormAchievement.firstFormCheck:
        return AchievementInfo(
          title: "First Check",
          description: "Completed your first form check",
          icon: "🎯",
          rarity: AchievementRarity.common,
        );
      case FormAchievement.firstPerfectRep:
        return AchievementInfo(
          title: "Perfect Start",
          description: "Hit your first 90%+ form score",
          icon: "⭐",
          rarity: AchievementRarity.common,
        );
      case FormAchievement.firstEliteScore:
        return AchievementInfo(
          title: "Elite Form",
          description: "Achieved 95%+ form score",
          icon: "🔥",
          rarity: AchievementRarity.rare,
        );
      case FormAchievement.firstFlawless:
        return AchievementInfo(
          title: "Flawless",
          description: "Achieved 98%+ form score",
          icon: "💎",
          rarity: AchievementRarity.legendary,
        );
      case FormAchievement.tenPerfectReps:
        return AchievementInfo(
          title: "Getting Consistent",
          description: "10 perfect reps total",
          icon: "🏅",
          rarity: AchievementRarity.common,
        );
      case FormAchievement.fiftyPerfectReps:
        return AchievementInfo(
          title: "Form Veteran",
          description: "50 perfect reps total",
          icon: "🥈",
          rarity: AchievementRarity.rare,
        );
      case FormAchievement.hundredPerfectReps:
        return AchievementInfo(
          title: "Form Master",
          description: "100 perfect reps total",
          icon: "🥇",
          rarity: AchievementRarity.epic,
        );
      case FormAchievement.threeInARow:
        return AchievementInfo(
          title: "Hat Trick",
          description: "3 perfect reps in one session",
          icon: "🎩",
          rarity: AchievementRarity.common,
        );
      case FormAchievement.fiveInARow:
        return AchievementInfo(
          title: "High Five",
          description: "5 perfect reps in one session",
          icon: "🖐️",
          rarity: AchievementRarity.rare,
        );
      case FormAchievement.tenInARow:
        return AchievementInfo(
          title: "Perfect Ten",
          description: "10 perfect reps in one session",
          icon: "💯",
          rarity: AchievementRarity.epic,
        );
      case FormAchievement.squatMaster:
        return AchievementInfo(
          title: "Squat Master",
          description: "10 perfect squat reps",
          icon: "🦵",
          rarity: AchievementRarity.rare,
        );
      case FormAchievement.deadliftMaster:
        return AchievementInfo(
          title: "Deadlift Master",
          description: "10 perfect deadlift reps",
          icon: "💪",
          rarity: AchievementRarity.rare,
        );
      case FormAchievement.benchMaster:
        return AchievementInfo(
          title: "Bench Master",
          description: "10 perfect bench press reps",
          icon: "🏋️",
          rarity: AchievementRarity.rare,
        );
      case FormAchievement.bigImprovement:
        return AchievementInfo(
          title: "Level Up",
          description: "+10% improvement from last week",
          icon: "📈",
          rarity: AchievementRarity.common,
        );
      case FormAchievement.hugeImprovement:
        return AchievementInfo(
          title: "Breakthrough",
          description: "+20% improvement from last week",
          icon: "🚀",
          rarity: AchievementRarity.rare,
        );
      case FormAchievement.threeDayStreak:
        return AchievementInfo(
          title: "Getting Started",
          description: "3 day form check streak",
          icon: "🌱",
          rarity: AchievementRarity.common,
        );
      case FormAchievement.sevenDayStreak:
        return AchievementInfo(
          title: "One Week Strong",
          description: "7 day form check streak",
          icon: "🔥",
          rarity: AchievementRarity.rare,
        );
      case FormAchievement.thirtyDayStreak:
        return AchievementInfo(
          title: "Unstoppable",
          description: "30 day form check streak",
          icon: "👑",
          rarity: AchievementRarity.legendary,
        );
    }
  }
}

enum AchievementRarity {
  common,    // Gray/white
  rare,      // Blue/cyan
  epic,      // Purple
  legendary, // Gold/lime
}

class AchievementInfo {
  final String title;
  final String description;
  final String icon;
  final AchievementRarity rarity;
  
  AchievementInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.rarity,
  });
  
  Color get color {
    switch (rarity) {
      case AchievementRarity.common:
        return const Color(0xFF888888);
      case AchievementRarity.rare:
        return const Color(0xFF00F0FF);
      case AchievementRarity.epic:
        return const Color(0xFFAA66FF);
      case AchievementRarity.legendary:
        return const Color(0xFFCCFF00);
    }
  }
}
