import 'dart:math' as math;
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

enum FaultSeverity { low, medium, high, critical }

class FormFault {
  final String message;
  final String? correction;
  final String? bodyPart;
  final FaultSeverity severity;
  final int deduction;
  const FormFault({required this.message, this.correction, this.bodyPart, required this.severity, required this.deduction});
}

class FormCheckResult {
  final int formScore;
  final List<FormFault> faults;
  final Map<String, double> angles;
  final String? voiceWarning;
  const FormCheckResult({required this.formScore, required this.faults, required this.angles, this.voiceWarning});
}

class FormCheckRules {
  final String exerciseName;
  final List<FormRule> rules;
  const FormCheckRules({required this.exerciseName, required this.rules});
}

class FormRule {
  final String name;
  final String checkType;
  final List<PoseLandmarkType> landmarks;
  final double? minAngle;
  final double? maxAngle;
  final String faultMessage;
  final String? correction;
  final String? bodyPart;
  final FaultSeverity severity;
  final int deduction;
  const FormRule({required this.name, required this.checkType, required this.landmarks, this.minAngle, this.maxAngle, required this.faultMessage, this.correction, this.bodyPart, required this.severity, required this.deduction});
}

class FormChecker {
  final FormCheckRules rules;
  final Map<String, double> _smoothedAngles = {};
  static const double _smoothingFactor = 0.3;
  final Map<String, int> _faultCounters = {};
  static const int _faultThreshold = 5;
  DateTime? _lastVoiceTime;
  String? _lastVoiceMessage;
  static const Duration _voiceCooldown = Duration(seconds: 3);

  FormChecker(this.rules);

  void reset() { _smoothedAngles.clear(); _faultCounters.clear(); _lastVoiceTime = null; _lastVoiceMessage = null; }

  FormCheckResult analyzeForm(Map<PoseLandmarkType, PoseLandmark> landmarks) {
    final faults = <FormFault>[];
    final angles = <String, double>{};
    int totalDeduction = 0;
    String? voiceWarning;

    for (final rule in rules.rules) {
      if (rule.checkType == 'angle' && rule.landmarks.length >= 3) {
        final angle = _calcBestAngle(rule.landmarks[0], rule.landmarks[1], rule.landmarks[2], landmarks);
        if (angle != null) {
          final smoothed = _smoothAngle(rule.name, angle);
          angles[rule.name] = smoothed;
          if (!_isAngleValid(smoothed, rule.minAngle, rule.maxAngle)) {
            _faultCounters[rule.name] = (_faultCounters[rule.name] ?? 0) + 1;
            if (_faultCounters[rule.name]! >= _faultThreshold) {
              faults.add(FormFault(message: rule.faultMessage, correction: rule.correction, bodyPart: rule.bodyPart, severity: rule.severity, deduction: rule.deduction));
              totalDeduction += rule.deduction;
              if (_shouldSpeak(rule.faultMessage)) { voiceWarning = rule.faultMessage; _lastVoiceTime = DateTime.now(); _lastVoiceMessage = rule.faultMessage; }
            }
          } else { _faultCounters[rule.name] = 0; }
        }
      }
    }
    return FormCheckResult(formScore: math.max(0, 100 - totalDeduction), faults: faults, angles: angles, voiceWarning: voiceWarning);
  }

  double? _calcBestAngle(PoseLandmarkType t1, PoseLandmarkType t2, PoseLandmarkType t3, Map<PoseLandmarkType, PoseLandmark> lm) {
    final leftAngle = _calcAngle(t1, t2, t3, lm);
    final leftConf = _avgConf([t1, t2, t3], lm);
    final r1 = _mirror(t1), r2 = _mirror(t2), r3 = _mirror(t3);
    final rightAngle = _calcAngle(r1, r2, r3, lm);
    final rightConf = _avgConf([r1, r2, r3], lm);
    if (leftAngle != null && rightAngle != null) return leftConf >= rightConf ? leftAngle : rightAngle;
    return leftAngle ?? rightAngle;
  }

  double? _calcAngle(PoseLandmarkType t1, PoseLandmarkType t2, PoseLandmarkType t3, Map<PoseLandmarkType, PoseLandmark> lm) {
    final p1 = lm[t1], p2 = lm[t2], p3 = lm[t3];
    if (p1 == null || p2 == null || p3 == null || p1.likelihood < 0.5 || p2.likelihood < 0.5 || p3.likelihood < 0.5) return null;
    final v1x = p1.x - p2.x, v1y = p1.y - p2.y, v2x = p3.x - p2.x, v2y = p3.y - p2.y;
    final dot = v1x * v2x + v1y * v2y;
    final mag1 = math.sqrt(v1x * v1x + v1y * v1y), mag2 = math.sqrt(v2x * v2x + v2y * v2y);
    if (mag1 < 0.001 || mag2 < 0.001) return null;
    return math.acos((dot / (mag1 * mag2)).clamp(-1.0, 1.0)) * 180 / math.pi;
  }

  double _avgConf(List<PoseLandmarkType> types, Map<PoseLandmarkType, PoseLandmark> lm) {
    double total = 0; int count = 0;
    for (final t in types) { final l = lm[t]; if (l != null) { total += l.likelihood; count++; } }
    return count > 0 ? total / count : 0;
  }

  PoseLandmarkType _mirror(PoseLandmarkType t) {
    final n = t.name;
    if (n.startsWith('left')) return PoseLandmarkType.values.firstWhere((x) => x.name == 'right${n.substring(4)}', orElse: () => t);
    if (n.startsWith('right')) return PoseLandmarkType.values.firstWhere((x) => x.name == 'left${n.substring(5)}', orElse: () => t);
    return t;
  }

  double _smoothAngle(String name, double newVal) {
    final cur = _smoothedAngles[name];
    if (cur == null) { _smoothedAngles[name] = newVal; return newVal; }
    final smoothed = cur + _smoothingFactor * (newVal - cur);
    _smoothedAngles[name] = smoothed;
    return smoothed;
  }

  bool _isAngleValid(double angle, double? min, double? max) => (min == null || angle >= min) && (max == null || angle <= max);
  bool _shouldSpeak(String msg) {
    if (_lastVoiceTime == null) return true;
    if (_lastVoiceMessage == msg) return DateTime.now().difference(_lastVoiceTime!) > const Duration(seconds: 5);
    return DateTime.now().difference(_lastVoiceTime!) > _voiceCooldown;
  }
}
