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
        return PushPattern(
          inverted: config.params['inverted'] ?? false,
          cueGood: config.params['cueGood'] ?? 'Good!',
          cueBad: config.params['cueBad'] ?? 'Lower!',
          extensionThreshold: config.params['extensionThreshold'] as double?,
          flexionThreshold: config.params['flexionThreshold'] as double?,
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

    // BASIC SQUATS
    'barbell_bench_front_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_bench_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_front_chest_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_front_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_full_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_full_zercher_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_high_bar_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_low_bar_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_low_bar_squat_with_rack': ExerciseConfig(patternType: PatternType.squat),
    'barbell_olympic_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_one_leg_squat': ExerciseConfig(patternType: PatternType.squat),
    'barbell_quarter_squat': ExerciseConfig(patternType: PatternType.squat),
    'bodyweight_pulse_goblet_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.85, 'cueGood': 'Pulse!', 'cueBad': 'Stay low!'}),
    'dumbbell_bench_squat': ExerciseConfig(patternType: PatternType.squat),
    'dumbbell_goblet_squat': ExerciseConfig(patternType: PatternType.squat),
    'dumbbell_squat': ExerciseConfig(patternType: PatternType.squat),
    'lever_chair_squat': ExerciseConfig(patternType: PatternType.squat),
    'lever_full_squat': ExerciseConfig(patternType: PatternType.squat),
    'lever_pistol_squat': ExerciseConfig(patternType: PatternType.squat),
    'lever_seated_squat': ExerciseConfig(patternType: PatternType.squat),
    'lever_seated_wide_squat': ExerciseConfig(patternType: PatternType.squat),
    'lever_squat_plate_loaded': ExerciseConfig(patternType: PatternType.squat),
    'single_leg_squat_with_support_pistol': ExerciseConfig(patternType: PatternType.squat),
    'sit_squat': ExerciseConfig(patternType: PatternType.squat),
    'sled_full_hack_squat': ExerciseConfig(patternType: PatternType.squat),
    'sled_hack_squat': ExerciseConfig(patternType: PatternType.squat),
    'sled_lying_squat': ExerciseConfig(patternType: PatternType.squat),
    'sled_reverse_hack_squat': ExerciseConfig(patternType: PatternType.squat),
    'smith_chair_squat': ExerciseConfig(patternType: PatternType.squat),
    'smith_frankenstein_squat': ExerciseConfig(patternType: PatternType.squat),
    'smith_front_squat': ExerciseConfig(patternType: PatternType.squat),
    'smith_front_squat_clean_grip': ExerciseConfig(patternType: PatternType.squat),
    'smith_low_bar_squat': ExerciseConfig(patternType: PatternType.squat),
    'smith_squat': ExerciseConfig(patternType: PatternType.squat),
    'smith_squat_to_bench': ExerciseConfig(patternType: PatternType.squat),
    'smith_zercher_squat': ExerciseConfig(patternType: PatternType.squat),
    'squat_m': ExerciseConfig(patternType: PatternType.squat),

    // SUMO SQUATS
    'dumbbell_goblet_sumo_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'smith_sumo_chair_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'sumo_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),

    // SPLIT SQUATS & LUNGES
    'barbell_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'barbell_rear_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'barbell_side_split_squat_ii': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'bulgarian_split_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'bulgarian_split_sumo_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'dumbbell_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'dumbbell_rear_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'dumbbell_reverse_lunge_from_deficit': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'dumbbell_single_leg_split_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'single_curtsy_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'smith_single_leg_split_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'smith_split_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'split_squats': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),
    'walking_lunge_male': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78, 'resetPercent': 0.88}),

    // LEG PRESS
    'lever_seated_leg_press': ExerciseConfig(patternType: PatternType.squat),
    'sled_45°_leg_press': ExerciseConfig(patternType: PatternType.squat),
    'sled_45°_narrow_stance_leg_press': ExerciseConfig(patternType: PatternType.squat),
    'smith_leg_press': ExerciseConfig(patternType: PatternType.squat),

    // JUMPS & PLYOS
    'bodyweight_jump_squat_wide_leg': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Explode!', 'cueBad': 'Lower!'}),
    'jump_on_fit_box': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Explode!', 'cueBad': 'Lower!'}),
    'jump_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Explode!', 'cueBad': 'Lower!'}),
    'jumping_jack': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.90, 'cueGood': 'Jump!', 'cueBad': 'Arms up!'}),
    'star_jump': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'cueGood': 'Explode!', 'cueBad': 'Arms up!'}),
    'tuck_jump': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Knees up!', 'cueBad': 'Higher!'}),

    // DEADLIFTS (squat pattern)
    'barbell_deadlift': ExerciseConfig(patternType: PatternType.squat),
    'barbell_sumo_deadlift': ExerciseConfig(patternType: PatternType.squat),
    'dumbbell_deadlift': ExerciseConfig(patternType: PatternType.squat),
    'lever_deadlift_plate_loaded': ExerciseConfig(patternType: PatternType.squat),
    'smith_deadlift': ExerciseConfig(patternType: PatternType.squat),

    // LEG EXTENSIONS & CURLS
    'cable_standing_leg_curl': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'dumbbell_lying_femoral': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'lever_alternate_leg_extension_plate_loaded': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'lever_kneeling_leg_curl_plate_loaded': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'lever_leg_extension': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'lever_leg_extension_plate_loaded': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'lever_lying_leg_curl': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'lever_seated_leg_curl': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'nordic_hamstring_curl': ExerciseConfig(patternType: PatternType.squat, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),

    // =========================================================================
    // ===== STEP UP PATTERN =====
    // =========================================================================

    // STEP UPS
    'barbell_step_up': ExerciseConfig(patternType: PatternType.stepUp, params: {'cueGood': 'Up!', 'cueBad': 'Drive!'}),
    'dumbbell_step_up': ExerciseConfig(patternType: PatternType.stepUp, params: {'cueGood': 'Up!', 'cueBad': 'Drive!'}),
    'high_knee_step_up': ExerciseConfig(patternType: PatternType.stepUp, params: {'cueGood': 'Up!', 'cueBad': 'Drive!'}),
    'smith_lateral_step_up': ExerciseConfig(patternType: PatternType.stepUp, params: {'cueGood': 'Up!', 'cueBad': 'Drive!'}),
    'step_up': ExerciseConfig(patternType: PatternType.stepUp, params: {'cueGood': 'Up!', 'cueBad': 'Drive!'}),

    // =========================================================================
    // ===== CORE PATTERN - Crunches & Sit-ups (noseRise) =====
    // =========================================================================

    // CRUNCHES & SIT-UPS
    '3_4_sit_up': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 20.0, 'resetRisePercent': 3.0, 'cueGood': 'Up!', 'cueBad': 'All the way!'}),
    'cable_kneeling_crunch': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!'}),
    'cable_standing_crunch_with_rope_attachment': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!'}),
    'cocoons': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!'}),
    'cross_body_crunch': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!'}),
    'crunch_floor_m': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!'}),
    'crunch_on_stability_ball': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!'}),
    'lying_bicycle_crunch': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!'}),
    'reverse_crunch_m': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!'}),
    'sit_up_ii': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 20.0, 'resetRisePercent': 3.0, 'cueGood': 'Up!', 'cueBad': 'All the way!'}),
    'tuck_crunch': ExerciseConfig(patternType: PatternType.core, params: {'coreMode': CoreMode.noseRise, 'triggerRisePercent': 10.0, 'resetRisePercent': 2.0, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch up!'}),

    // =========================================================================
    // ===== PUSH PATTERN - Upper body pressing + rows + DB curls =====
    // =========================================================================

    // PUSH-UPS
    'archer_push_up': ExerciseConfig(patternType: PatternType.push),
    'close_grip_push_up': ExerciseConfig(patternType: PatternType.push),
    'decline_push_up_m': ExerciseConfig(patternType: PatternType.push),
    'diamond_push_up': ExerciseConfig(patternType: PatternType.push),
    'incline_reverse_grip_push_up': ExerciseConfig(patternType: PatternType.push),
    'pike_push_up': ExerciseConfig(patternType: PatternType.push),
    'pike_push_ups': ExerciseConfig(patternType: PatternType.push),
    'push_up_m': ExerciseConfig(patternType: PatternType.push),
    'push_up_on_forearms': ExerciseConfig(patternType: PatternType.push),
    'wide_hand_push_up': ExerciseConfig(patternType: PatternType.push),

    // BENCH PRESS
    'barbell_bench_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_close_grip_bench_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_decline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_decline_wide_grip_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_incline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_incline_close_grip_bench_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_incline_wide_reverse_grip_bench_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_reverse_close_grip_bench_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_reverse_grip_decline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_reverse_grip_incline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_wide_reverse_grip_bench_press': ExerciseConfig(patternType: PatternType.push),
    'cable_bench_press': ExerciseConfig(patternType: PatternType.push),
    'cable_decline_press': ExerciseConfig(patternType: PatternType.push),
    'cable_incline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'cable_seated_chest_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_bench_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_bench_seated_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_close_grip_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_decline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_decline_hammer_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_incline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_incline_reverse_grip_30_degrees_bench_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_lying_elbow_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_lying_hammer_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_lying_hammer_press_version_2': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_palms_in_incline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_reverse_bench_press': ExerciseConfig(patternType: PatternType.push),
    'lever_chest_press': ExerciseConfig(patternType: PatternType.push),
    'lever_chest_press_plate_loaded': ExerciseConfig(patternType: PatternType.push),
    'lever_chest_press_version_2': ExerciseConfig(patternType: PatternType.push),
    'lever_chest_press_version_4': ExerciseConfig(patternType: PatternType.push),
    'lever_decline_chest_press': ExerciseConfig(patternType: PatternType.push),
    'lever_decline_chest_press_version_2': ExerciseConfig(patternType: PatternType.push),
    'lever_incline_chest_press': ExerciseConfig(patternType: PatternType.push),
    'lever_incline_hammer_chest_press': ExerciseConfig(patternType: PatternType.push),
    'lever_lying_chest_press_plate_loaded': ExerciseConfig(patternType: PatternType.push),
    'lever_parallel_chest_press': ExerciseConfig(patternType: PatternType.push),
    'leverage_incline_chest_press': ExerciseConfig(patternType: PatternType.push),
    'machine_inner_chest_press': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'smith_bench_press': ExerciseConfig(patternType: PatternType.push),
    'smith_close_grip_bench_press': ExerciseConfig(patternType: PatternType.push),
    'smith_decline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'smith_decline_reverse_grip_press': ExerciseConfig(patternType: PatternType.push),
    'smith_incline_bench_press': ExerciseConfig(patternType: PatternType.push),
    'smith_incline_reverse_grip_press': ExerciseConfig(patternType: PatternType.push),
    'smith_machine_decline_close_grip_bench_press': ExerciseConfig(patternType: PatternType.push),
    'smith_machine_reverse_decline_close_grip_bench_press': ExerciseConfig(patternType: PatternType.push),
    'smith_reverse_grip_press': ExerciseConfig(patternType: PatternType.push),
    'smith_wide_grip_bench_press': ExerciseConfig(patternType: PatternType.push),
    'smith_wide_grip_decline_bench_press': ExerciseConfig(patternType: PatternType.push),

    // OVERHEAD PRESS (inverted)
    'barbell_seated_behind_head_military_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_seated_close_grip_behind_neck_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_seated_military_press_inside_squat_cage': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_seated_overhead_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_standing_close_grip_military_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_standing_military_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_standing_overhead_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_standing_wide_military_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_high_pulley_overhead_tricep_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_overhead_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_overhead_triceps_extension_rope_attachment': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_shoulder_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_arnold_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_arnold_press_ii': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_seated_shoulder_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'lever_military_press_plate_loaded': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'lever_seated_shoulder_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'lever_shoulder_press_plate_loaded_ii': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'lever_shoulder_press_plate_loaded_version_3': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'smith_behind_neck_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'smith_seated_shoulder_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'smith_shoulder_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'smith_standing_behind_head_military_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'smith_standing_military_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),

    // TRICEP EXTENSIONS (inverted)
    'barbell_decline_close_grip_to_skull_press': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_lying_back_of_the_head_tricep_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_lying_close_grip_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'barbell_lying_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_alternate_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_concentration_extension_on_knee': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_incline_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_kneeling_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_kneeling_triceps_extension_version_2': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_lying_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'cable_rope_incline_tricep_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_decline_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_incline_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_lying_single_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_lying_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_seated_bench_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_seated_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_standing_bent_over_two_arm_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_standing_one_arm_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbell_standing_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'dumbbells_seated_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'ez_barbell_decline_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'ez_barbell_incline_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'ez_barbell_seated_triceps_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),
    'smith_machine_incline_tricep_extension': ExerciseConfig(patternType: PatternType.push, params: {'inverted': true, 'cueGood': 'Lockout!', 'cueBad': 'Press higher!'}),

    // DIPS
    'bench_dip_knees_bent': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'chest_dip': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'lever_overhand_triceps_dip': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'lever_seated_dip': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'lever_triceps_dip_plate_loaded': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'reverse_dip': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'triceps_dip': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'triceps_dips_floor': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'weighted_bench_dip': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),
    'wide_grip_chest_dip_on_high_parallel_bars': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Push!', 'cueBad': 'Deeper!'}),

    // FLYES & CROSSOVERS
    'cable_cross_over_revers_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_crossover_variation': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_decline_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_incline_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_low_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_lying_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_middle_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_standing_cross_over_high_reverse_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_standing_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_standing_up_straight_crossovers': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_supine_reverse_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_upper_chest_crossovers': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_decline_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_fly': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_incline_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_rear_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'lever_pec_deck_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'lever_seated_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'lever_seated_reverse_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),

    // ROWS — Seated/machine rows (push pattern, side view)
    'barbell_reverse_grip_incline_bench_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_low_seated_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_reverse_grip_straight_back_seated_high_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_rope_elevated_seated_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_rope_seated_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_seated_high_row_v_bar': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_seated_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_seated_row_bent_bar': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_seated_wide_grip_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'cable_straight_back_seated_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_lying_rear_delt_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_reverse_grip_incline_bench_two_arm_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_row_with_chest_supported': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'lever_lying_t_bar_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'lever_neutral_grip_seated_row_plate_loaded': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'lever_reverse_grip_vertical_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'lever_row_plate_loaded': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'lever_seated_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'lever_single_arm_neutral_grip_seated_row_plate_loaded': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'lever_unilateral_row': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),

    // FACE PULLS & REAR DELTS (push pattern)
    'dumbbell_rear_delt_raise': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),

    // DUMBBELL CURLS (push pattern)
    'dumbbell_alternate_biceps_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_biceps_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_biceps_curl_reverse': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_concentration_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_cross_body_hammer_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_cross_body_hammer_curl_version_2': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_hammer_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_hammer_curl_ii': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_high_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_incline_inner_biceps_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_peacher_hammer_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_revers_grip_biceps_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_reverse_preacher_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_seated_bicep_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_seated_hammer_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_seated_preacher_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_seated_revers_grip_concentration_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_standing_biceps_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_standing_concentration_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_standing_inner_biceps_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_standing_inner_biceps_curl_version_2': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_standing_one_arm_concentration_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'dumbbell_zottman_curl': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),

    // OTHER PUSH
    'barbell_incline_reverse_grip_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_lying_close_grip_press': ExerciseConfig(patternType: PatternType.push),
    'barbell_reverse_grip_skullcrusher': ExerciseConfig(patternType: PatternType.push),
    'cable_hammer_curl_with_rope_attachment_male': ExerciseConfig(patternType: PatternType.push),
    'dumbbell_one_arm_kickback': ExerciseConfig(patternType: PatternType.push),
    'glutes_bridge_lift_the_hip_high': ExerciseConfig(patternType: PatternType.push),
    'sled_45°_leg_wide_press': ExerciseConfig(patternType: PatternType.squat),

    // =========================================================================
    // ===== PULL PATTERN - Pull-ups, pulldowns, shrugs, twists =====
    // =========================================================================

    // ═════════════════════════════════════════════════════════════════════════
    // PULL PATTERN - FREE WEIGHT ROWS (diagonal view)
    // Moved from push — these work from front/diagonal angle on pull pattern
    // Seated/machine rows STAY on push pattern (side view)
    // ═════════════════════════════════════════════════════════════════════════
    'barbell_bent_over_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'barbell_incline_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'barbell_rear_delt_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'barbell_reverse_grip_bent_over_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'barbell_upright_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'cable_elevated_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'cable_upper_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'cable_upright_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'dumbbell_bent_over_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'dumbbell_incline_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'dumbbell_one_arm_row_rack_support': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'dumbbell_palm_rotational_bent_over_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'dumbbell_rear_delt_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'dumbbell_upright_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'dumbbell_upright_row_back_pov': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'ez_bar_reverse_grip_bent_over_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'inverted_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'inverted_row_bent_knees': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'lever_high_row_plate_loaded': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'lever_reverse_t_bar_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'lever_t_bar_reverse_grip_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'lever_t_bar_row_plate_loaded': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'smith_bent_over_narrow_supinated_grip_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'smith_bent_over_pronated_grip_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'smith_reverse_grip_bent_over_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'smith_upright_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'underhand_grip_inverted_back_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),

    // PULL-UPS & CHIN-UPS
    'barbell_decline_wide_grip_pullover': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'chin_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'chin_ups_narrow_parallel_grip': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'close_grip_chin_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'hammer_grip_pull_up_on_dip_cage': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'inverse_leg_curl_on_pull_up_cable_machine': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'pull_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'pull_up_neutral_grip': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'rear_pull_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'shoulder_grip_pull_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'wide_grip_pull_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'wide_grip_pull_up_on_dip_cage': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'wide_grip_rear_pull_up': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),

    // PULLDOWNS
    'cable_bar_lateral_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_close_grip_front_lat_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_cross_over_lateral_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_incline_pushdown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_lat_pulldown_full_range_of_motion': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_pushdown_straight_arm_ii': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_rear_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_straight_arm_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_underhand_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_wide_grip_behind_neck_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_wide_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'lever_front_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'lever_lateral_pulldown_plate_loaded': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'reverse_grip_machine_lat_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'twin_handle_parallel_grip_lat_pulldown': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),

    // SHRUGS
    'barbell_shrug': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    'cable_shrug': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    'dumbbell_decline_shrug': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    'dumbbell_incline_shrug': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    'dumbbell_shrug': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    'lever_shrug_bench_press_machine': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    'lever_shrug_plate_loaded': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),
    'smith_shrug': ExerciseConfig(patternType: PatternType.pull, params: {'cueGood': 'Shrug!', 'cueBad': 'Higher!'}),

    // TWISTS & WOOD CHOPS
    'cable_twist': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'russian_twist': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'russian_twist_with_medicine_ball': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),

    // PULLOVERS
    'barbell_bent_arm_pullover': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'barbell_decline_bent_arm_pullover': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'barbell_decline_pullover': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'barbell_front_raise_and_pullover': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_lying_extension_pullover_with_rope_attachment': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'dumbbell_pullover': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'dumbbell_straight_arm_pullover': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'lever_pullover_plate_loaded': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),

    // =========================================================================
    // ===== HINGE PATTERN - Hip hinge movements =====
    // =========================================================================

    // RDLs & GOOD MORNINGS
    'barbell_good_morning': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'barbell_romanian_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'barbell_seated_good_morning': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'barbell_stiff_leg_good_morning': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'barbell_straight_leg_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'barbell_sumo_romanian_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'dumbbell_romanian_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'dumbbell_stiff_leg_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'smith_stiff_legged_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),

    // HIP THRUSTS & BRIDGES
    'barbell_hip_thrust': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true, 'triggerPercent': 0.55}),
    'barbell_lying_lifting_on_hip': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'bent_knee_glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'frog_pump': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'hip_raise_bent_knee': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'hip_thrusts': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true}),
    'rear_decline_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'resistance_band_glute_bridge_abduction': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'single_leg_glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'single_straight_leg_glute_bridge_hold': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'weighted_frog_pump': ExerciseConfig(patternType: PatternType.hinge, params: {'floor': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),

    // KICKBACKS & DONKEY KICKS
    'donkey_kick': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'donkey_kick_leg_straight': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'donkey_kick_pulse': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40}),
    'quadruped_hip_extension': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),

    // BACK EXTENSIONS & HYPEREXTENSIONS
    'cable_pull_through': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
    'hyperextension': ExerciseConfig(patternType: PatternType.hinge),
    'hyperextension_on_bench': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Extend!'}),
    'hyperextension_version_2': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Extend!'}),
    'reverse_hyper_on_flat_bench': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Extend!'}),

    // BURPEES
    'burpee': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'burpee_jump_box': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),

    // HIP ABDUCTION/ADDUCTION
    'cable_hip_adduction': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Control!'}),
    'lever_hip_extension_version_2': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Control!'}),
    'lever_seated_hip_abduction': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Control!'}),
    'lever_seated_hip_abduction_version_2': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Control!'}),
    'lever_seated_hip_adduction': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Control!'}),
    'lever_seated_hip_adduction_version_2': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Control!'}),
    'lever_side_hip_abduction': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Control!'}),
    'lever_side_hip_adduction': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Control!'}),
    'lever_standing_hip_extension': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Control!'}),

    // =========================================================================
    // ===== CURL PATTERN - Barbell/cable curls, pushdowns, raises =====
    // =========================================================================

    // BARBELL & CABLE CURLS
    'barbell_curl': ExerciseConfig(patternType: PatternType.curl),
    'barbell_drag_curl': ExerciseConfig(patternType: PatternType.curl),
    'barbell_preacher_curl': ExerciseConfig(patternType: PatternType.curl),
    'barbell_prone_incline_curl': ExerciseConfig(patternType: PatternType.curl),
    'barbell_reverse_curl': ExerciseConfig(patternType: PatternType.curl),
    'barbell_seated_close_grip_concentration_curl': ExerciseConfig(patternType: PatternType.curl),
    'barbell_standing_concentration_curl': ExerciseConfig(patternType: PatternType.curl),
    'barbell_standing_reverse_grip_curl': ExerciseConfig(patternType: PatternType.curl),
    'barbell_standing_wide_grip_biceps_curl': ExerciseConfig(patternType: PatternType.curl),
    'barbell_standing_wide_grip_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_biceps_curl_sz_bar': ExerciseConfig(patternType: PatternType.curl),
    'cable_close_grip_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_concentration_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_curl_male': ExerciseConfig(patternType: PatternType.curl),
    'cable_curl_with_multipurpose_v_bar': ExerciseConfig(patternType: PatternType.curl),
    'cable_drag_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_lying_close_grip_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_one_arm_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_one_arm_inner_biceps_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_overhead_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_preacher_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_reverse_preacher_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_seated_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_standing_inner_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_standing_reverse_curl_sz_bar': ExerciseConfig(patternType: PatternType.curl),
    'cable_two_arm_tricep_kickback': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_kickback': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_seated_kickback': ExerciseConfig(patternType: PatternType.curl),
    'ez_bar_seated_close_grip_concentration_curl': ExerciseConfig(patternType: PatternType.curl),
    'ez_barbell_close_grip_curl': ExerciseConfig(patternType: PatternType.curl),
    'ez_barbell_close_grip_preacher_curl': ExerciseConfig(patternType: PatternType.curl),
    'ez_barbell_curl': ExerciseConfig(patternType: PatternType.curl),
    'ez_barbell_reverse_grip_curl': ExerciseConfig(patternType: PatternType.curl),
    'ez_barbell_reverse_grip_preacher_curl': ExerciseConfig(patternType: PatternType.curl),
    'ez_barbell_seated_curls': ExerciseConfig(patternType: PatternType.curl),
    'lever_alternate_biceps_curl': ExerciseConfig(patternType: PatternType.curl),
    'lever_bicep_curl': ExerciseConfig(patternType: PatternType.curl),
    'lever_hammer_grip_preacher_curl': ExerciseConfig(patternType: PatternType.curl),
    'lever_preacher_curl': ExerciseConfig(patternType: PatternType.curl),
    'lever_preacher_curl_plate_loaded': ExerciseConfig(patternType: PatternType.curl),
    'lever_preacher_curl_version_2': ExerciseConfig(patternType: PatternType.curl),
    'lever_reverse_grip_preacher_curl': ExerciseConfig(patternType: PatternType.curl),
    'smith_machine_bicep_curl': ExerciseConfig(patternType: PatternType.curl),

    // TRICEP PUSHDOWNS
    'cable_one_arm_side_triceps_pushdown': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Push!', 'cueBad': 'Lockout!'}),
    'cable_reverse_grip_triceps_pushdown_sz_bar': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Push!', 'cueBad': 'Lockout!'}),
    'cable_triceps_pushdown_sz_bar': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Push!', 'cueBad': 'Lockout!'}),
    'cable_triceps_pushdown_v_bar_attachment': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Push!', 'cueBad': 'Lockout!'}),
    'lever_triceps_extension': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Push!', 'cueBad': 'Lockout!'}),

    // LATERAL & FRONT RAISES
    'barbell_front_raise': ExerciseConfig(patternType: PatternType.curl),
    'cable_front_raise': ExerciseConfig(patternType: PatternType.curl),
    'cable_front_shoulder_raise': ExerciseConfig(patternType: PatternType.curl),
    'cable_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'cable_one_arm_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'cable_seated_rear_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_front_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_incline_front_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_incline_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_incline_rear_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_rear_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_seated_bent_arm_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_seated_front_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_seated_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_standing_alternate_raise': ExerciseConfig(patternType: PatternType.curl),
    'lever_lateral_raise': ExerciseConfig(patternType: PatternType.curl),
    'lever_lateral_raise_plate_loaded': ExerciseConfig(patternType: PatternType.curl),

    // =========================================================================
    // ===== KNEE DRIVE PATTERN - Cardio movements =====
    // =========================================================================

    // VERTICAL KNEE (high knees, skaters)
    'crossover_high_knee': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
    'elbow_to_knee': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
    'high_knee': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
    'skater': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),
    'skater_hops': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.verticalKnee}),

    // HORIZONTAL KNEE (mountain climbers)
    'mountain_climber': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.horizontalKnee, 'cueGood': 'Drive!', 'cueBad': 'Knee in!'}),
    'mountain_climbers': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.horizontalKnee}),

    // LEG RAISES
    'bicycle_crunch': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'cueGood': 'Twist!', 'cueBad': 'Opposite!'}),
    'flutter_kicks': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'triggerThreshold': 0.25, 'resetThreshold': 0.12}),
    'flutter_kicks_version_2': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'triggerThreshold': 0.25, 'resetThreshold': 0.12}),
    'flutter_kicks_version_3': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise, 'triggerThreshold': 0.25, 'resetThreshold': 0.12}),
    'hanging_leg_hip_raise': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise}),
    'lever_standing_leg_raise': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise}),
    'lying_leg_raise': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise}),
    'lying_leg_raise_and_hold': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise}),
    'lying_leg_raise_flat_bench': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise}),
    'seated_leg_raise': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.legRaise}),

    // BUTT KICKS
    'butt_kick': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.buttKick, 'cueGood': 'Snap!', 'cueBad': 'Heels up!'}),
    'butt_kicks': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.buttKick, 'cueGood': 'Snap!', 'cueBad': 'Heels up!'}),
    'butt_ups': ExerciseConfig(patternType: PatternType.kneeDrive, params: {'mode': KneeDriveMode.buttKick, 'cueGood': 'Snap!', 'cueBad': 'Heels up!'}),

    // =========================================================================
    // ===== HOLD PATTERN - Isometric holds =====
    // =========================================================================

    // PLANKS & HOLDS
    'bird_dog': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'cable_horizontal_pallof_press': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Brace!', 'cueBad': 'Stay tight!'}),
    'cable_vertical_pallof_press': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Brace!', 'cueBad': 'Stay tight!'}),
    'front_plank': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'glute_bridge_hold': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'side_plank_male': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'superman': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank, 'cueGood': 'Hold!', 'cueBad': 'Lift higher!'}),

    // =========================================================================
    // ===== CALF PATTERN - Calf raises & kickbacks =====
    // =========================================================================

    // CALF RAISES & STANDING KICKBACKS
    'barbell_floor_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'barbell_seated_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'barbell_standing_leg_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'bodyweight_standing_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'cable_donkey_kickback': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'cable_kickback': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'cable_medius_kickback': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'cable_standing_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'cable_standing_hip_extension': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'dumbbell_standing_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'dumbbell_standing_kickback': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'hack_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'kneeling_straight_leg_kickback': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'lever_calf_press_plate_loaded': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'lever_calf_raise_bench_press_machine': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'lever_donkey_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'lever_rotary_calf': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'lever_seated_calf_press': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'lever_seated_calf_raise_plate_loaded': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'lever_seated_one_leg_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'lever_standing_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'lever_standing_rear_kick': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),
    'sled_45°_calf_press': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'sled_calf_press_on_leg_press': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'sled_forward_angled_calf_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'smith_calf_raise_version_2': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'smith_reverse_calf_raises': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'smith_toe_raise': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'standing_glute_kickback': ExerciseConfig(patternType: PatternType.calf, params: {'cueGood': 'Squeeze!', 'cueBad': 'Kick back!'}),

  };
}
