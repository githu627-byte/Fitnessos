import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math' as math;
import 'base_pattern.dart';

// THIS FIXES THE "TYPE NOT FOUND" ERROR FOR YOUR CONFIG LIST
enum KneeDriveMode {
  verticalKnee,    // High Knees, Marching, Skaters
  horizontalKnee,  // Mountain Climbers (Plank)
  legRaise,        // Leg Raises, V-ups, Crunches
  buttKick,        // Butt Kicks (Heel to Glute)
}

class KneeDrivePattern extends BasePattern {
  final KneeDriveMode mode;
  final String cueGood;
  final String cueBad;
  final double triggerThreshold;
  final double resetThreshold;

  RepState _state = RepState.ready;
  bool _isLocked = false;
  int _repCount = 0;
  String _feedback = '';
  double _chargeProgress = 0.0;
  bool _justHitTrigger = false;

  // INDEPENDENT LEG MEMORY - This is what makes the circuit work
  double _leftPeak = 999.0; 
  double _rightPeak = 999.0;
  double _leftBase = 0.0;
  double _rightBase = 0.0;
  bool _leftActive = false;
  bool _rightActive = false;

  KneeDrivePattern({
    this.mode = KneeDriveMode.verticalKnee,
    this.cueGood = 'Drive!',
    this.cueBad = 'Higher!',
    this.triggerThreshold = 0.06,
    this.resetThreshold = 0.12,
  });

  @override RepState get state => _state;
  @override bool get isLocked => _isLocked;
  @override int get repCount => _repCount;
  @override String get feedback => _feedback;
  @override double get chargeProgress => _chargeProgress;
  @override bool get justHitTrigger => _justHitTrigger;

  @override
  String get debugInfo => 'KNEEDRIVE\nMode: ${mode.name}\nReps: $_repCount';

  @override
  void captureBaseline(Map<PoseLandmarkType, PoseLandmark> landmarks) {
    _isLocked = true;
    _state = RepState.ready;
    _feedback = 'LOCKED';
    _resetMemory();
  }

  @override
  bool processFrame(Map<PoseLandmarkType, PoseLandmark> landmarks) {
    _justHitTrigger = false;

    // 1. DATA PULL
    final lH = landmarks[PoseLandmarkType.leftHip];
    final rH = landmarks[PoseLandmarkType.rightHip];
    final lK = landmarks[PoseLandmarkType.leftKnee];
    final rK = landmarks[PoseLandmarkType.rightKnee];
    final lA = landmarks[PoseLandmarkType.leftAnkle];
    final rA = landmarks[PoseLandmarkType.rightAnkle];

    if (lH == null || rH == null || lK == null || rK == null || lA == null || rA == null) return false;

    // 2. CALCULATE DISTANCE BASED ON EXERCISE MODE
    double leftVal = _getVal(lH, lK, lA);
    double rightVal = _getVal(rH, rK, rA);

    // Initial base calibration
    if (_leftBase == 0.0) _leftBase = leftVal;
    if (_rightBase == 0.0) _rightBase = rightVal;

    bool repScored = false;

    // 3. LEFT LEG INDEPENDENT TRACKER
    if (leftVal < _leftPeak) _leftPeak = leftVal;
    if (!_leftActive && leftVal < _leftBase - 0.08) _leftActive = true;
    if (_leftActive && leftVal > _leftPeak + triggerThreshold) {
      _repCount++;
      _justHitTrigger = true;
      _leftActive = false;
      _leftPeak = 999.0;
      _leftBase = leftVal; 
      repScored = true;
    }

    // 4. RIGHT LEG INDEPENDENT TRACKER
    if (rightVal < _rightPeak) _rightPeak = rightVal;
    if (!_rightActive && rightVal < _rightBase - 0.08) _rightActive = true;
    if (_rightActive && rightVal > _rightPeak + triggerThreshold) {
      _repCount++;
      _justHitTrigger = true;
      _rightActive = false;
      _rightPeak = 999.0;
      _rightBase = rightVal;
      repScored = true;
    }

    // 5. UPDATE GAUGE
    double currentDepth = math.max((_leftBase - leftVal), (_rightBase - rightVal));
    _chargeProgress = (currentDepth / 0.25).clamp(0.0, 1.0);
    _state = repScored ? RepState.down : RepState.ready;
    _feedback = _chargeProgress > 0.6 ? cueGood : cueBad;

    return repScored;
  }

  // THE ENGINE: Maps your entire config list to the correct biology
  double _getVal(PoseLandmark hip, PoseLandmark knee, PoseLandmark ankle) {
    // Leg length for normalization — prevents ghost reps from walking/swaying
    double legLength = math.sqrt(
      math.pow(hip.x - knee.x, 2) + math.pow(hip.y - knee.y, 2)
    ) + math.sqrt(
      math.pow(knee.x - ankle.x, 2) + math.pow(knee.y - ankle.y, 2)
    );
    if (legLength < 1.0) legLength = 1.0;

    switch (mode) {
      case KneeDriveMode.buttKick:
        // Butt kick: heel kicks UP toward glute
        // Track ankle Y relative to KNEE Y (not hip) — shorter distance, more sensitive
        // When heel kicks up, ankle rises toward knee, value shrinks
        return (ankle.y - knee.y) / legLength;

      case KneeDriveMode.horizontalKnee:
        // Mountain climber: in plank, knee drives toward chest
        // From front camera, knee rises toward hip — same as high knees
        // Using knee-to-hip Y normalized
        return (knee.y - hip.y) / legLength;

      case KneeDriveMode.legRaise:
        // Leg raises, flutter kicks, bicycle crunches
        // Ankle Y relative to hip Y — legs rise up
        return (ankle.y - hip.y) / legLength;

      default: // verticalKnee — HIGH KNEES (WORKING — DO NOT CHANGE THIS LOGIC)
        // Knee Y relative to hip Y, normalized
        return (knee.y - hip.y) / legLength;
    }
  }

  void _resetMemory() {
    _leftPeak = 999.0; _rightPeak = 999.0;
    _leftBase = 0.0; _rightBase = 0.0;
    _leftActive = false; _rightActive = false;
  }

  @override
  void reset() {
    _repCount = 0;
    _state = RepState.ready;
    _resetMemory();
  }
}
