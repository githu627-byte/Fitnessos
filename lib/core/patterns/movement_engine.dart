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

/// Pattern types
enum PatternType { squat, stepUp, push, pull, hinge, curl, kneeDrive, hold, rotation, calf }

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
        // FIXED: Now uses triggerPercent/resetPercent
        return HingePattern(
          triggerPercent: config.params['triggerPercent'] ?? 0.40,
          resetPercent: config.params['resetPercent'] ?? 0.75,
          inverted: config.params['inverted'] ?? false,
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
    
    
    // SQUAT PATTERN - GLUTE EXERCISES
    
    // SQUAT PATTERN - CRUNCHES (uses squat for torso-hip tracking)
    'crunch': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'resetPercent': 0.92, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch harder!'}),
    'crunches': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'resetPercent': 0.92, 'cueGood': 'Squeeze!', 'cueBad': 'Crunch harder!'}),
    'cable_crunch': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.92}),
    'cable_crunches': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'resetPercent': 0.92}),
    'sit_up': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70, 'resetPercent': 0.92, 'cueGood': 'Up!', 'cueBad': 'Squeeze abs!'}),
    'sit_ups': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70, 'resetPercent': 0.92, 'cueGood': 'Up!', 'cueBad': 'Squeeze abs!'}),
    'situp': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70, 'resetPercent': 0.92}),
    'situps': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70, 'resetPercent': 0.92}),
    'decline_situp': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70, 'resetPercent': 0.92}), // NEW - Missing
    'decline_weighted_sit_up': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.65, 'resetPercent': 0.92}),
    'standing_oblique_crunch': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80}),
    
    // SQUAT PATTERN - BEAR CRAWL (REMOVED)
    
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
    
    // PUSH PATTERN - PLANK SHOULDER TAPS (REMOVED)
    
    // PUSH PATTERN - AB WHEEL (REMOVED)
    
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
    
    // PULL PATTERN - ROWS
    'row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'bent_over_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'bent_over_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'bent_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'barbell_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'barbell_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'barbell_bent_over_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'dumbbell_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'dumbbell_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'single_arm_db_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'one_arm_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'cable_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'seated_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'seated_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'seated_cable_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'seated_cable_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'machine_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'chest_supported_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'tbar_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'tbar_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    't_bar_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'pendlay_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'pendlay_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'inverted_row': ExerciseConfig(patternType: PatternType.pull),
    'inverted_rows': ExerciseConfig(patternType: PatternType.pull),
    'renegade_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'renegade_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'upright_row': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    'upright_rows': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.60, 'resetPercent': 0.85}),
    
    // PULL PATTERN - FACE PULLS / REAR DELTS
    'face_pull': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Pull apart!', 'cueBad': 'Elbows high!'}),
    'face_pulls': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Pull apart!', 'cueBad': 'Elbows high!'}),
    'reverse_fly': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85, 'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
    'reverse_flys': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'reverse_flyes': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'rear_delt_fly': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'reverse_pec_deck': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    'rear_delt_flys': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
    
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
    
    // HINGE PATTERN - DEADLIFTS
    'deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
    'deadlifts': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75}),
    'rack_pull': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75}),
    'conventional_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75}),
    'deficit_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.35, 'resetPercent': 0.75}),
    'sumo_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.75}),
    'sumo_deadlifts': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.75}),
    'romanian_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.35, 'resetPercent': 0.70, 'cueGood': 'Hamstrings!', 'cueBad': 'Flat back!'}),
    'romanian_deadlifts': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.35, 'resetPercent': 0.70}),
    'rdl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.35, 'resetPercent': 0.70}),
    'dumbbell_rdl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75}),
    'stiff_leg_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.35, 'resetPercent': 0.70}),
    'stiff_leg_deadlifts': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.35, 'resetPercent': 0.70}),
    'single_leg_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.70}),
    'single_leg_deadlifts': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.70}),
    'single_leg_rdl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.70}),
    'trap_bar_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.75}),
    
    // HINGE PATTERN - GOOD MORNINGS
    'good_morning': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.70, 'cueGood': 'Feel it!', 'cueBad': 'Hinge!'}),
    'good_mornings': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.70}),
    
    // HINGE PATTERN - SWINGS
    'kettlebell_swing': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80, 'cueGood': 'Snap!', 'cueBad': 'Hips drive!'}),
    'kettlebell_swings': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
    'kb_swing': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
    'russian_swing': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
    'american_swing': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
    
    // HINGE PATTERN - HIP THRUST/BRIDGES (inverted)
    'hip_thrust': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'hip_thrusts': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true}),
    'glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true, 'cueGood': 'Squeeze!', 'cueBad': 'Hips up!'}),
    'glute_bridges': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true}),
    'single_leg_glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true}),
    'elevated_glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true}),
    'banded_glute_bridge': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true}),
    'barbell_hip_thrust': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true, 'triggerPercent': 0.55}), // NEW - Missing
    'glute_bridge_single': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true}), // NEW - Missing
    'glute_bridge_hold': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}), // NEW - Missing
    'quadruped_hip_extension': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'quadruped_hip_extension_pulse': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40}),
    'standing_glute_squeeze': ExerciseConfig(patternType: PatternType.hinge, params: {'inverted': true}),
    'single_leg_rdl_pulse': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.35}),
    
    // HINGE PATTERN - KICKBACKS
    'glute_kickback': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'glute_kickbacks': ExerciseConfig(patternType: PatternType.hinge, params: {'cueGood': 'Squeeze!', 'cueBad': 'Higher!'}),
    'cable_kickback': ExerciseConfig(patternType: PatternType.hinge),
    'standing_glute_kickback': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40}),
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
    'banded_kickback': ExerciseConfig(patternType: PatternType.hinge),
    
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
    'dumbbell_curl': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_curls': ExerciseConfig(patternType: PatternType.curl),
    'dumbbell_bicep_curl': ExerciseConfig(patternType: PatternType.curl),
    'hammer_curl': ExerciseConfig(patternType: PatternType.curl),
    'hammer_curls': ExerciseConfig(patternType: PatternType.curl),
    'standing_hammer_curl': ExerciseConfig(patternType: PatternType.curl),
    'seated_hammer_curl': ExerciseConfig(patternType: PatternType.curl),
    'cross_body_hammer_curl': ExerciseConfig(patternType: PatternType.curl),
    'preacher_curl': ExerciseConfig(patternType: PatternType.curl),
    'preacher_curls': ExerciseConfig(patternType: PatternType.curl),
    'preacher_curl_machine': ExerciseConfig(patternType: PatternType.curl),
    'concentration_curl': ExerciseConfig(patternType: PatternType.curl),
    'concentration_curls': ExerciseConfig(patternType: PatternType.curl),
    'cable_curl': ExerciseConfig(patternType: PatternType.curl),
    'cable_curls': ExerciseConfig(patternType: PatternType.curl),
    'cable_bicep_curl': ExerciseConfig(patternType: PatternType.curl),
    'incline_curl': ExerciseConfig(patternType: PatternType.curl),
    'incline_curls': ExerciseConfig(patternType: PatternType.curl),
    'spider_curl': ExerciseConfig(patternType: PatternType.curl),
    'spider_curls': ExerciseConfig(patternType: PatternType.curl),
    'ez_bar_curl': ExerciseConfig(patternType: PatternType.curl),
    'ez_bar_curls': ExerciseConfig(patternType: PatternType.curl),
    '21s_curl': ExerciseConfig(patternType: PatternType.curl),
    'reverse_curl': ExerciseConfig(patternType: PatternType.curl),
    'reverse_curls': ExerciseConfig(patternType: PatternType.curl),
    'zottman_curl': ExerciseConfig(patternType: PatternType.curl),
    'zottman_curls': ExerciseConfig(patternType: PatternType.curl),
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
    
    // CURL PATTERN - LEG EXTENSIONS/CURLS
    'leg_extension': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'leg_extensions': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full extension!'}),
    'leg_curl': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full curl!'}),
    'leg_curls': ExerciseConfig(patternType: PatternType.curl, params: {'cueGood': 'Squeeze!', 'cueBad': 'Full curl!'}),
    'hamstring_curl': ExerciseConfig(patternType: PatternType.curl),
    'hamstring_curls': ExerciseConfig(patternType: PatternType.curl),
    'lying_leg_curl': ExerciseConfig(patternType: PatternType.curl),
    'seated_leg_curl': ExerciseConfig(patternType: PatternType.curl),
    'nordic_curl': ExerciseConfig(patternType: PatternType.curl),
    'nordic_curls': ExerciseConfig(patternType: PatternType.curl),
    
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
    
    // HOLD PATTERN - STRETCHES/MOBILITY (REMOVED)
    'worlds_greatest_stretch': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    'childs_pose': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.plank}),
    
    // HOLD PATTERN - WALL SIT (REMOVED)
    
    // HOLD PATTERN - HANGS (REMOVED)
    
    // HOLD PATTERN - L-SIT (REMOVED)
    
    // HOLD PATTERN - SUPERMAN (REMOVED)
    
    // =========================================================================
    // ===== ROTATION PATTERN - Twisting movements =====
    // =========================================================================
    
    'russian_twist': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 45, 'cueGood': 'Twist!', 'cueBad': 'Rotate more!'}),
    'russian_twists': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 45}),
    'russian_twist_weighted': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 45}),
    'wood_chop': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60, 'cueGood': 'Chop!', 'cueBad': 'Rotate!'}),
    'wood_chops': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}),
    'cable_wood_chop': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}),
    'medicine_ball_woodchop': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}), // NEW - Missing
    'dumbbell_woodchop': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}), // NEW - Missing
    'woodchop': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}), // NEW - Missing
    'woodchoppers': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}), // NEW - Missing
    'windmill': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 45}),
    'windmills': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 45}),
    'pallof_press': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 30}),
    'pallof_press_kneeling': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 30}),
    'pallof_press_standing': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 30}),
    'pallof_press_split_stance': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 30}),
    'landmine_rotation': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 45}),
    'seated_twist': ExerciseConfig(patternType: PatternType.rotation),
    'oblique_crunch': ExerciseConfig(patternType: PatternType.rotation),
    'oblique_crunches': ExerciseConfig(patternType: PatternType.rotation),
    
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
