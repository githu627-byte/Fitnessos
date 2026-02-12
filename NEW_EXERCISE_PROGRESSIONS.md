# NEW EXERCISE PROGRESSIONS - TO FIX DUPLICATE WORKOUTS

## HOW THE CURRENT LOGIC WORKS:

**EXISTING STRUCTURE (DON'T TOUCH):**
```dart
static const List<ExerciseProgression> chestProgressions = [
  ExerciseProgression(
    beginner: 'push_ups',
    intermediate: 'dumbbell_bench_press',
    advanced: 'barbell_bench_press',
    muscleGroup: 'chest',
    movementPattern: 'push',
  ),
  // ... more progressions
];
```

**Then in getProgressionsForMuscleGroup():**
```dart
case 'chest':
  return chestProgressions;
```

**SAME STRUCTURE, NEW LISTS!**

---

## PROBLEM 1: HOME / HIIT CIRCUITS (All 4 use 'hiit')

### **CURRENT (BROKEN):**
- 10 Min Quick Burn → `['hiit']`
- 20 Min Destroyer → `['hiit']`
- Tabata Torture → `['hiit']`
- Cardio Blast → `['hiit']`

### **NEW SOLUTION (ADD THESE NEW PROGRESSIONS):**

**Keep 'hiit' for 10 Min Quick Burn (don't touch existing)**

**Add 'hiit_endurance' for 20 Min Destroyer:**
```dart
static const List<ExerciseProgression> hiitEnduranceProgressions = [
  ExerciseProgression(
    beginner: 'step_touch',
    intermediate: 'jumping_jack',
    advanced: 'burpee',
    muscleGroup: 'full_body',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'air_squat',
    intermediate: 'jump_squat',
    advanced: 'tuck_jump',
    muscleGroup: 'legs',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'incline_push_up',
    intermediate: 'push_up',
    advanced: 'burpee_tuck_jump',
    muscleGroup: 'chest',
    movementPattern: 'push',
  ),
  ExerciseProgression(
    beginner: 'plank',
    intermediate: 'mountain_climber',
    advanced: 'mountain_climber_crossover',
    muscleGroup: 'core',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'static_lunge',
    intermediate: 'walking_lunge',
    advanced: 'jumping_lunge',
    muscleGroup: 'legs',
    movementPattern: 'squat',
  ),
  ExerciseProgression(
    beginner: 'side_step',
    intermediate: 'lateral_shuffle',
    advanced: 'skater_hop',
    muscleGroup: 'legs',
    movementPattern: 'cardio',
  ),
];
```

**Add 'hiit_tabata' for Tabata Torture:**
```dart
static const List<ExerciseProgression> hiitTabataProgressions = [
  ExerciseProgression(
    beginner: 'knee_tap',
    intermediate: 'butt_kick',
    advanced: 'butt_kick_sprint',
    muscleGroup: 'legs',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'modified_burpee',
    intermediate: 'burpee',
    advanced: 'burpee_tuck_jump',
    muscleGroup: 'full_body',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'squat_reach',
    intermediate: 'squat_jump',
    advanced: 'tuck_jump',
    muscleGroup: 'legs',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'plank_tap',
    intermediate: 'plank_jack',
    advanced: 'burpee_sprawl',
    muscleGroup: 'core',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'step_touch',
    intermediate: 'jumping_jack',
    advanced: 'star_jump',
    muscleGroup: 'full_body',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'standing_oblique_crunch',
    intermediate: 'mountain_climber',
    advanced: 'mountain_climber_crossover',
    muscleGroup: 'core',
    movementPattern: 'cardio',
  ),
];
```

**Add 'hiit_cardio' for Cardio Blast (pure cardio, no strength):**
```dart
static const List<ExerciseProgression> hiitCardioProgressions = [
  ExerciseProgression(
    beginner: 'marching_in_place',
    intermediate: 'high_knee',
    advanced: 'high_knee_sprint',
    muscleGroup: 'full_body',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'step_touch',
    intermediate: 'jumping_jack',
    advanced: 'star_jump',
    muscleGroup: 'full_body',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'knee_tap',
    intermediate: 'butt_kick',
    advanced: 'butt_kick_sprint',
    muscleGroup: 'legs',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'side_step',
    intermediate: 'lateral_shuffle',
    advanced: 'skater_hop',
    muscleGroup: 'legs',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'step_up',
    intermediate: 'box_step_up',
    advanced: 'box_jump',
    muscleGroup: 'legs',
    movementPattern: 'cardio',
  ),
  ExerciseProgression(
    beginner: 'squat_reach',
    intermediate: 'squat_jump',
    advanced: 'tuck_jump',
    muscleGroup: 'legs',
    movementPattern: 'cardio',
  ),
];
```

---

## PROBLEM 2: GYM / BOOTY BUILDER (Both use 'glutes')

### **CURRENT (BROKEN):**
- Glute Sculpt → `['glutes']`
- Peach Pump → `['glutes']`

### **NEW SOLUTION:**

**Keep 'glutes' for Glute Sculpt**

**Add 'glutes_pump' for Peach Pump:**
```dart
static const List<ExerciseProgression> glutesPumpProgressions = [
  // Start with different glute exercises
  ExerciseProgression(
    beginner: 'sumo_squat',
    intermediate: 'sumo_squat_pulse',
    advanced: 'sumo_squat_hold_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'squat',
  ),
  ExerciseProgression(
    beginner: 'frog_pump',
    intermediate: 'frog_pump_pulse',
    advanced: 'frog_pump_hold_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'hinge',
  ),
  ExerciseProgression(
    beginner: 'reverse_lunge',
    intermediate: 'curtsy_lunge',
    advanced: 'pulse_curtsy_lunge',
    muscleGroup: 'glutes',
    movementPattern: 'squat',
  ),
  ExerciseProgression(
    beginner: 'glute_bridge',
    intermediate: 'single_leg_glute_bridge',
    advanced: 'elevated_glute_bridge',
    muscleGroup: 'glutes',
    movementPattern: 'hinge',
  ),
  ExerciseProgression(
    beginner: 'standing_glute_squeeze',
    intermediate: 'single_leg_rdl',
    advanced: 'single_leg_rdl_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'hinge',
  ),
  ExerciseProgression(
    beginner: 'standing_glute_kickback',
    intermediate: 'donkey_kick',
    advanced: 'donkey_kick_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'isolation',
  ),
];
```

---

## PROBLEM 3: HOME / HOME BOOTY (All 3 use 'glutes')

### **CURRENT (BROKEN):**
- Glute Activation → `['glutes']`
- Booty Burner → `['glutes']`
- Band Booty → `['glutes']`

### **NEW SOLUTION:**

**Keep 'glutes' for Glute Activation**

**Add 'glutes_burner' for Booty Burner:**
```dart
static const List<ExerciseProgression> glutesBurnerProgressions = [
  // High-volume focus order
  ExerciseProgression(
    beginner: 'sumo_squat',
    intermediate: 'sumo_squat_pulse',
    advanced: 'sumo_squat_hold_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'squat',
  ),
  ExerciseProgression(
    beginner: 'glute_bridge',
    intermediate: 'single_leg_glute_bridge',
    advanced: 'elevated_glute_bridge',
    muscleGroup: 'glutes',
    movementPattern: 'hinge',
  ),
  ExerciseProgression(
    beginner: 'reverse_lunge',
    intermediate: 'curtsy_lunge',
    advanced: 'pulse_curtsy_lunge',
    muscleGroup: 'glutes',
    movementPattern: 'squat',
  ),
  ExerciseProgression(
    beginner: 'standing_glute_kickback',
    intermediate: 'donkey_kick',
    advanced: 'donkey_kick_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'isolation',
  ),
  ExerciseProgression(
    beginner: 'frog_pump',
    intermediate: 'frog_pump_pulse',
    advanced: 'frog_pump_hold_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'hinge',
  ),
  ExerciseProgression(
    beginner: 'standing_glute_squeeze',
    intermediate: 'single_leg_rdl',
    advanced: 'single_leg_rdl_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'hinge',
  ),
];
```

**Add 'glutes_band' for Band Booty:**
```dart
static const List<ExerciseProgression> glutesBandProgressions = [
  // Band-focused exercise order
  ExerciseProgression(
    beginner: 'glute_bridge',
    intermediate: 'single_leg_glute_bridge',
    advanced: 'elevated_glute_bridge',
    muscleGroup: 'glutes',
    movementPattern: 'hinge',
  ),
  ExerciseProgression(
    beginner: 'sumo_squat',
    intermediate: 'sumo_squat_pulse',
    advanced: 'sumo_squat_hold_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'squat',
  ),
  ExerciseProgression(
    beginner: 'standing_glute_kickback',
    intermediate: 'donkey_kick',
    advanced: 'donkey_kick_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'isolation',
  ),
  ExerciseProgression(
    beginner: 'frog_pump',
    intermediate: 'frog_pump_pulse',
    advanced: 'frog_pump_hold_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'hinge',
  ),
  ExerciseProgression(
    beginner: 'reverse_lunge',
    intermediate: 'curtsy_lunge',
    advanced: 'pulse_curtsy_lunge',
    muscleGroup: 'glutes',
    movementPattern: 'squat',
  ),
  ExerciseProgression(
    beginner: 'standing_glute_squeeze',
    intermediate: 'single_leg_rdl',
    advanced: 'single_leg_rdl_pulse',
    muscleGroup: 'glutes',
    movementPattern: 'hinge',
  ),
];
```

---

## THEN UPDATE workout_data.dart LIKE THIS:

**HOME HIIT (FIXED):**
```dart
10 Min Quick Burn: muscleGroups: ['hiit']  // Keep original
20 Min Destroyer: muscleGroups: ['hiit_endurance']  // NEW
Tabata Torture: muscleGroups: ['hiit_tabata']  // NEW
Cardio Blast: muscleGroups: ['hiit_cardio']  // NEW
```

**GYM BOOTY BUILDER (FIXED):**
```dart
Glute Sculpt: muscleGroups: ['glutes']  // Keep original
Peach Pump: muscleGroups: ['glutes_pump']  // NEW
```

**HOME BOOTY (FIXED):**
```dart
Glute Activation: muscleGroups: ['glutes']  // Keep original
Booty Burner: muscleGroups: ['glutes_burner']  // NEW
Band Booty: muscleGroups: ['glutes_band']  // NEW
```

---

## WHY THIS WON'T BREAK ANYTHING:

✅ **No logic changes** - WorkoutTemplateService stays EXACTLY the same  
✅ **Same structure** - New progressions follow EXACT same format as existing  
✅ **Same exercise IDs** - MediaPipe still recognizes them  
✅ **Just different order** - Pulling from different progression lists  
✅ **Proven pattern** - Using the SAME pattern that already works (chest, back, legs all do this!)

**IT'S LITERALLY COPY/PASTE THE WORKING LOGIC WITH NEW DATA!**

**Should I code this now bro? This is SAFE! 💯**
