import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'form_checker.dart';

class PremiumSkeletonPainter extends CustomPainter {
  final Map<PoseLandmarkType, PoseLandmark> landmarks;
  final Size imageSize;
  final bool isFrontCamera;
  final int formScore;
  final List<FormFault> faults;
  final bool showAngles;

  PremiumSkeletonPainter({required this.landmarks, required this.imageSize, required this.isFrontCamera, required this.formScore, this.faults = const [], this.showAngles = false});

  Color get _baseColor => formScore >= 90 ? const Color(0xFFCCFF00) : formScore >= 70 ? const Color(0xFFBFFF00) : formScore >= 50 ? const Color(0xFFFFB800) : const Color(0xFFFF003C);
  double get _glowRadius => formScore >= 90 ? 12.0 : formScore >= 70 ? 10.0 : 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (landmarks.isEmpty) return;
    final faultyParts = <String>{};
    for (final f in faults) if (f.bodyPart != null) faultyParts.add(f.bodyPart!);
    _drawBones(canvas, size, faultyParts);
    _drawJoints(canvas, size, faultyParts);
    if (showAngles) _drawAngleLabels(canvas, size);
  }

  Offset? _transform(PoseLandmarkType type, Size canvasSize) {
    final lm = landmarks[type];
    if (lm == null || lm.likelihood < 0.5) return null;
    
    // Use the WORKING logic from train tab skeleton_painter.dart
    double x = lm.x * canvasSize.width / imageSize.width;
    double y = lm.y * canvasSize.height / imageSize.height;
    
    if (isFrontCamera) {
      x = canvasSize.width - x;
    }
    
    return Offset(x, y);
  }

  void _drawBones(Canvas canvas, Size size, Set<String> faultyParts) {
    final bones = [[PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder], [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip], [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip], [PoseLandmarkType.leftHip, PoseLandmarkType.rightHip], [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow], [PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist], [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow], [PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist], [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee], [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle], [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee], [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle], [PoseLandmarkType.leftShoulder, PoseLandmarkType.nose], [PoseLandmarkType.rightShoulder, PoseLandmarkType.nose]];
    for (final bone in bones) {
      final p1 = _transform(bone[0], size), p2 = _transform(bone[1], size);
      if (p1 == null || p2 == null) continue;
      final isFaulty = _isBoneFaulty(bone, faultyParts);
      _drawPremiumBone(canvas, p1, p2, isFaulty ? const Color(0xFFFF003C) : _baseColor);
    }
  }

  void _drawPremiumBone(Canvas canvas, Offset p1, Offset p2, Color color) {
    final dist = (p2 - p1).distance;
    if (dist < 5) return;
    final thickness = math.max(8.0, math.min(14.0, dist * 0.06));
    final endRadius = thickness * 0.9;
    canvas.drawLine(p1, p2, Paint()..color = color.withOpacity(0.4)..strokeWidth = thickness + 16..strokeCap = StrokeCap.round..maskFilter = MaskFilter.blur(BlurStyle.normal, _glowRadius + 4));
    canvas.drawLine(p1, p2, Paint()..color = color.withOpacity(0.6)..strokeWidth = thickness + 8..strokeCap = StrokeCap.round..maskFilter = MaskFilter.blur(BlurStyle.normal, _glowRadius));
    canvas.drawLine(p1, p2, Paint()..color = color.withOpacity(0.95)..strokeWidth = thickness..strokeCap = StrokeCap.round);
    final dir = (p2 - p1) / dist, perp = Offset(-dir.dy, dir.dx), off = perp * (thickness * 0.15);
    canvas.drawLine(p1 + off, p2 + off, Paint()..color = Colors.white.withOpacity(0.4)..strokeWidth = thickness * 0.3..strokeCap = StrokeCap.round);
    _drawJointBulb(canvas, p1, endRadius, color);
    _drawJointBulb(canvas, p2, endRadius, color);
  }

  void _drawJointBulb(Canvas canvas, Offset pos, double radius, Color color) {
    canvas.drawCircle(pos, radius * 1.5, Paint()..color = color.withOpacity(0.3)..maskFilter = MaskFilter.blur(BlurStyle.normal, radius));
    canvas.drawCircle(pos, radius, Paint()..color = color.withOpacity(0.9));
    canvas.drawCircle(pos + Offset(-radius * 0.2, -radius * 0.2), radius * 0.35, Paint()..color = Colors.white.withOpacity(0.5));
  }

  void _drawJoints(Canvas canvas, Size size, Set<String> faultyParts) {
    final joints = {PoseLandmarkType.nose: 16.0, PoseLandmarkType.leftShoulder: 12.0, PoseLandmarkType.rightShoulder: 12.0, PoseLandmarkType.leftElbow: 10.0, PoseLandmarkType.rightElbow: 10.0, PoseLandmarkType.leftWrist: 8.0, PoseLandmarkType.rightWrist: 8.0, PoseLandmarkType.leftHip: 12.0, PoseLandmarkType.rightHip: 12.0, PoseLandmarkType.leftKnee: 10.0, PoseLandmarkType.rightKnee: 10.0, PoseLandmarkType.leftAnkle: 8.0, PoseLandmarkType.rightAnkle: 8.0};
    for (final e in joints.entries) {
      final pos = _transform(e.key, size);
      if (pos == null) continue;
      final isFaulty = _isJointFaulty(e.key, faultyParts);
      _drawEnhancedJoint(canvas, pos, e.value, isFaulty ? const Color(0xFFFF003C) : _baseColor, isFaulty);
    }
  }

  void _drawEnhancedJoint(Canvas canvas, Offset pos, double radius, Color color, bool isFaulty) {
    canvas.drawCircle(pos, radius * 2, Paint()..color = color.withOpacity(0.25)..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 1.5));
    canvas.drawCircle(pos, radius * 1.3, Paint()..color = color.withOpacity(0.5)..maskFilter = MaskFilter.blur(BlurStyle.normal, radius * 0.5));
    canvas.drawCircle(pos, radius, Paint()..color = color);
    canvas.drawCircle(pos + Offset(-radius * 0.25, -radius * 0.25), radius * 0.4, Paint()..color = Colors.white.withOpacity(0.6));
    if (isFaulty) {
      canvas.drawCircle(pos, radius * 1.8, Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 3);
      canvas.drawCircle(pos, radius * 2.5, Paint()..color = color.withOpacity(0.5)..style = PaintingStyle.stroke..strokeWidth = 2);
    }
  }

  void _drawAngleLabels(Canvas canvas, Size size) {
    for (final e in {'KNEE': PoseLandmarkType.leftKnee, 'HIP': PoseLandmarkType.leftHip, 'ELBOW': PoseLandmarkType.leftElbow}.entries) {
      final pos = _transform(e.value, size);
      if (pos == null) continue;
      final angle = _calcAngle(e.value);
      if (angle == null) continue;
      final bgRect = RRect.fromRectAndRadius(Rect.fromCenter(center: pos + const Offset(25, -10), width: 60, height: 36), const Radius.circular(8));
      canvas.drawRRect(bgRect, Paint()..color = const Color(0xFF1A1F35).withOpacity(0.9));
      canvas.drawRRect(bgRect, Paint()..color = _baseColor.withOpacity(0.5)..style = PaintingStyle.stroke..strokeWidth = 1);
      final tp = TextPainter(text: TextSpan(text: '${angle.toStringAsFixed(0)}°', style: TextStyle(color: _baseColor, fontSize: 14, fontWeight: FontWeight.w800)), textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, pos + const Offset(25, -10) - Offset(tp.width / 2, tp.height / 2));
    }
  }

  double? _calcAngle(PoseLandmarkType joint) {
    PoseLandmarkType? p1, p2, p3;
    if (joint == PoseLandmarkType.leftKnee) { p1 = PoseLandmarkType.leftHip; p2 = PoseLandmarkType.leftKnee; p3 = PoseLandmarkType.leftAnkle; }
    else if (joint == PoseLandmarkType.leftHip) { p1 = PoseLandmarkType.leftShoulder; p2 = PoseLandmarkType.leftHip; p3 = PoseLandmarkType.leftKnee; }
    else if (joint == PoseLandmarkType.leftElbow) { p1 = PoseLandmarkType.leftShoulder; p2 = PoseLandmarkType.leftElbow; p3 = PoseLandmarkType.leftWrist; }
    else return null;
    final l1 = landmarks[p1], l2 = landmarks[p2], l3 = landmarks[p3];
    if (l1 == null || l2 == null || l3 == null) return null;
    final v1 = Offset(l1.x - l2.x, l1.y - l2.y), v2 = Offset(l3.x - l2.x, l3.y - l2.y);
    final dot = v1.dx * v2.dx + v1.dy * v2.dy;
    final mag1 = math.sqrt(v1.dx * v1.dx + v1.dy * v1.dy), mag2 = math.sqrt(v2.dx * v2.dx + v2.dy * v2.dy);
    if (mag1 < 0.001 || mag2 < 0.001) return null;
    return math.acos((dot / (mag1 * mag2)).clamp(-1.0, 1.0)) * 180 / math.pi;
  }

  bool _isBoneFaulty(List<PoseLandmarkType> bone, Set<String> faultyParts) {
    for (final f in faultyParts) {
      final fl = f.toLowerCase();
      if ((fl.contains('spine') || fl.contains('back')) && bone.any((t) => t == PoseLandmarkType.leftShoulder || t == PoseLandmarkType.rightShoulder || t == PoseLandmarkType.leftHip || t == PoseLandmarkType.rightHip)) return true;
      if (fl.contains('knee') && bone.any((t) => t == PoseLandmarkType.leftKnee || t == PoseLandmarkType.rightKnee)) return true;
      if (fl.contains('elbow') && bone.any((t) => t == PoseLandmarkType.leftElbow || t == PoseLandmarkType.rightElbow)) return true;
      if (fl.contains('hip') && bone.any((t) => t == PoseLandmarkType.leftHip || t == PoseLandmarkType.rightHip)) return true;
    }
    return false;
  }

  bool _isJointFaulty(PoseLandmarkType joint, Set<String> faultyParts) {
    final name = joint.name.toLowerCase();
    for (final f in faultyParts) {
      final fl = f.toLowerCase();
      if (name.contains('knee') && fl.contains('knee')) return true;
      if (name.contains('elbow') && fl.contains('elbow')) return true;
      if (name.contains('hip') && fl.contains('hip')) return true;
      if (name.contains('shoulder') && fl.contains('shoulder')) return true;
      if ((name.contains('shoulder') || name.contains('hip')) && (fl.contains('spine') || fl.contains('back'))) return true;
    }
    return false;
  }

  @override
  bool shouldRepaint(PremiumSkeletonPainter old) => old.formScore != formScore || old.landmarks != landmarks || old.faults != faults;
}

