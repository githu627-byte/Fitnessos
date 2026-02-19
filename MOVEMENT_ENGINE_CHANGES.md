# MOVEMENT ENGINE PATTERN REMAPPING - SURGICAL CHANGES

## OVERVIEW
These are the exact changes needed for `lib/core/patterns/movement_engine.dart` to remap exercises to different patterns for better MediaPipe tracking.

## CHANGE 1: LEG EXTENSIONS/CURLS → BARBELL SQUAT PATTERN

**FIND THIS SECTION:**
```dart
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
```

**REPLACE WITH:**
```dart
// SQUAT PATTERN - LEG EXTENSIONS/CURLS (moved from curl - use barbell_squat pattern)
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
```

## CHANGE 2: RDLs & GOOD MORNINGS → BURPEE HINGE PATTERN

**FIND THESE EXERCISES:**
```dart
'romanian_deadlift': ExerciseConfig(patternType: PatternType.squat),
'romanian_deadlifts': ExerciseConfig(patternType: PatternType.squat),
'rdl': ExerciseConfig(patternType: PatternType.squat),
'dumbbell_rdl': ExerciseConfig(patternType: PatternType.squat),
'stiff_leg_deadlift': ExerciseConfig(patternType: PatternType.squat),
'stiff_leg_deadlifts': ExerciseConfig(patternType: PatternType.squat),
'single_leg_rdl': ExerciseConfig(patternType: PatternType.squat),
'good_morning': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.70, 'cueGood': 'Feel it!', 'cueBad': 'Hinge!'}),
'good_mornings': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.70}),
```

**REPLACE WITH (use exact same params as burpee):**
```dart
'romanian_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
'romanian_deadlifts': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
'rdl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
'dumbbell_rdl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
'stiff_leg_deadlift': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
'stiff_leg_deadlifts': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
'single_leg_rdl': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
'good_morning': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
'good_mornings': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.40, 'resetPercent': 0.75, 'cueGood': 'Lockout!', 'cueBad': 'Hips forward!'}),
```

## CHANGE 3: ALL ROWS & FACE PULLS → CHEST FLY PATTERN

**FIND THE ENTIRE ROW SECTION:**
```dart
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
```

**REPLACE WITH (use chest_fly pattern params):**
```dart
// PUSH PATTERN - ROWS (moved from pull - use chest_fly pattern)
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

// PUSH PATTERN - FACE PULLS / REAR DELTS (moved from pull - use chest_fly pattern)
'face_pull': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
'face_pulls': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
'reverse_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
'reverse_flys': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
'reverse_flyes': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
'rear_delt_fly': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
'reverse_pec_deck': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
'rear_delt_flys': ExerciseConfig(patternType: PatternType.push, params: {'cueGood': 'Squeeze!', 'cueBad': 'Open up!'}),
```

## CHANGE 4: ONE-ARM DUMBBELL CURLS → CHEST FLY PATTERN

**FIND THESE SPECIFIC DUMBBELL CURLS IN THE CURL SECTION:**
```dart
'dumbbell_curl': ExerciseConfig(patternType: PatternType.curl),
'dumbbell_curls': ExerciseConfig(patternType: PatternType.curl),
'dumbbell_bicep_curl': ExerciseConfig(patternType: PatternType.curl),
'hammer_curl': ExerciseConfig(patternType: PatternType.curl),
'hammer_curls': ExerciseConfig(patternType: PatternType.curl),
'standing_hammer_curl': ExerciseConfig(patternType: PatternType.curl),
'seated_hammer_curl': ExerciseConfig(patternType: PatternType.curl),
'cross_body_hammer_curl': ExerciseConfig(patternType: PatternType.curl),
'concentration_curl': ExerciseConfig(patternType: PatternType.curl),
'concentration_curls': ExerciseConfig(patternType: PatternType.curl),
'incline_curl': ExerciseConfig(patternType: PatternType.curl),
'incline_curls': ExerciseConfig(patternType: PatternType.curl),
'zottman_curl': ExerciseConfig(patternType: PatternType.curl),
'zottman_curls': ExerciseConfig(patternType: PatternType.curl),
```

**REMOVE THESE FROM CURL SECTION AND ADD TO PUSH SECTION:**
```dart
// PUSH PATTERN - ONE-ARM DUMBBELL CURLS (moved from curl - use chest_fly pattern)
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
```

**KEEP THESE IN CURL SECTION (barbell/cable curls stay):**
```dart
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
```

## CHANGE 5: SWINGS → ROW PATTERN

**FIND THIS SECTION:**
```dart
// HINGE PATTERN - SWINGS
'kettlebell_swing': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80, 'cueGood': 'Snap!', 'cueBad': 'Hips drive!'}),
'kettlebell_swings': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
'kb_swing': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
'russian_swing': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
'american_swing': ExerciseConfig(patternType: PatternType.hinge, params: {'triggerPercent': 0.45, 'resetPercent': 0.80}),
```

**REPLACE WITH (use original row pattern params):**
```dart
// PULL PATTERN - SWINGS (moved from hinge - use original row pattern)
'kettlebell_swing': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'kettlebell_swings': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'kb_swing': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'russian_swing': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'american_swing': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
```

## CHANGE 6: ROTATION EXERCISES → BENT OVER ROW PATTERN

**FIND ALL ROTATION EXERCISES:**
```dart
// RUSSIAN TWISTS
'russian_twist': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 45, 'cueGood': 'Twist!', 'cueBad': 'Rotate more!'}),
'russian_twists': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 45}),
'russian_twist_weighted': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 45}),

// WOOD CHOPS
'wood_chop': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60, 'cueGood': 'Chop!', 'cueBad': 'Rotate!'}),
'wood_chops': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}),
'cable_wood_chop': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}),
'medicine_ball_woodchop': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}),
'dumbbell_woodchop': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}),
'woodchop': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}),
'woodchoppers': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 60}),

// LANDMINE & SEATED
'landmine_rotation': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 50, 'cueGood': 'Rotate!', 'cueBad': 'Twist more!'}),
'seated_twist': ExerciseConfig(patternType: PatternType.rotation, params: {'triggerAngle': 45}),
```

**REPLACE WITH (use original bent_over_row pattern params):**
```dart
// PULL PATTERN - ROTATION EXERCISES (moved from rotation - use original bent_over_row pattern)
'russian_twist': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'russian_twists': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'russian_twist_weighted': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),

// PULL PATTERN - WOOD CHOPS (moved from rotation - use original bent_over_row pattern)
'wood_chop': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'wood_chops': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'cable_wood_chop': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'medicine_ball_woodchop': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'dumbbell_woodchop': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'woodchop': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'woodchoppers': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),

// PULL PATTERN - LANDMINE & SEATED (moved from rotation - use original bent_over_row pattern)
'landmine_rotation': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
'seated_twist': ExerciseConfig(patternType: PatternType.pull, params: {'triggerPercent': 0.55, 'resetPercent': 0.85}),
```

## CRITICAL NOTES:

1. **NO DUPLICATES**: When moving exercises, make sure to REMOVE them from their original location to avoid duplicate key errors.

2. **EXACT PARAMS**: Use the exact parameter values specified above - they match existing working patterns.

3. **BARBELL/CABLE CURLS STAY**: Only dumbbell/one-arm curls move to push pattern. Barbell and cable curls stay in curl pattern.

4. **TEST AFTER EACH CHANGE**: Run `flutter analyze` after each major change to catch any errors early.

5. **PRESERVE COMMENTS**: Keep the section comments updated to reflect the new pattern assignments.

This document provides the exact surgical changes needed without breaking the existing MediaPipe tracking system.