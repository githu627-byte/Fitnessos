import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math' as math;
import 'base_pattern.dart';

class RotationPattern implements BasePattern {
  final double triggerAngle;
  final String cueGood;
  final String cueBad;

  RepState _state = RepState.ready;
  bool _isLocked = false;
  int _repCount = 0;
  String _feedback = "";
  bool _justHitTrigger = false;
  double _chargeProgress = 0.0;

  // Pendulum Memory
  bool _lastWasLeft = false;
  bool _hasCrossedCenter = true;
  bool _isFirstRep = true;

  // Smoothing
  double _smoothedSweep = 0.0;
  static const double _emaAlpha = 0.45;

  // Timing Guard
  DateTime _lastRepTime = DateTime.now();
  static const int _minTimeBetweenRepsMs = 350;

  RotationPattern({
    this.triggerAngle = 45.0,
    this.cueGood = "Twist!",
    this.cueBad = "Rotate more!",
  });

  @override RepState get state => _state;
  @override bool get isLocked => _isLocked;
  @override int get repCount => _repCount;
  @override String get feedback => _feedback;
  @override double get chargeProgress => _chargeProgress;
  @override bool get justHitTrigger => _justHitTrigger;

  @override
  void captureBaseline(Map<PoseLandmarkType, PoseLandmark> map) {
    _isLocked = true;
    _state = RepState.ready;
    _feedback = "LOCKED";
    _smoothedSweep = 0.0;
  }

  @override
  bool processFrame(Map<PoseLandmarkType, PoseLandmark> map) {
    _justHitTrigger = false;

    final lW = map[PoseLandmarkType.leftWrist];
    final rW = map[PoseLandmarkType.rightWrist];
    final lH = map[PoseLandmarkType.leftHip];
    final rH = map[PoseLandmarkType.rightHip];

    if (lW == null || rW == null || lH == null || rH == null) return false;

    if (lW.likelihood < 0.3 || rW.likelihood < 0.3 ||
        lH.likelihood < 0.3 || rH.likelihood < 0.3) {
      _feedback = "Stay in frame";
      return false;
    }

    final double bodyCenter = (lH.x + rH.x) / 2;
    final double handX = (lW.x + rW.x) / 2;
    final double bodyWidth = (lH.x - rH.x).abs() + 0.01;
    final double rawSweep = (handX - bodyCenter) / bodyWidth;

    // EMA smoothing - alpha 0.45 so it actually responds
    _smoothedSweep = (_emaAlpha * rawSweep) + ((1 - _emaAlpha) * _smoothedSweep);

    // Threshold: 45 → 0.325 | 50 → 0.35 | 60 → 0.40
    final double threshold = 0.10 + (triggerAngle / 200.0);
    final double centerDeadzone = 0.08;

    final bool inLeftZone = _smoothedSweep < -threshold;
    final bool inRightZone = _smoothedSweep > threshold;
    final bool inCenterZone = _smoothedSweep.abs() < centerDeadzone;

    if (inCenterZone) {
      _hasCrossedCenter = true;
    }

    _chargeProgress = (_smoothedSweep.abs() / threshold).clamp(0.0, 1.0);
    _state = _chargeProgress > 0.15 ? RepState.goingDown : RepState.ready;

    final now = DateTime.now();
    final timeSinceLastRep = now.difference(_lastRepTime).inMilliseconds;

    if (_hasCrossedCenter && timeSinceLastRep > _minTimeBetweenRepsMs) {
      if (inLeftZone && (!_lastWasLeft || _isFirstRep)) {
        _countRep(true, now);
        return true;
      } else if (inRightZone && (_lastWasLeft || _isFirstRep)) {
        _countRep(false, now);
        return true;
      }
    }

    if (_chargeProgress > 0.85) {
      _feedback = cueGood;
    } else if (_chargeProgress > 0.4) {
      _feedback = "Keep going!";
    } else {
      _feedback = cueBad;
    }

    return false;
  }

  void _countRep(bool left, DateTime now) {
    _repCount++;
    _lastWasLeft = left;
    _isFirstRep = false;
    _hasCrossedCenter = false;
    _justHitTrigger = true;
    _lastRepTime = now;
    _state = RepState.down;
    _feedback = cueGood;
  }

  @override
  void reset() {
    _repCount = 0;
    _state = RepState.ready;
    _isLocked = false;
    _lastWasLeft = false;
    _hasCrossedCenter = true;
    _isFirstRep = true;
    _smoothedSweep = 0.0;
    _lastRepTime = DateTime.now();
  }
}
