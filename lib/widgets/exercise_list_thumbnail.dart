import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../utils/app_colors.dart';
import '../services/exercise_video_service.dart';

/// =============================================================================
/// EXERCISE LIST THUMBNAIL - STATIC FIRST FRAME FROM VIDEO
/// =============================================================================
/// Loads the exercise video, grabs the first frame, displays it as a static
/// image, then keeps the controller paused. No ongoing video playback.
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
  VideoPlayerController? _controller;
  bool _isReady = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadFirstFrame();
  }

  @override
  void didUpdateWidget(ExerciseListThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exerciseId != widget.exerciseId) {
      _disposeController();
      _loadFirstFrame();
    }
  }

  Future<void> _loadFirstFrame() async {
    try {
      final videoPath = ExerciseVideoService.getVideoPath(
        widget.exerciseId,
        quality: VideoQuality.high, // Only 720p videos are available
      );

      if (videoPath == null) {
        if (mounted) setState(() => _hasError = true);
        return;
      }

      _controller = VideoPlayerController.asset(videoPath);
      await _controller!.initialize();
      // Seek to frame 0 and pause — we just want the first frame
      await _controller!.seekTo(Duration.zero);
      await _controller!.pause();
      _controller!.setVolume(0);

      if (mounted) {
        setState(() => _isReady = true);
      }
    } catch (e) {
      debugPrint('Thumbnail load error for ${widget.exerciseId}: $e');
      if (mounted) setState(() => _hasError = true);
    }
  }

  void _disposeController() {
    _controller?.dispose();
    _controller = null;
    _isReady = false;
    _hasError = false;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
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
    // Show first frame of video
    if (_isReady && _controller != null && _controller!.value.isInitialized) {
      return FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller!.value.size.width,
          height: _controller!.value.size.height,
          child: VideoPlayer(_controller!),
        ),
      );
    }

    // Loading state
    if (!_hasError) {
      return Center(
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.cyberLime,
          ),
        ),
      );
    }

    // Fallback — exercise icon (for exercises with no video)
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
