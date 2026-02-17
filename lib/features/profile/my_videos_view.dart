import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import '../../../utils/app_colors.dart';
import '../../../services/workout_recording_service.dart';
import '../../../widgets/workout_video_player.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// MY VIDEOS VIEW - Recorded Workout Videos
/// ═══════════════════════════════════════════════════════════════════════════
/// Displays all recorded workout videos in a beautiful grid.
/// Preserves all existing video functionality.
/// ═══════════════════════════════════════════════════════════════════════════

class MyVideosView extends StatefulWidget {
  const MyVideosView({super.key});

  @override
  State<MyVideosView> createState() => _MyVideosViewState();
}

class _MyVideosViewState extends State<MyVideosView> {
  List<WorkoutRecording> _recordings = [];
  bool _isLoadingRecordings = true;

  @override
  void initState() {
    super.initState();
    _loadRecordings();
  }

  Future<void> _loadRecordings() async {
    setState(() => _isLoadingRecordings = true);
    final recordings = await WorkoutRecordingService.getRecordings();
    if (mounted) {
      setState(() {
        _recordings = recordings;
        _isLoadingRecordings = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadRecordings,
      color: AppColors.cyberLime,
      backgroundColor: Colors.black,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'MY RECORDINGS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  '${_recordings.length} videos',
                  style: const TextStyle(
                    color: AppColors.white50,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Recordings Grid
            _buildRecordingsGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordingsGrid() {
    if (_isLoadingRecordings) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.cyberLime),
          ),
        ),
      );
    }

    if (_recordings.isEmpty) {
      return _buildEmptyRecordings();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: _recordings.length,
      itemBuilder: (context, index) {
        final recording = _recordings[index];
        return _buildRecordingCard(recording);
      },
    );
  }

  Widget _buildEmptyRecordings() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white10),
      ),
      child: Column(
        children: [
          Icon(
            Icons.videocam_off_outlined,
            color: AppColors.white30,
            size: 64,
          ),
          const SizedBox(height: 16),
          const Text(
            'No recordings yet',
            style: TextStyle(
              color: AppColors.white50,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Press the record button during a workout to save your session',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white40,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingCard(WorkoutRecording recording) {
    return GestureDetector(
      onTap: () async {
        HapticFeedback.mediumImpact();
        await _playRecording(recording);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.white10),
          color: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Thumbnail
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: recording.thumbnailPath != null && File(recording.thumbnailPath!).existsSync()
                    ? Image.file(
                        File(recording.thumbnailPath!),
                        fit: BoxFit.cover,
                      )
                    : Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.cyberLime.withOpacity(0.3),
                              AppColors.cyberLime.withOpacity(0.3),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
              ),
            ),
            
            // Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recording.workoutName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(recording.recordedAt),
                    style: const TextStyle(
                      color: AppColors.white50,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: AppColors.cyberLime,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDuration(recording.duration),
                        style: const TextStyle(
                          color: AppColors.cyberLime,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _playRecording(WorkoutRecording recording) async {
    // Open full-screen video player
    if (!mounted) return;

    final navigator = Navigator.of(context);
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => WorkoutVideoPlayer(
          videoPath: recording.videoPath,
          workoutName: recording.workoutName,
          onShare: () async {
            // Share video
            await WorkoutRecordingService.shareRecording(
              recording.videoPath,
              recording.workoutName,
            );
          },
          onDownload: () async {
            // Save to device gallery
            HapticFeedback.mediumImpact();
            final success = await WorkoutRecordingService.saveToDevice(
              recording.videoPath,
              recording.workoutName,
            );

            if (mounted && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    success
                        ? '✅ Saved to gallery!'
                        : '❌ Failed to save. Check permissions.',
                  ),
                  backgroundColor: success ? AppColors.cyberLime : AppColors.neonCrimson,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
        ),
        fullscreenDialog: true,
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}:${seconds.toString().padLeft(2, '0')}';
  }
}
