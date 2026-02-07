import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:ui' as ui;
import 'form_checker.dart';

/// =============================================================================
/// FORM SKELETON PAINTER - Color-Coded Real-Time Feedback (NO FACE)
/// =============================================================================
/// Draws skeleton overlay with colors based on form quality.
/// EXCLUDES face landmarks for cleaner, more professional look.
///
/// Colors:
/// - 🟢 Green (90-100%): Perfect form
/// - 🟡 Yellow (70-89%): Minor issues  
/// - 🟠 Orange (50-69%): Form breakdown
/// - 🔴 Red (<50%): Dangerous
/// =============================================================================

class FormSkeletonPainter extends CustomPainter {
  final Map<PoseLandmarkType, PoseLandmark> landmarks;
  final Size imageSize;
  final bool isFrontCamera;
  final int formScore;
  final List<FormFault> faults;

  FormSkeletonPainter({
    required this.landmarks,
    required this.imageSize,
    required this.isFrontCamera,
    required this.formScore,
    this.faults = const [],
  });

  @override
  void paint(Canvas canvas, Size size) {
    final formColor = _getFormColor(formScore);
    
    // Collect faulty body parts for highlighting
    final faultyParts = <String>{};
    for (final fault in faults) {
      if (fault.bodyPart != null) {
        faultyParts.add(fault.bodyPart!);
      }
    }

    // Draw skeleton (NO FACE)
    _drawConnections(canvas, size, formColor, faultyParts);
    _drawJoints(canvas, size, formColor, faultyParts);
  }

  /// Get position with proper scaling and mirroring
  Offset? _getPosition(PoseLandmarkType type, Size size) {
    final landmark = landmarks[type];
    if (landmark == null || landmark.likelihood < 0.5) return null;

    double x = landmark.x * size.width / imageSize.width;
    double y = landmark.y * size.height / imageSize.height;

    if (isFrontCamera) {
      x = size.width - x;
    }

    return Offset(x, y);
  }

  void _drawConnections(Canvas canvas, Size size, Color formColor, Set<String> faultyParts) {
    // === BODY CONNECTIONS ONLY - NO FACE ===
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

    for (final connection in connections) {
      final start = _getPosition(connection[0], size);
      final end = _getPosition(connection[1], size);
      
      if (start != null && end != null) {
        // Check if this limb has a fault
        final limbName = _getLimbName(connection[0], connection[1]);
        final isFaulty = faultyParts.contains(limbName);
        
        _drawBone(canvas, start, end, isFaulty ? const Color(0xFFFF003C) : formColor);
      }
    }
  }

  void _drawJoints(Canvas canvas, Size size, Color formColor, Set<String> faultyParts) {
    // === BODY JOINTS ONLY - NO FACE ===
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
      final pos = _getPosition(joint, size);
      if (pos != null) {
        final jointName = _getJointName(joint);
        final isFaulty = faultyParts.contains(jointName);
        final color = isFaulty ? const Color(0xFFFF003C) : formColor;
        
        _drawJoint(canvas, pos, color, isFaulty ? 14.0 : 10.0);
      }
    }
  }

  /// Draw a thick bone shape between two points
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

  /// Draw a glowing joint
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

  Color _getFormColor(int score) {
    if (score >= 90) return const Color(0xFF00FF66); // Neon green
    if (score >= 70) return const Color(0xFFFFDD00); // Yellow
    if (score >= 50) return const Color(0xFFFF9500); // Orange
    return const Color(0xFFFF003C); // Red
  }

  String _getLimbName(PoseLandmarkType start, PoseLandmarkType end) {
    // Map connections to body part names for fault highlighting
    if ((start == PoseLandmarkType.leftShoulder && end == PoseLandmarkType.leftElbow) ||
        (start == PoseLandmarkType.leftElbow && end == PoseLandmarkType.leftWrist)) {
      return 'left_arm';
    }
    if ((start == PoseLandmarkType.rightShoulder && end == PoseLandmarkType.rightElbow) ||
        (start == PoseLandmarkType.rightElbow && end == PoseLandmarkType.rightWrist)) {
      return 'right_arm';
    }
    if ((start == PoseLandmarkType.leftHip && end == PoseLandmarkType.leftKnee) ||
        (start == PoseLandmarkType.leftKnee && end == PoseLandmarkType.leftAnkle)) {
      return 'left_leg';
    }
    if ((start == PoseLandmarkType.rightHip && end == PoseLandmarkType.rightKnee) ||
        (start == PoseLandmarkType.rightKnee && end == PoseLandmarkType.rightAnkle)) {
      return 'right_leg';
    }
    if (start == PoseLandmarkType.leftShoulder && end == PoseLandmarkType.leftHip) {
      return 'left_torso';
    }
    if (start == PoseLandmarkType.rightShoulder && end == PoseLandmarkType.rightHip) {
      return 'right_torso';
    }
    return 'body';
  }

  String _getJointName(PoseLandmarkType type) {
    switch (type) {
      case PoseLandmarkType.leftShoulder:
      case PoseLandmarkType.rightShoulder:
        return 'shoulders';
      case PoseLandmarkType.leftElbow:
      case PoseLandmarkType.rightElbow:
        return 'elbows';
      case PoseLandmarkType.leftWrist:
      case PoseLandmarkType.rightWrist:
        return 'wrists';
      case PoseLandmarkType.leftHip:
      case PoseLandmarkType.rightHip:
        return 'hips';
      case PoseLandmarkType.leftKnee:
      case PoseLandmarkType.rightKnee:
        return 'knees';
      case PoseLandmarkType.leftAnkle:
      case PoseLandmarkType.rightAnkle:
        return 'ankles';
      default:
        return 'body';
    }
  }

  @override
  bool shouldRepaint(covariant FormSkeletonPainter oldDelegate) {
    return oldDelegate.formScore != formScore ||
           oldDelegate.landmarks != landmarks ||
           oldDelegate.faults != faults;
  }
}
