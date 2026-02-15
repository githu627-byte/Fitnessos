import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

// =============================================================================
// SKELETON STATE — Rep phase colors
// =============================================================================

enum SkeletonState {
  normal, // White bones - default
  success, // Blue bones - rep counted flash
}

// =============================================================================
// SKELETON PAINTER — Form skeleton approach + EMA smoothing + phase colors
// =============================================================================

class SkeletonPainter extends CustomPainter {
  final List<PoseLandmark>? landmarks;
  final Size imageSize;
  final bool isFrontCamera;
  final SkeletonState skeletonState;
  final double chargeProgress;

  // EMA smoothing state — static so it persists between frames
  static final Map<PoseLandmarkType, Offset> _smoothed = {};

  SkeletonPainter({
    required this.landmarks,
    required this.imageSize,
    this.isFrontCamera = true,
    this.skeletonState = SkeletonState.normal,
    this.chargeProgress = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (landmarks == null || landmarks!.isEmpty) return;

    // Create map for quick lookup
    final Map<PoseLandmarkType, PoseLandmark> landmarkMap = {};
    for (final landmark in landmarks!) {
      landmarkMap[landmark.type] = landmark;
    }

    final Color color = _getPhaseColor();

    // Body connections — NO nose/face
    final connections = [
      // Torso
      [PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder],
      [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip],
      [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip],
      [PoseLandmarkType.leftHip, PoseLandmarkType.rightHip],
      // Left Arm
      [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow],
      [PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist],
      // Right Arm
      [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow],
      [PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist],
      // Left Leg
      [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
      [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle],
      // Right Leg
      [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
      [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle],
    ];

    // Draw bones
    for (final conn in connections) {
      final p1 = _getPosition(conn[0], size, landmarkMap);
      final p2 = _getPosition(conn[1], size, landmarkMap);
      if (p1 != null && p2 != null) {
        _drawBone(canvas, p1, p2, color);
      }
    }

    // Draw joints — major joints only
    final joints = [
      PoseLandmarkType.leftShoulder,
      PoseLandmarkType.rightShoulder,
      PoseLandmarkType.leftElbow,
      PoseLandmarkType.rightElbow,
      PoseLandmarkType.leftWrist,
      PoseLandmarkType.rightWrist,
      PoseLandmarkType.leftHip,
      PoseLandmarkType.rightHip,
      PoseLandmarkType.leftKnee,
      PoseLandmarkType.rightKnee,
      PoseLandmarkType.leftAnkle,
      PoseLandmarkType.rightAnkle,
    ];

    for (final joint in joints) {
      final pos = _getPosition(joint, size, landmarkMap);
      if (pos != null) {
        _drawJoint(canvas, pos, color);
      }
    }
  }

  /// Position with proper scaling, mirroring, and EMA smoothing (alpha 0.1)
  Offset? _getPosition(PoseLandmarkType type, Size size, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    final landmark = landmarkMap[type];
    if (landmark == null || landmark.likelihood < 0.5) return null;

    double x = landmark.x * size.width / imageSize.width;
    double y = landmark.y * size.height / imageSize.height;

    if (isFrontCamera) {
      x = size.width - x;
    }

    final raw = Offset(x, y);
    final prev = _smoothed[type];
    if (prev == null) {
      _smoothed[type] = raw;
      return raw;
    }
    final smoothed = Offset(
      prev.dx + 0.1 * (raw.dx - prev.dx),
      prev.dy + 0.1 * (raw.dy - prev.dy),
    );
    _smoothed[type] = smoothed;
    return smoothed;
  }

  /// Phase colors: White → Green → Blue
  Color _getPhaseColor() {
    if (skeletonState == SkeletonState.success) {
      return const Color(0xFF00D9FF);
    }
    if (chargeProgress > 0.5) {
      return const Color(0xFF00FF41);
    }
    return Colors.white.withOpacity(0.9);
  }

  /// Bone drawing — thin, single subtle glow
  void _drawBone(Canvas canvas, Offset start, Offset end, Color color) {
    final distance = (end - start).distance;
    if (distance < 10) return;

    // Subtle glow
    canvas.drawLine(
      start,
      end,
      Paint()
        ..color = color.withOpacity(0.3)
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // Main bone
    canvas.drawLine(
      start,
      end,
      Paint()
        ..color = color
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round,
    );
  }

  /// Joint drawing — small dots, major joints only
  void _drawJoint(Canvas canvas, Offset pos, Color color) {
    // Small glow
    canvas.drawCircle(
      pos,
      8,
      Paint()
        ..color = color.withOpacity(0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    // Joint dot
    canvas.drawCircle(pos, 5, Paint()..color = color);
  }

  @override
  bool shouldRepaint(SkeletonPainter oldDelegate) {
    return oldDelegate.skeletonState != skeletonState ||
        oldDelegate.chargeProgress != chargeProgress;
  }

  static void resetSmoothing() {
    _smoothed.clear();
  }
}
