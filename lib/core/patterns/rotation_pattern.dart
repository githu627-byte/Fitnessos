import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math' as math;
import 'base_pattern.dart';

class RotationPattern implements BasePattern {
  final double triggerAngle; 
  final String cueGood;
  final String cueBad;
  
  RepState _state = RepState.ready;
  bool _baselineCaptured = false;
  int _repCount = 0;
  String _feedback = "";
  bool _justHitTrigger = false;
  
  bool _sideSwitched = true;
  bool _lastWasLeft = false;
  double _currentTorque = 0;

  RotationPattern({
    this.triggerAngle = 35.0, // Tightened to 35 for better response
    this.cueGood = "Good Twist!",
    this.cueBad = "Rotate Core!",
  });
  
  @override RepState get state => _state;
  @override bool get isLocked => _baselineCaptured;
  @override int get repCount => _repCount;
  @override String get feedback => _feedback;
  @override bool get justHitTrigger => _justHitTrigger;
  @override double get chargeProgress => (_currentTorque.abs() / triggerAngle).clamp(0.0, 1.0);
  
  @override
  void captureBaseline(Map<PoseLandmarkType, PoseLandmark> map) {
    _baselineCaptured = true;
    _state = RepState.ready;
  }
  
  @override
  bool processFrame(Map<PoseLandmarkType, PoseLandmark> map) {
    if (!_baselineCaptured) return false;
    _justHitTrigger = false;

    final lSh = map[PoseLandmarkType.leftShoulder];
    final rSh = map[PoseLandmarkType.rightShoulder];
    final lH = map[PoseLandmarkType.leftHip];
    final rH = map[PoseLandmarkType.rightHip];
    
    if (lSh == null || rSh == null || lH == null || rH == null) return false;

    // 1. CALCULATE ANGLES FOR SHOULDERS AND HIPS SEPARATELY
    // We use atan2 on X and Z to get the "Top-Down" angle of each line
    double shoulderAngle = math.atan2((lSh.z ?? 0) - (rSh.z ?? 0), lSh.x - rSh.x) * (180 / math.pi);
    double hipAngle = math.atan2((lH.z ?? 0) - (rH.z ?? 0), lH.x - rH.x) * (180 / math.pi);

    // 2. TORQUE = The difference between shoulder rotation and hip stability
    // This is what actually measures a Russian Twist
    _currentTorque = shoulderAngle - hipAngle;

    // Handle degree wrap-around (e.g., jumping from 179 to -179)
    if (_currentTorque > 180) _currentTorque -= 360;
    if (_currentTorque < -180) _currentTorque += 360;

    // 3. TRIGGER LOGIC
    bool rotatingLeft = _currentTorque < -triggerAngle;
    bool rotatingRight = _currentTorque > triggerAngle;

    // Reset neutral zone so user can't "jiggle" for reps
    if (_currentTorque.abs() < 15) {
      _sideSwitched = true;
      _state = RepState.ready;
    }

    if (_sideSwitched) {
      if (rotatingLeft && !_lastWasLeft) {
        _countRep(true);
        return true;
      } else if (rotatingRight && _lastWasLeft) {
        _countRep(false);
        return true;
      } 
      // Handle the very first rep of a set
      else if ((rotatingLeft || rotatingRight) && _repCount == 0) {
        _countRep(rotatingLeft);
        return true;
      }
    }

    _feedback = _currentTorque.abs() > 20 ? cueGood : cueBad;
    return false;
  }

  void _countRep(bool left) {
    _repCount++;
    _lastWasLeft = left;
    _sideSwitched = false; // Must return toward center to trigger next side
    _justHitTrigger = true;
    _state = RepState.down;
  }

  @override
  void reset() {
    _repCount = 0;
    _state = RepState.ready;
    _baselineCaptured = false;
    _lastWasLeft = false;
    _sideSwitched = true;
  }
}
