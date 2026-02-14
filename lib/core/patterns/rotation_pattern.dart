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

  bool _lastWasLeft = false;
  bool _hasCrossedCenter = true;
  bool _isFirstRep = true;

  // Debug
  double _debugSweep = 0;
  double _debugThreshold = 0;
  String _debugLandmarks = '';

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
  String get debugInfo => 'ROTATION\nSweep: ${_debugSweep.toStringAsFixed(3)}\nThresh: ${_debugThreshold.toStringAsFixed(3)}\nCharge: ${(_chargeProgress * 100).toStringAsFixed(0)}%\nLM: $_debugLandmarks\nReps: $_repCount';

  @override
  void captureBaseline(Map<PoseLandmarkType, PoseLandmark> map) {
    _isLocked = true;
    _state = RepState.ready;
    _feedback = "LOCKED";
  }

  @override
  bool processFrame(Map<PoseLandmarkType, PoseLandmark> map) {
    _justHitTrigger = false;

    // Get landmarks - USE SHOULDERS AS FALLBACK FOR HIPS
    final lW = map[PoseLandmarkType.leftWrist];
    final rW = map[PoseLandmarkType.rightWrist];
    final lH = map[PoseLandmarkType.leftHip];
    final rH = map[PoseLandmarkType.rightHip];
    final lS = map[PoseLandmarkType.leftShoulder];
    final rS = map[PoseLandmarkType.rightShoulder];

    // Debug: track what landmarks we have
    _debugLandmarks = '${lW != null ? "LW" : ".."}|${rW != null ? "RW" : ".."}|${lH != null ? "LH" : ".."}|${rH != null ? "RH" : ".."}|${lS != null ? "LS" : ".."}|${rS != null ? "RS" : ".."}';

    // Need at least ONE wrist and ONE body center reference
    // Use shoulders if hips aren't visible (seated position)
    double? centerX;
    double? bodyWidth;

    if (lH != null && rH != null) {
      centerX = (lH.x + rH.x) / 2;
      bodyWidth = (lH.x - rH.x).abs() + 0.01;
    } else if (lS != null && rS != null) {
      centerX = (lS.x + rS.x) / 2;
      bodyWidth = (lS.x - rS.x).abs() + 0.01;
    } else if (lH != null && rS != null) {
      centerX = (lH.x + rS.x) / 2;
      bodyWidth = (lH.x - rS.x).abs() + 0.01;
    } else if (rH != null && lS != null) {
      centerX = (rH.x + lS.x) / 2;
      bodyWidth = (rH.x - lS.x).abs() + 0.01;
    }

    if (centerX == null || bodyWidth == null) {
      _feedback = "Body not visible";
      return false;
    }

    // Get hand position - use whichever wrist(s) are visible
    double? handX;
    if (lW != null && rW != null) {
      handX = (lW.x + rW.x) / 2;
    } else if (lW != null) {
      handX = lW.x;
    } else if (rW != null) {
      handX = rW.x;
    }

    if (handX == null) {
      _feedback = "Hands not visible";
      return false;
    }

    // Calculate sweep
    double sweepOffset = (handX - centerX) / bodyWidth;

    // Threshold - LOW so it actually triggers
    double threshold = 0.15;

    _debugSweep = sweepOffset;
    _debugThreshold = threshold;

    // Zone detection
    bool inLeftZone = sweepOffset < -threshold;
    bool inRightZone = sweepOffset > threshold;
    bool inCenterZone = sweepOffset.abs() < 0.05;

    if (inCenterZone) {
      _hasCrossedCenter = true;
    }

    // Update gauge
    _chargeProgress = (sweepOffset.abs() / threshold).clamp(0.0, 1.0);
    _state = _chargeProgress > 0.15 ? RepState.goingDown : RepState.ready;

    // Trigger
    if (_hasCrossedCenter) {
      if (inLeftZone && (!_lastWasLeft || _isFirstRep)) {
        _countRep(true);
        return true;
      } else if (inRightZone && (_lastWasLeft || _isFirstRep)) {
        _countRep(false);
        return true;
      }
    }

    if (_chargeProgress > 0.8) {
      _feedback = cueGood;
    } else {
      _feedback = cueBad;
    }

    return false;
  }

  void _countRep(bool left) {
    _repCount++;
    _lastWasLeft = left;
    _isFirstRep = false;
    _hasCrossedCenter = false;
    _justHitTrigger = true;
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
    _debugSweep = 0;
    _debugThreshold = 0;
    _debugLandmarks = '';
  }
}
