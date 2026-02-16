import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'base_pattern.dart';
import 'squat_pattern.dart';
import 'step_up_pattern.dart';
import 'push_pattern.dart';
import 'pull_pattern.dart';
import 'hinge_pattern.dart';
import 'curl_pattern.dart';
import 'knee_drive_pattern.dart';
import 'hold_pattern.dart';
import 'rotation_pattern.dart';
import 'calf_pattern.dart';
import 'piston_pattern.dart';
import 'core_pattern.dart';

/// Pattern types
enum PatternType { squat, stepUp, push, pull, hinge, curl, kneeDrive, hold, rotation, calf, piston, core }

/// Exercise configuration
class ExerciseConfig {
  final PatternType patternType;
  final Map<String, dynamic> params;
  
  const ExerciseConfig({
    required this.patternType,
    this.params = const {},
  });
}

/// =============================================================================
/// MOVEMENT ENGINE - Master Controller
/// =============================================================================
/// Maps 300+ exercises to their pattern type.
/// Creates the right pattern instance for each exercise.
/// 
/// UPDATED: 2026-01-16 - Fixed patterns to use Y-position tracking
/// =============================================================================

class MovementEngine {
  BasePattern? _activePattern;
  BasePattern? get activePattern => _activePattern;
  String? _currentExerciseId;
  
  // Getters - delegate to active pattern
  int get repCount => _activePattern?.repCount ?? 0;
  String get feedback => _activePattern?.feedback ?? '';
  double get chargeProgress => _activePattern?.chargeProgress ?? 0;
  bool get justHitTrigger => _activePattern?.justHitTrigger ?? false;
  bool get isLocked => _activePattern?.isLocked ?? false;
  RepState get state => _activePattern?.state ?? RepState.ready;
  String? get currentExerciseId => _currentExerciseId;
  
  /// Set the current exercise - creates the appropriate pattern
  void setExercise(String exerciseId) {
    _currentExerciseId = exerciseId.toLowerCase().replaceAll(' ', '_').replaceAll('-', '_');

    final config = exercises[_currentExerciseId];
    if (config == null) {
      // Default to squat pattern for unknown exercises
      _activePattern = SquatPattern();
      return;
    }

    _activePattern = _createPattern(config);
  }

  /// LEGACY: Alias for setExercise for backwards compatibility
  void loadExercise(String exerciseId) => setExercise(exerciseId);

  /// Check if an exercise has a pattern configured
  static bool hasPattern(String exerciseId) {
    final normalized = exerciseId.toLowerCase().replaceAll(' ', '_').replaceAll('-', '_');
    return exercises.containsKey(normalized);
  }

  /// Capture baseline position (Map version)
  void captureBaseline(dynamic landmarks) {
    if (_activePattern == null) return;

    // Handle both List<PoseLandmark> and Map<PoseLandmarkType, PoseLandmark>
    if (landmarks is List<PoseLandmark>) {
      final map = {for (var lm in landmarks) lm.type: lm};
      _activePattern!.captureBaseline(map);
    } else if (landmarks is Map<PoseLandmarkType, PoseLandmark>) {
      _activePattern!.captureBaseline(landmarks);
    }
  }

  /// Process a frame - returns true if rep was counted
  bool processFrame(dynamic landmarks) {
    if (_activePattern == null) return false;

    // Handle both List<PoseLandmark> and Map<PoseLandmarkType, PoseLandmark>
    if (landmarks is List<PoseLandmark>) {
      final map = {for (var lm in landmarks) lm.type: lm};
      return _activePattern!.processFrame(map);
    } else if (landmarks is Map<PoseLandmarkType, PoseLandmark>) {
      return _activePattern!.processFrame(landmarks);
    }

    return false;
  }
  
  /// Reset the current pattern
  void reset() {
    _activePattern?.reset();
  }
  
  /// Create pattern instance from config
  /// FIXED: Updated to use new Y-position based patterns
  BasePattern _createPattern(ExerciseConfig config) {
    switch (config.patternType) {
      case PatternType.squat:
        return SquatPattern(
          triggerPercent: config.params['triggerPercent'] ?? 0.78,
          resetPercent: config.params['resetPercent'] ?? 0.92,
          cueGood: config.params['cueGood'] ?? 'Depth!',
          cueBad: config.params['cueBad'] ?? 'Lower!',
        );
        
      case PatternType.stepUp:
        return StepUpPattern(
          cueGood: config.params['cueGood'] ?? 'Up!',
          cueBad: config.params['cueBad'] ?? 'Drive!',
        );
        
      case PatternType.push:
        // FIXED: No more triggerAngle/resetAngle
        return PushPattern(
          inverted: config.params['inverted'] ?? false,
          cueGood: config.params['cueGood'] ?? 'Good!',
          cueBad: config.params['cueBad'] ?? 'Lower!',
        );
        
      case PatternType.pull:
        // FIXED: resetPercent should be HIGH (0.85) - reset when arms EXTEND back out
        return PullPattern(
          triggerPercent: config.params['triggerPercent'] ?? 0.55,
          resetPercent: config.params['resetPercent'] ?? 0.85,
          cueGood: config.params['cueGood'] ?? 'Squeeze!',
          cueBad: config.params['cueBad'] ?? 'Pull more!',
        );
        
      case PatternType.hinge:
        return HingePattern(
          triggerPercent: config.params['triggerPercent'] ?? 0.40,
          resetPercent: config.params['resetPercent'] ?? 0.75,
          inverted: config.params['inverted'] ?? false,
          floor: config.params['floor'] ?? false,
          cueGood: config.params['cueGood'] ?? 'Lockout!',
          cueBad: config.params['cueBad'] ?? 'Hips forward!',
        );
        
      case PatternType.curl:
        // CurlPattern already uses Y-position, just cues
        return CurlPattern(
          cueGood: config.params['cueGood'] ?? 'Squeeze!',
          cueBad: config.params['cueBad'] ?? 'Full curl!',
        );
        
      case PatternType.kneeDrive:
        return KneeDrivePattern(
          mode: (config.params['mode'] as KneeDriveMode?) ?? KneeDriveMode.verticalKnee,
          cueGood: config.params['cueGood'] ?? 'Drive!',
          cueBad: config.params['cueBad'] ?? 'Knees up!',
          triggerThreshold: (config.params['triggerThreshold'] as double?) ?? 0.35,
          resetThreshold: (config.params['resetThreshold'] as double?) ?? 0.18,
        );
        
      case PatternType.hold:
        return HoldPattern(
          holdType: config.params['holdType'] ?? HoldType.plank,
          cueGood: config.params['cueGood'] ?? 'Hold it!',
          cueBad: config.params['cueBad'] ?? 'Get in position!',
        );
        
      case PatternType.rotation:
        return RotationPattern(
          triggerAngle: config.params['triggerAngle'] ?? 45,
          cueGood: config.params['cueGood'] ?? 'Twist!',
          cueBad: config.params['cueBad'] ?? 'Rotate more!',
        );
        
      case PatternType.calf:
        return CalfPattern(
          cueGood: config.params['cueGood'] ?? 'Squeeze!',
          cueBad: config.params['cueBad'] ?? 'Higher!',
        );

      case PatternType.piston:
        return PistonPattern(
          pointA: config.params['pointA'] as PoseLandmarkType,
          pointB: config.params['pointB'] as PoseLandmarkType,
          pointARight: config.params['pointARight'] as PoseLandmarkType?,
          pointBRight: config.params['pointBRight'] as PoseLandmarkType?,
          mode: (config.params['mode'] as PistonMode?) ?? PistonMode.shrink,
          triggerPercent: (config.params['triggerPercent'] as double?) ?? 0.70,
          resetPercent: (config.params['resetPercent'] as double?) ?? 0.90,
          cueGood: config.params['cueGood'] ?? 'Good!',
          cueBad: config.params['cueBad'] ?? 'More!',
        );

      case PatternType.core:
        return CorePattern(
          coreMode: (config.params['coreMode'] as CoreMode?) ?? CoreMode.noseRise,
          triggerRisePercent: (config.params['triggerRisePercent'] as double?) ?? 15.0,
          resetRisePercent: (config.params['resetRisePercent'] as double?) ?? 5.0,
          cueGood: config.params['cueGood'] ?? 'Squeeze!',
          cueBad: config.params['cueBad'] ?? 'Higher!',
        );
    }
  }
  
  /// ==========================================================================
  /// EXERCISE DATABASE - 300+ exercises mapped to patterns
  /// ==========================================================================
  /// 
  /// ORGANIZATION:
  /// 1. SQUAT PATTERN - Lower body quad-dominant
  /// 2. PUSH PATTERN - Upper body pressing
  /// 3. PULL PATTERN - Upper body pulling
  /// 4. HINGE PATTERN - Hip hinge movements
  /// 5. CURL PATTERN - Isolation arm/leg curls
  /// 6. KNEE DRIVE PATTERN - Cardio/running movements
  /// 7. HOLD PATTERN - Isometric holds
  /// 8. ROTATION PATTERN - Twisting movements
  /// 9. CALF PATTERN - Calf raises
  /// ==========================================================================
  
  static const Map<String, ExerciseConfig> exercises = {
    
    // =========================================================================
    // ===== SQUAT PATTERN - Lower body quad-dominant =====
    // =========================================================================
    
    // SQUAT PATTERN - BASIC SQUATS
    'squat': ExerciseConfig(patternType: PatternType.squat),
    'squats': ExerciseConfig(patternType: PatternType.squat),
    'air_squat': ExerciseConfig(patternType: PatternType.squat),
    'air_squats': ExerciseConfig(patternType: PatternType.squat),
    'bodyweight_squat': ExerciseConfig(patternType: PatternType.squat),
    'bodyweight_squats': ExerciseConfig(patternType: PatternType.squat),
    'squats_bw': ExerciseConfig(patternType: PatternType.squat),
    'goblet_squat': ExerciseConfig(patternType: PatternType.squat),
    'goblet_squats': ExerciseConfig(patternType: PatternType.squat),
    'barbell_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_back_squat': ExerciseConfig(patternType: PatternType.squat),
    'back_squat': ExerciseConfig(patternType: PatternType.squat),
    'front_squat': ExerciseConfig(patternType: PatternType.squat),
    'zercher_squat': ExerciseConfig(patternType: PatternType.squat),
    'overhead_squat': ExerciseConfig(patternType: PatternType.squat),
    'hack_squat': ExerciseConfig(patternType: PatternType.squat),
    'sissy_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70}),
    
    // SQUAT PATTERN - SUMO
    'sumo_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'sumo_squats': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    
    // SQUAT PATTERN - SPLIT SQUATS
    'split_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'split_squats': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'bulgarian_split_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'bulgarian_split_squats': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'bulgarian_split': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'bulgarian_split_squat_bw': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    
    // SQUAT PATTERN - LUNGES
    'lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'walking_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'walking_lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'reverse_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'reverse_lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'static_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'deficit_reverse_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'curtsy_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'curtsy_lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'pulse_curtsy_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.85}),
    'lateral_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.88}),
    'lateral_lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.88}),
    'jump_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.86}),
    'jump_lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.86}),
    'jumping_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.86, 'cueGood': 'Explode!', 'cueBad': 'Switch!'}),
    
    // SQUAT PATTERN - LEG PRESS
    'leg_press': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'cueGood': 'Push!', 'cueBad': 'Full depth!'}),
    'leg_press_high': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    
    // SQUAT PATTERN - JUMPS
    'jump_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Explode!', 'cueBad': 'Lower!'}),
    'jump_squats': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Explode!', 'cueBad': 'Lower!'}),
    'squat_jump': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Explode!', 'cueBad': 'Lower!'}),
    'squat_jumps': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Explode!', 'cueBad': 'Lower!'}),
    'squat_reach': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'cueGood': 'Reach up!', 'cueBad': 'Full squat!'}),
    'pistol_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70, 'cueGood': 'Balance!', 'cueBad': 'Lower!'}),
    'box_jump': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'cueGood': 'Explode!', 'cueBad': 'Load up!'}),
    'box_jumps': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'cueGood': 'Explode!', 'cueBad': 'Load up!'}),
    'jumping_jack': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.90, 'cueGood': 'Jump!', 'cueBad': 'Arms up!'}),
    'jumping_jacks': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.90, 'cueGood': 'Jump!', 'cueBad': 'Arms up!'}),
    'tuck_jump': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Knees up!', 'cueBad': 'Higher!'}),
    'tuck_jumps': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Knees up!', 'cueBad': 'Higher!'}),
    'star_jump': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'cueGood': 'Explode!', 'cueBad': 'Arms up!'}),
    'star_jumps': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'cueGood': 'Explode!', 'cueBad': 'Arms up!'}),
    'lateral_hop': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85}),
    'lateral_hops': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85}),
    'skater_hop': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Jump!', 'cueBad': 'Push off!'}),
    
    // SQUAT PATTERN - PULSE
    'squat_pulse': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.85, 'cueGood': 'Pulse!', 'cueBad': 'Stay low!'}),
    'sumo_squat_pulse': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.85, 'cueGood': 'Pulse!', 'cueBad': 'Stay low!'}),
    'sumo_squat_hold_pulse': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.85, 'cueGood': 'Pulse!', 'cueBad': 'Stay low!'}),
    
    // SQUAT PATTERN - BANDED
    'banded_squat': ExerciseConfig(patternType: PatternType.squat),
    'banded_lateral_walk': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.90}),
    
    // SQUAT PATTERN - OTHER VARIANTS
    'squat_to_kickback': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78}),
    'squat_press': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Drive up!', 'cueBad': 'Full squat!'}),
    'barbell_squat_press': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Drive up!', 'cueBad': 'Full squat!'}),
    'thruster': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Drive up!', 'cueBad': 'Full squat!'}),
    'thrusters': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Drive up!', 'cueBad': 'Full squat!'}),
    'spanish_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70}),
    
    // SQUAT PATTERN - DEADLIFTS (moved from hinge - use basic squat pattern)
    'deadlift': ExerciseConfig(patternType: PatternType.squat),
    'deadlifts': ExerciseConfig(patternType: PatternType.squat),
    'rack_pull': ExerciseConfig(patternType: PatternType.squat),
    'conventional_deadlift': ExerciseConfig(patternType: PatternType.squat),
    'deficit_deadlift': ExerciseConfig(patternType: PatternType.squat),
    'sumo_deadlift': ExerciseConfig(patternType: PatternType.squat),
    'sumo_deadlifts': ExerciseConfig(patternType: PatternType.squat),
    // HINGE PATTERN - RDLs & GOOD MORNINGS (RDLs moved from squat)
    'romanian_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'romanian_deadlifts': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'rdl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'dumbbell_rdl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'stiff_leg_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'stiff_leg_deadlifts': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'single_leg_deadlift': ExerciseConfig(patternType: PatternType.squat),
    'single_leg_deadlifts': ExerciseConfig(patternType: PatternType.squat),
    'single_leg_rdl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'trap_bar_deadlift': ExerciseConfig(patternType: PatternType.squat),
    
    // SQUAT PATTERN - GLUTE EXERCISES
    // 'clamshell': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    // 'side_lying_leg_lift': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85}),
    // 'fire_hydrant_pulse': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85}),
    
    // CORE PATTERN - CRUNCHES
    'crunch': ExerciseConfig(patternType: PatternType.core, params: {
      'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0,
      'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!',
    }),
    'crunches': ExerciseConfig(patternType: PatternType.core, params: {
      'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0,
      'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!',
    }),
    'cable_crunch': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.92}),
    'cable_crunches': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.92}),
    'sit_up': ExerciseConfig(patternType: PatternType.core, params: {
      'coreMode': CoreMode.noseRise, 'triggerRisePercent': 20.0, 'resetRisePercent': 3.0,
      'cueGood': 'Up!', 'cueBad': 'All the way!',
    }),
    'sit_ups': ExerciseConfig(patternType: PatternType.core, params: {
      'coreMode': CoreMode.noseRise, 'triggerRisePercent': 20.0, 'resetRisePercent': 3.0,
      'cueGood': 'Up!', 'cueBad': 'All the way!',
    }),
    'situp': ExerciseConfig(patternType: PatternType.core, params: {
      'coreMode': CoreMode.noseRise, 'triggerRisePercent': 20.0, 'resetRisePercent': 3.0,
      'cueGood': 'Up!', 'cueBad': 'All the way!',
    }),
    'situps': ExerciseConfig(patternType: PatternType.core, params: {
      'coreMode': CoreMode.noseRise, 'triggerRisePercent': 20.0, 'resetRisePercent': 3.0,
      'cueGood': 'Up!', 'cueBad': 'All the way!',
    }),
    'decline_situp': ExerciseConfig(patternType: PatternType.core, params: {
      'coreMode': CoreMode.noseRise, 'triggerRisePercent': 18.0, 'resetRisePercent': 3.0,
      'cueGood': 'Up!', 'cueBad': 'All the way!',
    }),
    'decline_weighted_sit_up': ExerciseConfig(patternType: PatternType.core, params: {
      'coreMode': CoreMode.noseRise, 'triggerRisePercent': 15.0, 'resetRisePercent': 3.0,
      'cueGood': 'Up!', 'cueBad': 'All the way!',
    }),
    'standing_oblique_crunch': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80}),
    
    // SQUAT PATTERN - BEAR CRAWL
    // 'bear_crawl': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'cueGood': 'Crawl!', 'cueBad': 'Stay low!'}),
    // 'bear_crawls': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'cueGood': 'Crawl!', 'cueBad': 'Stay low!'}),
    // 'inchworm': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70, 'cueGood': 'Walk out!', 'cueBad': 'Chest down!'}),
    
    // =========================================================================
    // ===== STEPUP PATTERN - Step up movements =====
    // =========================================================================
    
    'step_up': ExerciseConfig(patternType: PatternType.stepUp, params: {'cueGood': 'Up!', 'cueBad': 'Drive!'}),
    'step_ups': ExerciseConfig(patternType: PatternType.stepUp, params: {'cueGood': 'Up!', 'cueBad': 'Drive!'}),
    'stepups_chair': ExerciseConfig(patternType: PatternType.stepUp, params: {'cueGood': 'Up!', 'cueBad': 'Drive!'}),
    'box_stepups': ExerciseConfig(patternType: PatternType.stepUp, params: {'cueGood': 'Up!', 'cueBad': 'Drive!'}),
    'box_step_up': ExerciseConfig(patternType: PatternType.stepUp, params: {'cueGood': 'Up!', 'cueBad': 'Drive!'}),
    
    // =========================================================================
    // ===== PUSH PATTERN - Upper body pressing =====
    // =========================================================================
    
    // PUSH PATTERN - PUSH-UPS
    'pushup': ExerciseConfig(patternType: PatternType.push),
    'pushups': ExerciseConfig(patternType: PatternType.push),
    'push_up': ExerciseConfig(patternType: PatternType.push),
    'push_ups': ExerciseConfig(patternType: PatternType.push),
    'incline_push_up': ExerciseConfig(patternType: PatternType.push),
    'incline_push_ups': ExerciseConfig(patternType: PatternType.push),
    'wall_push_up': ExerciseConfig(patternType: PatternType.push),
    'decline_push_up': ExerciseConfig(patternType: PatternType.push),
    'wide_pushup': ExerciseConfig(patternType: PatternType.push),
    'wide_pushups': ExerciseConfig(patternType: PatternType.push),
    'diamond_pushup': ExerciseConfig(patternType: PatternType.push),
    'diamond_pushups': ExerciseConfig(patternType: PatternType.push),
    'diamond_push_up': ExerciseConfig(patternType: PatternType.push),
    'close_grip_pushup': ExerciseConfig(patternType: PatternType.push),
    'close_grip_push_ups': ExerciseConfig(patternType: PatternType.push),
    'close_grip_push_up': ExerciseConfig(patternType: PatternType.push),
    'close_grip_pushups': ExerciseConfig(patternType: PatternType.push), // NEW - Missing
    'decline_pushup': ExerciseConfig(patternType: PatternType.push),
    'decline_pushups': ExerciseConfig(patternType: PatternType.push),
    'incline_pushup': ExerciseConfig(patternType: PatternType.push),
    'incline_pushups': ExerciseConfig(patternType: PatternType.push),
    'pike_pushup': ExerciseConfig(patternType: PatternType.push),
    'pike_pushups': ExerciseConfig(patternType: PatternType.push),
    'pike_push_ups': ExerciseConfig(patternType: PatternType.push),
    'archer_pushup': ExerciseConfig(patternType: PatternType.push),
    'archer_push_up': ExerciseConfig(patternType: PatternType.push),
    'clap_pushup': ExerciseConfig(patternType: PatternType.push),
    'plank_to_pushup': ExerciseConfig(patternType: PatternType.push),
    
    // PUSH PATTERN - BENCH PRESS
    'bench_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_bench_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_bench_press': ExerciseConfig(patternType: PatternType.push),
    'incline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'incline_press': ExerciseConfig(patternType: PatternType.push),
    'incline_db_press': ExerciseConfig(patternType: PatternType.push),
    'incline_dumbbell_press': ExerciseConfig(patternType: PatternType.push),
    'incline_barbell_press': ExerciseConfig(patternType: PatternType.push),
    'decline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'decline_press': ExerciseConfig(patternType: PatternType.push),
    'decline_dumbbell_press': ExerciseConfig(patternType: PatternType.push),
    'decline_barbell_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_press': ExerciseConfig(patternType: PatternType.push),
    'close_grip_bench': ExerciseConfig(patternType: PatternType.push),
    'close_grip_bench_press': ExerciseConfig(patternType: PatternType.push),
    'jm_press': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Control!', 'cueBad': 'Elbows in!'}),
    'machine_chest_press': ExerciseConfig(patternType: PatternType.push),
    'landmine_press': ExerciseConfig(patternType: PatternType.push), // NEW - Missing
    
    // PUSH PATTERN - OVERHEAD PRESS (inverted - wrists go ABOVE shoulders)
    'overhead_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'shoulder_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'military_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'arnold_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'push_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'seated_db_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'seated_dumbbell_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'standing_dumbbell_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'seated_shoulder_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_shoulder_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_overhead_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'machine_shoulder_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'db_overhead_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'standing_ohp': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'ohp': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    
    // PUSH PATTERN - TRICEP EXTENSIONS (moved from curl - use barbell_overhead_press pattern)
    'tricep_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'tricep_extensions': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'overhead_tricep_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'overhead_tricep': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'overhead_tricep_ext': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'skull_crusher': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'skull_crushers': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_tricep_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    
    // PUSH PATTERN - DIPS
    'dip': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'dips': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'tricep_dip': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'tricep_dips': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'bench_dip': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'bench_dips': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'dip_machine': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'weighted_dip': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'ring_dip': ExerciseConfig(patternType: PatternType.push),
    'ring_dips': ExerciseConfig(patternType: PatternType.push),
    'chest_dips': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}), // NEW - Missing
    'dips_chest': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}), // NEW - Missing
    'tricep_dips_chair': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}), // NEW - Missing
    
    // PUSH PATTERN - FLYES
    'chest_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'chest_flys': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'chest_flyes': ExerciseConfig(patternType: PatternType.push),
    'cable_chest_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_chest_fly': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_fly': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_flys': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_flyes': ExerciseConfig(patternType: PatternType.push), // NEW - Missing
    'cable_fly': ExerciseConfig(patternType: PatternType.push),
    'cable_flys': ExerciseConfig(patternType: PatternType.push),
    'cable_flyes': ExerciseConfig(patternType: PatternType.push),
    'cable_flye': ExerciseConfig(patternType: PatternType.push), // NEW - Missing
    'cable_crossover': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'pec_deck': ExerciseConfig(patternType: PatternType.push),
    'machine_fly': ExerciseConfig(patternType: PatternType.push),
    'machine_chest_fly': ExerciseConfig(patternType: PatternType.push), // NEW - Missing
    'incline_fly': ExerciseConfig(patternType: PatternType.push),
    'incline_flys': ExerciseConfig(patternType: PatternType.push),
    
    // PUSH PATTERN - PLANK SHOULDER TAPS
    // 'plank_shoulder_tap': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Tap!', 'cueBad': 'Stay stable!'}),
    // 'plank_shoulder_taps': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Tap!', 'cueBad': 'Stay stable!'}),
    
    // PUSH PATTERN - AB WHEEL
    // 'ab_wheel': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Extend!', 'cueBad': 'Control!'}),
    // 'ab_wheel_rollout': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Extend!', 'cueBad': 'Control!'}),
    // 'ab_wheel_kneeling': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Extend!', 'cueBad': 'Control!'}),
    // 'ab_wheel_standing': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Extend!', 'cueBad': 'Control!'}),
    
    // =========================================================================
    // ===== PULL PATTERN - Upper body pulling =====
    // =========================================================================
    // FIXED: resetPercent changed from 0.20/0.25 to 0.85
    // Reset happens when arms EXTEND back out (distance grows to 85% of baseline)
    
    // PULL PATTERN - PULL-UPS/CHIN-UPS
    'pullup': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'pullups': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'pull_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'pull_ups': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'assisted_pull_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'weighted_pull_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'chinup': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'chinups': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'chin_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'chin_ups': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'wide_grip_pullup': ExerciseConfig(patternType: PatternType.pull),
    'close_grip_pullup': ExerciseConfig(patternType: PatternType.pull),
    'neutral_grip_pullup': ExerciseConfig(patternType: PatternType.pull),
    'muscle_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.65}),
    
    // PULL PATTERN - PULLDOWNS
    'lat_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'lat_pulldowns': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'neutral_grip_lat_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'straight_arm_pulldown': ExerciseConfig(patternType: PatternType.pull),
    
    // PUSH PATTERN - ROWS (moved from pull)
    'row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'bent_over_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'bent_over_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'bent_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'barbell_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'barbell_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'barbell_bent_over_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'single_arm_db_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'one_arm_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'seated_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'seated_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'seated_cable_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'seated_cable_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'machine_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'chest_supported_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'tbar_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'tbar_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    't_bar_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'pendlay_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'pendlay_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'inverted_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'inverted_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'renegade_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'renegade_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'upright_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'upright_rows': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),

    // PUSH PATTERN - FACE PULLS / REAR DELTS (moved from pull)
    'face_pull': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'face_pulls': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'reverse_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'reverse_flys': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'reverse_flyes': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'rear_delt_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'reverse_pec_deck': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'rear_delt_flys': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),

    // PUSH PATTERN - DUMBBELL CURLS (moved from curl)
    'dumbbell_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_curls': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_bicep_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'hammer_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'hammer_curls': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'standing_hammer_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'seated_hammer_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cross_body_hammer_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'concentration_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'concentration_curls': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'incline_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'incline_curls': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'zottman_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'zottman_curls': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),

    // PULL PATTERN - SHRUGS
    'shrug': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    'shrugs': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    'barbell_shrugs': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    'dumbbell_shrugs': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    
    // =========================================================================
    // ===== HINGE PATTERN - Hip hinge movements =====
    // =========================================================================
    
    // HINGE PATTERN - BURPEE/SPRAWL (moved from squat - use deadlift pattern)
    'burpee': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'burpees': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'modified_burpee': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'burpee_tuck_jump': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'burpee_sprawl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'sprawl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'sprawls': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    
    // HINGE PATTERN - GOOD MORNINGS
    'good_morning': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'good_mornings': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    
    // PULL PATTERN - SWINGS (moved from hinge)
    'kettlebell_swing': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'kettlebell_swings': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'kb_swing': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'russian_swing': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'american_swing': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    
    // HINGE PATTERN - HIP THRUST/BRIDGES (inverted)
    'hip_thrust': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'hip_thrusts': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true}),
    'glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'glute_bridges': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'single_leg_glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'elevated_glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'banded_glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'barbell_hip_thrust': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true, 'triggerPercent': 0.55}), // NEW - Missing
    'glute_bridge_single': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'glute_bridge_hold': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    'frog_pump': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'frog_pumps': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'frog_pump_pulse': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'frog_pump_hold_pulse': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'quadruped_hip_extension': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'quadruped_hip_extension_pulse': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40}),
    'standing_glute_squeeze': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true}),
    'single_leg_rdl_pulse': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.35}),
    
    // STANDING GLUTE KICKBACKS - Use calf pattern (ankle rise/fall)
    'glute_kickback': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'glute_kickbacks': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'cable_kickback': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'standing_glute_kickback': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'banded_kickback': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    // DONKEY KICKS - stay as hinge (on all fours, different movement)
    'donkey_kick': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'donkey_kicks': ExerciseConfig(patternType: PatternType.hinge),
    'donkey_kick_pulse': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40}),
    'donkey_kick_pulses': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40}), // NEW - Missing
    'donkey_kicks_cable': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.55}), // NEW - Missing
    'fire_hydrant': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.70}), // NEW - Missing
    'fire_hydrants': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.70}), // NEW - Missing
    'banded_fire_hydrant': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.70}), // NEW - Missing
    'banded_clamshell': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.70}), // NEW - Missing
    'side_lying_leg_raise': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.75}), // NEW - Missing
    
    // HINGE PATTERN - CABLE PULL THROUGH
    'cable_pull_through': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
    'cable_pullthrough': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}), // NEW - Missing
    'pull_through': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
    
    // HINGE PATTERN - BACK EXTENSION
    'back_extension': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Extend!'}),
    'back_extensions': ExerciseConfig(patternType: PatternType.hinge),
    'hyperextension': ExerciseConfig(patternType: PatternType.hinge),
    'hyperextensions': ExerciseConfig(patternType: PatternType.hinge),
    'reverse_hyper': ExerciseConfig(patternType: PatternType.hinge),
    
    // =========================================================================
    // ===== CURL PATTERN - Isolation arm/leg curls =====
    // =========================================================================
    
    // CURL PATTERN - BICEP CURLS
    'curl': ExerciseConfig(patternType: PatternType.curl),
    'curls': ExerciseConfig(patternType: PatternType.curl),
    'bicep_curl': ExerciseConfig(patternType: PatternType.curl),
    'bicep_curls': ExerciseConfig(patternType: PatternType.curl),
    'barbell_curl': ExerciseConfig(patternType: PatternType.curl),
    'barbell_curls': ExerciseConfig(patternType: PatternType.curl),
    'barbell_bicep_curl': ExerciseConfig(patternType: PatternType.curl),
    'preacher_curl': ExerciseConfig(patternType: PatternType.curl),
    'preacher_curls': ExerciseConfig(patternType: PatternType.curl),
    'preacher_curl_machine': ExerciseConfig(patternType: PatternType.curl),
    'cable_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_curls': ExerciseConfig(patternType: PatternType.curl),
    'cable_bicep_curl': ExerciseConfig(patternType: PatternType.curl),
    'spider_curl': ExerciseConfig(patternType: PatternType.curl),
    'spider_curls': ExerciseConfig(patternType: PatternType.curl),
    'ez_bar_curl': ExerciseConfig(patternType: PatternType.curl),
    'ez_bar_curls': ExerciseConfig(patternType: PatternType.curl),
    '21s_curl': ExerciseConfig(patternType: PatternType.curl),
    'reverse_curl': ExerciseConfig(patternType: PatternType.curl),
    'reverse_curls': ExerciseConfig(patternType: PatternType.curl),
    '21s': ExerciseConfig(patternType: PatternType.curl),
    
    // CURL PATTERN - TRICEP EXTENSIONS
    'tricep_pushdown': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Push!', 'cueBad': 'Lockout!'}),
    'tricep_pushdowns': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Push!', 'cueBad': 'Lockout!'}),
    'cable_pushdown': ExerciseConfig(patternType: PatternType.curl),
    'rope_pushdown': ExerciseConfig(patternType: PatternType.curl),
    'rope_pushdowns': ExerciseConfig(patternType: PatternType.curl),
    'rope_tricep_extension': ExerciseConfig(patternType: PatternType.curl),
    'tricep_kickback': ExerciseConfig(patternType: PatternType.curl),
    'tricep_kickbacks': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_kickback': ExerciseConfig(patternType: PatternType.curl),
    
    // SQUAT PATTERN - LEG EXTENSIONS/CURLS (moved from curl)
    'leg_extension': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'leg_extensions': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'leg_curl': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full curl!'}),
    'leg_curls': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full curl!'}),
    'hamstring_curl': ExerciseConfig(patternType: PatternType.squat),
    'hamstring_curls': ExerciseConfig(patternType: PatternType.squat),
    'lying_leg_curl': ExerciseConfig(patternType: PatternType.squat),
    'seated_leg_curl': ExerciseConfig(patternType: PatternType.squat),
    'nordic_curl': ExerciseConfig(patternType: PatternType.squat),
    'nordic_curls': ExerciseConfig(patternType: PatternType.squat),
    
    // CURL PATTERN - WRIST
    'wrist_curl': ExerciseConfig(patternType: PatternType.curl),
    'wrist_curls': ExerciseConfig(patternType: PatternType.curl),
    'reverse_wrist_curl': ExerciseConfig(patternType: PatternType.curl),
    
    // CURL PATTERN - LATERAL RAISES & FRONT RAISES (moved from push - use barbell_curl pattern)
    'lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'lateral_raises': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'leaning_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'front_raise': ExerciseConfig(patternType: PatternType.curl),
    'front_raises': ExerciseConfig(patternType: PatternType.curl),
    'plate_front_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_front_raise': ExerciseConfig(patternType: PatternType.curl),
    'barbell_front_raise': ExerciseConfig(patternType: PatternType.curl),
    'cable_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'cable_lateral_raises': ExerciseConfig(patternType: PatternType.curl),
    

// =============================================================================
// VERTICAL KNEE (high knees, running) - knee → shoulder
// =============================================================================
'high_knee': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'high_knees': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'high_knee_sprint': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'marching_in_place': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'running_in_place': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'knee_tap': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'a_skip': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'b_skip': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'step_touch': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'side_step': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'lateral_shuffle': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'skater': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
'skaters': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),

// =============================================================================
// HORIZONTAL KNEE (plank-based) - knee → hip
// =============================================================================
'mountain_climber': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.horizontalKnee, 'cueGood': 'Drive!', 'cueBad': 'Knee in!'}),
'mountain_climbers': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.horizontalKnee}),
'mountain_climber_crossover': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.horizontalKnee, 'cueGood': 'Cross!', 'cueBad': 'Knee across!'}),

// =============================================================================
// LEG RAISE (core / supine) - ankle → hip
// =============================================================================
'leg_raise': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Legs up!', 'cueBad': 'Control!'}),
'leg_raises': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Legs up!', 'cueBad': 'Control!'}),
'lying_leg_raise': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise}),
'hanging_leg_raise': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Up!', 'cueBad': 'No swing!'}),
'hanging_leg_raises': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Up!', 'cueBad': 'No swing!'}),
'v_up': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Touch!', 'cueBad': 'Reach!'}),
'v_ups': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Touch!', 'cueBad': 'Reach!'}),
'bicycle_crunch': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Twist!', 'cueBad': 'Opposite!'}),
'bicycle_crunches': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise}),
'flutter_kick': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Fast!', 'cueBad': 'Control!', 'triggerThreshold': 0.25, 'resetThreshold': 0.12}),
'flutter_kicks': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'triggerThreshold': 0.25, 'resetThreshold': 0.12}),
'scissor_kick': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'triggerThreshold': 0.25, 'resetThreshold': 0.12}),
'scissor_kicks': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'triggerThreshold': 0.25, 'resetThreshold': 0.12}),
'dead_bug': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Extend!', 'cueBad': 'Opposite!'}),
'dead_bugs': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Extend!', 'cueBad': 'Opposite!'}),

// =============================================================================
// BUTT KICK (posterior) - ankle → hip
// =============================================================================
'butt_kick': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.buttKick, 'cueGood': 'Snap!', 'cueBad': 'Heels up!'}),
'butt_kicks': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.buttKick, 'cueGood': 'Snap!', 'cueBad': 'Heels up!'}),
'butt_kick_sprint': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.buttKick, 'cueGood': 'Fast!', 'cueBad': 'Heels up!'}),


    // =========================================================================
    // ===== HOLD PATTERN - Isometric holds =====
    // =========================================================================
    
    // HOLD PATTERN - PLANKS
    'plank': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'planks': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'plank_hold': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'forearm_plank': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'high_plank': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'side_plank': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'side_planks': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'side_plank_left': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'side_plank_right': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'plank_jack': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'plank_jacks': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'plank_tap': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'plank_walk_out': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'bird_dog': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'hollow_body_hold': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'clamshells': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    
    // HOLD PATTERN - STRETCHES/MOBILITY (NEW)
    // '90_90_stretch': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'butterfly_stretch': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'cat_cow': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'chest_doorway_stretch': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'frog_stretch': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'hamstring_stretch': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'happy_baby': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'hip_flexor_stretch': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'pigeon_pose': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'quad_stretch': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'superman_raises': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    // 'worlds_greatest_stretch': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    // 'childs_pose': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    
    // HOLD PATTERN - WALL SIT
    // 'wall_sit': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.wallSit}),
    // 'wall_sits': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.wallSit}),
    // 'wall_squat': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.wallSit}),
    
    // HOLD PATTERN - HANGS
    // 'dead_hang': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.hang}),
    // 'active_hang': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.hang}),
    // 'hang': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.hang}),
    
    // HOLD PATTERN - L-SIT
    // 'l_sit': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    // 'l_sits': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    
    // HOLD PATTERN - SUPERMAN
    // 'superman': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Hold!', 'cueBad': 'Lift higher!'}),
    // 'supermans': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    // 'superman_hold': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    
    // =========================================================================
    // ===== ROTATION PATTERN - Lateral sweep twisting movements =====
    // =========================================================================

    // PULL PATTERN - RUSSIAN TWISTS (moved from rotation)
    'russian_twist': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'russian_twists': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'russian_twist_weighted': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),

    // PULL PATTERN - WOOD CHOPS (moved from rotation)
    'wood_chop': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'wood_chops': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_wood_chop': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'medicine_ball_woodchop': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'dumbbell_woodchop': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'woodchop': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'woodchoppers': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),

    // PULL PATTERN - LANDMINE & SEATED (moved from rotation)
    'landmine_rotation': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'seated_twist': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),

    // MOVED TO HOLD - these don't sweep laterally, rotation pattern can't track them
    'windmill': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Control!', 'cueBad': 'Stay stable!'}),
    'windmills': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Control!', 'cueBad': 'Stay stable!'}),
    'pallof_press': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Brace!', 'cueBad': 'Stay tight!'}),
    'pallof_press_kneeling': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Brace!', 'cueBad': 'Stay tight!'}),
    'pallof_press_standing': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Brace!', 'cueBad': 'Stay tight!'}),
    'pallof_press_split_stance': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Brace!', 'cueBad': 'Stay tight!'}),
    'oblique_crunch': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Crunch!', 'cueBad': 'Squeeze obliques!'}),
    'oblique_crunches': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Crunch!', 'cueBad': 'Squeeze obliques!'}),
    
    // =========================================================================
    // ===== CALF PATTERN - Calf raises =====
    // =========================================================================
    
    'calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'calf_raises': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'standing_calf_raise': ExerciseConfig(patternType: PatternType.calf),
    'standing_calf_raises': ExerciseConfig(patternType: PatternType.calf),
    'seated_calf_raise': ExerciseConfig(patternType: PatternType.calf),
    'seated_calf_raises': ExerciseConfig(patternType: PatternType.calf),
    'donkey_calf_raise': ExerciseConfig(patternType: PatternType.calf),
    'single_leg_calf_raise': ExerciseConfig(patternType: PatternType.calf),
    'jump_rope': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Jump!', 'cueBad': 'Light feet!'}),
    
  };
}
