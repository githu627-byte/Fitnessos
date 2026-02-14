import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math' as math;
import 'base_pattern.dart';

/// =============================================================================
/// HINGE PATTERN - Shoulder Y Position Relative to Hip (FIXED)
/// =============================================================================
/// Used for: deadlift, romanian_deadlift, good_morning, kettlebell_swing, etc.
/// 
/// FIXED: Uses Y-position tracking (like CurlPattern) instead of angles.
/// Works from ANY camera angle!
/// =============================================================================

class HingePattern implements BasePattern {
  final double triggerPercent;
  final double resetPercent;
  final bool inverted;
  final bool floor;
  final String cueGood;
  final String cueBad;
  
  RepState _state = RepState.ready;
  bool _baselineCaptured = false;
  int _repCount = 0;
  String _feedback = "";
  bool _justHitTrigger = false;
  
  double _baselineShoulderHipY = 0;
  double _baselineHipY = 0;
  double _baselineKneeY = 0;
  double _hipRisePercent = 0;
  double _currentPercentage = 100;
  double _smoothedPercentage = 100;
  
  static const double _smoothingFactor = 0.3;
  DateTime? _intentTimer;
  DateTime _lastRepTime = DateTime.now();
  static const int _intentDelayMs = 250;
  static const int _minTimeBetweenRepsMs = 500;
  
  HingePattern({
    this.triggerPercent = 0.40,
    this.resetPercent = 0.75,
    this.inverted = false,
    this.floor = false,
    this.cueGood = "Lockout!",
    this.cueBad = "Hips forward!",
  });
  
  @override RepState get state => _state;
  @override bool get isLocked => _baselineCaptured;
  @override int get repCount => _repCount;
  @override String get feedback => _feedback;
  @override bool get justHitTrigger => _justHitTrigger;
  
  @override
  double get chargeProgress {
    if (floor) {
      return ((_currentPercentage - 100) / 15).clamp(0.0, 1.0);
    } else if (inverted) {
      return ((_currentPercentage - 100) / 15).clamp(0.0, 1.0);
    } else {
      double trigger = triggerPercent * 100;
      return ((100 - _currentPercentage) / (100 - trigger)).clamp(0.0, 1.0);
    }
  }
  
  @override
  String get debugInfo => 'HINGE\nMode: ${floor ? "FLOOR" : inverted ? "INV" : "STD"}\nPct: ${_currentPercentage.toStringAsFixed(1)}%\nSmooth: ${_smoothedPercentage.toStringAsFixed(1)}%\nBaseline: ${_baselineShoulderHipY.toStringAsFixed(1)}\n${floor ? "HipY: ${_baselineHipY.toStringAsFixed(1)}\nRise: ${_hipRisePercent.toStringAsFixed(1)}%" : "Inv: $inverted"}\nState: ${_state.name}\nReps: $_repCount';

  @override
  void captureBaseline(Map<PoseLandmarkType, PoseLandmark> map) {
    final lShoulder = map[PoseLandmarkType.leftShoulder];
    final rShoulder = map[PoseLandmarkType.rightShoulder];
    final lHip = map[PoseLandmarkType.leftHip];
    final rHip = map[PoseLandmarkType.rightHip];
    
    if ((lShoulder == null && rShoulder == null) || 
        (lHip == null && rHip == null)) {
      _feedback = "Body not in frame";
      return;
    }
    
    double shoulderY = 0;
    int sc = 0;
    if (lShoulder != null) { shoulderY += lShoulder.y; sc++; }
    if (rShoulder != null) { shoulderY += rShoulder.y; sc++; }
    if (sc > 0) shoulderY /= sc;
    
    double hipY = 0;
    int hc = 0;
    if (lHip != null) { hipY += lHip.y; hc++; }
    if (rHip != null) { hipY += rHip.y; hc++; }
    if (hc > 0) hipY /= hc;
    
    _baselineShoulderHipY = (hipY - shoulderY).abs();
    
    if (_baselineShoulderHipY < 0.01) {
      _feedback = "Move back";
      return;
    }
    
    // FLOOR MODE: Also capture absolute hip Y and knee Y
    if (floor) {
      _baselineHipY = hipY;
      final lKnee = map[PoseLandmarkType.leftKnee];
      final rKnee = map[PoseLandmarkType.rightKnee];
      double kneeY = 0;
      int kc = 0;
      if (lKnee != null) { kneeY += lKnee.y; kc++; }
      if (rKnee != null) { kneeY += rKnee.y; kc++; }
      if (kc > 0) kneeY /= kc;
      _baselineKneeY = kneeY;
    }

    _smoothedPercentage = 100;
    _baselineCaptured = true;
    _state = RepState.ready;
    _feedback = "LOCKED";
  }
  
  @override
  bool processFrame(Map<PoseLandmarkType, PoseLandmark> map) {
    if (!_baselineCaptured) {
      _feedback = "Waiting for lock";
      return false;
    }
    
    _justHitTrigger = false;
    
    final lShoulder = map[PoseLandmarkType.leftShoulder];
    final rShoulder = map[PoseLandmarkType.rightShoulder];
    final lHip = map[PoseLandmarkType.leftHip];
    final rHip = map[PoseLandmarkType.rightHip];
    
    if ((lShoulder == null && rShoulder == null) || 
        (lHip == null && rHip == null)) {
      _feedback = "Stay in frame";
      return false;
    }
    
    double shoulderY = 0;
    int sc = 0;
    if (lShoulder != null) { shoulderY += lShoulder.y; sc++; }
    if (rShoulder != null) { shoulderY += rShoulder.y; sc++; }
    if (sc > 0) shoulderY /= sc;
    
    double hipY = 0;
    int hc = 0;
    if (lHip != null) { hipY += lHip.y; hc++; }
    if (rHip != null) { hipY += rHip.y; hc++; }
    if (hc > 0) hipY /= hc;
    
    double currentShoulderHipY = (hipY - shoulderY).abs();

    // FLOOR MODE: Track hip Y rising instead of shoulder-hip ratio
    if (floor) {
      double legLength = (_baselineKneeY - _baselineHipY).abs();
      if (legLength < 1) legLength = 100;
      double hipRise = _baselineHipY - hipY; // positive = hips went up (Y decreases)
      _hipRisePercent = (hipRise / legLength) * 100;

      double rawPct = 100 + _hipRisePercent; // 100% at rest, goes higher as hips rise
      _smoothedPercentage = (_smoothingFactor * rawPct) + ((1 - _smoothingFactor) * _smoothedPercentage);
      _currentPercentage = _smoothedPercentage;

      // Use inverted logic - trigger when percentage goes UP (hips rise)
      bool isDown = _currentPercentage >= 112; // Hips rose 12% of leg length
      bool isReset = _currentPercentage <= 104; // Hips back near floor

      // Run the same state machine
      switch (_state) {
        case RepState.ready:
        case RepState.up:
          if (isDown) {
            _intentTimer ??= DateTime.now();
            if (DateTime.now().difference(_intentTimer!).inMilliseconds > _intentDelayMs) {
              _state = RepState.down;
              _feedback = cueGood;
              _intentTimer = null;
              _justHitTrigger = true;
            } else {
              _state = RepState.goingDown;
            }
          } else {
            _intentTimer = null;
            _state = RepState.ready;
            _feedback = "";
          }
          return false;
        case RepState.goingDown:
          if (isDown) {
            _intentTimer ??= DateTime.now();
            if (DateTime.now().difference(_intentTimer!).inMilliseconds > _intentDelayMs) {
              _state = RepState.down;
              _feedback = cueGood;
              _intentTimer = null;
              _justHitTrigger = true;
            }
          } else {
            _intentTimer = null;
            _state = RepState.ready;
          }
          return false;
        case RepState.down:
          if (isReset) {
            _state = RepState.goingUp;
          }
          return false;
        case RepState.goingUp:
          if (isReset) {
            if (DateTime.now().difference(_lastRepTime).inMilliseconds > _minTimeBetweenRepsMs) {
              _state = RepState.up;
              _repCount++;
              _lastRepTime = DateTime.now();
              _feedback = "";
              return true;
            }
          } else {
            _state = RepState.down;
          }
          return false;
      }
    }

    double rawPercentage = (_baselineShoulderHipY > 0.01)
        ? (currentShoulderHipY / _baselineShoulderHipY) * 100
        : 100;
    
    _smoothedPercentage = (_smoothingFactor * rawPercentage) + ((1 - _smoothingFactor) * _smoothedPercentage);
    _currentPercentage = _smoothedPercentage.clamp(0, 200);
    
    bool isDown;
    bool isReset;
    
    if (inverted) {
      isDown = _currentPercentage >= 115;
      isReset = _currentPercentage <= 105;
    } else {
      isDown = _currentPercentage <= (triggerPercent * 100);
      isReset = _currentPercentage >= (resetPercent * 100);
    }
    
    switch (_state) {
      case RepState.ready:
      case RepState.up:
        if (isDown) {
          _intentTimer ??= DateTime.now();
          if (DateTime.now().difference(_intentTimer!).inMilliseconds > _intentDelayMs) {
            _state = RepState.down;
            _feedback = cueGood;
            _intentTimer = null;
            _justHitTrigger = true;
          } else {
            _state = RepState.goingDown;
          }
        } else {
          _intentTimer = null;
          _state = RepState.ready;
          _feedback = "";
        }
        return false;
        
      case RepState.goingDown:
        if (isDown) {
          _intentTimer ??= DateTime.now();
          if (DateTime.now().difference(_intentTimer!).inMilliseconds > _intentDelayMs) {
            _state = RepState.down;
            _feedback = cueGood;
            _intentTimer = null;
            _justHitTrigger = true;
          }
        } else {
          _intentTimer = null;
          _state = RepState.ready;
          _feedback = cueBad;
        }
        return false;
        
      case RepState.down:
        if (isReset) {
          if (DateTime.now().difference(_lastRepTime).inMilliseconds > _minTimeBetweenRepsMs) {
            _repCount++;
            _lastRepTime = DateTime.now();
            _state = RepState.up;
            _feedback = "";
            return true;
          }
        }
        return false;
        
      case RepState.goingUp:
        if (isReset) {
          if (DateTime.now().difference(_lastRepTime).inMilliseconds > _minTimeBetweenRepsMs) {
            _repCount++;
            _lastRepTime = DateTime.now();
            _state = RepState.up;
            _feedback = "";
            return true;
          }
        } else if (isDown) {
          _state = RepState.down;
        }
        return false;
    }
  }
  
  @override
  void reset() {
    _repCount = 0;
    _state = RepState.ready;
    _feedback = "";
    _baselineCaptured = false;
    _intentTimer = null;
    _justHitTrigger = false;
    _smoothedPercentage = 100;
    _currentPercentage = 100;
  }
}
