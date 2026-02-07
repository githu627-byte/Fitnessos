import '../base_pattern.dart';
import '../movement_engine.dart';

/// Squat Pattern Exercises
/// Lower body quad-dominant movements
class SquatExercises {
  static const Map<String, ExerciseConfig> definitions = {
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
    'split_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'split_squats': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'bulgarian_split_squat': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'bulgarian_split_squats': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'bulgarian_split': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'bulgarian_split_squat_bw': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}), // NEW - Missing
    
    // SQUAT PATTERN - LUNGES
    'lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'resetPercent': 0.90}),
    'lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'resetPercent': 0.90}),
    'walking_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'resetPercent': 0.90}),
    'walking_lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'resetPercent': 0.90}),
    'reverse_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'resetPercent': 0.90}),
    'reverse_lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'resetPercent': 0.90}),
    'static_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'resetPercent': 0.90}),
    'deficit_reverse_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'resetPercent': 0.90}),
    'curtsy_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'curtsy_lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'pulse_curtsy_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'lateral_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78}),
    'lateral_lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.78}),
    'jump_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    'jump_lunges': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75}),
    
    // SQUAT PATTERN - STEP UPS
    'step_up': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80}),
    'step_ups': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80}),
    'stepups_chair': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80}),
    'box_stepups': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80}),
    
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
    'box_step_up': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80}),
    'tuck_jump': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Knees up!', 'cueBad': 'Higher!'}),
    'tuck_jumps': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Knees up!', 'cueBad': 'Higher!'}),
    'star_jump': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'cueGood': 'Explode!', 'cueBad': 'Arms up!'}),
    'star_jumps': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'cueGood': 'Explode!', 'cueBad': 'Arms up!'}),
    'jumping_jack': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.90, 'cueGood': 'Jump!', 'cueBad': 'Arms up!'}),
    'jumping_jacks': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.90, 'cueGood': 'Jump!', 'cueBad': 'Arms up!'}),
    'jumping_lunge': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.75, 'cueGood': 'Explode!', 'cueBad': 'Switch!'}),
    'lateral_hop': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85}),
    'lateral_hops': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85}),
    'skater_hop': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.80, 'cueGood': 'Jump!', 'cueBad': 'Push off!'}),
    
    // SQUAT PATTERN - BURPEE/SPRAWL
    'burpee': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.65, 'resetPercent': 0.90, 'cueGood': 'Explode!', 'cueBad': 'Chest down!'}),
    'burpees': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.65, 'resetPercent': 0.90, 'cueGood': 'Explode!', 'cueBad': 'Chest down!'}),
    'modified_burpee': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70, 'resetPercent': 0.90}),
    'burpee_tuck_jump': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.60, 'resetPercent': 0.88, 'cueGood': 'Explode!', 'cueBad': 'Tuck!'}),
    'burpee_sprawl': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.65, 'resetPercent': 0.90}),
    'sprawl': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.65, 'resetPercent': 0.90}),
    'sprawls': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.65, 'resetPercent': 0.90}),
    
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
    'side_lying_leg_lift': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85}),
    'fire_hydrant_pulse': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85}),
    
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
    
    // SQUAT PATTERN - BEAR CRAWL
    'bear_crawl': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'cueGood': 'Crawl!', 'cueBad': 'Stay low!'}),
    'bear_crawls': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.85, 'cueGood': 'Crawl!', 'cueBad': 'Stay low!'}),
    'inchworm': ExerciseConfig(patternType: PatternType.squat, params: {'triggerPercent': 0.70, 'cueGood': 'Walk out!', 'cueBad': 'Chest down!'}),
    
    // SQUAT PATTERN - WALL SIT
    'wall_sit': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.squat, 'cueGood': 'Hold it!', 'cueBad': 'Stay strong!'}),
    'wall_sits': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.squat, 'cueGood': 'Hold it!', 'cueBad': 'Stay strong!'}),
    'wall_squat': ExerciseConfig(patternType: PatternType.hold, params: {'holdType': HoldType.squat}),
  };
}
