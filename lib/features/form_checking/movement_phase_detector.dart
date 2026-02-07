import 'dart:math';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

/// Movement phases for compound lifts
enum MovementPhase {
  setup, // Standing, preparing
  descent, // Eccentric - going down
  bottom, // Bottom position (transition point)
  ascent, // Concentric - coming up
  lockout, // Top position, rep complete
}

/// Detects the current phase of movement based on joint angles
class MovementPhaseDetector {
  final String exerciseName;
  
  // Phase detection state
  MovementPhase _currentPhase = MovementPhase.setup;
  MovementPhase _previousPhase = MovementPhase.setup;
  
  // Angle history for phase detection
  final List<double> _primaryAngleHistory = [];
  static const int _historySize = 10;
  
  // Phase thresholds (degrees) - configurable per exercise
  late final double _bottomThreshold;
  late final double _topThreshold;
  late final double _movementThreshold; // Minimum change to detect movement
  
  // Rep counting
  int _repCount = 0;
  bool _wasAtBottom = false;
  
  MovementPhaseDetector(this.exerciseName) {
    _initializeThresholds();
  }
  
  void _initializeThresholds() {
    switch (exerciseName.toLowerCase()) {
      case 'squat':
        _bottomThreshold = 90; // Knee angle at parallel
        _topThreshold = 160; // Nearly straight legs
        _movementThreshold = 5;
        break;
      case 'deadlift':
        _bottomThreshold = 70; // Hip angle at bottom
        _topThreshold = 170; // Standing tall
        _movementThreshold = 5;
        break;
      case 'bench press':
        _bottomThreshold = 70; // Elbow angle at chest
        _topThreshold = 160; // Arms extended
        _movementThreshold = 5;
        break;
      case 'overhead press':
        _bottomThreshold = 90; // Bar at shoulders
        _topThreshold = 170; // Arms overhead
        _movementThreshold = 5;
        break;
      case 'barbell row':
        _bottomThreshold = 160; // Arms extended
        _topThreshold = 70; // Bar at torso (reversed for rows)
        _movementThreshold = 5;
        break;
      default:
        _bottomThreshold = 90;
        _topThreshold = 160;
        _movementThreshold = 5;
    }
  }
  
  /// Get the primary angle for this exercise
  double? _getPrimaryAngle(Map<PoseLandmarkType, PoseLandmark> landmarks) {
    switch (exerciseName.toLowerCase()) {
      case 'squat':
        return _calculateAngle(
          landmarks[PoseLandmarkType.leftHip],
          landmarks[PoseLandmarkType.leftKnee],
          landmarks[PoseLandmarkType.leftAnkle],
        );
      case 'deadlift':
        return _calculateAngle(
          landmarks[PoseLandmarkType.leftShoulder],
          landmarks[PoseLandmarkType.leftHip],
          landmarks[PoseLandmarkType.leftKnee],
        );
      case 'bench press':
      case 'overhead press':
        return _calculateAngle(
          landmarks[PoseLandmarkType.leftShoulder],
          landmarks[PoseLandmarkType.leftElbow],
          landmarks[PoseLandmarkType.leftWrist],
        );
      case 'barbell row':
        return _calculateAngle(
          landmarks[PoseLandmarkType.leftShoulder],
          landmarks[PoseLandmarkType.leftElbow],
          landmarks[PoseLandmarkType.leftWrist],
        );
      default:
        return null;
    }
  }
  
  double? _calculateAngle(
    PoseLandmark? p1,
    PoseLandmark? p2, // vertex
    PoseLandmark? p3,
  ) {
    if (p1 == null || p2 == null || p3 == null) return null;
    
    final v1 = [p1.x - p2.x, p1.y - p2.y];
    final v2 = [p3.x - p2.x, p3.y - p2.y];
    
    final dot = v1[0] * v2[0] + v1[1] * v2[1];
    final mag1 = sqrt(v1[0] * v1[0] + v1[1] * v1[1]);
    final mag2 = sqrt(v2[0] * v2[0] + v2[1] * v2[1]);
    
    if (mag1 == 0 || mag2 == 0) return null;
    
    final cosAngle = (dot / (mag1 * mag2)).clamp(-1.0, 1.0);
    return acos(cosAngle) * 180 / pi;
  }
  
  /// Detect current movement phase and update rep count
  PhaseDetectionResult detectPhase(Map<PoseLandmarkType, PoseLandmark> landmarks) {
    final primaryAngle = _getPrimaryAngle(landmarks);
    
    if (primaryAngle == null) {
      return PhaseDetectionResult(
        phase: _currentPhase,
        repCount: _repCount,
        primaryAngle: null,
        isNewRep: false,
      );
    }
    
    // Add to history
    _primaryAngleHistory.add(primaryAngle);
    if (_primaryAngleHistory.length > _historySize) {
      _primaryAngleHistory.removeAt(0);
    }
    
    // Need enough history to detect movement
    if (_primaryAngleHistory.length < 3) {
      return PhaseDetectionResult(
        phase: MovementPhase.setup,
        repCount: _repCount,
        primaryAngle: primaryAngle,
        isNewRep: false,
      );
    }
    
    // Calculate movement direction
    final recentAvg = _primaryAngleHistory.sublist(_primaryAngleHistory.length - 3).reduce((a, b) => a + b) / 3;
    final olderAvg = _primaryAngleHistory.sublist(0, min(3, _primaryAngleHistory.length - 3)).reduce((a, b) => a + b) / 
                     min(3, _primaryAngleHistory.length - 3);
    
    final angleChange = recentAvg - olderAvg;
    
    // Store previous phase
    _previousPhase = _currentPhase;
    
    // Determine phase based on angle and direction
    bool isNewRep = false;
    
    // For rows, the logic is inverted (pulling = angle decreasing)
    final isRow = exerciseName.toLowerCase() == 'barbell row';
    
    if (isRow) {
      // Barbell row: bottom = arms extended (high angle), top = bar at torso (low angle)
      if (primaryAngle > _bottomThreshold - 10) {
        _currentPhase = MovementPhase.setup;
      } else if (angleChange < -_movementThreshold) {
        _currentPhase = MovementPhase.ascent; // Pulling up (angle decreasing)
      } else if (primaryAngle <= _topThreshold + 10) {
        if (!_wasAtBottom) {
          _wasAtBottom = true;
        }
        _currentPhase = MovementPhase.bottom;
      } else if (angleChange > _movementThreshold) {
        _currentPhase = MovementPhase.descent; // Lowering (angle increasing)
        if (_wasAtBottom) {
          _repCount++;
          _wasAtBottom = false;
          isNewRep = true;
        }
      } else if (primaryAngle > _bottomThreshold - 10) {
        _currentPhase = MovementPhase.lockout;
      }
    } else {
      // Standard lifts: bottom = low angle, top = high angle
      if (primaryAngle > _topThreshold - 10) {
        _currentPhase = MovementPhase.setup;
      } else if (angleChange < -_movementThreshold) {
        _currentPhase = MovementPhase.descent; // Going down (angle decreasing)
      } else if (primaryAngle <= _bottomThreshold + 10) {
        if (!_wasAtBottom) {
          _wasAtBottom = true;
        }
        _currentPhase = MovementPhase.bottom;
      } else if (angleChange > _movementThreshold) {
        _currentPhase = MovementPhase.ascent; // Coming up (angle increasing)
      } else if (primaryAngle > _topThreshold - 10) {
        _currentPhase = MovementPhase.lockout;
        if (_wasAtBottom) {
          _repCount++;
          _wasAtBottom = false;
          isNewRep = true;
        }
      }
    }
    
    return PhaseDetectionResult(
      phase: _currentPhase,
      repCount: _repCount,
      primaryAngle: primaryAngle,
      isNewRep: isNewRep,
      previousPhase: _previousPhase,
    );
  }
  
  void reset() {
    _currentPhase = MovementPhase.setup;
    _previousPhase = MovementPhase.setup;
    _primaryAngleHistory.clear();
    _repCount = 0;
    _wasAtBottom = false;
  }
}

/// Result of phase detection
class PhaseDetectionResult {
  final MovementPhase phase;
  final int repCount;
  final double? primaryAngle;
  final bool isNewRep;
  final MovementPhase? previousPhase;
  
  const PhaseDetectionResult({
    required this.phase,
    required this.repCount,
    required this.primaryAngle,
    required this.isNewRep,
    this.previousPhase,
  });
}

