# MOVEMENT ENGINE REORGANIZATION PLAN
================================================================================

## Problem Statement
- **498 total exercises** crammed into ONE `movement_engine.dart` file
- **36 exercises missing** pattern assignments
- **Whack-a-mole bug fixing**: Fixing one exercise breaks another
- Impossible to maintain and test individual movement patterns

## Solution: Modular File Structure

Split by pattern type + separate lookup registry

```
lib/core/patterns/
├── movement_engine.dart          (Main controller - 100 lines)
├── exercise_registry.dart        (Central lookup - 50 lines)
└── exercises/
    ├── squat_exercises.dart      (97 exercises)
    ├── push_exercises.dart       (101 exercises)
    ├── pull_exercises.dart       (62 exercises)
    ├── hinge_exercises.dart      (54 exercises)
    ├── curl_exercises.dart       (62 exercises)
    ├── hold_exercises.dart       (27 exercises)
    ├── cardio_exercises.dart     (34 knee drive exercises)
    ├── rotation_exercises.dart   (16 exercises)
    ├── calf_exercises.dart       (9 exercises)
    └── missing_exercises.dart    (36 to be assigned)
```

## File Breakdown

### 1. movement_engine.dart (MAIN CONTROLLER)
**Purpose**: Pattern creation & frame processing logic
**Size**: ~100 lines
**Contains**:
- `MovementEngine` class
- Pattern factory methods
- `captureBaseline()` & `processFrame()` logic
- **NO exercise definitions**

### 2. exercise_registry.dart (LOOKUP TABLE)
**Purpose**: Central exercise → pattern mapping
**Size**: ~50 lines
**Contains**:
```dart
class ExerciseRegistry {
  static final Map<String, ExerciseConfig> all = {
    ...SquatExercises.definitions,
    ...PushExercises.definitions,
    ...PullExercises.definitions,
    ...HingeExercises.definitions,
    ...CurlExercises.definitions,
    ...HoldExercises.definitions,
    ...CardioExercises.definitions,
    ...RotationExercises.definitions,
    ...CalfExercises.definitions,
  };
  
  static bool hasPattern(String exerciseId) => all.containsKey(exerciseId);
  static ExerciseConfig? getConfig(String exerciseId) => all[exerciseId];
}
```

### 3. squat_exercises.dart (97 EXERCISES)
**Pattern Type**: SQUAT
**Examples**: air_squat, barbell_back_squat, bulgarian_split_squat, burpee, goblet_squat, jump_squat, lunge, pistol_squat, sissy_squat, step_up, sumo_squat
**Special Notes**:
- Jumping jacks & star jumps REMOVED (moved to cardio as inverted push)
- Crunches, sit-ups, cable crunches (core work with squat-like motion)
- ALL lunges (forward, reverse, walking, jumping, curtsy, deficit)

### 4. push_exercises.dart (101 EXERCISES)
**Pattern Type**: PUSH
**Examples**: bench_press, push_up, overhead_press, dip, shoulder_press, lateral_raise, pike_pushup, incline_press, decline_press
**Special Notes**:
- All chest pressing (bench, incline, decline, dumbbell, barbell)
- All shoulder pressing (overhead, arnold, military, pike)
- All push-up variations (standard, diamond, wide, archer, clap, decline, incline)
- Dips (chest, tricep, bench, ring, weighted)
- Lateral & front raises
- Ab wheel rollouts (pushing motion)

### 5. pull_exercises.dart (62 EXERCISES)
**Pattern Type**: PULL
**Examples**: pull_up, chin_up, lat_pulldown, barbell_row, cable_row, face_pull, shrug, rear_delt_fly
**Special Notes**:
- All pull-ups/chin-ups (wide, close, neutral, assisted, weighted)
- All rows (barbell, dumbbell, cable, seated, chest-supported, pendlay, t-bar, inverted)
- Lat pulldowns (standard, wide, neutral, close)
- Face pulls & rear delt work
- Shrugs (barbell, dumbbell)

### 6. hinge_exercises.dart (54 EXERCISES)
**Pattern Type**: HINGE
**Examples**: deadlift, romanian_deadlift, hip_thrust, glute_bridge, kettlebell_swing, good_morning, donkey_kick
**Special Notes**:
- ALL deadlifts (conventional, sumo, romanian, stiff-leg, single-leg, rack-pull, trap-bar)
- All hip thrusts & glute bridges (single-leg, banded, elevated)
- Kettlebell swings (russian, american)
- Donkey kicks & kickbacks
- Good mornings & back extensions
- Frog pumps & glute squeezes

### 7. curl_exercises.dart (62 EXERCISES)
**Pattern Type**: CURL
**Examples**: bicep_curl, hammer_curl, preacher_curl, tricep_extension, skull_crusher, leg_extension, leg_curl
**Special Notes**:
- ALL bicep curls (dumbbell, barbell, cable, hammer, concentration, spider, preacher, incline, ez-bar)
- ALL tricep extensions (overhead, rope, cable, skull crushers, kickbacks)
- Leg extensions & leg curls (seated, lying, nordic)
- Wrist curls & reverse curls

### 8. hold_exercises.dart (27 EXERCISES)
**Pattern Type**: HOLD (isometric)
**Examples**: plank, side_plank, wall_sit, dead_hang, l_sit, hollow_body_hold, bird_dog, clamshell
**Special Notes**:
- All planks (forearm, high, side, plank_tap, plank_walk_out)
- Wall sits
- Hangs (dead, active)
- L-sits
- Superman holds
- Clamshells & bird dogs (glute activation holds)

### 9. cardio_exercises.dart (34 EXERCISES)
**Pattern Type**: KNEEDRIVE (cardio movements)
**Examples**: high_knees, mountain_climber, butt_kicks, bicycle_crunch, leg_raise, skaters, lateral_shuffle, jumping_jacks, star_jumps
**Special Notes**:
- High knees, butt kicks, knee taps
- Mountain climbers (standard, crossover)
- Bicycle crunches, flutter kicks
- Leg raises (lying, hanging)
- Dead bugs
- Skaters, lateral shuffles
- **MOVED HERE**: jumping_jacks, star_jumps (inverted push pattern for arm tracking)

### 10. rotation_exercises.dart (16 EXERCISES)
**Pattern Type**: ROTATION (twisting/anti-rotation)
**Examples**: russian_twist, pallof_press, wood_chop, cable_wood_chop, oblique_crunch, landmine_rotation
**Special Notes**:
- Russian twists (weighted, bodyweight)
- Pallof press (standing, kneeling, split-stance)
- Wood chops & cable wood chops
- Oblique crunches
- Windmills

### 11. calf_exercises.dart (9 EXERCISES)
**Pattern Type**: CALF
**Examples**: calf_raise, standing_calf_raise, seated_calf_raise, single_leg_calf_raise, jump_rope
**Special Notes**:
- Standing calf raises
- Seated calf raises
- Single-leg variations
- Donkey calf raises
- Jump rope

### 12. missing_exercises.dart (36 EXERCISES - NEED PATTERN ASSIGNMENT)
**Status**: Needs manual review and pattern assignment
**List**:
- **Stretches/Mobility** (assign to HOLD):
  - 90_90_stretch, butterfly_stretch, cat_cow, chest_doorway_stretch, frog_stretch, hamstring_stretch, happy_baby, hip_flexor_stretch, pigeon_pose, quad_stretch
  
- **Glute Work** (assign to HINGE):
  - banded_clamshell, banded_fire_hydrant, fire_hydrant, fire_hydrants, barbell_hip_thrust, donkey_kick_pulses, donkey_kicks_cable, side_lying_leg_raise
  
- **Chest/Upper** (assign to PUSH):
  - chest_dips, dips_chest, cable_flye, dumbbell_flyes, machine_chest_fly, landmine_press, close_grip_pushups
  
- **Cable/Specialty** (assign patterns):
  - cable_pullthrough (HINGE)
  - tricep_dips_chair (PUSH)
  - overhead_tricep (CURL)
  - decline_situp (SQUAT)
  - glute_bridge_hold (HOLD)
  - glute_bridge_single (HINGE)
  - clamshells (HOLD)
  - battle_ropes (CARDIO/KNEEDRIVE)
  - bulgarian_split_squat_bw (SQUAT - already mapped but different ID)
  - superman_raises (HOLD)
  - woodchoppers (ROTATION)

## Migration Strategy

### Phase 1: Create Structure (5 mins)
1. Create `lib/core/patterns/exercises/` folder
2. Create all 12 new exercise files with boilerplate

### Phase 2: Extract & Split (10 mins)
3. Copy exercises from `movement_engine.dart` to respective files
4. Create `exercise_registry.dart` with combined map
5. Update `movement_engine.dart` to use registry

### Phase 3: Assign Missing (5 mins)
6. Review 36 missing exercises
7. Assign patterns based on movement mechanics
8. Add to appropriate files

### Phase 4: Test & Push (5 mins)
9. Run linter checks
10. Test build
11. Commit & push

## Benefits

✅ **Isolation**: Fix squats without touching push-ups
✅ **Organization**: Find exercises by movement pattern instantly
✅ **Testing**: Test each pattern file independently
✅ **Collaboration**: Multiple people can work on different patterns
✅ **Maintainability**: Add new exercises to correct file only
✅ **Debugging**: Know exactly which file has the broken exercise
✅ **Scalability**: Easy to add 100+ more exercises later

## Next Steps

**What's your call?**
1. ✅ **Execute this plan** - I'll implement it right now
2. ❌ **Modify plan** - Tell me what to change
3. 🤔 **Quick fix only** - Just add the 36 missing exercises

Type the number or tell me what to do!
