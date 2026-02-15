import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

// =============================================================================
// ONE EURO FILTER — Industry-standard skeleton smoothing
// =============================================================================
// Speed-adaptive: smooth when idle (kills jitter), responsive when moving
// (near-zero lag). This is what Google used in the original MediaPipe before
// they removed the smoothLandmarks parameter.
// =============================================================================

class OneEuroFilter {
  final double _freq;
  final double _minCutoff;
  final double _beta;
  final double _dCutoff;
  double? _xPrev;
  double? _dxPrev;
  double? _tPrev;

  OneEuroFilter({
    double freq = 30.0,
    double minCutoff = 1.7,
    double beta = 0.3,
    double dCutoff = 1.0,
  })  : _freq = freq,
        _minCutoff = minCutoff,
        _beta = beta,
        _dCutoff = dCutoff;

  double _alpha(double cutoff, double te) {
    final r = 2 * math.pi * cutoff * te;
    return r / (r + 1);
  }

  double filter(double x, {double? timestamp}) {
    final double te;
    if (timestamp != null && _tPrev != null) {
      te = timestamp - _tPrev!;
    } else {
      te = 1.0 / _freq;
    }
    if (timestamp != null) _tPrev = timestamp;

    if (_xPrev == null) {
      _xPrev = x;
      _dxPrev = 0.0;
      _tPrev = timestamp;
      return x;
    }

    // Filter the derivative
    final double aD = _alpha(_dCutoff, te);
    final double dx = (x - _xPrev!) / te;
    final double dxHat = aD * dx + (1 - aD) * _dxPrev!;
    _dxPrev = dxHat;

    // Filter the signal
    final double cutoff = _minCutoff + _beta * dxHat.abs();
    final double a = _alpha(cutoff, te);
    final double xHat = a * x + (1 - a) * _xPrev!;
    _xPrev = xHat;

    return xHat;
  }

  void reset() {
    _xPrev = null;
    _dxPrev = null;
    _tPrev = null;
  }
}

// =============================================================================
// SKELETON STATE — Rep phase colors
// =============================================================================

enum SkeletonState {
  normal, // White bones - default
  success, // Blue bones - rep counted flash
}

// =============================================================================
// SKELETON PAINTER — One Euro Filter + phase colors + subtle glow
// =============================================================================

class SkeletonPainter extends CustomPainter {
  final List<PoseLandmark>? landmarks;
  final Size imageSize;
  final bool isFrontCamera;
  final SkeletonState skeletonState;
  final double chargeProgress;

  // One filter per landmark per axis (x and y) — static so they persist between frames
  static final Map<PoseLandmarkType, OneEuroFilter> _filtersX = {};
  static final Map<PoseLandmarkType, OneEuroFilter> _filtersY = {};
  static final Map<PoseLandmarkType, Offset> _lastGoodPositions = {};

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

    // Body connections — NO nose/face lines
    final connections = [
      [PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder],
      [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip],
      [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip],
      [PoseLandmarkType.leftHip, PoseLandmarkType.rightHip],
      [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow],
      [PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist],
      [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow],
      [PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist],
      [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
      [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle],
      [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
      [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle],
    ];

    // Draw bones
    for (final conn in connections) {
      final p1 = getPos(conn[0], size, landmarkMap);
      final p2 = getPos(conn[1], size, landmarkMap);
      if (p1 != null && p2 != null) {
        _drawBone(canvas, p1, p2, color);
      }
    }

    // Draw joints — major joints only
    final majorJoints = [
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

    for (final joint in majorJoints) {
      final pos = getPos(joint, size, landmarkMap);
      if (pos != null) {
        _drawJoint(canvas, pos, color);
      }
    }
  }

  /// One Euro Filter smoothing — replaces the old LERP approach
  Offset? getPos(PoseLandmarkType type, Size size, Map<PoseLandmarkType, PoseLandmark> landmarkMap) {
    final lm = landmarkMap[type];

    // Confidence filter — if garbage, return last known good position
    if (lm == null || lm.likelihood < 0.5) {
      return _lastGoodPositions[type];
    }

    // Convert to screen space
    double tx = lm.x * size.width / imageSize.width;
    double ty = lm.y * size.height / imageSize.height;
    if (isFrontCamera) tx = size.width - tx;

    // Get or create One Euro Filters for this landmark
    _filtersX.putIfAbsent(type, () => OneEuroFilter(minCutoff: 1.7, beta: 0.3));
    _filtersY.putIfAbsent(type, () => OneEuroFilter(minCutoff: 1.7, beta: 0.3));

    // Apply One Euro Filter
    final filteredX = _filtersX[type]!.filter(tx);
    final filteredY = _filtersY[type]!.filter(ty);
    final result = Offset(filteredX, filteredY);

    // Store as last known good position
    _lastGoodPositions[type] = result;
    return result;
  }

  /// Rep phase colors: White → Green → Blue
  Color _getPhaseColor() {
    // Rep complete → ELECTRIC BLUE flash
    if (skeletonState == SkeletonState.success) {
      return const Color(0xFF00D9FF);
    }
    // Past halfway of rep → GREEN (the dopamine hit)
    if (chargeProgress > 0.5) {
      return const Color(0xFF00FF41);
    }
    // Default → clean WHITE
    return Colors.white.withOpacity(0.9);
  }

  /// Bone drawing — thinner than form skeleton, single subtle glow
  void _drawBone(Canvas canvas, Offset start, Offset end, Color color) {
    final distance = (end - start).distance;
    if (distance < 10) return;

    // Subtle glow only
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
    _filtersX.clear();
    _filtersY.clear();
    _lastGoodPositions.clear();
  }
}
