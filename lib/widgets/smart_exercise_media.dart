import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../utils/app_colors.dart';
import '../services/exercise_video_service.dart';
import 'exercise_list_thumbnail.dart';

/// =============================================================================
/// SMART EXERCISE MEDIA - CONTEXT-AWARE VIDEO/THUMBNAIL WIDGET
/// =============================================================================
/// 
/// This widget intelligently chooses what to display:
/// - In LISTS: Shows static thumbnail (no video loading)
/// - In DETAIL views: Shows video player
/// 
/// Usage:
/// ```dart
/// // In a list - will show thumbnail
/// SmartExerciseMedia(
///   exerciseId: 'bench_press',
///   size: 60,
///   context: ExerciseMediaContext.list,
/// )
/// 
/// // In detail view - will show video
/// SmartExerciseMedia(
///   exerciseId: 'bench_press',
///   size: 300,
///   context: ExerciseMediaContext.detail,
/// )
/// ```
/// =============================================================================

enum ExerciseMediaContext {
  /// List context - uses static thumbnail (no video)
  list,
  
  /// Detail view - loads and plays video
  detail,
  
  /// Preview - loads video but smaller
  preview,
  
  /// Hero - large detail view with controls
  hero,
}

class SmartExerciseMedia extends StatefulWidget {
  final String exerciseId;
  final double size;
  final ExerciseMediaContext mediaContext;
  final String? exerciseName;
  final String? muscleGroup;
  final String? equipment;
  final VoidCallback? onTap;
  final bool showWatermark;
  final BoxFit fit;

  const SmartExerciseMedia({
    Key? key,
    required this.exerciseId,
    this.size = 60,
    this.mediaContext = ExerciseMediaContext.list,
    this.exerciseName,
    this.muscleGroup,
    this.equipment,
    this.onTap,
    this.showWatermark = false,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  State<SmartExerciseMedia> createState() => _SmartExerciseMediaState();
}

class _SmartExerciseMediaState extends State<SmartExerciseMedia> {
  VideoPlayerController? _controller;
  bool _isLoading = false;
  bool _hasError = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Only load video for detail/preview/hero contexts
    if (_shouldLoadVideo()) {
      _initializeVideo();
    }
  }

  @override
  void didUpdateWidget(SmartExerciseMedia oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exerciseId != widget.exerciseId) {
      _disposeController();
      if (_shouldLoadVideo()) {
        _initializeVideo();
      }
    }
  }

  bool _shouldLoadVideo() {
    return widget.mediaContext != ExerciseMediaContext.list;
  }

  Future<void> _initializeVideo() async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final videoPath = ExerciseVideoService.getVideoPath(
        widget.exerciseId,
        quality: _getQualityForContext(),
      );

      if (videoPath == null) {
        debugPrint('⚠️ No video found for: ${widget.exerciseId}');
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        return;
      }

      debugPrint('🎬 Loading video: $videoPath');
      _controller = VideoPlayerController.asset(videoPath);

      await _controller!.initialize();
      _controller!.setLooping(true);
      _controller!.setVolume(0); // Silent
      _controller!.play();

      if (mounted) {
        setState(() {
          _isLoading = false;
          _isInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('❌ Video load error for ${widget.exerciseId}: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  VideoQuality _getQualityForContext() {
    switch (widget.mediaContext) {
      case ExerciseMediaContext.list:
        return VideoQuality.low; // Won't be used, but just in case
      case ExerciseMediaContext.preview:
        return VideoQuality.medium;
      case ExerciseMediaContext.detail:
      case ExerciseMediaContext.hero:
        return VideoQuality.high;
    }
  }

  void _disposeController() {
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
    _isInitialized = false;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // LIST CONTEXT: Always show static thumbnail
    if (widget.mediaContext == ExerciseMediaContext.list) {
      return ExerciseListThumbnail(
        exerciseId: widget.exerciseId,
        size: widget.size,
        exerciseName: widget.exerciseName,
        muscleGroup: widget.muscleGroup,
        equipment: widget.equipment,
        onTap: widget.onTap,
      );
    }

    // DETAIL/PREVIEW/HERO: Show video if available, otherwise fallback
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(widget.size * 0.1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.size * 0.1),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    // Loading state
    if (_isLoading) {
      return _buildLoadingState();
    }

    // Error or no video - show enhanced fallback
    if (_hasError || !_isInitialized || _controller == null) {
      return _buildFallbackState();
    }

    // Video ready - show it
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video
        FittedBox(
          fit: widget.fit,
          child: SizedBox(
            width: _controller!.value.size.width,
            height: _controller!.value.size.height,
            child: VideoPlayer(_controller!),
          ),
        ),
        
        // Watermark (optional)
        if (widget.showWatermark)
          Positioned(
            right: 8,
            bottom: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo/playstore_icon.png',
                    width: 16,
                    height: 16,
                    errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Skelatal-PT',
                    style: TextStyle(
                      color: AppColors.cyberLime,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Container(
      color: AppColors.white5,
      child: Center(
        child: SizedBox(
          width: widget.size * 0.3,
          height: widget.size * 0.3,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(AppColors.cyberLime),
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackState() {
    // Use the thumbnail as fallback for detail views too
    return Stack(
      fit: StackFit.expand,
      children: [
        // Thumbnail background
        ExerciseListThumbnail(
          exerciseId: widget.exerciseId,
          size: widget.size,
          exerciseName: widget.exerciseName,
          muscleGroup: widget.muscleGroup,
          equipment: widget.equipment,
          showBorder: false,
        ),
        
        // "No Video" indicator for detail contexts
        if (widget.mediaContext != ExerciseMediaContext.list)
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'VIDEO COMING SOON',
                style: TextStyle(
                  color: AppColors.white60,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

/// =============================================================================
/// CONVENIENCE WIDGETS
/// =============================================================================

/// For use in exercise lists (cards, grids, etc)
class ExerciseMediaForList extends StatelessWidget {
  final String exerciseId;
  final double size;
  final String? exerciseName;
  final String? muscleGroup;
  final String? equipment;
  final VoidCallback? onTap;

  const ExerciseMediaForList({
    Key? key,
    required this.exerciseId,
    this.size = 60,
    this.exerciseName,
    this.muscleGroup,
    this.equipment,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartExerciseMedia(
      exerciseId: exerciseId,
      size: size,
      mediaContext: ExerciseMediaContext.list,
      exerciseName: exerciseName,
      muscleGroup: muscleGroup,
      equipment: equipment,
      onTap: onTap,
    );
  }
}

/// For use in exercise detail screens
class ExerciseMediaForDetail extends StatelessWidget {
  final String exerciseId;
  final double width;
  final double height;
  final String? exerciseName;
  final String? muscleGroup;
  final bool showWatermark;

  const ExerciseMediaForDetail({
    Key? key,
    required this.exerciseId,
    this.width = 300,
    this.height = 300,
    this.exerciseName,
    this.muscleGroup,
    this.showWatermark = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SmartExerciseMedia(
        exerciseId: exerciseId,
        size: height,
        mediaContext: ExerciseMediaContext.detail,
        exerciseName: exerciseName,
        muscleGroup: muscleGroup,
        showWatermark: showWatermark,
        fit: BoxFit.contain,
      ),
    );
  }
}
