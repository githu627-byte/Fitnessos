import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

enum SkeletonState {
  normal, // White bones - default
  success, // Blue bones - rep counted flash
}

class SkeletonPainter extends CustomPainter {
  final List<PoseLandmark>? landmarks;
  final Size imageSize;
  final bool isFrontCamera;
  final SkeletonState skeletonState;
  final double chargeProgress;

  // Smoothing config
  static final Map<PoseLandmarkType, Offset> _smoothedPositions = {};
  static const double _lerpFactor = 0.35; // Pro-grade smoothing
  
  // Visual config
  static const double _lineWidth = 3.0;
  static const double _jointSize = 8.0;

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

    // Get the phase color
    final Color skeletonColor = _getPhaseColor();
    
    // Draw skeleton
    _drawBody(canvas, size, skeletonColor, landmarkMap);
  }

  /// SMOOTHING ENGINE - Gets position with LERP and confidence filtering
  Offset? getPos(PoseLandmarkType type, Size size, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    final lm = landmarkMap[type];
    
    // CONFIDENCE SHIELD: Ignore garbage data (likelihood < 0.5)
    if (lm == null || lm.likelihood < 0.5) {
      return _smoothedPositions[type]; // Return last known good position
    }

    // Convert landmark coordinates to screen space
    double tx = lm.x * size.width / imageSize.width;
    double ty = lm.y * size.height / imageSize.height;
    if (isFrontCamera) tx = size.width - tx;
    
    final Offset targetPos = Offset(tx, ty);

    // LERP SMOOTHING: Current + (Target - Current) * Factor
    final Offset current = _smoothedPositions[type] ?? targetPos;
    final Offset smoothed = Offset(
      ui.lerpDouble(current.dx, targetPos.dx, _lerpFactor)!,
      ui.lerpDouble(current.dy, targetPos.dy, _lerpFactor)!,
    );

    // Store smoothed position for next frame
    _smoothedPositions[type] = smoothed;
    return smoothed;
  }

  /// Get color based on charge/state
  Color _getPhaseColor() {
    // Success state (rep counted) → ELECTRIC BLUE
    if (skeletonState == SkeletonState.success) {
      return const Color(0xFF00D9FF); // Electric blue
    }
    
    // Charging (going down) → GREEN
    if (chargeProgress > 0.3) {
      return const Color(0xFF00FF41); // Cyber green
    }
    
    // Normal → WHITE
    return Colors.white.withOpacity(0.9);
  }

  /// Draw the complete skeleton
  void _drawBody(Canvas canvas, Size size, Color color, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _lineWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final jointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw all connections
    _drawTorso(canvas, size, paint, jointPaint, landmarkMap);
    _drawLeftArm(canvas, size, paint, jointPaint, landmarkMap);
    _drawRightArm(canvas, size, paint, jointPaint, landmarkMap);
    _drawLeftLeg(canvas, size, paint, jointPaint, landmarkMap);
    _drawRightLeg(canvas, size, paint, jointPaint, landmarkMap);
  }

  void _drawTorso(Canvas canvas, Size size, Paint linePaint, Paint jointPaint, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    _drawLine(canvas, size, PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder, linePaint, jointPaint, landmarkMap);
    _drawLine(canvas, size, PoseLandmarkType.leftHip, PoseLandmarkType.rightHip, linePaint, jointPaint, landmarkMap);
    _drawLine(canvas, size, PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, linePaint, jointPaint, landmarkMap);
    _drawLine(canvas, size, PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip, linePaint, jointPaint, landmarkMap);
  }

  void _drawLeftArm(Canvas canvas, Size size, Paint linePaint, Paint jointPaint, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    _drawLine(canvas, size, PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, linePaint, jointPaint, landmarkMap);
    _drawLine(canvas, size, PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, linePaint, jointPaint, landmarkMap);
  }

  void _drawRightArm(Canvas canvas, Size size, Paint linePaint, Paint jointPaint, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    _drawLine(canvas, size, PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow, linePaint, jointPaint, landmarkMap);
    _drawLine(canvas, size, PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, linePaint, jointPaint, landmarkMap);
  }

  void _drawLeftLeg(Canvas canvas, Size size, Paint linePaint, Paint jointPaint, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    _drawLine(canvas, size, PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, linePaint, jointPaint, landmarkMap);
    _drawLine(canvas, size, PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, linePaint, jointPaint, landmarkMap);
  }

  void _drawRightLeg(Canvas canvas, Size size, Paint linePaint, Paint jointPaint, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    _drawLine(canvas, size, PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, linePaint, jointPaint, landmarkMap);
    _drawLine(canvas, size, PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, linePaint, jointPaint, landmarkMap);
  }

  void _drawLine(
    Canvas canvas, 
    Size size, 
    PoseLandmarkType start, 
    PoseLandmarkType end,
    Paint linePaint,
    Paint jointPaint,
    Map<PoseLandmarkType, PoseLandmark> landmarkMap,
  ) {
    final p1 = getPos(start, size, landmarkMap);
    final p2 = getPos(end, size, landmarkMap);
    
    if (p1 != null && p2 != null) {
      canvas.drawLine(p1, p2, linePaint);
      canvas.drawCircle(p1, _jointSize, jointPaint);
      canvas.drawCircle(p2, _jointSize, jointPaint);
    }
  }

  @override
  bool shouldRepaint(SkeletonPainter oldDelegate) {
    return oldDelegate.skeletonState != skeletonState ||
           oldDelegate.chargeProgress != chargeProgress;
  }
  
  static void resetSmoothing() {
    _smoothedPositions.clear();
  }
}
