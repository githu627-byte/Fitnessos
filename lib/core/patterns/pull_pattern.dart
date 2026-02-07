import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math' as math;
import 'base_pattern.dart';

/// =============================================================================
/// PULL PATTERN - Elbow Angle Logic (TUNED FOR FLOOR VIEW)
/// =============================================================================
/// Used for: rows, pull-ups, lat_pulldowns, face_pulls.
///
/// REFACTOR 2026-01-19:
/// - Uses Elbow Angle.
/// - RELAXED THRESHOLDS: Extension set to 125° to handle "Foreshortening"
///   when filming Bent Over Rows from the floor (where straight arms look bent).
/// =============================================================================

class PullPattern implements BasePattern {
  final double triggerPercent;
  final double resetPercent;
  final String cueGood;
  final String cueBad;

  RepState _state = RepState.ready;
  bool _baselineCaptured = false;
  int _repCount = 0;
  String _feedback = "";
  bool _justHitTrigger = false;

  // ANGLE THRESHOLDS (TUNED)
  // Extension: 125 degrees (Low to allow floor-view foreshortening)
  // Flexion: 105 degrees (Higher to ensure easy trigger)
  static const double _extensionThreshold = 125.0;
  static const double _flexionThreshold = 105.0;

  double _currentAngle = 180;
  double _smoothedAngle = 180;

  static const double _smoothingFactor = 0.3;
  DateTime? _intentTimer;
  DateTime _lastRepTime = DateTime.now();
  static const int _intentDelayMs = 200;
  static const int _minTimeBetweenRepsMs = 400;

  PullPattern({
    this.triggerPercent = 0.55,
    this.resetPercent = 0.85,
    this.cueGood = "Squeeze!",
    this.cueBad = "Full extension!",
  });

  @override RepState get state => _state;
  @override bool get isLocked => _baselineCaptured;
  @override int get repCount => _repCount;
  @override String get feedback => _feedback;
  @override bool get justHitTrigger => _justHitTrigger;

  @override
  double get chargeProgress {
    // Start Straight (180) -> Goal Bent (90)
    // Adjusted visualization to match new thresholds
    return ((180 - _currentAngle) / (180 - 90)).clamp(0.0, 1.0);
  }

  double _calculateAngle(PoseLandmark first, PoseLandmark middle, PoseLandmark last) {
    double dx1 = first.x - middle.x;
    double dy1 = first.y - middle.y;
    double dx2 = last.x - middle.x;
    double dy2 = last.y - middle.y;

    double dot = dx1 * dx2 + dy1 * dy2;
    double mag1 = math.sqrt(dx1 * dx1 + dy1 * dy1);
    double mag2 = math.sqrt(dx2 * dx2 + dy2 * dy2);

    if (mag1 * mag2 == 0) return 180;

    double cosine = (dot / (mag1 * mag2)).clamp(-1.0, 1.0);
    return (math.acos(cosine) * 180 / math.pi);
  }

  @override
  void captureBaseline(Map<PoseLandmarkType, PoseLandmark> map) {
    final lShoulder = map[PoseLandmarkType.leftShoulder];
    final lElbow = map[PoseLandmarkType.leftElbow];
    final lWrist = map[PoseLandmarkType.leftWrist];
    
    if (lShoulder == null || lElbow == null || lWrist == null) {
      _feedback = "Body not in frame";
      return;
    }
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
    final lElbow = map[PoseLandmarkType.leftElbow];
    final rElbow = map[PoseLandmarkType.rightElbow];
    final lWrist = map[PoseLandmarkType.leftWrist];
    final rWrist = map[PoseLandmarkType.rightWrist];

    // Calculate angles
    double angleL = 180;
    double angleR = 180;
    int validArms = 0;

    if (lShoulder != null && lElbow != null && lWrist != null && lShoulder.likelihood > 0.5) {
      angleL = _calculateAngle(lShoulder, lElbow, lWrist);
      validArms++;
    }
    if (rShoulder != null && rElbow != null && rWrist != null && rShoulder.likelihood > 0.5) {
      angleR = _calculateAngle(rShoulder, rElbow, rWrist);
      validArms++;
    }

    if (validArms == 0) {
      _feedback = "Arms not visible";
      return false;
    }

    // Use the "Most Bent" arm (the one doing the work)
    double rawAngle = 180;
    if (validArms == 2) {
       rawAngle = (angleL + angleR) / 2;
    } else {
       rawAngle = (angleL < 180) ? angleL : angleR; 
    }

    _smoothedAngle = (_smoothingFactor * rawAngle) + ((1 - _smoothingFactor) * _smoothedAngle);
    _currentAngle = _smoothedAngle;

    bool isBent = _currentAngle <= _flexionThreshold;      
    bool isStraight = _currentAngle >= _extensionThreshold;

    // State Machine
    switch (_state) {
      case RepState.ready: // Extended
      case RepState.goingDown:
        if (isBent) { // PULLED IN
           _intentTimer ??= DateTime.now();
           if (DateTime.now().difference(_intentTimer!).inMilliseconds > _intentDelayMs) {
              _state = RepState.down;
              _feedback = cueGood;
              _intentTimer = null;
              _justHitTrigger = true;
           }
        }
        break;

      case RepState.down: // Pulled In
        if (isStraight) { // EXTENDED BACK
           if (DateTime.now().difference(_lastRepTime).inMilliseconds > _minTimeBetweenRepsMs) {
              _repCount++;
              _lastRepTime = DateTime.now();
              _state = RepState.ready;
              _feedback = "";
              return true; 
           }
        }
        break;
        
      default:
        _state = RepState.ready;
        break;
    }

    return false;
  }

  @override
  void reset() {
    _repCount = 0;
    _state = RepState.ready;
    _feedback = "";
    _baselineCaptured = false;
    _currentAngle = 180;
    _smoothedAngle = 180;
    _intentTimer = null;
    _justHitTrigger = false;
  }
}
