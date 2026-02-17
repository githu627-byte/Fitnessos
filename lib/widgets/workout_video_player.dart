import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import '../utils/app_colors.dart';

/// Full-screen video player for workout recordings
class WorkoutVideoPlayer extends StatefulWidget {
  final String videoPath;
  final String workoutName;
  final VoidCallback? onShare;
  final VoidCallback? onDownload;

  const WorkoutVideoPlayer({
    Key? key,
    required this.videoPath,
    required this.workoutName,
    this.onShare,
    this.onDownload,
  }) : super(key: key);

  @override
  State<WorkoutVideoPlayer> createState() => _WorkoutVideoPlayerState();
}

class _WorkoutVideoPlayerState extends State<WorkoutVideoPlayer> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _showControls = true;
  bool _isPlaying = false;
  String _currentPosition = '0:00';
  String _duration = '0:00';
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      final file = File(widget.videoPath);
      if (!await file.exists()) {
        debugPrint('❌ Video file does not exist: ${widget.videoPath}');
        return;
      }

      _controller = VideoPlayerController.file(file);
      await _controller!.initialize();

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _duration = _formatDuration(_controller!.value.duration);
        });

        // Auto-play
        _controller!.play();
        _isPlaying = true;

        // Listen to position updates
        _controller!.addListener(_videoListener);
      }
    } catch (e) {
      debugPrint('❌ Error initializing video: $e');
    }
  }

  void _videoListener() {
    if (!mounted) return;

    final position = _controller?.value.position ?? Duration.zero;
    final duration = _controller?.value.duration ?? Duration.zero;

    setState(() {
      _currentPosition = _formatDuration(position);
      if (duration.inMilliseconds > 0) {
        _sliderValue = position.inMilliseconds / duration.inMilliseconds;
      }

      // Check if video ended
      if (position >= duration && duration.inMilliseconds > 0) {
        _isPlaying = false;
      }
    });
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _togglePlayPause() {
    if (_controller == null) return;

    HapticFeedback.mediumImpact();
    
    setState(() {
      if (_isPlaying) {
        _controller!.pause();
        _isPlaying = false;
      } else {
        _controller!.play();
        _isPlaying = true;
      }
    });
  }

  void _onSliderChanged(double value) {
    if (_controller == null) return;

    final duration = _controller!.value.duration;
    final newPosition = Duration(milliseconds: (value * duration.inMilliseconds).toInt());
    _controller!.seekTo(newPosition);
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Video player
            Center(
              child: _isInitialized && _controller != null
                  ? GestureDetector(
                      onTap: _toggleControls,
                      child: AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      ),
                    )
                  : CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColors.cyberLime),
                    ),
            ),

            // Top bar with close and share buttons
            if (_showControls)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      // Close button
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Workout name
                      Expanded(
                        child: Text(
                          widget.workoutName.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      // Share button
                      if (widget.onShare != null)
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            widget.onShare?.call();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.cyberLime.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.cyberLime,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.share,
                              color: AppColors.cyberLime,
                              size: 24,
                            ),
                          ),
                        ),
                      
                      const SizedBox(width: 12),

                      // Download button
                      if (widget.onDownload != null)
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            widget.onDownload?.call();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.cyberLime.withOpacity(0.2),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.cyberLime,
                                width: 1.5,
                              ),
                            ),
                            child: Icon(
                              Icons.download,
                              color: AppColors.cyberLime,
                              size: 24,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

            // Bottom controls
            if (_showControls && _isInitialized)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Seek bar
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 3,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                          activeTrackColor: AppColors.cyberLime,
                          inactiveTrackColor: AppColors.white30,
                          thumbColor: AppColors.cyberLime,
                          overlayColor: AppColors.cyberLime.withOpacity(0.3),
                        ),
                        child: Slider(
                          value: _sliderValue.clamp(0.0, 1.0),
                          onChanged: _onSliderChanged,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Time and play/pause
                      Row(
                        children: [
                          // Current time
                          Text(
                            _currentPosition,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          
                          const Spacer(),

                          // Play/Pause button
                          GestureDetector(
                            onTap: _togglePlayPause,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.cyberLime,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.cyberLime.withOpacity(0.5),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                color: Colors.black,
                                size: 32,
                              ),
                            ),
                          ),

                          const Spacer(),

                          // Duration
                          Text(
                            _duration,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            // Center play/pause overlay (when video is paused and controls visible)
            if (!_isPlaying && _showControls && _isInitialized)
              Center(
                child: GestureDetector(
                  onTap: _togglePlayPause,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.cyberLime,
                        width: 3,
                      ),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: AppColors.cyberLime,
                      size: 64,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

