import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math' as math;
import 'base_pattern.dart';

/// =============================================================================
/// STEP UP PATTERN - Hip Rises UP
/// =============================================================================
/// Used for: step_up, step_ups, box_stepups, box_step_up
/// 
/// Logic: Track hip Y going UP (Y decreases on screen).
/// When hip rises above baseline by threshold, trigger.
/// When hip returns near baseline, count rep.
/// 
/// This is INVERTED from SquatPattern:
/// - Squat: Hip goes DOWN (Y increases) → trigger
/// - StepUp: Hip goes UP (Y decreases) → trigger
/// =============================================================================

class StepUpPattern implements BasePattern {
  // Config
  final String cueGood;
  final String cueBad;
  
  // State
  RepState _state = RepState.ready;
  bool _baselineCaptured = false;
  int _repCount = 0;
  String _feedback = "";
  bool _justHitTrigger = false;
  
  // Baseline
  double _baselineHipY = 0; // Hip Y when standing on ground
  double _baselineLegLength = 0; // For normalization
  
  // Thresholds (as percentage of leg length)
  static const double _triggerRisePercent = 15.0; // Hip must rise 15% of leg length
  static const double _resetRisePercent = 5.0; // Reset when within 5% of baseline
  
  // Current values
  double _currentRisePercent = 0;
  double _smoothedRisePercent = 0;
  
  // Anti-ghost
  static const double _smoothingFactor = 0.3;
  DateTime? _intentTimer;
  DateTime _lastRepTime = DateTime.now();
  static const int _intentDelayMs = 150;
  static const int _minTimeBetweenRepsMs = 400;
  
  StepUpPattern({
    this.cueGood = "Up!",
    this.cueBad = "Drive!",
  });
  
  // Getters
  @override RepState get state => _state;
  @override bool get isLocked => _baselineCaptured;
  @override int get repCount => _repCount;
  @override String get feedback => _feedback;
  @override bool get justHitTrigger => _justHitTrigger;
  
  @override
  String get debugInfo => 'STEPUP\nRise: ${_currentRisePercent.toStringAsFixed(1)}%\nState: ${_state.name}\nReps: $_repCount';

  @override
  double get chargeProgress {
    double progress = _currentRisePercent / _triggerRisePercent;
    return progress.clamp(0.0, 1.0);
  }
  
  @override
  void captureBaseline(Map<PoseLandmarkType, PoseLandmark> map) {
    final lHip = map[PoseLandmarkType.leftHip];
    final rHip = map[PoseLandmarkType.rightHip];
    final lAnkle = map[PoseLandmarkType.leftAnkle];
    final rAnkle = map[PoseLandmarkType.rightAnkle];
    
    if (lHip == null || lAnkle == null) {
      _feedback = "Body not in frame";
      return;
    }
    
    // Baseline hip Y (average both hips)
    _baselineHipY = rHip != null ? (lHip.y + rHip.y) / 2 : lHip.y;
    
    // Leg length for normalization
    double leftLeg = (lAnkle.y - lHip.y).abs();
    double rightLeg = rAnkle != null && rHip != null 
        ? (rAnkle.y - rHip.y).abs() 
        : leftLeg;
    _baselineLegLength = (leftLeg + rightLeg) / 2;
    
    if (_baselineLegLength < 10) {
      _feedback = "Move back";
      return;
    }
    
    _smoothedRisePercent = 0;
    _currentRisePercent = 0;
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
    
    final lHip = map[PoseLandmarkType.leftHip];
    final rHip = map[PoseLandmarkType.rightHip];
    
    if (lHip == null) {
      _feedback = "Stay in frame";
      return false;
    }
    
    // Current hip Y
    double currentHipY = rHip != null ? (lHip.y + rHip.y) / 2 : lHip.y;
    
    // Calculate rise (positive = hip went UP)
    // baseline - current because Y decreases when going UP on screen
    double rise = _baselineHipY - currentHipY;
    
    // Convert to percentage of leg length
    double rawRisePercent = (rise / _baselineLegLength) * 100;
    
    // Smooth
    _smoothedRisePercent = (_smoothingFactor * rawRisePercent) + ((1 - _smoothingFactor) * _smoothedRisePercent);
    _currentRisePercent = _smoothedRisePercent;
    
    // Check thresholds
    bool isUp = _currentRisePercent >= _triggerRisePercent;
    bool isReset = _currentRisePercent <= _resetRisePercent;
    
    // State machine
    switch (_state) {
      case RepState.ready:
      case RepState.down:
        if (isUp) {
          _intentTimer ??= DateTime.now();
          if (DateTime.now().difference(_intentTimer!).inMilliseconds > _intentDelayMs) {
            _state = RepState.up;
            _feedback = cueGood;
            _intentTimer = null;
            _justHitTrigger = true;
          } else {
            _state = RepState.goingUp;
          }
        } else {
          _intentTimer = null;
          _state = RepState.ready;
          if (_currentRisePercent > _resetRisePercent) {
            _feedback = cueBad;
          } else {
            _feedback = "";
          }
        }
        return false;
        
      case RepState.goingUp:
        if (isUp) {
          _intentTimer ??= DateTime.now();
          if (DateTime.now().difference(_intentTimer!).inMilliseconds > _intentDelayMs) {
            _state = RepState.up;
            _feedback = cueGood;
            _intentTimer = null;
            _justHitTrigger = true;
          }
        } else {
          _intentTimer = null;
          _state = RepState.ready;
        }
        return false;

      case RepState.up:
        if (isReset) {
          _state = RepState.goingDown;
        }
        return false;
        
      case RepState.goingDown:
        if (isReset) {
          if (DateTime.now().difference(_lastRepTime).inMilliseconds > _minTimeBetweenRepsMs) {
            _state = RepState.down;
            _repCount++;
            _lastRepTime = DateTime.now();
            _feedback = "";
            return true; // REP COUNTED
          }
        } else {
          _state = RepState.up;
        }
        return false;
    }
  }
  
  @override
  void reset() {
    _repCount = 0;
    _state = RepState.ready;
    _feedback = "";
    _intentTimer = null;
    _baselineCaptured = false;
    _smoothedRisePercent = 0;
    _currentRisePercent = 0;
    _justHitTrigger = false;
  }
}
