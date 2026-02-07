# CUSTOM WORKOUT BUG ANALYSIS
================================================================================

## User Report

**Issue 1**: "When I create a custom workout and press commit, the hero card has no exercise, sets and calorie count"
**Issue 2**: "When I press start workout it lets me do it, but if I do it it doesn't fill out any analytics data at all - must be a cutoff"
**Issue 3**: "Recovery body should be filled"

## Root Cause Analysis

### Bug 1: Hero Card Shows Empty Data for Custom Workouts

**Location**: `lib/screens/tabs/home_tab.dart` lines 534-575

**The Problem**:
When a custom workout is committed, `displayWorkout` is a `LockedWorkout` type, not a `WorkoutSchedule`. The hero card code correctly handles this (lines 565-574):

```dart
} else {
  // For LockedWorkout
  workoutName = displayWorkout.name;
  exerciseCount = displayWorkout.exercises.length;  // ✅ Should work
  totalSets = displayWorkout.totalSets;              // ✅ Should work
  estimatedCalories = displayWorkout.estimatedCalories; // ✅ Should work
  scheduledTime = null;
}
```

**BUT** the issue is likely that `WorkoutPreset.exercises` array is being passed without the `.included` filter applied properly.

**In `custom_workouts_screen.dart` lines 155-164**:
```dart
exercises: _selectedExercises.map((e) {
  final settings = _exerciseSettings[e.id]!;
  return WorkoutExercise(
    id: e.id,
    name: e.name,
    sets: settings.sets,
    reps: settings.reps,
    restSeconds: settings.restSeconds,
    // ❌ MISSING: included: true
  );
}).toList(),
```

**Missing `included` field**: WorkoutExercise has `included` field (default true), but when creating from scratch, it may not be set properly.

**Secondary Issue** - `LockedWorkout.fromPreset()` filters by `.included`:
```dart
// lib/models/workout_models.dart line 326
final includedExercises = (customExercises ?? preset.exercises)
    .where((e) => e.included)  // ← Filters exercises
    .toList();
```

If `included` is somehow false or null, ALL exercises get filtered out → empty workout!

### Bug 2: No Analytics Data Recorded

**Location**: `lib/screens/tabs/train_tab.dart` line 576

**The Code**:
```dart
final saveResult = await UnifiedWorkoutSaveService.saveCompletedWorkout(
  workoutName: _committedWorkout!.name,  // ✅ Has name
  mode: WorkoutMode.autoCamera,
  startTime: workoutStartTime,
  endTime: workoutEndTime,
  sets: allSets,  // ← Created from _committedWorkout.exercises
  exercises: _committedWorkout!.exercises.map((e) => e.name).toList(),
  sessionId: sessionId,
  videoPath: null,
);
```

**The Problem**:
If `_committedWorkout.exercises` is **empty** (due to Bug 1), then:
- `allSets` list will be empty (line 520-557 loop never runs)
- `exercises` list will be empty
- `totalReps` will be 0
- Workout gets saved but with NO data → doesn't show up in analytics

**The Chain**:
1. Custom workout committed with no exercises (Bug 1)
2. User starts workout → `_committedWorkout` loaded with empty exercises
3. User completes workout → Loop through exercises creates NO sets
4. Workout saved with 0 sets, 0 reps → Analytics show nothing

### Bug 3: Recovery Body Not Filled

**Location**: `lib/services/muscle_recovery_service.dart` lines 76-100

**The Code**:
```dart
static Future<void> recordWorkout(List<String> exerciseNames) async {
  final Set<String> affectedMuscles = {};

  for (final exercise in exerciseNames) {
    final normalizedName = exercise.toLowerCase().replaceAll(' ', '_');
    
    // Try exact match first
    if (exerciseMuscleMap.containsKey(normalizedName)) {
      affectedMuscles.addAll(exerciseMuscleMap[normalizedName]!);
      continue;
    }
    // ... fuzzy match
  }

  if (affectedMuscles.isNotEmpty) {
    await recordMusclesTrained(affectedMuscles.toList());
  }
}
```

**The Problem**:
If workout has NO exercises (Bug 1 & 2), then:
- `exerciseNames` list is empty
- Loop never runs
- `affectedMuscles` stays empty
- `recordMusclesTrained()` is never called
- Recovery body never updates

**This is called from `UnifiedWorkoutSaveService`**, which receives empty exercise list.

## The Root Bug

**ALL THREE ISSUES** stem from ONE root cause:

### Custom Workout Exercises Array is Empty After Commit

**Evidence Trail**:

1. **Create Custom Workout** (`custom_workouts_screen.dart` line 147):
   ```dart
   final customPreset = WorkoutPreset(
     exercises: _selectedExercises.map((e) { ... }).toList(),
   );
   ```

2. **Commit Workout** (line 174):
   ```dart
   await ref.read(committedWorkoutProvider.notifier).commitWorkout(customPreset);
   ```

3. **Convert to LockedWorkout** (`workout_provider.dart` line 27):
   ```dart
   Future<void> commitWorkout(WorkoutPreset preset, {List<WorkoutExercise>? customExercises}) async {
     final locked = LockedWorkout.fromPreset(preset, customExercises: customExercises);
     // ...
   }
   ```

4. **Filter Exercises** (`workout_models.dart` line 326):
   ```dart
   factory LockedWorkout.fromPreset(WorkoutPreset preset, {List<WorkoutExercise>? customExercises}) {
     final includedExercises = (customExercises ?? preset.exercises)
         .where((e) => e.included)  // ← PROBLEM: If all have included=false, this returns []
         .toList();
   ```

5. **Save Empty Workout** (`workout_models.dart` line 334):
   ```dart
   return LockedWorkout(
     exercises: includedExercises,  // ← Empty list!
   );
   ```

## The Fix

### Fix 1: Ensure `included: true` in Custom Workout Creation

**File**: `lib/screens/custom_workouts_screen.dart` line 157

**Before**:
```dart
return WorkoutExercise(
  id: e.id,
  name: e.name,
  sets: settings.sets,
  reps: settings.reps,
  restSeconds: settings.restSeconds,
);
```

**After**:
```dart
return WorkoutExercise(
  id: e.id,
  name: e.name,
  sets: settings.sets,
  reps: settings.reps,
  restSeconds: settings.restSeconds,
  included: true,  // ← FIX: Explicitly set to true
);
```

### Fix 2: Add Missing Fields for Calorie Calculation

**File**: `lib/screens/custom_workouts_screen.dart` line 157

**Add**:
```dart
return WorkoutExercise(
  id: e.id,
  name: e.name,
  sets: settings.sets,
  reps: settings.reps,
  restSeconds: settings.restSeconds,
  included: true,
  primaryMuscles: [],  // ← Add for muscle tracking
  secondaryMuscles: [],
);
```

### Fix 3: Debug Logging

Add logging to track where exercises disappear:

**In `workout_provider.dart` line 27**:
```dart
Future<void> commitWorkout(WorkoutPreset preset, {List<WorkoutExercise>? customExercises}) async {
  print('🔵 COMMIT: preset.exercises.length = ${preset.exercises.length}');
  print('🔵 COMMIT: customExercises = $customExercises');
  
  final locked = LockedWorkout.fromPreset(preset, customExercises: customExercises);
  
  print('🔵 COMMIT: locked.exercises.length = ${locked.exercises.length}');
  // ...
}
```

## Files to Modify

1. ✅ **lib/screens/custom_workouts_screen.dart**
   - Line 157: Add `included: true` to WorkoutExercise
   - Line 157: Add `primaryMuscles` and `secondaryMuscles`

2. ✅ **lib/screens/workout_editor_screen.dart** (if also creates custom workouts)
   - Check if same issue exists there

3. ⚠️ **lib/models/workout_models.dart** (defensive)
   - Line 326: Add fallback if `includedExercises.isEmpty`
   - Warn user instead of creating empty workout

## Testing Checklist

- [ ] Create custom workout with 3 exercises
- [ ] Press "Commit"
- [ ] Hero card shows: 3 exercises, correct sets, calories
- [ ] Press "Start Workout"
- [ ] Complete all exercises
- [ ] Analytics show: workout data, reps, sets
- [ ] Recovery body shows: affected muscles colored
- [ ] Heatmap shows: workout on calendar

## Priority: CRITICAL

Users are creating workouts but getting NO feedback. This breaks:
- ✅ Hero card display
- ✅ Analytics tracking
- ✅ Recovery visualization
- ✅ Workout history

**IMPLEMENT FIX IMMEDIATELY**
