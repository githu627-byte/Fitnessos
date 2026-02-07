import 'package:flutter/material.dart';
import 'exercise_video_player.dart';
import 'exercise_list_thumbnail.dart';
import 'smart_exercise_media.dart';

/// Widget that displays an exercise animation
/// Now uses smart media selection based on context
class ExerciseAnimationWidget extends StatelessWidget {
  final String exerciseId;
  final double size;
  final bool showWatermark;
  final bool useVideoInList;  // NEW: Control video loading

  const ExerciseAnimationWidget({
    Key? key,
    required this.exerciseId,
    this.size = 200,
    this.showWatermark = true,
    this.useVideoInList = false,  // Default: NO video in lists
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // For small sizes (list items), use thumbnail
    if (size <= 100 && !useVideoInList) {
      return ExerciseListThumbnail(
        exerciseId: exerciseId,
        size: size,
      );
    }
    
    // For larger sizes (detail views), use video
    return ExerciseVideoPlayer(
      exerciseId: exerciseId,
      width: size,
      height: size,
      fit: BoxFit.cover,
      showWatermark: showWatermark,
    );
  }
}

/// Circular exercise animation for compact display
class ExerciseAnimationCircle extends StatelessWidget {
  final String exerciseId;
  final double size;

  const ExerciseAnimationCircle({
    Key? key,
    required this.exerciseId,
    this.size = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: ExerciseListThumbnail(  // Always use thumbnail for circles
        exerciseId: exerciseId,
        size: size,
        showBorder: false,
      ),
    );
  }
}

/// Preview size exercise animation - ONLY for detail screens
class ExerciseAnimationPreview extends StatelessWidget {
  final String exerciseId;
  final double width;
  final double height;

  const ExerciseAnimationPreview({
    Key? key,
    required this.exerciseId,
    this.width = 300,
    this.height = 300,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExerciseVideoPlayer(
      exerciseId: exerciseId,
      width: width,
      height: height,
      fit: BoxFit.contain,
      showWatermark: true,
    );
  }
}
