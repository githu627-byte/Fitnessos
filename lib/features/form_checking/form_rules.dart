import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'form_checker.dart';

class FormRules {
  static FormCheckRules? getRules(String exerciseName) {
    final name = exerciseName.toUpperCase().replaceAll('\n', ' ').trim();
    switch (name) {
      case 'SQUAT': return _squatRules;
      case 'BENCH PRESS': return _benchPressRules;
      case 'DEADLIFT': return _deadliftRules;
      case 'OVERHEAD PRESS': return _overheadPressRules;
      case 'BARBELL ROW': return _barbellRowRules;
      default: return _genericRules;
    }
  }

  static final _squatRules = FormCheckRules(exerciseName: 'Squat', rules: [
    FormRule(name: 'knee_angle', checkType: 'angle', landmarks: [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle], minAngle: 70, maxAngle: 175, faultMessage: 'Go deeper!', correction: 'Break parallel - hips below knees', bodyPart: 'knee', severity: FaultSeverity.medium, deduction: 15),
    FormRule(name: 'hip_angle', checkType: 'angle', landmarks: [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee], minAngle: 45, maxAngle: 120, faultMessage: 'Watch your torso!', correction: 'Keep chest up, slight forward lean', bodyPart: 'spine', severity: FaultSeverity.high, deduction: 20),
    FormRule(name: 'back_angle', checkType: 'angle', landmarks: [PoseLandmarkType.nose, PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip], minAngle: 140, maxAngle: 200, faultMessage: 'Back rounding!', correction: 'Brace core, neutral spine', bodyPart: 'spine', severity: FaultSeverity.critical, deduction: 25),
  ]);

  static final _benchPressRules = FormCheckRules(exerciseName: 'Bench Press', rules: [
    FormRule(name: 'elbow_angle', checkType: 'angle', landmarks: [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist], minAngle: 70, maxAngle: 175, faultMessage: 'Control the bar!', correction: 'Full range of motion, touch chest', bodyPart: 'elbow', severity: FaultSeverity.medium, deduction: 15),
    FormRule(name: 'shoulder_angle', checkType: 'angle', landmarks: [PoseLandmarkType.leftHip, PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow], minAngle: 30, maxAngle: 85, faultMessage: 'Tuck your elbows!', correction: '45-75 degree elbow angle to protect shoulders', bodyPart: 'shoulder', severity: FaultSeverity.high, deduction: 20),
  ]);

  static final _deadliftRules = FormCheckRules(exerciseName: 'Deadlift', rules: [
    FormRule(name: 'back_angle', checkType: 'angle', landmarks: [PoseLandmarkType.nose, PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip], minAngle: 150, maxAngle: 200, faultMessage: 'STOP! Back rounding!', correction: 'Brace hard, chest up, neutral spine', bodyPart: 'spine', severity: FaultSeverity.critical, deduction: 30),
    FormRule(name: 'hip_angle', checkType: 'angle', landmarks: [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee], minAngle: 80, maxAngle: 170, faultMessage: 'Drive hips!', correction: 'Push through floor, squeeze glutes at top', bodyPart: 'hip', severity: FaultSeverity.medium, deduction: 15),
    FormRule(name: 'knee_angle', checkType: 'angle', landmarks: [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle], minAngle: 130, maxAngle: 180, faultMessage: 'Soft knees!', correction: 'Slight knee bend, not stiff-legged', bodyPart: 'knee', severity: FaultSeverity.low, deduction: 10),
  ]);

  static final _overheadPressRules = FormCheckRules(exerciseName: 'Overhead Press', rules: [
    FormRule(name: 'elbow_angle', checkType: 'angle', landmarks: [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist], minAngle: 60, maxAngle: 175, faultMessage: 'Full extension!', correction: 'Press to full lockout overhead', bodyPart: 'elbow', severity: FaultSeverity.medium, deduction: 15),
    FormRule(name: 'back_angle', checkType: 'angle', landmarks: [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee], minAngle: 160, maxAngle: 200, faultMessage: 'Stop leaning back!', correction: 'Brace core, squeeze glutes, stay upright', bodyPart: 'spine', severity: FaultSeverity.high, deduction: 20),
  ]);

  static final _barbellRowRules = FormCheckRules(exerciseName: 'Barbell Row', rules: [
    FormRule(name: 'hip_angle', checkType: 'angle', landmarks: [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee], minAngle: 70, maxAngle: 130, faultMessage: 'Stay bent over!', correction: 'Maintain hip hinge throughout the lift', bodyPart: 'hip', severity: FaultSeverity.high, deduction: 20),
    FormRule(name: 'back_angle', checkType: 'angle', landmarks: [PoseLandmarkType.nose, PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip], minAngle: 150, maxAngle: 200, faultMessage: 'Neutral spine!', correction: 'Keep back flat, no rounding', bodyPart: 'spine', severity: FaultSeverity.critical, deduction: 25),
    FormRule(name: 'elbow_angle', checkType: 'angle', landmarks: [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist], minAngle: 40, maxAngle: 160, faultMessage: 'Pull to belly!', correction: 'Squeeze shoulder blades, pull to lower chest', bodyPart: 'elbow', severity: FaultSeverity.medium, deduction: 15),
  ]);

  static final _genericRules = FormCheckRules(exerciseName: 'Generic', rules: [
    FormRule(name: 'posture', checkType: 'angle', landmarks: [PoseLandmarkType.nose, PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip], minAngle: 140, maxAngle: 200, faultMessage: 'Watch your posture!', correction: 'Maintain neutral spine', bodyPart: 'spine', severity: FaultSeverity.medium, deduction: 15),
  ]);
}
