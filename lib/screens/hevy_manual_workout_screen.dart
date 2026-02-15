import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../utils/app_colors.dart';
import '../models/workout_models.dart';
import '../models/exercise_in_workout.dart';
import '../models/workout_set_model.dart';
import '../models/exercise_set_data.dart';
import '../services/unified_workout_save_service.dart';
import '../widgets/hevy_exercise_card.dart';
import '../features/analytics/services/analytics_service.dart';
import '../widgets/workout_summary_screen.dart';
import '../widgets/exercise_selector_modal.dart';

/// Hevy-style manual workout screen
/// All exercises visible with collapsible cards
class HevyManualWorkoutScreen extends ConsumerStatefulWidget {
  final LockedWorkout workout;

  const HevyManualWorkoutScreen({
    super.key,
    required this.workout,
  });

  @override
  ConsumerState<HevyManualWorkoutScreen> createState() => _HevyManualWorkoutScreenState();
}

class _HevyManualWorkoutScreenState extends ConsumerState<HevyManualWorkoutScreen> {
  DateTime? _workoutStartTime;
  Duration _elapsed = Duration.zero;
  Timer? _workoutTimer;
  List<ExerciseInWorkout> _exercises = [];
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _workoutStartTime = DateTime.now();
    _startWorkoutTimer();
    _initializeExercises(); // Now async, loads previous sets
    
    // Keep screen awake during workout
    WakelockPlus.enable();
    
    // Lock to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _workoutTimer?.cancel();
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  void _startWorkoutTimer() {
    _workoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && !_isPaused) {
        setState(() {
          _elapsed = DateTime.now().difference(_workoutStartTime!);
        });
      }
    });
  }

  void _togglePause() {
    setState(() {
      if (_isPaused) {
        // Resume: adjust start time to account for paused duration
        final pausedDuration = DateTime.now().difference(_workoutStartTime!).inSeconds - _elapsed.inSeconds;
        _workoutStartTime = _workoutStartTime!.add(Duration(seconds: pausedDuration));
        _isPaused = false;
      } else {
        // Pause
        _isPaused = true;
      }
    });
    HapticFeedback.mediumImpact();
  }

  int _getTotalCompletedSets() {
    return _exercises.fold(0, (sum, ex) => sum + ex.completedSetsCount);
  }

  int _getTotalSets() {
    return _exercises.fold(0, (sum, ex) => sum + ex.sets.length);
  }

  Future<void> _addExercise() async {
    final selectedExercise = await showModalBottomSheet<WorkoutExercise>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const ExerciseSelectorModal(),
    );

    if (selectedExercise != null) {
      setState(() {
        _exercises.add(ExerciseInWorkout.fromWorkoutExercise(selectedExercise));
      });
      HapticFeedback.mediumImpact();
    }
  }

  Future<void> _initializeExercises() async {
    _exercises = [];
    
    // Load previous sets for each exercise from history
    for (final exercise in widget.workout.exercises) {
      // Get last workout history for this exercise
      final history = await AnalyticsService.getExerciseHistory(exercise.name);
      List<WorkoutSet>? previousSets;
      
      if (history.isNotEmpty) {
        // Get the most recent workout's sets
        final lastWorkout = history.first;
        previousSets = lastWorkout.sets.map((set) => WorkoutSet(
          setNumber: set.setNumber,
          weight: set.weight,
          reps: set.reps,
          isCompleted: false, // Previous sets are not completed
        )).toList();
      }
      
      _exercises.add(ExerciseInWorkout(
        exerciseId: exercise.id,
        name: exercise.name,
        sets: List.generate(exercise.sets, (index) {
          return WorkoutSet(
            setNumber: index + 1,
            weight: null,
            reps: exercise.reps, // Pre-fill with target reps from committed workout
            isCompleted: false,
          );
        }),
        defaultRestSeconds: 90,
        isExpanded: true, // First exercise expanded by default
        previousSets: previousSets, // Load from history!
        primaryMuscles: exercise.primaryMuscles,
        secondaryMuscles: exercise.secondaryMuscles,
        instructions: exercise.instructions,
        formTip: exercise.formTip,
      ));
    }

    // Only expand first exercise
    if (_exercises.length > 1) {
      for (int i = 1; i < _exercises.length; i++) {
        _exercises[i].isExpanded = false;
      }
    }
    
    if (mounted) {
      setState(() {}); // Update UI with previous sets
    }
  }

  String _formatElapsedTime() {
    final minutes = _elapsed.inMinutes;
    final seconds = _elapsed.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _finishWorkout() async {
    // Calculate stats
    final totalSets = _exercises.fold(0, (sum, ex) => sum + ex.completedSetsCount);
    final totalReps = _exercises.fold(0, (sum, ex) {
      return sum + ex.sets.where((s) => s.isCompleted).fold(0, (rSum, s) => rSum + (s.reps ?? 0));
    });
    final totalVolume = _exercises.fold(0.0, (sum, ex) => sum + ex.totalVolume);

    if (totalSets == 0) {
      // No sets completed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete at least one set before finishing'),
          backgroundColor: AppColors.neonCrimson,
        ),
      );
      return;
    }

    // Convert exercises to ExerciseSetData list
    final List<ExerciseSetData> allSets = [];
    
    for (final exercise in _exercises) {
      for (final set in exercise.sets) {
        if (set.isCompleted && set.reps != null) {
          allSets.add(ExerciseSetData(
            exerciseName: exercise.name,
            setNumber: set.setNumber,
            weight: set.weight,
            repsCompleted: set.reps!,
            repsTarget: set.reps!,  // In Pro Logger, completed = target
            timestamp: DateTime.now(),
            primaryMuscles: exercise.primaryMuscles,
          ));
        }
      }
    }
    
    // Save workout to database BEFORE showing summary
    int actualCalories = (totalVolume * 0.05).round(); // Fallback estimate
    if (allSets.isNotEmpty) {
      final workoutEndTime = DateTime.now();
      final saveResult = await UnifiedWorkoutSaveService.saveCompletedWorkout(
        workoutName: widget.workout.name,
        mode: WorkoutMode.proLogger,
        startTime: _workoutStartTime!,
        endTime: workoutEndTime,
        exerciseSets: allSets,
      );
      
      if (saveResult['success'] as bool) {
        debugPrint('✅ Pro Logger workout saved to database successfully!');
        actualCalories = saveResult['caloriesBurned'] as int; // Get accurate calories
      } else {
        debugPrint('❌ Failed to save Pro Logger workout to database');
      }
    }

    HapticFeedback.heavyImpact();

    // Show summary screen
    if (mounted) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WorkoutSummaryScreen(
            workoutName: widget.workout.name,
            totalSets: totalSets,
            totalReps: totalReps,
            durationSeconds: _elapsed.inSeconds,
            caloriesBurned: actualCalories, // Use accurate calories from service
            exercises: _exercises.map((e) {
              return ExerciseSummary(
                name: e.name,
                sets: e.completedSetsCount,
                reps: e.sets.where((s) => s.isCompleted).fold(0, (sum, s) => sum + (s.reps ?? 0)),
              );
            }).toList(),
          ),
        ),
      );

      // After summary, pop all the way back to main tab navigator (home tab)
      if (mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }

  void _showWorkoutMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.cancel, color: AppColors.neonCrimson),
                title: const Text('Cancel Workout', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                  _cancelWorkout();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _cancelWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Cancel Workout?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to cancel this workout? All progress will be lost.',
          style: TextStyle(color: AppColors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No', style: TextStyle(color: AppColors.white50)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close workout screen
            },
            child: const Text('Yes, Cancel', style: TextStyle(color: AppColors.neonCrimson)),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsHeader() {
    final totalVolume = _exercises.fold(0.0, (sum, ex) => sum + ex.totalVolume);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.cyberLime.withOpacity(0.15),
            AppColors.electricCyan.withOpacity(0.15),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: AppColors.cyberLime.withOpacity(0.5),
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          // Timer with pause button
          Expanded(
            child: GestureDetector(
              onTap: _togglePause,
              child: _buildStatItem(
                icon: _isPaused ? Icons.play_arrow : Icons.pause,
                label: 'TIME',
                value: _formatElapsedTime(),
                color: _isPaused ? AppColors.neonCrimson : AppColors.cyberLime,
              ),
            ),
          ),
          
          Container(
            width: 1,
            height: 40,
            color: AppColors.white10,
          ),
          
          // Sets completed
          Expanded(
            child: _buildStatItem(
              icon: Icons.check_circle_outline,
              label: 'SETS',
              value: '${_getTotalCompletedSets()}/${_getTotalSets()}',
              color: AppColors.electricCyan,
            ),
          ),
          
          Container(
            width: 1,
            height: 40,
            color: AppColors.white10,
          ),
          
          // Total volume
          Expanded(
            child: _buildStatItem(
              icon: Icons.fitness_center,
              label: 'VOLUME',
              value: '${totalVolume.toInt()} kg',
              color: AppColors.cyberLime,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.white50,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Save as draft and go back
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.workout.name.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: _showWorkoutMenu,
          ),
        ],
      ),
      body: Column(
        children: [
          // Enhanced stats header
          _buildStatsHeader(),
          
          // Exercise cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _exercises.length,
              itemBuilder: (context, index) {
                return HevyExerciseCard(
                  key: ValueKey(_exercises[index].exerciseId),
                  exercise: _exercises[index],
                  onToggleExpand: () {
                    setState(() {
                      _exercises[index].isExpanded = !_exercises[index].isExpanded;
                    });
                  },
                  onCompleteSet: (setIndex) {
                    setState(() {
                      _exercises[index].sets[setIndex].isCompleted = true;
                      _exercises[index].sets[setIndex].completedAt = DateTime.now();
                    });
                  },
                  onAddSet: () {
                    setState(() {
                      _exercises[index].sets.add(WorkoutSet(
                        setNumber: _exercises[index].sets.length + 1,
                        weight: null,
                        reps: null,
                        isCompleted: false,
                      ));
                    });
                    HapticFeedback.selectionClick();
                  },
                  onUpdateWeight: (setIndex, weight) {
                    setState(() {
                      // AUTO-FILL: Fill all other sets with same weight
                      for (int i = 0; i < _exercises[index].sets.length; i++) {
                        if (i != setIndex && _exercises[index].sets[i].weight == null) {
                          _exercises[index].sets[i].weight = weight;
                        }
                      }
                      _exercises[index].sets[setIndex].weight = weight;
                    });
                  },
                  onUpdateReps: (setIndex, reps) {
                    setState(() {
                      // AUTO-FILL: Fill all other sets with same reps
                      for (int i = 0; i < _exercises[index].sets.length; i++) {
                        if (i != setIndex && _exercises[index].sets[i].reps == null) {
                          _exercises[index].sets[i].reps = reps;
                        }
                      }
                      _exercises[index].sets[setIndex].reps = reps;
                    });
                  },
                  onReplace: () async {
                    // Open exercise selector to replace this exercise
                    final newExercise = await showModalBottomSheet<WorkoutExercise>(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => const ExerciseSelectorModal(),
                    );
                    if (newExercise != null) {
                      setState(() {
                        _exercises[index] = ExerciseInWorkout.fromWorkoutExercise(newExercise);
                      });
                      HapticFeedback.mediumImpact();
                    }
                  },
                  onRemove: () {
                    setState(() {
                      _exercises.removeAt(index);
                    });
                    HapticFeedback.mediumImpact();
                  },
                );
              },
            ),
          ),

          // Footer buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border(
                top: BorderSide(color: AppColors.white10, width: 1),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  // Add exercise button
                  Expanded(
                    child: GestureDetector(
                      onTap: _addExercise,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: AppColors.white10,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.white30),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'ADD EXERCISE',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Finish workout button
                  Expanded(
                    child: GestureDetector(
                      onTap: _finishWorkout,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.cyberLime, AppColors.electricCyan],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.cyberLime.withOpacity(0.4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'FINISH',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.bolt, color: Colors.black, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

