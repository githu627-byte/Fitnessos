# HIIT CIRCUITS BUG ANALYSIS
================================================================================

## The Problem

**User Report**: "HIIT circuits on home basically it's bullshit - supposed to be timer based, you work for certain amount of time then rest, but the rest is off and it seems the rep counter is off like you do one then it stops, there something completely off with it even the way it counts exercises."

## Root Cause Analysis

### Issue 1: REP-BASED vs TIME-BASED Confusion

**HIIT Circuit Definition** (workout_data.dart lines 1387-1442):
```dart
WorkoutExercise(
  id: 'burpees', 
  name: 'Burpees', 
  sets: 1,           // ← Says "1 set"
  reps: 1,           // ← Says "1 rep" 🚨 WRONG!
  timeSeconds: 30,   // ← Should work for 30 seconds
  restSeconds: 10    // ← Should rest for 10 seconds
),
```

**The Bug**:
- WorkoutSession (`workout_session.dart`) only tracks `reps` and `sets`
- It calls `startExercise(exerciseId, sets: 1, reps: 1)` 
- After 1 rep counted, it thinks the set is complete
- Moves to rest immediately, ignoring the `timeSeconds: 30`

**Current Flow (BROKEN)**:
```
User starts HIIT → WorkoutSession loads exercise with reps=1
→ MediaPipe counts 1 burpee
→ WorkoutSession: "Set complete! (1/1 reps done)"
→ Goes to rest after 1 rep (ignores timeSeconds: 30)
→ User supposed to work for 30 seconds, but only did 1 rep
```

**Expected Flow (CORRECT)**:
```
User starts HIIT → WorkoutSession detects timeSeconds exists
→ Start 30-second TIMER (ignore rep counter)
→ User does as many reps as possible in 30 seconds
→ Timer ends → Move to rest for 10 seconds
→ Rest ends → Next exercise
```

### Issue 2: No Time-Based Mode in WorkoutSession

**WorkoutSession.dart** has NO logic for:
- Detecting `timeSeconds` field
- Running a timer instead of rep counter
- Stopping after time expires instead of target reps

**Evidence** (workout_session.dart line 103-146):
```dart
Future<void> startExercise({
  required String exerciseId,
  required int sets,
  required int reps,   // ← Only accepts REPS, no timeSeconds parameter
}) async {
  // ... only tracks reps, never checks timeSeconds
}
```

### Issue 3: Difficulty Prefixes Still Attached

**User mentioned**: "info has to not have difficulty levels attached to it etc"

**Found in workout_data.dart**:
- HIIT exercises use base IDs: `burpees`, `jump_squats`, `pushups` ✅ GOOD
- But when generated with difficulty levels (lines 551-552, 668-669):
```dart
case 'hiit_circuits':
  return WorkoutData.getHomeHIITCircuits('intermediate');
```
- These might add difficulty prefixes depending on implementation

**Need to check**: Does `getHomeHIITCircuits()` add prefixes?

### Issue 4: Rest Timer Uses Wrong Duration

**In train_tab.dart**:
- Rest timer uses `exercise.restSeconds` (line 852)
- BUT it's hardcoded to 60 seconds in some places
- For HIIT, should use `restSeconds: 10` from exercise definition

## The Complete Problem List

1. ✅ **HIIT exercises have `timeSeconds` field but it's ignored**
2. ✅ **WorkoutSession only tracks reps, not time**
3. ✅ **After 1 rep, set ends (should run for full timeSeconds)**
4. ❌ **Rest duration may not use correct restSeconds**
5. ❌ **Exercise counter might be wrong (need to verify rounds logic)**
6. ❌ **Difficulty prefixes might still be attached**

## Solution Required

### Fix 1: Add Time-Based Mode to WorkoutSession

**Modify `workout_session.dart`**:
```dart
Future<void> startExercise({
  required String exerciseId,
  required int sets,
  required int reps,
  int? timeSeconds,      // NEW: Optional time-based duration
  int? restSeconds,      // NEW: Custom rest duration
}) async {
  _isTimeBased = timeSeconds != null;  // NEW: Flag for time vs reps
  _timeSeconds = timeSeconds;
  _restSeconds = restSeconds ?? 60;     // NEW: Store custom rest
  
  if (_isTimeBased) {
    // Start timer mode, ignore reps
    _startTimeBasedSet(timeSeconds!);
  } else {
    // Normal rep-based mode
    // ... existing code
  }
}
```

### Fix 2: Timer-Based Set Completion

**Add to `workout_session.dart`**:
```dart
Timer? _exerciseTimer;
bool _isTimeBased = false;
int? _timeSeconds;
int _timeRemaining = 0;

void _startTimeBasedSet(int seconds) {
  _timeRemaining = seconds;
  _exerciseTimer?.cancel();
  
  _exerciseTimer = Timer.periodic(Duration(seconds: 1), (timer) {
    _timeRemaining--;
    
    if (_timeRemaining <= 0) {
      timer.cancel();
      _onSetComplete();  // Complete set after time expires
    }
  });
}
```

### Fix 3: Pass timeSeconds from train_tab

**Modify `train_tab.dart` line ~649**:
```dart
final exercise = _committedWorkout!.exercises[_currentExerciseIndex];

_session?.startExercise(
  exerciseId: exercise.id,
  sets: exercise.sets,
  reps: exercise.reps,
  timeSeconds: exercise.timeSeconds,  // NEW: Pass time duration
  restSeconds: exercise.restSeconds,  // NEW: Pass rest duration
);
```

### Fix 4: UI Shows Timer for Time-Based Exercises

**In `train_tab.dart`**:
- Show countdown timer for time-based exercises
- Show "KEEP GOING!" instead of "X/Y reps"
- Display: "15 seconds remaining" instead of "5/10 reps"

### Fix 5: Verify No Difficulty Prefixes in HIIT

**Check `getHomeHIITCircuits()` implementation**:
- Ensure IDs are: `burpees`, NOT `beginner_burpees`
- Verify exercises are returned with base IDs

## Files to Modify

1. **lib/services/workout_session.dart**
   - Add `timeSeconds` and `restSeconds` parameters
   - Add time-based mode flag and timer
   - Modify `startExercise()` to handle both modes

2. **lib/screens/tabs/train_tab.dart**
   - Pass `timeSeconds` and `restSeconds` to WorkoutSession
   - Update UI to show timer instead of rep counter for time-based
   - Use correct rest duration from exercise

3. **lib/models/workout_data.dart**
   - Verify `getHomeHIITCircuits()` doesn't add difficulty prefixes
   - Ensure all HIIT exercises have correct timeSeconds/restSeconds

## Testing Checklist

- [ ] HIIT exercise runs for full `timeSeconds` duration
- [ ] Rep counter still counts reps but doesn't stop exercise
- [ ] After time expires, rest begins automatically
- [ ] Rest duration uses `restSeconds` from exercise (not hardcoded 60)
- [ ] All rounds complete correctly (3 rounds = 3 full cycles)
- [ ] No difficulty prefixes on exercise IDs
- [ ] MediaPipe still tracks reps for stats (but doesn't control flow)

## Priority: CRITICAL

This breaks the entire HIIT workout experience. Users expect:
- **Work for 30 seconds** → Currently stops after 1 rep
- **Rest for 10 seconds** → May be using 60 seconds
- **Repeat for X rounds** → Needs verification

**IMPLEMENT THIS FIX IMMEDIATELY**
