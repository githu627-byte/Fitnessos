import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'dart:math' as math;
import 'base_pattern.dart';

/// =============================================================================
/// CORE PATTERN - Track a body point rising from baseline
/// =============================================================================
/// Crunches/sit ups: nose rises off floor
/// Leg raises: ankle rises off floor
/// Hanging leg raises: ankle rises toward hip
/// =============================================================================

enum CoreMode { noseRise, ankleRise }

class CorePattern implements BasePattern {
  final CoreMode coreMode;
  final double triggerRisePercent; // How much the point must rise (% of torso length)
  final double resetRisePercent;   // How close to baseline to reset
  final String cueGood;
  final String cueBad;

  RepState _state = RepState.ready;
  bool _baselineCaptured = false;
  int _repCount = 0;
  String _feedback = "";
  bool _justHitTrigger = false;

  // Baseline
  double _baselineTrackY = 0; // The Y of the point we're tracking at rest
  double _baselineTorsoLength = 0; // For normalization (shoulder to hip distance)

  // Current
  double _currentRisePercent = 0;
  double _smoothedRisePercent = 0;

  static const double _smoothingFactor = 0.35;
  DateTime? _intentTimer;
  DateTime _lastRepTime = DateTime.now();
  static const int _intentDelayMs = 150;
  static const int _minTimeBetweenRepsMs = 500;

  CorePattern({
    this.coreMode = CoreMode.noseRise,
    this.triggerRisePercent = 15.0,
    this.resetRisePercent = 5.0,
    this.cueGood = "Squeeze!",
    this.cueBad = "Higher!",
  });

  @override RepState get state => _state;
  @override bool get isLocked => _baselineCaptured;
  @override int get repCount => _repCount;
  @override String get feedback => _feedback;
  @override bool get justHitTrigger => _justHitTrigger;

  @override
  String get debugInfo => 'CORE ${coreMode.name}\nRise: ${_currentRisePercent.toStringAsFixed(1)}%\nSmooth: ${_smoothedRisePercent.toStringAsFixed(1)}%\nTrig: ${triggerRisePercent.toStringAsFixed(0)}%\nReset: ${resetRisePercent.toStringAsFixed(0)}%\nTorso: ${_baselineTorsoLength.toStringAsFixed(1)}\nState: ${_state.name}\nReps: $_repCount';

  @override
  double get chargeProgress {
    return (_currentRisePercent / triggerRisePercent).clamp(0.0, 1.0);
  }

  @override
  void captureBaseline(Map<PoseLandmarkType, PoseLandmark> map) {
    // Get torso length for normalization
    final lShoulder = map[PoseLandmarkType.leftShoulder];
    final rShoulder = map[PoseLandmarkType.rightShoulder];
    final lHip = map[PoseLandmarkType.leftHip];
    final rHip = map[PoseLandmarkType.rightHip];

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

    _baselineTorsoLength = (hipY - shoulderY).abs();
    if (_baselineTorsoLength < 10) _baselineTorsoLength = 100;

    // Capture baseline Y of the tracked point
    if (coreMode == CoreMode.noseRise) {
      final nose = map[PoseLandmarkType.nose];
      if (nose == null) {
        _feedback = "Face not visible";
        return;
      }
      _baselineTrackY = nose.y;
    } else {
      // ankleRise
      final lAnkle = map[PoseLandmarkType.leftAnkle];
      final rAnkle = map[PoseLandmarkType.rightAnkle];
      if (lAnkle == null && rAnkle == null) {
        _feedback = "Legs not visible";
        return;
      }
      double ankleY = 0;
      int ac = 0;
      if (lAnkle != null) { ankleY += lAnkle.y; ac++; }
      if (rAnkle != null) { ankleY += rAnkle.y; ac++; }
      if (ac > 0) ankleY /= ac;
      _baselineTrackY = ankleY;
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

    // Get current Y of tracked point
    double currentY;
    if (coreMode == CoreMode.noseRise) {
      final nose = map[PoseLandmarkType.nose];
      if (nose == null) {
        _feedback = "Face not visible";
        return false;
      }
      currentY = nose.y;
    } else {
      final lAnkle = map[PoseLandmarkType.leftAnkle];
      final rAnkle = map[PoseLandmarkType.rightAnkle];
      if (lAnkle == null && rAnkle == null) {
        _feedback = "Legs not visible";
        return false;
      }
      double ankleY = 0;
      int ac = 0;
      if (lAnkle != null) { ankleY += lAnkle.y; ac++; }
      if (rAnkle != null) { ankleY += rAnkle.y; ac++; }
      if (ac > 0) ankleY /= ac;
      currentY = ankleY;
    }

    // Rise = baseline minus current (Y decreases when going up on screen)
    double rise = _baselineTrackY - currentY;
    double rawRisePercent = (rise / _baselineTorsoLength) * 100;

    _smoothedRisePercent = (_smoothingFactor * rawRisePercent) + ((1 - _smoothingFactor) * _smoothedRisePercent);
    _currentRisePercent = _smoothedRisePercent;

    bool isTriggered = _currentRisePercent >= triggerRisePercent;
    bool isReset = _currentRisePercent <= resetRisePercent;

    // State machine - same as calf/curl (proven working)
    switch (_state) {
      case RepState.ready:
      case RepState.up:
        if (isTriggered) {
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
        if (isTriggered) {
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
