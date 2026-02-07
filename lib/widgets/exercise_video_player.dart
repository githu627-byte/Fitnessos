import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../services/exercise_video_service.dart';

/// A widget that plays an exercise video (MP4) in a loop
/// Replaces the old GIF-based animation
class ExerciseVideoPlayer extends StatefulWidget {
  final String exerciseId;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool showWatermark;

  const ExerciseVideoPlayer({
    Key? key,
    required this.exerciseId,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.showWatermark = true,
  }) : super(key: key);

  @override
  State<ExerciseVideoPlayer> createState() => _ExerciseVideoPlayerState();
}

class _ExerciseVideoPlayerState extends State<ExerciseVideoPlayer> {
  VideoPlayerController? _controller;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  @override
  void didUpdateWidget(ExerciseVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.exerciseId != widget.exerciseId) {
      _disposeController();
      _initializeVideo();
    }
  }

  Future<void> _initializeVideo() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      // Get video path from service
      final videoPath = ExerciseVideoService.getVideoPath(
        widget.exerciseId,
        quality: VideoQuality.high, // Use 720p
      );

      if (videoPath == null) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        return;
      }

      // Create controller for asset video
      _controller = VideoPlayerController.asset(videoPath);

      await _controller!.initialize();
      
      // Loop and play
      _controller!.setLooping(true);
      _controller!.play();

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading video for ${widget.exerciseId}: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    }
  }

  void _disposeController() {
    _controller?.pause();
    _controller?.dispose();
    _controller = null;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _buildPlaceholder(isLoading: true);
    }

    if (_hasError || _controller == null || !_controller!.value.isInitialized) {
      return _buildPlaceholder(isLoading: false);
    }

    Widget videoWidget = AspectRatio(
      aspectRatio: _controller!.value.aspectRatio,
      child: VideoPlayer(_controller!),
    );

    // Add watermark if requested
    if (widget.showWatermark) {
      videoWidget = Stack(
        children: [
          videoWidget,
          Positioned(
            bottom: 8,
            right: 8,
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                'assets/images/logo/playstore_icon.png',
                width: 32,
                height: 32,
              ),
            ),
          ),
        ],
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FittedBox(
          fit: widget.fit,
          child: SizedBox(
            width: _controller!.value.size.width,
            height: _controller!.value.size.height,
            child: videoWidget,
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder({required bool isLoading}) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white24),
              )
            : Icon(
                Icons.fitness_center,
                size: 48,
                color: Colors.white24,
              ),
      ),
    );
  }
}

