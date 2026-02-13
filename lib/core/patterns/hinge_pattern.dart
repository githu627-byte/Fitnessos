import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math' as math;
import 'base_pattern.dart';

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

  // Standard hinge baseline
  double _baselineShoulderHipY = 0;

  // Floor mode baselines
  double _baselineHipY = 0;
  double _baselineLegLength = 0;

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
      // Floor: hip rises = percentage drops below 100
      // At rest ~100%, at top of bridge ~80%. Gauge fills as it drops.
      double progress = (100 - _currentPercentage) / 15;
      return progress.clamp(0.0, 1.0);
    } else if (inverted) {
      // FIXED: Scale between reset (115) and trigger (125)
      return ((_currentPercentage - 115) / 10).clamp(0.0, 1.0);
    } else {
      double trigger = triggerPercent * 100;
      return ((100 - _currentPercentage) / (100 - trigger)).clamp(0.0, 1.0);
    }
  }

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

    double hipY = 0;
    int hc = 0;
    if (lHip != null) { hipY += lHip.y; hc++; }
    if (rHip != null) { hipY += rHip.y; hc++; }
    if (hc > 0) hipY /= hc;

    if (floor) {
      // =====================================================================
      // FLOOR MODE BASELINE - Glute bridge, frog pump
      // Capture hip Y position and leg length for normalization
      // =====================================================================
      final lAnkle = map[PoseLandmarkType.leftAnkle];
      final rAnkle = map[PoseLandmarkType.rightAnkle];

      double ankleY = 0;
      int ac = 0;
      if (lAnkle != null) { ankleY += lAnkle.y; ac++; }
      if (rAnkle != null) { ankleY += rAnkle.y; ac++; }
      if (ac > 0) ankleY /= ac;

      _baselineHipY = hipY;
      _baselineLegLength = (ankleY - hipY).abs();

      if (_baselineLegLength < 10) {
        _feedback = "Move back";
        return;
      }

      _smoothedPercentage = 100;
      _baselineCaptured = true;
      _state = RepState.ready;
      _feedback = "LOCKED";
      return;
    }

    // =====================================================================
    // STANDARD + INVERTED BASELINE - Unchanged
    // =====================================================================
    double shoulderY = 0;
    int sc = 0;
    if (lShoulder != null) { shoulderY += lShoulder.y; sc++; }
    if (rShoulder != null) { shoulderY += rShoulder.y; sc++; }
    if (sc > 0) shoulderY /= sc;

    _baselineShoulderHipY = (hipY - shoulderY).abs();

    if (_baselineShoulderHipY < 0.01) {
      _feedback = "Move back";
      return;
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

    double hipY = 0;
    int hc = 0;
    if (lHip != null) { hipY += lHip.y; hc++; }
    if (rHip != null) { hipY += rHip.y; hc++; }
    if (hc > 0) hipY /= hc;

    double rawPercentage;

    if (floor) {
      // =====================================================================
      // FLOOR MODE PROCESSING
      // Track hip Y relative to baseline, normalized by leg length
      // Hip on floor = 100%. Hip rises = percentage drops (Y goes up on screen)
      // =====================================================================
      rawPercentage = (_baselineLegLength > 0.01)
          ? (hipY / _baselineHipY) * 100
          : 100;
    } else {
      // =====================================================================
      // STANDARD + INVERTED PROCESSING - Unchanged
      // =====================================================================
      double shoulderY = 0;
      int sc = 0;
      if (lShoulder != null) { shoulderY += lShoulder.y; sc++; }
      if (rShoulder != null) { shoulderY += rShoulder.y; sc++; }
      if (sc > 0) shoulderY /= sc;

      double currentShoulderHipY = (hipY - shoulderY).abs();

      rawPercentage = (_baselineShoulderHipY > 0.01)
          ? (currentShoulderHipY / _baselineShoulderHipY) * 100
          : 100;
    }

    _smoothedPercentage = (_smoothingFactor * rawPercentage) + ((1 - _smoothingFactor) * _smoothedPercentage);
    _currentPercentage = _smoothedPercentage.clamp(0, 200);

    // =====================================================================
    // STATE MACHINE THRESHOLDS
    // =====================================================================
    bool isDown;
    bool isReset;

    if (floor) {
      // Floor: hip rises = Y drops = percentage drops below 100
      // Trigger when hip rises enough (percentage drops to 85)
      // Reset when hip comes back down (percentage returns to 95)
      isDown = _currentPercentage <= 85;
      isReset = _currentPercentage >= 95;
    } else if (inverted) {
      // FIXED: Lowered from 140→125, widened reset from 110→115
      isDown = _currentPercentage >= 125;
      isReset = _currentPercentage <= 115;
    } else {
      // Standard hinge - UNCHANGED
      isDown = _currentPercentage <= (triggerPercent * 100);
      isReset = _currentPercentage >= (resetPercent * 100);
    }

    // =====================================================================
    // STATE MACHINE - Same logic for all modes
    // =====================================================================

    // FIXED: Shorter intent delay for inverted/floor (150ms vs 250ms)
    // Hip thrusts and bridges are faster movements, don't need as long
    int effectiveIntentDelay = (inverted || floor) ? 150 : _intentDelayMs;

    switch (_state) {
      case RepState.ready:
      case RepState.up:
        if (isDown) {
          _intentTimer ??= DateTime.now();
          if (DateTime.now().difference(_intentTimer!).inMilliseconds > effectiveIntentDelay) {
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
          if (DateTime.now().difference(_intentTimer!).inMilliseconds > effectiveIntentDelay) {
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
