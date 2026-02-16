import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import '../utils/app_colors.dart';
import '../models/workout_models.dart';
import '../models/exercise_set_data.dart';
import '../services/unified_workout_save_service.dart';
import '../widgets/exercise_animation_widget.dart';
import '../widgets/quick_swap_modal.dart';
import '../widgets/workout_summary_screen.dart';
import 'dart:async';

/// 🔥 MANUAL TRAINING MODE - The most beautiful, addictive training experience ever
/// Clean, fast, intuitive - every tap feels amazing
class ManualTrainingScreen extends ConsumerStatefulWidget {
  final LockedWorkout workout;

  const ManualTrainingScreen({
    super.key,
    required this.workout,
  });

  @override
  ConsumerState<ManualTrainingScreen> createState() => _ManualTrainingScreenState();
}

class _ManualTrainingScreenState extends ConsumerState<ManualTrainingScreen> {
  int _currentExerciseIndex = 0;
  int _currentSet = 1;
  int _currentReps = 0;
  double _currentWeight = 0.0;
  late TextEditingController _weightController;
  
  bool _isResting = false;
  int _restTimeRemaining = 60;
  Timer? _restTimer;
  bool _isBetweenExerciseRest = false;
  
  // Workout timer
  Timer? _workoutTimer;
  int _totalElapsedSeconds = 0;
  bool _isPaused = false;

  DateTime? _workoutStartTime;
  final Map<String, List<Map<String, dynamic>>> _workoutLog = {}; // exerciseId -> list of sets
  
  @override
  void initState() {
    super.initState();
    _weightController = TextEditingController(text: _currentWeight > 0 ? _currentWeight.toInt().toString() : '');
    _workoutStartTime = DateTime.now();
    _initializeExercise();
    _startWorkoutTimer();

    // Keep screen awake during workout
    WakelockPlus.enable();
    
    // Lock to portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _weightController.dispose();
    _restTimer?.cancel();
    _workoutTimer?.cancel();
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  void _initializeExercise() {
    final exercise = widget.workout.exercises[_currentExerciseIndex];
    setState(() {
      _currentSet = 1;
      _currentReps = exercise.reps;
      _currentWeight = 0.0;
    });
  }

  void _startWorkoutTimer() {
    _workoutTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && !_isResting) {
        setState(() => _totalElapsedSeconds++);
      }
    });
  }

  void _togglePause() {
    setState(() => _isPaused = !_isPaused);
    HapticFeedback.mediumImpact();
  }

  String _formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _completeSet() {
    final exercise = widget.workout.exercises[_currentExerciseIndex];
    
    // Log the set
    if (!_workoutLog.containsKey(exercise.id)) {
      _workoutLog[exercise.id] = [];
    }
    
    _workoutLog[exercise.id]!.add({
      'set': _currentSet,
      'reps': _currentReps,
      'weight': _currentWeight,
      'timestamp': DateTime.now(),
    });
    
    // Haptic feedback
    HapticFeedback.mediumImpact();
    
    // Check if all sets complete
    if (_currentSet >= exercise.sets) {
      _moveToNextExercise();
    } else {
      // Start rest timer
      _startRest();
    }
  }

  void _skipSet() {
    final exercise = widget.workout.exercises[_currentExerciseIndex];
    
    // Log skipped set
    if (!_workoutLog.containsKey(exercise.id)) {
      _workoutLog[exercise.id] = [];
    }
    
    _workoutLog[exercise.id]!.add({
      'set': _currentSet,
      'reps': 0,
      'weight': 0.0,
      'skipped': true,
      'timestamp': DateTime.now(),
    });
    
    HapticFeedback.lightImpact();
    
    // Check if all sets complete
    if (_currentSet >= exercise.sets) {
      _moveToNextExercise();
    } else {
      setState(() {
        _currentSet++;
        _currentReps = exercise.reps; // Reset to default reps
      });
    }
  }

  void _startRest() {
    // ═══════════════════════════════════════════════════════════════════════════
    // FIX: Use exercise's actual rest time instead of hardcoded 60
    // ═══════════════════════════════════════════════════════════════════════════
    final exercise = widget.workout.exercises[_currentExerciseIndex];
    final actualRestTime = exercise.restSeconds ?? 60;

    debugPrint('⏸️ Manual mode rest: ${actualRestTime}s (exercise.restSeconds: ${exercise.restSeconds})');

    setState(() {
      _isResting = true;
      _isBetweenExerciseRest = false;
      _restTimeRemaining = actualRestTime;
    });

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_restTimeRemaining > 0) {
        setState(() => _restTimeRemaining--);
      } else {
        _endRest();
      }
    });
  }

  void _endRest() {
    _restTimer?.cancel();
    setState(() {
      _isResting = false;
      _currentSet++;
      _currentReps = widget.workout.exercises[_currentExerciseIndex].reps;
    });
  }

  void _skipRest() {
    _restTimer?.cancel();
    if (_isBetweenExerciseRest) {
      // Skip rest between exercises — move to next exercise
      setState(() {
        _isResting = false;
        _isBetweenExerciseRest = false;
        _currentExerciseIndex++;
        _initializeExercise();
      });
    } else {
      _endRest();
    }
  }

  void _moveToNextExercise() {
    if (_currentExerciseIndex < widget.workout.exercises.length - 1) {
      // REST between exercises before moving on
      final currentExercise = widget.workout.exercises[_currentExerciseIndex];
      final restTime = (currentExercise.restSeconds != null && currentExercise.restSeconds! > 0)
          ? currentExercise.restSeconds!
          : 60;

      setState(() {
        _isResting = true;
        _isBetweenExerciseRest = true;
        _restTimeRemaining = restTime;
      });

      _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_restTimeRemaining > 0) {
          setState(() => _restTimeRemaining--);
        } else {
          _restTimer?.cancel();
          setState(() {
            _isResting = false;
            _isBetweenExerciseRest = false;
            _currentExerciseIndex++;
            _initializeExercise();
          });
        }
      });
    } else {
      _completeWorkout();
    }
  }

  void _completeWorkout() async {
    final workoutEndTime = DateTime.now();
    final duration = workoutEndTime.difference(_workoutStartTime!);
    
    // Convert workout log to ExerciseSetData list
    final List<ExerciseSetData> allSets = [];
    int totalReps = 0;

    for (final exercise in widget.workout.exercises) {
      final exerciseSets = _workoutLog[exercise.id];
      if (exerciseSets != null) {
        for (final setData in exerciseSets) {
          if (setData['skipped'] != true) {
            final reps = setData['reps'] as int;
            totalReps += reps;
            allSets.add(ExerciseSetData(
              exerciseName: exercise.name,
              setNumber: setData['set'] as int,
              weight: (setData['weight'] as num).toDouble(),
              repsCompleted: reps,
              repsTarget: exercise.reps,
              timestamp: setData['timestamp'] as DateTime,
              primaryMuscles: exercise.primaryMuscles,
            ));
          }
        }
      }
    }

    // Save workout to database BEFORE showing summary
    int actualCalories = totalReps * 5; // Fallback estimate
    if (allSets.isNotEmpty) {
      final saveResult = await UnifiedWorkoutSaveService.saveCompletedWorkout(
        workoutName: widget.workout.name,
        mode: WorkoutMode.visualGuide,
        startTime: _workoutStartTime!,
        endTime: workoutEndTime,
        exerciseSets: allSets,
      );
      
      if (saveResult['success'] as bool) {
        debugPrint('✅ Visual Guide workout saved to database successfully!');
        actualCalories = saveResult['caloriesBurned'] as int; // Get accurate calories
      } else {
        debugPrint('❌ Failed to save Visual Guide workout to database');
      }
    }
    
    // Calculate summary stats
    final totalSets = _workoutLog.values.fold<int>(0, (sum, sets) => sum + sets.length);
    final calories = actualCalories; // Use accurate calories from service
    
    HapticFeedback.heavyImpact();
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => WorkoutSummaryScreen(
          workoutName: widget.workout.name,
          durationSeconds: duration.inSeconds,
          exercises: widget.workout.exercises.map((ex) {
            final weights = _convertWorkoutLogToWeights()[ex.id];
            return ExerciseSummary(
              name: ex.name,
              sets: ex.sets,
              reps: ex.reps,
              weight: weights?.firstOrNull,
            );
          }).toList(),
          totalSets: totalSets,
          totalReps: totalReps,
          caloriesBurned: calories,
        ),
      ),
    );
  }

  Map<String, List<double>> _convertWorkoutLogToWeights() {
    final weights = <String, List<double>>{};
    _workoutLog.forEach((exerciseId, sets) {
      weights[exerciseId] = sets
        .where((s) => s['skipped'] != true)
        .map((s) => s['weight'] as double)
        .toList();
    });
    return weights;
  }

  Future<void> _showQuickSwap() async {
    final result = await showModalBottomSheet<WorkoutExercise>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuickSwapModal(
        currentExercise: widget.workout.exercises[_currentExerciseIndex],
      ),
    );
    
    if (result != null) {
      // Swap exercise
      setState(() {
        widget.workout.exercises[_currentExerciseIndex] = result;
        _initializeExercise();
      });
      
      HapticFeedback.mediumImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isResting) {
      return _buildRestScreen();
    }
    
    return _buildTrainingScreen();
  }

  Widget _buildTrainingScreen() {
    final exercise = widget.workout.exercises[_currentExerciseIndex];
    final isGymWorkout = widget.workout.category == 'gym';
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(exercise),
            
            // Main content - FULL SIZE ANIMATION
            _buildExerciseDisplay(exercise),
            
            // Bottom controls
            _buildControls(exercise, isGymWorkout),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(WorkoutExercise exercise) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.0),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side buttons
              Column(
                children: [
                  // Finish workout button
                  GestureDetector(
                    onTap: _completeWorkout,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.cyberLime.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.cyberLime.withOpacity(0.4),
                          width: 1,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.cyberLime,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'FINISH',
                            style: TextStyle(
                              color: AppColors.cyberLime,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Close button
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              
              // Exercise progress
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${_currentExerciseIndex + 1} / ${widget.workout.exercises.length}',
                      style: const TextStyle(
                        color: AppColors.white60,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exercise.name.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Action buttons
              Column(
                children: [
                  // Quick swap button
                  GestureDetector(
                    onTap: _showQuickSwap,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.cyberLime.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.swap_horiz_rounded,
                        color: AppColors.cyberLime,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Skip exercise button
                  GestureDetector(
                    onTap: _moveToNextExercise,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.neonCrimson.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.skip_next,
                        color: AppColors.neonCrimson,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 8),

          // Workout timer with pause button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.white10,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.white20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.timer,
                      size: 16,
                      color: _isPaused ? AppColors.neonOrange : AppColors.electricCyan,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatTime(_totalElapsedSeconds),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _togglePause,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _isPaused ? AppColors.neonOrange.withOpacity(0.2) : AppColors.white10,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isPaused ? AppColors.neonOrange : AppColors.white20,
                    ),
                  ),
                  child: Icon(
                    _isPaused ? Icons.play_arrow : Icons.pause,
                    size: 18,
                    color: _isPaused ? AppColors.neonOrange : Colors.white70,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Set indicator - MOVED UP under exercise name
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(exercise.sets, (index) {
              final isComplete = index < _currentSet - 1;
              final isCurrent = index == _currentSet - 1;
              
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isCurrent ? 28 : 20,
                height: 4,
                decoration: BoxDecoration(
                  color: isComplete
                      ? AppColors.cyberLime
                      : isCurrent
                          ? AppColors.electricCyan
                          : AppColors.white20,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: isCurrent ? [
                    BoxShadow(
                      color: AppColors.electricCyan.withOpacity(0.5),
                      blurRadius: 6,
                    ),
                  ] : null,
                ),
              );
            }),
          ),
          
          const SizedBox(height: 4),
          
          Text(
            'SET $_currentSet / ${exercise.sets}',
            style: const TextStyle(
              color: AppColors.electricCyan,
              fontSize: 11,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseDisplay(WorkoutExercise exercise) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: AppColors.cyberLime.withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyberLime.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Use full available height and width
              final size = constraints.maxHeight > constraints.maxWidth 
                  ? constraints.maxWidth 
                  : constraints.maxHeight;
              return ExerciseAnimationWidget(
                exerciseId: exercise.id,
                size: size,
                showWatermark: true,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildControls(WorkoutExercise exercise, bool isGymWorkout) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black,
            Colors.black.withOpacity(0.95),
            Colors.black.withOpacity(0.0),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Weight and Reps side by side
          Row(
            children: [
              // Weight input (ALWAYS show)
              Expanded(child: _buildWeightInputSquare()),
              const SizedBox(width: 12),
              
              // Reps input
              Expanded(child: _buildRepsInputSquare()),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Action buttons
          Row(
            children: [
              // Skip set
              Expanded(
                child: GestureDetector(
                  onTap: _skipSet,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.white10,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.white20),
                    ),
                    child: const Text(
                      'SKIP SET',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white60,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Complete set
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: _completeSet,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.electricCyan, AppColors.cyberLime],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cyberLime.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, color: Colors.black, size: 24),
                        const SizedBox(width: 8),
                        const Text(
                          'COMPLETE SET',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeightInputSquare() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cyberLime.withOpacity(0.3), width: 2),
      ),
      child: Column(
        children: [
          // Icon + Label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.fitness_center, color: AppColors.cyberLime, size: 18),
              SizedBox(width: 6),
              Text(
                'WEIGHT',
                style: TextStyle(
                  color: AppColors.cyberLime,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Manual input field
          TextField(
            controller: _weightController,  // ← FIXED: Use class-level controller
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w900,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(
                color: AppColors.white20,
                fontSize: 36,
                fontWeight: FontWeight.w900,
              ),
              suffixText: 'lbs',
              suffixStyle: const TextStyle(
                color: AppColors.white40,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: (value) {
              setState(() {
                _currentWeight = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRepsInputSquare() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.electricCyan.withOpacity(0.3), width: 2),
      ),
      child: Column(
        children: [
          // Icon + Label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.repeat, color: AppColors.electricCyan, size: 18),
              SizedBox(width: 6),
              Text(
                'REPS',
                style: TextStyle(
                  color: AppColors.electricCyan,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Value with +/- buttons - MINUS LEFT, NUMBER & PLUS LEFT
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Minus button - PUSHED TO LEFT CORNER
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (_currentReps > 1) _currentReps--;
                  });
                  HapticFeedback.selectionClick();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.remove, color: Colors.white, size: 18),
                ),
              ),
              
              // Number and Plus - MOVED LEFT
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Reps value
                  Text(
                    '$_currentReps',
                    style: const TextStyle(
                      color: AppColors.electricCyan,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Plus button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentReps++;
                      });
                      HapticFeedback.selectionClick();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.electricCyan.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add, color: AppColors.electricCyan, size: 18),
                    ),
                  ),
                ],
              ),
              
              // Right spacer to balance
              const SizedBox(width: 40), // Same width as minus button
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRestScreen() {
    final exercise = widget.workout.exercises[_currentExerciseIndex];
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'REST',
              style: TextStyle(
                color: AppColors.white40,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Big countdown
            Text(
              '$_restTimeRemaining',
              style: TextStyle(
                color: AppColors.cyberLime,
                fontSize: 120,
                fontWeight: FontWeight.w900,
                shadows: [
                  Shadow(
                    color: AppColors.cyberLime.withOpacity(0.5),
                    blurRadius: 30,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Next set/exercise info
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white5,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.white10),
              ),
              child: Column(
                children: [
                  Text(
                    _isBetweenExerciseRest
                        ? 'NEXT EXERCISE'
                        : 'NEXT: SET ${_currentSet + 1} / ${exercise.sets}',
                    style: const TextStyle(
                      color: AppColors.white60,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isBetweenExerciseRest && _currentExerciseIndex < widget.workout.exercises.length - 1
                        ? widget.workout.exercises[_currentExerciseIndex + 1].name.toUpperCase()
                        : exercise.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Skip rest button
            GestureDetector(
              onTap: _skipRest,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 32),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.white10,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.white20),
                ),
                child: const Text(
                  'SKIP REST',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

