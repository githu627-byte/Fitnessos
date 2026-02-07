---
name: Complete Analytics Data Integration
overview: ""
todos: []
---

# Complete Analytics Data Integration Plan

Current State Analysis

Databases

The app has 3 separate databases that are NOT connected:

workout_history.db - Used by analytics_service.dart for analytics dashboard

fitnessos.db - Used by database_service.dart for general app data

workout_schedules.db - Used by workout_schedule_db.dart for scheduling

Critical Gap

None of the 3 workout modes save data to workout_history.db:

Auto Mode (train_tab.dart) - Only shows WorkoutSummaryScreen, no DB save

Visual Guide (manual_training_screen.dart) - Only shows summary, no DB save

Pro Logger (hevy_manual_workout_screen.dart) - Only shows summary, no DB save

What's Missing

The analytics dashboard expects data in this schema:

workout_sessions

string

id

PK

string

name

datetime

date

int

duration_minutes

string

status

int

total_reps

float

avg_form_score

int

perfect_reps

datetime

created_at

exercise_sets

int

id

PK

string

session_id

FK

string

exercise_name

int

set_number

float

weight

int

reps_completed

int

reps_target

float

form_score

int

perfect_reps

int

good_reps

int

missed_reps

int

max_combo

datetime

timestamp

contains

But no workout mode currently populates this data.

---

Data Flow Architecture

Auto Mode

Visual Guide

Pro Logger

User Completes Workout

Which Mode?

TrainTab

ManualTrainingScreen

HevyManualWorkoutScreen

WorkoutSummaryScreen

NEW: WorkoutDataService

Save to workout_history.db

Analytics Dashboard

Profile Tab Analytics View

Calculate PRs

Update Streaks

Track Volume

---

Implementation Plan

Phase 1: Create Unified Workout Data Service

NEW FILE: lib/services/workout_data_service.dart

This service will:

Accept workout completion data from any mode

Save to workout_history.db with proper schema

Calculate and save PRs to personal_records table

Track form scores (if available from Auto Mode)

Calculate calories burned

Handle timestamps for all data

Key Methods:

class WorkoutDataService {

static Future<void> saveCompletedWorkout({

required String workoutName,

required int durationSeconds,

required List<CompletedExercise> exercises,

double? avgFormScore,

int? perfectReps,

});

static Future<void> _updatePersonalRecords(String exerciseName, double weight, int reps);

static double _calculateCalories(double totalVolume, int totalReps);

static double _calculateE1RM(double weight, int reps);

}

Phase 2: Integrate with Workout Summary Screen

MODIFY: lib/widgets/workout_summary_screen.dart

Add save functionality to initState():

@override

void initState() {

super.initState();

// Save workout data to analytics DB

_saveWorkoutData();

// ... existing animation code

}

Future<void> _saveWorkoutData() async {

await WorkoutDataService.saveCompletedWorkout(

workoutName: widget.workoutName,

durationSeconds: widget.durationSeconds,

exercises: widget.exercises.map((e) => CompletedExercise(

name: e.name,

sets: e.sets ?? 0,

reps: e.reps ?? 0,

weight: e.weight ?? 0,

)).toList(),

avgFormScore: widget.avgFormScore, // Add this parameter

perfectReps: widget.perfectReps, // Add this parameter

);

}

Phase 3: Update Each Workout Mode

A. Auto Mode (train_tab.dart line 462-499)

Collect form data from _session:

void _completeWorkout() {

// Existing code...

// NEW: Collect form data

final formData = _session?.getFormSummary(); // Add this method to WorkoutSession

Navigator.of(context).push(

MaterialPageRoute(

builder: (context) => WorkoutSummaryScreen(

// ... existing params

avgFormScore: formData?.avgScore,

perfectReps: formData?.perfectReps,

goodReps: formData?.goodReps,

missedReps: formData?.missedReps,

),

),

);

}

B. Visual Guide (manual_training_screen.dart line 170-200)

Pass weight data from _workoutLog:

void _completeWorkout() {

// ... existing code

// Convert log to detailed exercise data

final detailedExercises = widget.workout.exercises.map((ex) {

final sets = _workoutLog[ex.id] ?? [];

return ExerciseSummary(

name: ex.name,

sets: sets.length,

reps: ex.reps,

weight: sets.firstOrNull?['weight'],

allSetData: sets, // NEW: Pass all set data

);

}).toList();

Navigator.of(context).pushReplacement(

MaterialPageRoute(

builder: (context) => WorkoutSummaryScreen(

// ... existing params

exercises: detailedExercises,

),

),

);

}

C. Pro Logger (hevy_manual_workout_screen.dart line 142-192)

Extract complete set data:

Future<void> _finishWorkout() async {

// ... existing stats calculation

// NEW: Extract all set data with weights

final detailedExercises = _exercises.map((e) {

return ExerciseSummary(

name: e.name,

sets: e.completedSetsCount,

reps: e.sets.where((s) => s.isCompleted).fold(0, (sum, s) => sum + (s.reps ?? 0)),

allSetData: e.sets.where((s) => s.isCompleted).map((s) => {

'set_number': s.setNumber,

'weight': s.weight,

'reps': s.reps,

'timestamp': s.completedAt,

}).toList(),

);

}).toList();

await Navigator.push(

context,

MaterialPageRoute(

builder: (context) => WorkoutSummaryScreen(

// ... existing params

exercises: detailedExercises,

),

),

);

}

Phase 4: Enhance Exercise Detail Page

MODIFY