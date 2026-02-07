import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../services/exercise_video_service.dart';
import '../data/exercise_id_overrides_fixed.dart';

/// =============================================================================
/// EXERCISE LIST THUMBNAIL - STATIC IMAGE FOR LISTS
/// =============================================================================
/// This widget displays a static placeholder for exercises in lists.
/// It does NOT load videos - that's the key to fixing the performance issues.
/// 
/// Real apps like Hevy/Strong use static thumbnails in lists, only showing
/// video when you tap into the exercise detail screen.
/// =============================================================================

class ExerciseListThumbnail extends StatelessWidget {
  final String exerciseId;
  final double size;
  final String? exerciseName;
  final String? muscleGroup;
  final String? equipment;
  final VoidCallback? onTap;
  final bool showBorder;
  final Color? borderColor;

  const ExerciseListThumbnail({
    Key? key,
    required this.exerciseId,
    this.size = 60,
    this.exerciseName,
    this.muscleGroup,
    this.equipment,
    this.onTap,
    this.showBorder = true,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if we have a video for this exercise (for visual indicator)
    final hasVideo = ExerciseVideoService.getVideoPath(exerciseId) != null;
    
    // Get muscle group color
    final groupColor = _getMuscleGroupColor(muscleGroup);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          // Gradient background based on muscle group
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              groupColor.withOpacity(0.3),
              groupColor.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(size * 0.2),
          border: showBorder
              ? Border.all(
                  color: borderColor ?? groupColor.withOpacity(0.5),
                  width: 2,
                )
              : null,
        ),
        child: Stack(
          children: [
            // Main icon
            Center(
              child: Icon(
                _getExerciseIcon(),
                color: groupColor,
                size: size * 0.45,
              ),
            ),
            
            // Video available indicator (small play icon)
            if (hasVideo)
              Positioned(
                right: 4,
                bottom: 4,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: AppColors.cyberLime,
                    size: size * 0.18,
                  ),
                ),
              ),
            
            // Equipment indicator
            if (equipment != null)
              Positioned(
                left: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    _getEquipmentIcon(),
                    color: AppColors.white70,
                    size: size * 0.15,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  IconData _getExerciseIcon() {
    final id = exerciseId.toLowerCase();
    final name = (exerciseName ?? '').toLowerCase();
    
    // CHEST
    if (_matchesAny(id, name, ['bench', 'press', 'fly', 'chest', 'pec', 'pushup', 'push_up', 'dip'])) {
      return Icons.fitness_center;
    }
    
    // BACK
    if (_matchesAny(id, name, ['row', 'pull', 'lat', 'deadlift', 'back', 'shrug'])) {
      return Icons.straighten;
    }
    
    // SHOULDERS
    if (_matchesAny(id, name, ['shoulder', 'delt', 'raise', 'overhead', 'arnold', 'military'])) {
      return Icons.accessibility_new;
    }
    
    // LEGS
    if (_matchesAny(id, name, ['squat', 'lunge', 'leg', 'calf', 'ham', 'quad', 'glute', 'hip'])) {
      return Icons.directions_walk;
    }
    
    // ARMS
    if (_matchesAny(id, name, ['curl', 'bicep', 'tricep', 'arm', 'extension'])) {
      return Icons.sports_gymnastics;
    }
    
    // CORE
    if (_matchesAny(id, name, ['crunch', 'sit', 'plank', 'core', 'ab', 'twist', 'leg_raise'])) {
      return Icons.circle_outlined;
    }
    
    // CARDIO
    if (_matchesAny(id, name, ['burpee', 'jump', 'run', 'cardio', 'hiit', 'mountain', 'jack'])) {
      return Icons.directions_run;
    }
    
    // Default
    return Icons.fitness_center;
  }

  IconData _getEquipmentIcon() {
    final eq = (equipment ?? '').toLowerCase();
    
    if (eq.contains('barbell') || eq.contains('bar')) {
      return Icons.fitness_center;
    }
    if (eq.contains('dumbbell') || eq.contains('db')) {
      return Icons.fitness_center;
    }
    if (eq.contains('cable') || eq.contains('machine')) {
      return Icons.settings_input_component;
    }
    if (eq.contains('bodyweight') || eq.contains('body') || eq.contains('none')) {
      return Icons.accessibility_new;
    }
    if (eq.contains('band') || eq.contains('resistance')) {
      return Icons.waves;
    }
    if (eq.contains('kettlebell') || eq.contains('kb')) {
      return Icons.sports_handball;
    }
    
    return Icons.fitness_center;
  }

  Color _getMuscleGroupColor(String? group) {
    switch (group?.toLowerCase()) {
      case 'chest':
        return AppColors.neonCrimson;
      case 'back':
        return AppColors.electricCyan;
      case 'shoulders':
        return AppColors.neonOrange;
      case 'legs':
        return AppColors.neonPurple;
      case 'arms':
        return AppColors.cyberLime;
      case 'core':
        return AppColors.amber400;
      case 'cardio':
        return AppColors.rose400;
      default:
        return AppColors.cyberLime;
    }
  }

  bool _matchesAny(String id, String name, List<String> patterns) {
    for (final pattern in patterns) {
      if (id.contains(pattern) || name.contains(pattern)) {
        return true;
      }
    }
    return false;
  }
}

/// Circular variant for compact displays
class ExerciseListThumbnailCircle extends StatelessWidget {
  final String exerciseId;
  final double size;
  final String? exerciseName;
  final String? muscleGroup;
  final VoidCallback? onTap;

  const ExerciseListThumbnailCircle({
    Key? key,
    required this.exerciseId,
    this.size = 50,
    this.exerciseName,
    this.muscleGroup,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ExerciseListThumbnail(
        exerciseId: exerciseId,
        size: size,
        exerciseName: exerciseName,
        muscleGroup: muscleGroup,
        onTap: onTap,
        showBorder: false,
      ),
    );
  }
}
