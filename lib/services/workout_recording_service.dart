import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gal/gal.dart';

/// Service for managing workout video recordings
class WorkoutRecordingService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'workout_recordings.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE recordings (
            id TEXT PRIMARY KEY,
            workoutName TEXT NOT NULL,
            videoPath TEXT NOT NULL,
            thumbnailPath TEXT,
            duration INTEGER NOT NULL,
            recordedAt TEXT NOT NULL,
            sessionId TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Add sessionId column for linking to workout sessions
          await db.execute('ALTER TABLE recordings ADD COLUMN sessionId TEXT');
          debugPrint('✅ Added sessionId column to recordings table');
        }
      },
    );
  }

  /// Save a new workout recording (copies to persistent storage)
  static Future<String> saveRecording({
    required String workoutName,
    required String videoPath,
    String? thumbnailPath,
    required Duration duration,
    String? sessionId,
  }) async {
    final db = await database;
    final id = DateTime.now().millisecondsSinceEpoch.toString();

    // Copy video to our persistent recordings directory
    final recordingsDir = await getRecordingsDirectory();
    final fileName = '${id}_${workoutName.replaceAll(' ', '_')}.mp4';
    final newPath = join(recordingsDir.path, fileName);
    
    try {
      final originalFile = File(videoPath);
      final savedFile = await originalFile.copy(newPath);
      debugPrint('📁 Copied video to persistent storage: ${savedFile.path}');
      
      await db.insert('recordings', {
        'id': id,
        'workoutName': workoutName,
        'videoPath': savedFile.path,  // Use the new persistent path
        'thumbnailPath': thumbnailPath,
        'duration': duration.inSeconds,
        'recordedAt': DateTime.now().toIso8601String(),
        'sessionId': sessionId,
      });

      debugPrint('✅ Saved recording to database: $workoutName ($id)${sessionId != null ? " [Session: $sessionId]" : ""}');
      return savedFile.path;
    } catch (e) {
      debugPrint('❌ Error saving recording: $e');
      // Fallback to original path if copy fails
      await db.insert('recordings', {
        'id': id,
        'workoutName': workoutName,
        'videoPath': videoPath,
        'thumbnailPath': thumbnailPath,
        'duration': duration.inSeconds,
        'recordedAt': DateTime.now().toIso8601String(),
        'sessionId': sessionId,
      });
      return videoPath;
    }
  }

  /// Get all recordings
  static Future<List<WorkoutRecording>> getRecordings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'recordings',
      orderBy: 'recordedAt DESC',
    );

    return maps.map((map) => WorkoutRecording.fromMap(map)).toList();
  }

  /// Delete a recording
  static Future<void> deleteRecording(String id) async {
    final db = await database;
    
    // Get recording to delete files
    final recording = await db.query(
      'recordings',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (recording.isNotEmpty) {
      final videoPath = recording.first['videoPath'] as String;
      final thumbnailPath = recording.first['thumbnailPath'] as String?;

      // Delete video file
      final videoFile = File(videoPath);
      if (await videoFile.exists()) {
        await videoFile.delete();
      }

      // Delete thumbnail file
      if (thumbnailPath != null) {
        final thumbnailFile = File(thumbnailPath);
        if (await thumbnailFile.exists()) {
          await thumbnailFile.delete();
        }
      }
    }

    // Delete from database
    await db.delete(
      'recordings',
      where: 'id = ?',
      whereArgs: [id],
    );

    debugPrint('🗑️ Deleted recording: $id');
  }

  /// Get recordings directory
  static Future<Directory> getRecordingsDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final recordingsDir = Directory('${appDir.path}/workout_recordings');
    
    if (!await recordingsDir.exists()) {
      await recordingsDir.create(recursive: true);
    }
    
    return recordingsDir;
  }
  
  /// Save recording to device's gallery/downloads
  static Future<bool> saveToDevice(String videoPath, String workoutName) async {
    try {
      // Request storage permission for Android
      if (Platform.isAndroid) {
        final status = await Permission.photos.request();
        if (!status.isGranted) {
          debugPrint('❌ Photos permission denied');
          return false;
        }
      }

      // Use gal package for clean gallery saving
      await Gal.putVideo(videoPath, album: 'FitnessOS');
      
      debugPrint('✅ Saved to device gallery: $videoPath');
      return true;
    } catch (e) {
      debugPrint('❌ Error saving to device: $e');
      
      // Fallback to manual copy method
      try {
        // Get Downloads directory
        Directory? downloadsDir;
        
        if (Platform.isAndroid) {
          downloadsDir = Directory('/storage/emulated/0/Download');
          if (!await downloadsDir.exists()) {
            downloadsDir = Directory('/storage/emulated/0/Downloads');
          }
        } else if (Platform.isIOS) {
          // iOS: Save to app's documents directory (accessible via Files app)
          downloadsDir = await getApplicationDocumentsDirectory();
        }

        if (downloadsDir == null || !await downloadsDir.exists()) {
          debugPrint('❌ Could not find downloads directory');
          return false;
        }

        // Create FitnessOS folder in Downloads
        final fitnessDir = Directory('${downloadsDir.path}/FitnessOS');
        if (!await fitnessDir.exists()) {
          await fitnessDir.create(recursive: true);
        }

        // Copy video to device storage
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = '${workoutName.replaceAll(' ', '_')}_$timestamp.mp4';
        final destination = File('${fitnessDir.path}/$fileName');
        
        final videoFile = File(videoPath);
        await videoFile.copy(destination.path);
        
        debugPrint('✅ Saved to device (fallback): ${destination.path}');
        return true;
      } catch (fallbackError) {
        debugPrint('❌ Fallback also failed: $fallbackError');
        return false;
      }
    }
  }

  /// Share recording using native share dialog
  static Future<void> shareRecording(String videoPath, String workoutName) async {
    try {
      final file = XFile(videoPath);
      await Share.shareXFiles(
        [file],
        subject: 'My $workoutName Workout',
        text: 'Check out my $workoutName workout! 💪🔥',
      );
      debugPrint('✅ Shared recording: $videoPath');
    } catch (e) {
      debugPrint('❌ Error sharing recording: $e');
    }
  }
}

/// Model for a workout recording
class WorkoutRecording {
  final String id;
  final String workoutName;
  final String videoPath;
  final String? thumbnailPath;
  final Duration duration;
  final DateTime recordedAt;

  WorkoutRecording({
    required this.id,
    required this.workoutName,
    required this.videoPath,
    this.thumbnailPath,
    required this.duration,
    required this.recordedAt,
  });

  factory WorkoutRecording.fromMap(Map<String, dynamic> map) {
    return WorkoutRecording(
      id: map['id'] as String,
      workoutName: map['workoutName'] as String,
      videoPath: map['videoPath'] as String,
      thumbnailPath: map['thumbnailPath'] as String?,
      duration: Duration(seconds: map['duration'] as int),
      recordedAt: DateTime.parse(map['recordedAt'] as String),
    );
  }
}

