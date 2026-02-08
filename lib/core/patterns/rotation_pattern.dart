import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math' as math;
import 'base_pattern.dart';

class RotationPattern implements BasePattern {
  final double triggerAngle; // We'll use this to scale the sensitivity
  final String cueGood;
  final String cueBad;
  
  RepState _state = RepState.ready;
  bool _isLocked = false;
  int _repCount = 0;
  String _feedback = "";
  bool _justHitTrigger = false;
  double _chargeProgress = 0.0;

  // The "Pendulum" Memory
  bool _lastWasLeft = false;
  bool _hasCrossedCenter = true;
  bool _isFirstRep = true;

  RotationPattern({
    this.triggerAngle = 45.0, 
    this.cueGood = "Twist!",
    this.cueBad = "Swing Arms!",
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
  }

  @override
  bool processFrame(Map<PoseLandmarkType, PoseLandmark> map) {
    _justHitTrigger = false;

    // 1. DATA PULL (Hands and Hips only)
    final lW = map[PoseLandmarkType.leftWrist];
    final rW = map[PoseLandmarkType.rightWrist];
    final lH = map[PoseLandmarkType.leftHip];
    final rH = map[PoseLandmarkType.rightHip];

    if (lW == null || rW == null || lH == null || rH == null) return false;

    // 2. FIND THE MID-LINE (The Pendulum Anchor)
    double bodyCenter = (lH.x + rH.x) / 2;
    double handX = (lW.x + rW.x) / 2;

    // 3. CALCULATE SWEEP (Distance from center)
    // Normalized by body width so distance from camera doesn't break it
    double bodyWidth = (lH.x - rH.x).abs() + 0.01;
    double sweepOffset = (handX - bodyCenter) / bodyWidth;

    // 4. THE THRESHOLD (How far the arms must go)
    // 0.8 body-widths out is a solid "Full Twist"
    double threshold = 0.8; 

    // 5. ZONE DETECTION
    bool inLeftZone = sweepOffset < -threshold;
    bool inRightZone = sweepOffset > threshold;
    bool inCenterZone = sweepOffset.abs() < 0.2; // Return to middle to reset

    if (inCenterZone) {
      _hasCrossedCenter = true; 
    }

    // 6. REFRESH FEEDBACK
    _chargeProgress = (sweepOffset.abs() / threshold).clamp(0.0, 1.0);
    _state = _chargeProgress > 0.1 ? RepState.goingDown : RepState.ready;

    // 7. THE TRIGGER
    if (_hasCrossedCenter) {
      if (inLeftZone && (!_lastWasLeft || _isFirstRep)) {
        _countRep(true);
        return true;
      } else if (inRightZone && (_lastWasLeft || _isFirstRep)) {
        _countRep(false);
        return true;
      }
    }

    _feedback = _chargeProgress > 0.8 ? cueGood : cueBad;
    return false;
  }

  void _countRep(bool left) {
    _repCount++;
    _lastWasLeft = left;
    _isFirstRep = false;
    _hasCrossedCenter = false; // LOCK: Must go back to center before next side
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
  }
}
