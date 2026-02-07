import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_screen_recording/flutter_screen_recording.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gal/gal.dart';
import 'workout_recording_service.dart';

/// Service for recording the screen during workouts
/// Captures the camera preview WITH skeleton overlay
class ScreenRecordingService {
  static bool _isRecording = false;
  static DateTime? _startTime;

  /// Check if currently recording
  static bool get isRecording => _isRecording;

  /// Request necessary permissions for screen recording
  static Future<bool> requestPermissions() async {
    // Request microphone permission (for audio in recording)
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      debugPrint('⚠️ Microphone permission denied - recording without audio');
    }

    // Request storage permission for saving
    if (Platform.isAndroid) {
      final storageStatus = await Permission.storage.request();
      if (!storageStatus.isGranted) {
        // Try media permissions for Android 13+
        await Permission.photos.request();
        await Permission.videos.request();
      }
    }

    return true; // Screen recording permission is requested via system dialog
  }

  /// Start screen recording
  /// Returns true if recording started successfully
  static Future<bool> startRecording({String? title}) async {
    if (_isRecording) {
      debugPrint('⚠️ Already recording');
      return false;
    }

    try {
      await requestPermissions();

      final fileName = title ?? "workout_${DateTime.now().millisecondsSinceEpoch}";

      // Try recording with audio first (v2.0.24 API)
      bool started = false;
      try {
        started = await FlutterScreenRecording.startRecordScreenAndAudio(fileName);
      } catch (e) {
        debugPrint('⚠️ Audio recording failed, trying without audio: $e');
        // Fallback to screen only
        started = await FlutterScreenRecording.startRecordScreen(fileName);
      }

      if (started) {
        _isRecording = true;
        _startTime = DateTime.now();
        debugPrint('🎥 Screen recording started');
        return true;
      } else {
        debugPrint('❌ Failed to start screen recording');
        return false;
      }
    } catch (e) {
      debugPrint('❌ Error starting screen recording: $e');
      return false;
    }
  }

  /// Stop screen recording and save the video
  /// Returns the path to the saved video, or null if failed
  static Future<String?> stopRecording({required String workoutName}) async {
    if (!_isRecording) {
      debugPrint('⚠️ Not currently recording');
      return null;
    }

    try {
      final videoPath = await FlutterScreenRecording.stopRecordScreen;
      _isRecording = false;

      if (videoPath == null || videoPath.isEmpty) {
        debugPrint('❌ No video path returned from screen recording');
        return null;
      }

      debugPrint('🎥 Screen recording stopped: $videoPath');

      // Calculate duration
      final duration = _startTime != null
          ? DateTime.now().difference(_startTime!)
          : const Duration(seconds: 0);
      _startTime = null;

      // Save to gallery first
      try {
        await Gal.putVideo(videoPath);
        debugPrint('✅ Video saved to gallery');
      } catch (e) {
        debugPrint('⚠️ Could not save to gallery: $e');
      }

      // Save to our persistent storage
      final savedPath = await WorkoutRecordingService.saveRecording(
        workoutName: workoutName,
        videoPath: videoPath,
        duration: duration,
      );

      debugPrint('✅ Screen recording saved: $savedPath');

      return savedPath;
    } catch (e) {
      debugPrint('❌ Error stopping screen recording: $e');
      _isRecording = false;
      _startTime = null;
      return null;
    }
  }

  /// Cancel recording without saving
  static Future<void> cancelRecording() async {
    if (!_isRecording) return;

    try {
      await FlutterScreenRecording.stopRecordScreen;
      debugPrint('🎥 Screen recording cancelled');
    } catch (e) {
      debugPrint('❌ Error cancelling recording: $e');
    } finally {
      _isRecording = false;
      _startTime = null;
    }
  }
}
