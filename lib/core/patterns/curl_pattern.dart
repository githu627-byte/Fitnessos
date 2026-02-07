import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math' as math;
import 'base_pattern.dart';

/// =============================================================================
/// CURL PATTERN - Wrist Y Position (Hip to Shoulder)
/// =============================================================================
/// Used for: bicep_curls, hammer_curls, barbell_curl, tricep_extensions, etc.
/// 
/// Logic: Track where the wrist is vertically between hip and shoulder.
/// At rest, wrist is near hip (0%).
/// At top of curl, wrist is near shoulder (100%).
/// 
/// triggerAngle/resetAngle are converted to percentage thresholds:
/// - Lower triggerAngle = higher curl completion needed
/// - Higher resetAngle = more extension needed to reset
/// =============================================================================

class CurlPattern implements BasePattern {
  // Config
  final double triggerAngle;  // Converted to trigger percentage
  final double resetAngle;    // Converted to reset percentage
  final String cueGood;
  final String cueBad;
  
  // Derived thresholds
  late final double _triggerPercent;  // % curl needed to trigger
  late final double _resetPercent;    // % curl needed to reset
  
  // State
  RepState _state = RepState.ready;
  bool _baselineCaptured = false;
  int _repCount = 0;
  String _feedback = "";
  bool _justHitTrigger = false;
  
  // Current values - wrist position as % between hip and shoulder
  double _curlProgress = 0; // 0% = at hip, 100% = at shoulder
  double _smoothedCurlProgress = 0;
  
  // Anti-ghost
  static const double _smoothingFactor = 0.3;
  DateTime? _intentTimer;
  DateTime _lastRepTime = DateTime.now();
  static const int _intentDelayMs = 250;
  static const int _minTimeBetweenRepsMs = 500;
  
  CurlPattern({
    this.triggerAngle = 50,   // Default: ~70% curl completion
    this.resetAngle = 150,    // Default: ~30% curl (arm mostly down)
    this.cueGood = "Full curl!",
    this.cueBad = "Squeeze!",
  }) {
    // Convert angles to percentages
    // triggerAngle 50° = arm bent = need high curl % (70%)
    // triggerAngle 90° = arm at 90° = need medium curl % (50%)
    // resetAngle 150° = arm mostly straight = low curl % (30%)
    // resetAngle 120° = arm less straight = higher curl % to reset (40%)
    
    // Simple linear conversion: angle 0-180 maps inversely to progress 100-0
    _triggerPercent = math.max(20, 100 - (triggerAngle * 0.6));  // 50° -> 70%, 90° -> 46%
    _resetPercent = math.max(10, 100 - (resetAngle * 0.6));      // 150° -> 10%, 120° -> 28%
  }
  
  // Getters
  @override
  RepState get state => _state;
  @override
  bool get isLocked => _baselineCaptured;
  @override
  int get repCount => _repCount;
  @override
  String get feedback => _feedback;
  @override
  bool get justHitTrigger => _justHitTrigger;
  
  @override
  double get chargeProgress {
    return (_curlProgress / 100.0).clamp(0.0, 1.0);
  }
  
  @override
  void captureBaseline(Map<PoseLandmarkType, PoseLandmark> map) {
    final lShoulder = map[PoseLandmarkType.leftShoulder];
    final rShoulder = map[PoseLandmarkType.rightShoulder];
    final lHip = map[PoseLandmarkType.leftHip];
    final rHip = map[PoseLandmarkType.rightHip];
    final lWrist = map[PoseLandmarkType.leftWrist];
    final rWrist = map[PoseLandmarkType.rightWrist];
    
    if (lShoulder == null || rShoulder == null || 
        lHip == null || rHip == null || 
        lWrist == null || rWrist == null) {
      _feedback = "Body not in frame";
      return;
    }
    
    _smoothedCurlProgress = 0;
    _curlProgress = 0;
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
    final lWrist = map[PoseLandmarkType.leftWrist];
    final rWrist = map[PoseLandmarkType.rightWrist];
    
    if (lShoulder == null || rShoulder == null || 
        lHip == null || rHip == null || 
        lWrist == null || rWrist == null) {
      _feedback = "Stay in frame";
      return false;
    }
    
    // Calculate Y positions
    double shoulderY = (lShoulder.y + rShoulder.y) / 2;
    double hipY = (lHip.y + rHip.y) / 2;
    double wristY = (lWrist.y + rWrist.y) / 2;
    
    // Total range from shoulder to hip (in screen coords, hip Y > shoulder Y)
    double totalRange = hipY - shoulderY;
    
    // How far wrist is from shoulder
    double wristFromShoulder = wristY - shoulderY;
    
    // Calculate progress: 0% = at hip, 100% = at shoulder
    double rawCurlProgress = 0;
    if (totalRange > 0.01) {
      rawCurlProgress = ((totalRange - wristFromShoulder) / totalRange) * 100;
    }
    
    // Smooth it
    _smoothedCurlProgress = (_smoothingFactor * rawCurlProgress) + ((1 - _smoothingFactor) * _smoothedCurlProgress);
    _curlProgress = _smoothedCurlProgress.clamp(0, 100);
    
    // Check triggers using derived percentages
    bool isDown = _curlProgress >= _triggerPercent;  // Curl complete
    bool isReset = _curlProgress <= _resetPercent;   // Arm back down
    
    // State machine
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
            return true; // REP COUNTED
          }
        } else {
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
    _intentTimer = null;
    _baselineCaptured = false;  // CRITICAL: Allow re-lock for Set 2
    _smoothedCurlProgress = 0;
    _curlProgress = 0;
    _justHitTrigger = false;
  }
}
