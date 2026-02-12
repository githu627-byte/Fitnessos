/// =============================================================================
/// EXERCISE ID OVERRIDES - FIXED VERSION
/// =============================================================================
/// This file contains corrected mappings from workout_data IDs to video file IDs.
/// 
/// CHANGES FROM ORIGINAL:
/// - Fixed seated_db_press (was leg press, now shoulder press)
/// - Fixed several arm exercises
/// - Added missing mappings
/// - Removed incorrect cross-muscle mappings
/// =============================================================================

class ExerciseIdOverridesFix {
  static const Map<String, String> overrides = {
    // ═══════════════════════════════════════════════════════════════════════
    // CHEST EXERCISES
    // ═══════════════════════════════════════════════════════════════════════
    'bench_press': 'barbell_bench_press',
    'barbell_bench_press': 'barbell_bench_press',
    'incline_press': 'barbell_incline_bench_press',
    'incline_bench_press': 'barbell_incline_bench_press',
    'incline_db_press': 'dumbbell_incline_bench_press',
    'decline_press': 'barbell_decline_bench_press',
    'decline_bench_press': 'barbell_decline_bench_press',
    'chest_flys': 'dumbbell_fly',
    'chest_fly': 'dumbbell_fly',
    'dumbbell_flyes': 'dumbbell_fly',
    'dumbbell_fly': 'dumbbell_fly',
    'machine_chest_fly': 'machine_inner_chest_press',
    'pec_deck': 'machine_inner_chest_press',
    'pushups': 'push_up_m',
    'push_ups': 'push_up_m',
    'push_up': 'push_up_m',
    'wide_pushups': 'wide_hand_push_up',
    'wide_push_ups': 'wide_hand_push_up',
    'diamond_pushups': 'diamond_push_up',
    'diamond_push_ups': 'diamond_push_up',
    'close_grip_pushups': 'close_grip_push_up',
    'dips_chest': 'chest_dip',
    'chest_dips': 'chest_dip',
    'dips': 'chest_dip',
    'cable_crossover': 'cable_crossover_variation',
    'cable_crossovers': 'cable_crossover_variation',
    'landmine_press': 'barbell_incline_bench_press', // Closest match
    'close_grip_bench': 'barbell_lying_close_grip_press',
    'close_grip_bench_press': 'barbell_lying_close_grip_press',
    
    // ═══════════════════════════════════════════════════════════════════════
    // BACK EXERCISES
    // ═══════════════════════════════════════════════════════════════════════
    'deadlift': 'barbell_deadlift',
    'barbell_deadlift': 'barbell_deadlift',
    'bent_rows': 'barbell_bent_over_row',
    'bent_over_rows': 'barbell_bent_over_row',
    'barbell_row': 'barbell_bent_over_row',
    'barbell_rows': 'barbell_bent_over_row',
    'pullups': 'pull_up',
    'pull_ups': 'pull_up',
    'chin_ups': 'chin_up',
    'chinups': 'chin_up',
    'lat_pulldown': 'cable_bar_lateral_pulldown',
    'lat_pulldowns': 'cable_bar_lateral_pulldown',
    'cable_rows': 'cable_seated_row',
    'seated_cable_row': 'cable_seated_row',
    'seated_row': 'cable_seated_row',
    'tbar_rows': 'lever_t_bar_row',
    't_bar_rows': 'lever_t_bar_row',
    'face_pulls': 'cable_rear_delt_fly', // Better match than pulldown
    'face_pull': 'cable_rear_delt_fly',
    'reverse_flys': 'dumbbell_rear_lateral_raise',
    'reverse_fly': 'dumbbell_rear_lateral_raise',
    'shrugs': 'barbell_shrug',
    'barbell_shrugs': 'barbell_shrug',
    'dumbbell_shrugs': 'dumbbell_shrug',
    'dumbbell_row': 'dumbbell_bent_over_row',
    'single_arm_db_row': 'dumbbell_bent_over_row',
    'inverted_rows': 'inverted_row',
    'inverted_row': 'inverted_row',
    'cable_pullthrough': 'cable_pull_through',
    'romanian_deadlift': 'barbell_romanian_deadlift',
    'rdl': 'barbell_romanian_deadlift',
    
    // ═══════════════════════════════════════════════════════════════════════
    // SHOULDER EXERCISES
    // ═══════════════════════════════════════════════════════════════════════
    'overhead_press': 'barbell_standing_military_press',
    'ohp': 'barbell_standing_military_press',
    'military_press': 'barbell_standing_military_press',
    'shoulder_press': 'dumbbell_shoulder_press',
    'seated_db_press': 'dumbbell_shoulder_press', // FIXED: Was leg press!
    'seated_shoulder_press': 'dumbbell_shoulder_press',
    'arnold_press': 'dumbbell_arnold_press',
    'lateral_raises': 'dumbbell_lateral_raise',
    'lateral_raise': 'dumbbell_lateral_raise',
    'side_raises': 'dumbbell_lateral_raise',
    'front_raises': 'dumbbell_front_raise',
    'front_raise': 'dumbbell_front_raise',
    'rear_delt_flys': 'dumbbell_rear_lateral_raise',
    'rear_delt_fly': 'dumbbell_rear_lateral_raise',
    'upright_rows': 'barbell_upright_row',
    'upright_row': 'barbell_upright_row',
    'pike_pushups': 'pike_push_up',
    'pike_push_ups': 'pike_push_up',
    'handstand_pushups': 'pike_push_up', // Closest match
    
    // ═══════════════════════════════════════════════════════════════════════
    // LEG EXERCISES
    // ═══════════════════════════════════════════════════════════════════════
    'squats': 'barbell_full_squat',
    'squat': 'barbell_full_squat',
    'barbell_squat': 'barbell_full_squat',
    'back_squat': 'barbell_full_squat',
    'front_squat': 'barbell_front_squat',
    'squats_bw': 'squat_m',
    'bodyweight_squat': 'squat_m',
    'air_squats': 'squat_m',
    'goblet_squats': 'dumbbell_goblet_squat',
    'goblet_squat': 'dumbbell_goblet_squat',
    'lunges': 'dumbbell_lunge',
    'lunge': 'dumbbell_lunge',
    'walking_lunges': 'walking_lunge_male',
    'walking_lunge': 'walking_lunge_male',
    'bulgarian_split': 'dumbbell_bulgarian_split_squat',
    'bulgarian_split_squat': 'dumbbell_bulgarian_split_squat',
    'split_squat': 'dumbbell_bulgarian_split_squat',
    'leg_press': 'lever_seated_leg_press',
    'leg_extensions': 'lever_leg_extension',
    'leg_extension': 'lever_leg_extension',
    'leg_curls': 'lever_lying_leg_curl',
    'leg_curl': 'lever_lying_leg_curl',
    'hamstring_curl': 'lever_lying_leg_curl',
    'calf_raises': 'lever_standing_calf_raise',
    'calf_raise': 'lever_standing_calf_raise',
    'standing_calf_raise': 'lever_standing_calf_raise',
    'seated_calf_raise': 'lever_seated_calf_raise',
    'step_ups': 'dumbbell_step_up',
    'step_up': 'dumbbell_step_up',
    // 'wall_sits': 'wall_sit',
    // 'wall_sit': 'wall_sit',
    'jump_squats': 'jump_squat',
    'squat_jumps': 'jump_squat',
    'hip_thrust': 'hip_thrusts',
    'hip_thrusts': 'hip_thrusts',
    'glute_bridge': 'hip_thrusts', // Closest match
    'sumo_squat': 'barbell_sumo_squat',
    'sumo_deadlift': 'barbell_sumo_deadlift',
    'single_leg_deadlift': 'dumbbell_single_leg_deadlift',
    
    // ═══════════════════════════════════════════════════════════════════════
    // ARM EXERCISES - BICEPS
    // ═══════════════════════════════════════════════════════════════════════
    'bicep_curls': 'barbell_curl',
    'bicep_curl': 'barbell_curl',
    'barbell_curl': 'barbell_curl',
    'dumbbell_curl': 'dumbbell_biceps_curl',
    'dumbbell_curls': 'dumbbell_biceps_curl',
    'hammer_curls': 'dumbbell_hammer_curl',
    'hammer_curl': 'dumbbell_hammer_curl',
    'preacher_curls': 'barbell_preacher_curl',
    'preacher_curl': 'barbell_preacher_curl',
    'concentration_curls': 'dumbbell_concentration_curl',
    'concentration_curl': 'dumbbell_concentration_curl',
    'cable_curls': 'cable_curl',
    'cable_curl': 'cable_curl',
    'incline_curls': 'dumbbell_incline_curl',
    'incline_curl': 'dumbbell_incline_curl',
    'ez_bar_curl': 'ez_barbell_curl',
    
    // ═══════════════════════════════════════════════════════════════════════
    // ARM EXERCISES - TRICEPS
    // ═══════════════════════════════════════════════════════════════════════
    'tricep_extensions': 'dumbbell_lying_triceps_extension',
    'tricep_extension': 'dumbbell_lying_triceps_extension',
    'skull_crushers': 'barbell_lying_close_grip_triceps_extension',
    'skull_crusher': 'barbell_lying_close_grip_triceps_extension',
    'overhead_tricep': 'dumbbell_standing_triceps_extension',
    'overhead_tricep_ext': 'dumbbell_standing_triceps_extension',
    'overhead_tricep_extension': 'dumbbell_standing_triceps_extension',
    'tricep_pushdown': 'cable_triceps_pushdown',
    'tricep_pushdowns': 'cable_triceps_pushdown',
    'rope_pushdown': 'cable_triceps_pushdown',
    'tricep_dips': 'triceps_dip',
    'tricep_dip': 'triceps_dip',
    'tricep_kickbacks': 'dumbbell_kickback',
    'tricep_kickback': 'dumbbell_kickback',
    
    // ═══════════════════════════════════════════════════════════════════════
    // CORE EXERCISES
    // ═══════════════════════════════════════════════════════════════════════
    'planks': 'front_plank',
    'plank': 'front_plank',
    'side_planks': 'side_plank',
    'side_plank': 'side_plank',
    'crunches': 'crunch',
    'crunch': 'crunch',
    'situps': 'sit_up',
    'sit_ups': 'sit_up',
    'sit_up': 'sit_up',
    'decline_situp': 'decline_sit_up',
    'leg_raises': 'lying_leg_raise',
    'leg_raise': 'lying_leg_raise',
    'hanging_leg_raise': 'hanging_leg_hip_raise',
    'hanging_leg_raises': 'hanging_leg_hip_raise',
    'russian_twists': 'russian_twist',
    'russian_twist': 'russian_twist',
    'mountain_climbers': 'mountain_climber',
    'mountain_climber': 'mountain_climber',
    'bicycle_crunches': 'bicycle_crunch',
    'bicycle_crunch': 'bicycle_crunch',
    'flutter_kicks': 'flutter_kick',
    'flutter_kick': 'flutter_kick',
    'dead_bugs': 'dead_bug',
    'dead_bug': 'dead_bug',
    'v_ups': 'v_up',
    'v_up': 'v_up',
    'toe_touches': 'toe_touch',
    'cable_crunch': 'cable_kneeling_crunch',
    'cable_crunches': 'cable_kneeling_crunch',
    
    // ═══════════════════════════════════════════════════════════════════════
    // CARDIO & PLYOMETRIC EXERCISES
    // ═══════════════════════════════════════════════════════════════════════
    'burpees': 'burpee',
    'burpee': 'burpee',
    'jumping_jacks': 'jumping_jack',
    'jumping_jack': 'jumping_jack',
    'high_knees': 'high_knee_run',
    'high_knee': 'high_knee_run',
    'butt_kicks': 'butt_kick',
    'butt_kick': 'butt_kick',
    'box_jumps': 'box_jump',
    'box_jump': 'box_jump',
    'jump_rope': 'jump_rope',
    'skipping': 'jump_rope',
    'tuck_jumps': 'tuck_jump',
    'tuck_jump': 'tuck_jump',
    'star_jumps': 'star_jump',
    'star_jump': 'star_jump',
    'skaters': 'skater',
    'skater': 'skater',
    'lateral_hops': 'lateral_step',
    // 'bear_crawls': 'bear_crawl',
    // 'bear_crawl': 'bear_crawl',
    'sprawls': 'sprawl',
    'sprawl': 'sprawl',
    
    // ═══════════════════════════════════════════════════════════════════════
    // GLUTE & HIP EXERCISES
    // ═══════════════════════════════════════════════════════════════════════
    'glute_kickback': 'cable_kickback',
    'glute_kickbacks': 'cable_kickback',
    'cable_kickback': 'cable_kickback',
    'donkey_kicks': 'donkey_kick',
    'donkey_kick': 'donkey_kick',
    'fire_hydrants': 'fire_hydrant',
    'fire_hydrant': 'fire_hydrant',
    // 'clamshells': 'clamshell',
    // 'clamshell': 'clamshell',
    'banded_walks': 'resistance_band_lateral_walk',
    'lateral_band_walks': 'resistance_band_lateral_walk',
    
    // ═══════════════════════════════════════════════════════════════════════
    // BAND/RESISTANCE EXERCISES
    // ═══════════════════════════════════════════════════════════════════════
    'banded_squat': 'resistance_band_squat',
    'banded_row': 'resistance_band_bent_over_row',
    'banded_press': 'resistance_band_chest_press',
    'banded_curl': 'resistance_band_bicep_curl',
    'banded_lateral_raise': 'resistance_band_lateral_raise',
  };

  /// Get the corrected exercise ID for video/GIF lookup
  static String getOverriddenId(String exerciseId) {
    final normalized = exerciseId.toLowerCase().trim();
    return overrides[normalized] ?? normalized;
  }
  
  /// Check if we have an override for this ID
  static bool hasOverride(String exerciseId) {
    return overrides.containsKey(exerciseId.toLowerCase().trim());
  }
  
  /// Get all exercise IDs that map to a given video ID
  static List<String> getAliases(String videoId) {
    return overrides.entries
        .where((e) => e.value == videoId)
        .map((e) => e.key)
        .toList();
  }
}
