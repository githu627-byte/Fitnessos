import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

enum SkeletonState {
  normal,   // Cyber lime bones - default
  success,  // Electric cyan flash - rep counted
}

/// =============================================================================
/// SKELETON PAINTER - Using FormSkeletonPainter rendering logic
/// =============================================================================
/// Takes List<PoseLandmark> from train_tab (same interface as before).
/// Draws thick glowing bones and joints (same visual as Form Analysis).
/// Confidence filtering at 0.5. No face landmarks.
/// =============================================================================

class SkeletonPainter extends CustomPainter {
  final List<PoseLandmark>? landmarks;
  final Size imageSize;
  final bool isFrontCamera;
  final SkeletonState skeletonState;
  final double chargeProgress;

  // Smoothing — keep LERP from original for stability
  static final Map<PoseLandmarkType, Offset> _smoothedPositions = {};
  static const double _lerpFactor = 0.35;

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

    // Build lookup map (same as before)
    final Map<PoseLandmarkType, PoseLandmark> landmarkMap = {};
    for (final landmark in landmarks!) {
      landmarkMap[landmark.type] = landmark;
    }

    // Get color based on state (cyber lime default, cyan on rep flash)
    final Color baseColor = _getStateColor();

    // Draw using FormSkeletonPainter logic: thick bones, glow, big joints
    _drawConnections(canvas, size, baseColor, landmarkMap);
    _drawJoints(canvas, size, baseColor, landmarkMap);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // POSITION: Same LERP smoothing as original + confidence filter
  // ═══════════════════════════════════════════════════════════════════════════
  Offset? _getPos(PoseLandmarkType type, Size size, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    final lm = landmarkMap[type];

    // Confidence filter (same as FormSkeletonPainter)
    if (lm == null || lm.likelihood < 0.5) {
      return _smoothedPositions[type]; // Return last known good
    }

    // Coordinate transform (same as FormSkeletonPainter)
    double x = lm.x * size.width / imageSize.width;
    double y = lm.y * size.height / imageSize.height;
    if (isFrontCamera) x = size.width - x;

    final Offset target = Offset(x, y);

    // LERP smoothing (kept from original for stability)
    final Offset current = _smoothedPositions[type] ?? target;
    final Offset smoothed = Offset(
      current.dx + (target.dx - current.dx) * _lerpFactor,
      current.dy + (target.dy - current.dy) * _lerpFactor,
    );
    _smoothedPositions[type] = smoothed;
    return smoothed;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BONES: Thick glow + main bone + highlight (FROM FormSkeletonPainter)
  // ═══════════════════════════════════════════════════════════════════════════
  void _drawConnections(Canvas canvas, Size size, Color color, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    // Body connections only — NO FACE (same list as FormSkeletonPainter)
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

    for (final conn in connections) {
      final p1 = _getPos(conn[0], size, landmarkMap);
      final p2 = _getPos(conn[1], size, landmarkMap);
      if (p1 != null && p2 != null) {
        _drawBone(canvas, p1, p2, color);
      }
    }
  }

  /// Draw a thick bone with glow (EXACT copy from FormSkeletonPainter)
  void _drawBone(Canvas canvas, Offset start, Offset end, Color color) {
    final distance = (end - start).distance;
    if (distance < 10) return;

    // Glow layer
    final glowPaint = Paint()
      ..color = color.withOpacity(0.4)
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawLine(start, end, glowPaint);

    // Main bone
    final bonePaint = Paint()
      ..color = color
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, end, bonePaint);

    // Inner highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, end, highlightPaint);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // JOINTS: Glowing circles (FROM FormSkeletonPainter)
  // ═══════════════════════════════════════════════════════════════════════════
  void _drawJoints(Canvas canvas, Size size, Color color, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    // Body joints only — NO FACE
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
      final pos = _getPos(joint, size, landmarkMap);
      if (pos != null) {
        _drawJoint(canvas, pos, color, 10.0);
      }
    }
  }

  /// Draw a glowing joint (EXACT copy from FormSkeletonPainter)
  void _drawJoint(Canvas canvas, Offset pos, Color color, double radius) {
    // Outer glow
    final glowPaint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(pos, radius + 4, glowPaint);

    // Main joint
    final jointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, radius, jointPaint);

    // Inner highlight
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos.translate(-2, -2), radius * 0.4, highlightPaint);
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // COLOR: Based on skeleton state (normal vs rep flash)
  // ═══════════════════════════════════════════════════════════════════════════
  Color _getStateColor() {
    switch (skeletonState) {
      case SkeletonState.normal:
        return const Color(0xFFCCFF00); // Cyber lime — matches your brand
      case SkeletonState.success:
        return const Color(0xFF00F0FF); // Electric cyan — rep counted flash
    }
  }

  @override
  bool shouldRepaint(SkeletonPainter oldDelegate) {
    return oldDelegate.skeletonState != skeletonState ||
           oldDelegate.chargeProgress != chargeProgress ||
           oldDelegate.landmarks != landmarks;
  }

  static void resetSmoothing() {
    _smoothedPositions.clear();
  }
}
