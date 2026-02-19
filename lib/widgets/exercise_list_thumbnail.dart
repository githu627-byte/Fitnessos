import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../services/exercise_video_service.dart';

/// =============================================================================
/// EXERCISE LIST THUMBNAIL - STATIC WebP IMAGE FROM PRE-GENERATED THUMBNAILS
/// =============================================================================
/// Uses pre-generated WebP thumbnail images instead of VideoPlayerController.
/// This avoids the hardware video decoder limit (2-16 concurrent instances)
/// that caused random thumbnail load failures when showing multiple exercises.
/// =============================================================================

class ExerciseListThumbnail extends StatefulWidget {
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
  State<ExerciseListThumbnail> createState() => _ExerciseListThumbnailState();
}

class _ExerciseListThumbnailState extends State<ExerciseListThumbnail> {
  String? _thumbnailPath;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _thumbnailPath = ExerciseVideoService.getThumbnailPath(widget.exerciseId);
    if (_thumbnailPath == null) _hasError = true;
  }

  @override
  void didUpdateWidget(ExerciseListThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exerciseId != widget.exerciseId) {
      _thumbnailPath = ExerciseVideoService.getThumbnailPath(widget.exerciseId);
      _hasError = _thumbnailPath == null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: AppColors.white10,
          borderRadius: BorderRadius.circular(widget.size * 0.2),
          border: widget.showBorder
              ? Border.all(
                  color: widget.borderColor ??
                      AppColors.cyberLime.withOpacity(0.3),
                  width: 1,
                )
              : null,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.size * 0.2),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (!_hasError && _thumbnailPath != null) {
      return Image.asset(
        _thumbnailPath!,
        width: widget.size,
        height: widget.size,
        fit: BoxFit.cover,
        cacheWidth: (widget.size * MediaQuery.of(context).devicePixelRatio).toInt(),
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback();
        },
      );
    }
    return _buildFallback();
  }

  Widget _buildFallback() {
    return Center(
      child: Icon(
        Icons.fitness_center,
        color: AppColors.white40,
        size: widget.size * 0.4,
      ),
    );
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
