# Plan: Fix Preset Workout Exercise IDs

## Overview
Go through every preset card (Beginner/Intermediate/Advanced) in the Home > Workouts tab and replace fake/wrong exercise IDs with correct ones that have real GIF videos.

---

## CURRENT STATE

### 67 unique exercise IDs used across all presets
- **55 have valid GIF videos** (direct mapping or via overrides) - GOOD
- **3 have NO GIF at all** - MUST FIX:
  - `banded_clamshell` - no video exists
  - `banded_fire_hydrant` - no video exists
  - `fire_hydrant` - no video exists
- **9 use overrides** (work but show a "close enough" video, not exact)

### Presets with problems (3 presets):

#### 1. HOME BAND BOOTY (line ~7950)
```
banded_squat → squat_m ✓ (close enough)
banded_glute_bridge → bent_knee_glute_bridge ✓ (close enough)
banded_clamshell → ❌ NO GIF
banded_kickback → resistance_band_glute_kickback ✓
banded_lateral_walk → ❌ NO GIF
banded_fire_hydrant → ❌ NO GIF
```

#### 2. HOME GIRL GLUTE SCULPT (line ~7972)
```
glute_bridge → bent_knee_glute_bridge ✓
single_leg_glute_bridge ✓
donkey_kick → donkey_kick_leg_straight ✓
fire_hydrant → ❌ NO GIF
lying_leg_raise (as "Side-Lying Leg Raise") → ❌ wrong video for this exercise
```

#### 3. GYM FULL BODY BLAST circuit (line ~7555)
```
barbell_full_squat ✓
stationary_bike_run_version_3 (as "Battle Ropes") → shows stationary bike, NOT battle ropes
```

### Commented-out presets (ALL exercises removed):
- HOME 10 MIN QUICK BURN - entirely empty
- HOME 20 MIN DESTROYER - entirely empty
- HOME TABATA TORTURE - entirely empty
- HOME CARDIO BLAST - entirely empty
- HOME FULL BODY STRETCH - entirely empty
- HOME HIP OPENER - entirely empty

---

## PLAN

### Step 1: Fix HOME BAND BOOTY preset
**Replace** exercises with no GIF with ones that have real videos:

| Current | Problem | Replace With |
|---------|---------|-------------|
| `banded_clamshell` "Banded Clamshell" | No GIF | `banded_kickback` "Banded Glute Kickback" (has resistance_band_glute_kickback GIF) |
| `banded_lateral_walk` "Banded Lateral Walk" | No GIF | `banded_squat` "Banded Sumo Walk" (has squat_m GIF, closest match) |
| `banded_fire_hydrant` "Banded Fire Hydrant" | No GIF | `banded_glute_bridge` "Banded Single Leg Bridge" (has bent_knee_glute_bridge GIF) |

### Step 2: Fix HOME GIRL GLUTE SCULPT preset
| Current | Problem | Replace With |
|---------|---------|-------------|
| `fire_hydrant` "Fire Hydrant" | No GIF | `donkey_kick` "Donkey Kick (wide)" (has donkey_kick_leg_straight GIF, similar movement) |
| `lying_leg_raise` "Side-Lying Leg Raise" | Wrong video (shows lying leg raise, not side leg raise) | `single_leg_glute_bridge` "Single Leg Glute Bridge" (already has correct GIF) |

### Step 3: Fix GYM FULL BODY BLAST circuit
| Current | Problem | Replace With |
|---------|---------|-------------|
| `stationary_bike_run_version_3` "Battle Ropes" | Shows bike, not ropes | `burpee` "Burpees" (has real GIF, better for a HIIT circuit) |

### Step 4: Populate HOME HIIT CIRCUITS (4 empty presets)
All exercises commented out. Rebuild with exercises that have REAL GIF videos:

**HOME 10 MIN QUICK BURN** (beginner, 2 rounds):
- `burpee` "Burpees" (30s/10s)
- `jumping_jack` "Jumping Jacks" (30s/10s)
- `mountain_climber` "Mountain Climbers" (30s/10s)
- `jump_squat` "Jump Squats" (30s/10s)
- `high_knees` "High Knees" (30s/10s)

**HOME 20 MIN DESTROYER** (intermediate, 4 rounds):
- `burpee` "Burpees" (40s/20s)
- `jump_squat` "Jump Squats" (40s/20s)
- `mountain_climber` "Mountain Climbers" (40s/20s)
- `high_knees` "High Knees" (40s/20s)
- `skater` "Skaters" (40s/20s)

**HOME TABATA TORTURE** (advanced, 8 rounds):
- `burpee` "Burpees" (20s/10s)
- `tuck_jump` "Tuck Jumps" (20s/10s)
- `mountain_climber` "Mountain Climbers" (20s/10s)
- `star_jump` "Star Jumps" (20s/10s)

**HOME CARDIO BLAST** (intermediate, 3 rounds):
- `jumping_jack` "Jumping Jacks" (45s/15s)
- `high_knees` "High Knees" (45s/15s)
- `butt_kick` "Butt Kicks" (45s/15s)
- `skater` "Skater Hops" (45s/15s)
- `box_jump` "Box Jumps" (45s/15s)

### Step 5: Populate HOME RECOVERY presets (2 empty presets)
These use stretch/hold exercises - most don't have dedicated GIFs.
**Skip for now** - these need actual stretch GIFs which we don't have.

### Step 6: Fix other minor issues in presets
- `russian_twist_with_medicine_ball` used in 3 presets → change to `russian_twist` (has its own dedicated GIF now)
- `front_plank` used as "Dead Bug" (line 7827) → change to `bird_dog` "Bird Dog" (has real GIF, similar movement pattern)

---

## SUMMARY OF CHANGES
- **3 presets fixed** (Band Booty, Girl Glute Sculpt, Full Body Blast)
- **4 HIIT presets populated** with real exercises that have matching GIFs
- **2 minor ID swaps** (russian_twist, dead_bug→bird_dog)
- **2 recovery presets skipped** (need stretch GIFs first)
- **Total exercises affected**: ~25 exercise entries
