import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:collection/collection.dart'; // For firstWhereOrNull
import '../../utils/app_colors.dart';
import '../../utils/haptic_helper.dart';
import '../../services/pose_detector_service.dart';
import '../../services/workout_recording_service.dart';
import '../../services/screen_recording_service.dart';
import '../../widgets/skeleton_painter.dart';
import '../../widgets/power_gauge.dart';
import '../../widgets/cyber_grid_background.dart';
import '../../widgets/shatter_animation.dart';
import '../../widgets/tactical_countdown.dart';
import '../../widgets/tactical_hud.dart';
import '../../widgets/elite_positioning_screen.dart';
import '../../widgets/elite_countdown_widget.dart';
import '../../widgets/exercise_animation_widget.dart';
import '../../widgets/glassmorphism_card.dart';
import '../../widgets/glow_button.dart';
import '../../widgets/weight_input_dialog.dart';
import '../../widgets/workout_summary_screen.dart';
import '../../widgets/quick_swap_modal.dart';
import '../../models/workout_models.dart';
import '../../models/rep_quality.dart';
import '../../providers/workout_provider.dart';
import '../../providers/stats_provider.dart';
import '../home_screen.dart' show TabNavigator;
import '../training_mode_selection_screen.dart';
import '../manual_training_screen.dart';
import '../hevy_manual_workout_screen.dart';

// NEW: Import the rep counting system
import '../../services/workout_session.dart';
import '../../core/patterns/movement_engine.dart';
import '../../services/unified_workout_save_service.dart';
import '../../models/exercise_set_data.dart';

/// Elite countdown phases
enum CountdownPhase { positioning, counting, scanning }

class TrainTab extends ConsumerStatefulWidget {
  final Function(bool isActive)? onWorkoutStateChanged;
  
  const TrainTab({super.key, this.onWorkoutStateChanged});

  @override
  ConsumerState<TrainTab> createState() => _TrainTabState();
}

class _TrainTabState extends ConsumerState<TrainTab> with TickerProviderStateMixin {
  // Committed workout state
  LockedWorkout? _committedWorkout;
  int _currentExerciseIndex = 0;
  
  // Camera & pose detection
  CameraController? _cameraController;
  PoseDetectorService? _poseDetectorService;
  bool _isCameraInitialized = false;
  String? _cameraError;
  List<PoseLandmark>? _landmarks;
  
  // NEW: Workout session for rep counting
  WorkoutSession? _session;
  
  // UI state
  bool _isWorkoutActive = false;
  bool _isResting = false;
  int _restTimeRemaining = 60;
  Timer? _restTimer;
  bool _isBetweenExerciseRest = false; // Track if rest is between exercises or between sets
  
  // Feedback display
  String _feedback = '';
  double _formScore = 0;
  bool _showRepFlash = false;
  bool _isRecording = false;
  DateTime? _recordingStartTime;
  String? _currentRecordingPath;

  // GAMING FEATURES
  SkeletonState _skeletonState = SkeletonState.normal;
  double _chargeProgress = 0.0;
  double _powerGaugeFill = 0.0;
  RepQuality? _lastRepQuality;
  bool _showShatterAnimation = false;
  
  // Countdown & body detection
  bool _showCountdown = false;
  bool _bodyDetected = false;
  bool _countdownComplete = false;
  bool _isScanning = false;
  bool _isCommitted = false;
  int _countdownValue = 5; // Changed to 5 for 5,4,3,2,1,GO
  Timer? _countdownTimer;
  bool _hasSpokenExerciseName = false; // Track if we've said the exercise name
  
  // Elite countdown phases
  CountdownPhase _countdownPhase = CountdownPhase.positioning;
  
  // NEW: Timer for set duration
  DateTime? _setStartTime;
  int _setElapsedSeconds = 0;
  Timer? _setTimer;
  bool _isTimerPaused = false;
  int _pausedElapsedSeconds = 0;
  
  // Workout time tracking
  DateTime? _workoutStartTime;
  
  // NEW: Auto-hide UI
  bool _isUIHidden = false;
  Timer? _uiHideTimer;
  
  // NEW: Exercise preview modal
  bool _showExercisePreview = false;
  
  // NEW: Weight tracking
  bool _isWeightDialogShown = false;
  final Map<String, List<double>> _exerciseWeights = {}; // exerciseId -> list of weights per set
  
  // NEW: Actual reps tracking per exercise
  final Map<String, List<int>> _exerciseActualReps = {}; // exerciseId -> list of actual reps per set
  
  // NEW: Voice coaching mute
  bool _isVoiceMuted = false;

  // HIIT/Circuit mode tracking
  bool _isCircuitMode = false;
  int _workTimeRemaining = 0;
  Timer? _workTimer;

  @override
  void initState() {
    super.initState();
    _loadCommittedWorkout();
  }

  @override
  void dispose() {
    _restTimer?.cancel();
    _countdownTimer?.cancel();
    _setTimer?.cancel();
    _workTimer?.cancel();
    _uiHideTimer?.cancel();
    _cameraController?.dispose();
    _poseDetectorService?.dispose();
    _session?.dispose();
    // Cancel any ongoing screen recording
    if (_isRecording) {
      ScreenRecordingService.cancelRecording();
    }
    super.dispose();
  }

  void _loadCommittedWorkout() {
    final committedWorkout = ref.read(committedWorkoutProvider);
    setState(() {
      _committedWorkout = committedWorkout;
    });
  }

  Future<void> _initializeCamera() async {
    try {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        setState(() => _cameraError = 'Camera permission denied');
        return;
      }

      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        setState(() => _cameraError = 'No cameras available');
        return;
      }

      final frontCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: true,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await _cameraController!.initialize();
      _poseDetectorService = PoseDetectorService();

      // Start image stream
      _cameraController!.startImageStream(_processFrame);

      setState(() => _isCameraInitialized = true);
    } catch (e) {
      setState(() => _cameraError = 'Camera error: $e');
    }
  }

  Future<void> _processFrame(CameraImage image) async {
    if (_poseDetectorService == null) return;

    final landmarks = await _poseDetectorService!.detectPose(image);

    if (landmarks != null && mounted) {
      // IMPROVED: Check if FULL body is in frame with high confidence
      // Require all major body landmarks with good visibility
      final requiredLandmarks = [
        PoseLandmarkType.leftShoulder,
        PoseLandmarkType.rightShoulder,
        PoseLandmarkType.leftHip,
        PoseLandmarkType.rightHip,
        PoseLandmarkType.leftKnee,
        PoseLandmarkType.rightKnee,
        PoseLandmarkType.leftAnkle,
        PoseLandmarkType.rightAnkle,
      ];
      
      int visibleLandmarks = 0;
      for (final type in requiredLandmarks) {
        final landmark = landmarks.firstWhereOrNull((l) => l.type == type);
        if (landmark != null && landmark.likelihood > 0.6) {
          visibleLandmarks++;
        }
      }
      
      // Need at least 6 out of 8 key landmarks visible for full body detection
      final bodyInFrame = visibleLandmarks >= 6;
      
      // Update body detection status
      if (bodyInFrame != _bodyDetected) {
        setState(() => _bodyDetected = bodyInFrame);
      }
      
      // Countdown runs automatically now - no body detection checks
      // Body detection is only for skeleton overlay, not for countdown gating
      
      // Only process workout if countdown complete
      if (_countdownComplete && _isWorkoutActive && !_isResting) {
        _session?.processPose(landmarks);
      }

      setState(() {
        _landmarks = landmarks;
        // _feedback removed - voice coach handles feedback now
        _formScore = _session?.formScore ?? 0;

        // SIMPLE SKELETON: Always normal, flash success only on rep count
        // The success flash is handled in onRepCounted callback
        if (!_showRepFlash) {
          _skeletonState = SkeletonState.normal;
        }
        // Note: _skeletonState = SkeletonState.success is set in onRepCounted

        // Update power gauge fill based on charge progress
        final chargeProgress = _session?.chargeProgress ?? 0.0;
        _chargeProgress = chargeProgress;
        _powerGaugeFill = chargeProgress;
      });
    } else {
      // Body lost
      if (_bodyDetected && mounted) {
        setState(() => _bodyDetected = false);
      }
    }
  }

  Future<void> _startWorkout() async {
    if (_committedWorkout == null || _committedWorkout!.exercises.isEmpty) return;

    // Show mode selection screen first
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TrainingModeSelectionScreen(),
        fullscreenDialog: true,
      ),
    );
    
    if (result == null) {
      // User cancelled
      return;
    }
    
    if (result == 'manual') {
      // Go to manual training screen
      if (mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ManualTrainingScreen(
              workout: _committedWorkout!,
            ),
          ),
        );
      }
    } else if (result == 'hevy_manual') {
      // NEW: Hevy-style manual screen
      if (mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HevyManualWorkoutScreen(
              workout: _committedWorkout!,
            ),
          ),
        );
      }
    } else if (result == 'auto') {
      // Continue to auto mode (camera) - skip phone guide
      _continueToCountdown();
    }
  }
  
  Future<void> _continueToCountdown() async {
    // Initialize camera
    await _initializeCamera();
    
    // Show elite positioning screen
    setState(() {
      _showCountdown = true;
      _countdownComplete = false;
      _isScanning = false;
      _isCommitted = false;
      _countdownPhase = CountdownPhase.positioning;
    });
    
    // Initialize workout session
    _session = WorkoutSession();
    await _session!.init();
    
    // Set up callbacks
    _session!.onRepCounted = (reps, score) {
      print('🎯 REP COMPLETED: Rep $reps with score $score');

      setState(() {
        _showRepFlash = true;
        _formScore = score;
        _skeletonState = SkeletonState.success;  // Blue/green flash
      });

      // Haptic feedback - heavy impact for rep completion
      HapticHelper.perfectRepHaptic();

      // Return to normal after 300ms
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _showRepFlash = false;
            _skeletonState = SkeletonState.normal;  // Back to white/black
          });
        }
      });
    };
    
    _session!.onSetComplete = (setComplete, totalSets) {
      print('📞 onSetComplete callback: setComplete=$setComplete, totalSets=$totalSets');
      print('   Current exercise: ${_currentExerciseIndex + 1}/${_committedWorkout?.exercises.length ?? 0}');
      
      if (setComplete >= totalSets) {
        // ALL SETS DONE FOR THIS EXERCISE - Move to next exercise (with rest)
        print('✅ All sets complete for this exercise!');
        print('→ Calling _moveToNextExercise()');
        _isBetweenExerciseRest = true; // Mark as between-exercise rest
        _moveToNextExercise();
      } else {
        // MORE SETS TO GO - Start rest timer for SAME exercise
        print('⏸️ Set $setComplete/$totalSets complete, starting rest');
        print('→ Calling _startRest()');
        _isBetweenExerciseRest = false; // Mark as between-set rest
        _startRest();
        
        // Show weight input dialog after a short delay (so rest screen is visible)
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted && _isResting) {
            _showWeightInputDialog();
          }
        });
      }
    };
    
    _session!.onFeedback = (feedback) {
      setState(() => _feedback = feedback);
    };

    _session!.onRepQuality = (quality, score) {
      setState(() => _lastRepQuality = quality);
    };

    setState(() {
      _isWorkoutActive = true;
      _currentExerciseIndex = 0;
      _workoutStartTime = DateTime.now(); // Track workout start time
    });
    
    // Notify parent to hide bottom nav
    widget.onWorkoutStateChanged?.call(true);

    // Exercise will start after countdown completes in _finishCommitAndStartWorkout
  }


  void _startEliteCountdown() {
    // Called when elite positioning auto-triggers
    setState(() {
      _countdownPhase = CountdownPhase.counting;
    });
  }

  void _onEliteCountdownComplete() {
    // Called when 5-second countdown finishes
    setState(() {
      _countdownPhase = CountdownPhase.scanning;
      _isScanning = true;
    });
    
    // Scanning for 2 seconds, then commit
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _finishCommitAndStartWorkout();
      }
    });
  }

  void _startCountdownTimer() {
    _countdownTimer?.cancel();
    
    // First, speak the exercise name and instruction
    if (!_hasSpokenExerciseName && _committedWorkout != null && _currentExerciseIndex < _committedWorkout!.exercises.length) {
      final exerciseName = _committedWorkout!.exercises[_currentExerciseIndex].name;
      // Speak: "[Exercise Name], get in your position"
      print('🎤 Speaking: $exerciseName, get in your position');
      // TODO: Uncomment when TTS is enabled
      // _tts.speak('$exerciseName, get in your position');
      setState(() => _hasSpokenExerciseName = true);
      
      // Wait 2 seconds before starting countdown (no body detection check)
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _startActualCountdown();
        }
      });
    }
  }
  
  void _startActualCountdown() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      // Speak the countdown number
      if (_countdownValue > 0) {
        print('🎤 Speaking: $_countdownValue');
        // TODO: Uncomment when TTS is enabled
        // _tts.speak('$_countdownValue');
      } else if (_countdownValue == 0) {
        print('🎤 Speaking: GO!');
        // TODO: Uncomment when TTS is enabled
        // _tts.speak('GO');
      }
      
      setState(() {
        _countdownValue--;
      });
      
      if (_countdownValue < 0) {
        timer.cancel();
        _startScanning();
      }
    });
  }

  void _startScanning() {
    setState(() {
      _isScanning = true;
    });
    
    // Scanning for 2 seconds, then commit (no body detection check)
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _finishCommitAndStartWorkout();
      }
    });
  }

  void _finishCommitAndStartWorkout() {
    setState(() {
      _isScanning = false;
      _isCommitted = true;
    });
    
    // Show COMMITTED for 1.5 seconds, then hide countdown and start workout
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _showCountdown = false;
          _countdownComplete = true;
        });
        // Actually start the exercise
        _startCurrentExercise();
      }
    });
  }

  void _completeWorkout() async {
    // Stop the set timer
    _stopSetTimer();
    
    // Play completion haptic
    HapticHelper.workoutCompleteHaptic();
    
    final workoutEndTime = DateTime.now();
    final workoutStartTime = _workoutStartTime ?? workoutEndTime;
    
    // CRITICAL: Save actual reps for the LAST exercise
    if (_session != null && _committedWorkout != null) {
      final currentExercise = _committedWorkout!.exercises[_currentExerciseIndex];
      final actualReps = _session!.completedRepsPerSet;
      _exerciseActualReps[currentExercise.id] = List.from(actualReps);
      print('💾 SAVED ACTUAL REPS for LAST exercise ${currentExercise.name}: $actualReps');
    }
    
    // Collect all exercise set data from workout session
    final List<ExerciseSetData> allSets = [];
    
    if (_session != null && _committedWorkout != null) {
      // Build exercise sets from workout data using ACTUAL reps
      for (int exIndex = 0; exIndex < _committedWorkout!.exercises.length; exIndex++) {
        final exercise = _committedWorkout!.exercises[exIndex];
        
        // Get weight for this exercise (if any)
        final weight = _exerciseWeights[exercise.id]?.firstOrNull;
        
        // Get ACTUAL reps completed for this exercise
        final actualRepsForExercise = _exerciseActualReps[exercise.id] ?? [];
        
        // Create sets for this exercise using ACTUAL reps completed
        for (int setNum = 1; setNum <= exercise.sets; setNum++) {
          // Get actual reps for this specific set, or fall back to target if not tracked
          final actualReps = (setNum - 1) < actualRepsForExercise.length 
              ? actualRepsForExercise[setNum - 1]
              : exercise.reps; // Fallback if set wasn't tracked
          
          print('📊 Exercise: ${exercise.name}, Set $setNum: $actualReps reps (target: ${exercise.reps})');
          
          allSets.add(ExerciseSetData(
            exerciseName: exercise.name,
            setNumber: setNum,
            weight: weight,
            repsCompleted: actualReps, // USE ACTUAL REPS
            repsTarget: exercise.reps,
            formScore: _session!.formScore, // Average form score from session
            perfectReps: _session!.perfectReps ~/  exercise.sets, // Distribute across sets
            goodReps: _session!.goodReps ~/ exercise.sets,
            missedReps: _session!.missedReps ~/ exercise.sets,
            maxCombo: _session!.maxCombo,
            timestamp: workoutEndTime.subtract(Duration(minutes: (exercise.sets - setNum) * 2)),
            primaryMuscles: exercise.primaryMuscles,
          ));
        }
      }
    }
    
    // Calculate workout stats for summary using ACTUAL reps
    final workoutDuration = workoutEndTime.difference(workoutStartTime);
    final totalSets = _committedWorkout!.exercises.fold<int>(
      0, 
      (sum, ex) => sum + ex.sets,
    );
    final totalReps = allSets.fold<int>(
      0, 
      (sum, set) => sum + set.repsCompleted, // Use ACTUAL reps completed
    );
    
    // Generate session ID for linking recording
    final sessionId = DateTime.now().millisecondsSinceEpoch.toString();
    
    // Save workout to database BEFORE showing summary
    int actualCalories = totalReps * 5; // Fallback estimate
    if (allSets.isNotEmpty) {
      final saveResult = await UnifiedWorkoutSaveService.saveCompletedWorkout(
        workoutName: _committedWorkout!.name,
        mode: WorkoutMode.autoCamera,
        startTime: workoutStartTime,
        endTime: workoutEndTime,
        exerciseSets: allSets,
        sessionId: sessionId,
      );
      
      if (saveResult['success'] as bool) {
        debugPrint('✅ Workout saved to database successfully!');
        actualCalories = saveResult['caloriesBurned'] as int; // Get accurate calories
      } else {
        debugPrint('❌ Failed to save workout to database');
      }
    }
    
    // Link recording to session if there's a recording
    if (_currentRecordingPath != null && _currentRecordingPath!.isNotEmpty) {
      try {
        await WorkoutRecordingService.saveRecording(
          workoutName: _committedWorkout!.name,
          videoPath: _currentRecordingPath!,
          duration: workoutDuration,
          sessionId: sessionId,
        );
        debugPrint('✅ Recording linked to session: $sessionId');
      } catch (e) {
        debugPrint('❌ Error linking recording to session: $e');
      }
    }
    
    // Show stunning workout summary
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WorkoutSummaryScreen(
          workoutName: _committedWorkout!.name,
          durationSeconds: workoutDuration.inSeconds,
          exercises: _committedWorkout!.exercises.map((ex) => ExerciseSummary(
            name: ex.name,
            sets: ex.sets,
            reps: ex.reps,
            weight: _exerciseWeights[ex.id]?.firstOrNull,
          )).toList(),
          totalSets: totalSets,
          totalReps: totalReps,
          caloriesBurned: actualCalories, // Use accurate calories from service
        ),
      ),
    );
  }

  void _startCurrentExercise() {
    if (_committedWorkout == null) return;

    final exercise = _committedWorkout!.exercises[_currentExerciseIndex];

    // ═══════════════════════════════════════════════════════════════════════════
    // FIX: Check if this is a circuit/HIIT workout (time-based)
    // ═══════════════════════════════════════════════════════════════════════════
    final isTimeBasedExercise = exercise.timeSeconds != null && exercise.timeSeconds! > 0;

    print('🎬 STARTING EXERCISE: ${exercise.name} (${_currentExerciseIndex + 1}/${_committedWorkout!.exercises.length})');
    print('   Sets: ${exercise.sets}, Reps: ${exercise.reps}');
    print('   timeSeconds: ${exercise.timeSeconds}, restSeconds: ${exercise.restSeconds}');
    print('   isTimeBased: $isTimeBasedExercise');
    print('   Exercise ID: ${exercise.id}');

    // Reset weight dialog flag for new exercise
    _isWeightDialogShown = false;

    // Reset circuit mode flag
    setState(() {
      _isCircuitMode = isTimeBasedExercise;
    });

    // Start UI hide timer
    _resetUIHideTimer();

    // ═══════════════════════════════════════════════════════════════════════════
    // FIX: Start rep tracking for ALL exercises, including HIIT
    // For HIIT, reps are counted but there's no target - count as many as you can
    // ═══════════════════════════════════════════════════════════════════════════
    if (MovementEngine.hasPattern(exercise.id)) {
      print('🔵 Calling _session.startExercise() for: ${exercise.id}');
      _session?.startExercise(
        exerciseId: exercise.id,
        sets: exercise.sets,
        reps: isTimeBasedExercise ? 999 : exercise.reps, // No limit for HIIT
        timeSeconds: exercise.timeSeconds,
      );
      print('✅ Exercise session started for: ${exercise.id}');
    } else {
      // No AI tracking for this exercise - just manual mode
      print('⚠️ No tracking rule for ${exercise.name}, using manual mode');
    }

    // Start appropriate timer
    if (isTimeBasedExercise) {
      _startWorkCountdown(exercise.timeSeconds!);
    } else {
      _startSetTimer();
    }
  }
  
  void _startSetTimer() {
    _setStartTime = DateTime.now();
    _setElapsedSeconds = 0;
    _isTimerPaused = false;
    _pausedElapsedSeconds = 0;
    
    _setTimer?.cancel();
    _setTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && !_isTimerPaused) {
        setState(() {
          _setElapsedSeconds = DateTime.now().difference(_setStartTime!).inSeconds;
        });
        
        // FIXED: Auto-complete time-based exercises (HIIT circuits)
        if (_session?.isTimeBased == true && _session?.timeRemaining == 0) {
          print('⏰ Time-based exercise complete! Auto-completing set...');
          _session?.skipToNextSet();
        }
      }
    });
  }
  
  void _toggleTimerPause() {
    setState(() {
      if (_isTimerPaused) {
        // Resume: adjust start time to account for paused duration
        final pausedDuration = _setElapsedSeconds - _pausedElapsedSeconds;
        _setStartTime = DateTime.now().subtract(Duration(seconds: _pausedElapsedSeconds));
        _isTimerPaused = false;
      } else {
        // Pause: store current elapsed time
        _pausedElapsedSeconds = _setElapsedSeconds;
        _isTimerPaused = true;
      }
    });
    HapticFeedback.mediumImpact();
  }
  
  void _stopSetTimer() {
    _setTimer?.cancel();
  }
  
  void _resetUIHideTimer() {
    _uiHideTimer?.cancel();
    setState(() => _isUIHidden = false);
    
    _uiHideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted && _isWorkoutActive && !_isResting) {
        setState(() => _isUIHidden = true);
      }
    });
  }
  
  void _onScreenTap() {
    if (_isUIHidden) {
      _resetUIHideTimer();
    }
  }

  void _moveToNextExercise() {
    if (_committedWorkout == null) return;
    
    print('🔄 _moveToNextExercise called: current index = $_currentExerciseIndex, total = ${_committedWorkout!.exercises.length}');
    
    // CRITICAL: Save actual reps for the CURRENT exercise before moving to next
    if (_session != null) {
      final currentExercise = _committedWorkout!.exercises[_currentExerciseIndex];
      final actualReps = _session!.completedRepsPerSet;
      _exerciseActualReps[currentExercise.id] = List.from(actualReps);
      print('💾 SAVED ACTUAL REPS for ${currentExercise.name}: $actualReps');
    }
    
    if (_currentExerciseIndex < _committedWorkout!.exercises.length - 1) {
      // Move to next exercise
      setState(() {
        _currentExerciseIndex++;
      });
      
      print('▶️ Moving to exercise ${_currentExerciseIndex + 1}: ${_committedWorkout!.exercises[_currentExerciseIndex].name}');
      
      // Use the standard rest flow (which will call _startCurrentExercise via _endRest)
      _isBetweenExerciseRest = true;
      _startRest();
    } else {
      // Workout complete!
      print('🏆 ALL EXERCISES COMPLETE!');
      _completeWorkout();
    }
  }

  void _startRest() {
    // ═══════════════════════════════════════════════════════════════════════════
    // FIX: Use exercise's actual rest time instead of hardcoded 60
    // ═══════════════════════════════════════════════════════════════════════════
    final exercise = _committedWorkout!.exercises[_currentExerciseIndex];
    final actualRestTime = exercise.restSeconds ?? 60;

    debugPrint('⏸️ Starting rest: ${actualRestTime}s (exercise.restSeconds: ${exercise.restSeconds})');

    setState(() {
      _isResting = true;
      _restTimeRemaining = actualRestTime;
    });

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_restTimeRemaining > 0) {
        setState(() => _restTimeRemaining--);
      } else {
        timer.cancel();
        _endRest();
      }
    });
  }

  /// Start HIIT work countdown timer
  void _startWorkCountdown(int seconds) {
    _workTimer?.cancel();
    _setTimer?.cancel(); // Stop the count-up timer

    setState(() {
      _workTimeRemaining = seconds;
      _isCircuitMode = true;
    });

    debugPrint('⏱️ Starting HIIT work countdown: ${seconds}s');

    _workTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && _workTimeRemaining > 0) {
        setState(() {
          _workTimeRemaining--;
        });
      } else {
        timer.cancel();
        // Auto-complete the work period
        debugPrint('✅ HIIT work period complete, starting rest');
        HapticFeedback.heavyImpact();

        // Move to next exercise or complete workout
        if (_currentExerciseIndex < _committedWorkout!.exercises.length - 1) {
          _isBetweenExerciseRest = true;
          _startRest();
        } else {
          _completeWorkout();
        }
      }
    });
  }

  void _endRest() {
    print('🟢 _endRest CALLED: isBetweenExerciseRest=$_isBetweenExerciseRest');
    _restTimer?.cancel();
    setState(() => _isResting = false);
    
    if (_isBetweenExerciseRest) {
      // Between exercises - start the NEW exercise (resets set counter)
      print('🔄 END REST: Starting NEW exercise (calls startExercise)');
      _startCurrentExercise();
    } else {
      // Between sets - continue SAME exercise (doesn't reset counter)
      print('🔄 END REST: Starting next set of same exercise (calls startNextSet)');
      _session?.startNextSet();
    }
  }

  void _skipRest() {
    _restTimer?.cancel();
    _endRest();
  }
  
  void _showWeightInputDialog() {
    if (_committedWorkout == null) return;
    
    final exercise = _committedWorkout!.exercises[_currentExerciseIndex];
    final currentSet = _session?.currentSet ?? 1;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WeightInputDialog(
        exerciseName: exercise.name,
        setNumber: currentSet,
        onWeightEntered: (weight) {
          // Store the weight
          final exerciseId = exercise.id;
          if (!_exerciseWeights.containsKey(exerciseId)) {
            _exerciseWeights[exerciseId] = [];
          }
          _exerciseWeights[exerciseId]!.add(weight);
          
          debugPrint('💪 Weight logged: $weight lbs for ${exercise.name} set $currentSet');
        },
        onSkip: () {
          debugPrint('⏭️ Weight logging skipped for this set');
        },
      ),
    );
  }
  
  Future<void> _showQuickSwap() async {
    if (_committedWorkout == null) return;
    
    final result = await showModalBottomSheet<WorkoutExercise>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuickSwapModal(
        currentExercise: _committedWorkout!.exercises[_currentExerciseIndex],
      ),
    );
    
    if (result != null) {
      // Swap exercise
      setState(() {
        _committedWorkout!.exercises[_currentExerciseIndex] = result;
        _startCurrentExercise(); // Restart with new exercise
      });
      
      HapticFeedback.mediumImpact();
    }
  }

  Future<void> _showQuickSwapDuringRest() async {
    if (_committedWorkout == null) return;
    
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildQuickSwapRestModal(),
    );
    
    if (result != null) {
      // Swap exercise with custom reps/sets (rest stays same)
      final newExercise = result['exercise'] as WorkoutExercise;
      final customReps = result['reps'] as int?;
      final customSets = result['sets'] as int?;
      
      setState(() {
        // Update exercise, preserving rest time
        final currentRest = _committedWorkout!.exercises[_currentExerciseIndex].restSeconds;
        _committedWorkout!.exercises[_currentExerciseIndex] = WorkoutExercise(
          id: newExercise.id,
          name: newExercise.name,
          reps: customReps ?? newExercise.reps,
          sets: customSets ?? newExercise.sets,
          restSeconds: currentRest, // Keep original rest
        );
      });
      
      HapticFeedback.mediumImpact();
    }
  }

  void _finishSet() {
    _session?.skipToNextSet();
  }

  void _endWorkout() {
    _restTimer?.cancel();
    _cameraController?.stopImageStream();
    _cameraController?.dispose();
    _cameraController = null;
    _poseDetectorService?.dispose();
    _poseDetectorService = null;
    _session?.dispose();
    _session = null;

    // Cancel any ongoing screen recording
    if (_isRecording) {
      ScreenRecordingService.cancelRecording();
      _isRecording = false;
    }

    // Notify parent to show bottom nav
    widget.onWorkoutStateChanged?.call(false);

    // Refresh stats provider to update home screen
    ref.invalidate(workoutStatsProvider);

    setState(() {
      _isWorkoutActive = false;
      _isResting = false;
      _isCameraInitialized = false;
      _landmarks = null;
      _currentExerciseIndex = 0;
    });
  }

  /// Toggle workout recording - Screen recording captures skeleton overlay!
  Future<void> _toggleRecording() async {
    if (!_isRecording) {
      // Start screen recording
      final workoutName = _committedWorkout?.name ?? 'FitnessOS Workout';
      final started = await ScreenRecordingService.startRecording(title: workoutName);

      if (started) {
        setState(() {
          _isRecording = true;
          _recordingStartTime = DateTime.now();
        });

        HapticFeedback.heavyImpact();
        debugPrint('🎥 Started screen recording');

        // Show feedback
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('🎥 Recording started - Skeleton overlay captured!'),
              backgroundColor: AppColors.neonCrimson,
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        debugPrint('❌ Failed to start screen recording');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('❌ Could not start recording. Please allow screen capture.'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } else {
      // Stop screen recording
      final workoutName = _committedWorkout?.name ?? 'Unknown Workout';
      final savedPath = await ScreenRecordingService.stopRecording(workoutName: workoutName);

      setState(() {
        _isRecording = false;
        _currentRecordingPath = savedPath;
      });

      HapticFeedback.heavyImpact();

      if (savedPath != null) {
        debugPrint('✅ Screen recording saved: $savedPath');

        // Show success feedback
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('✅ Recording saved with skeleton! View in Profile tab'),
              backgroundColor: AppColors.cyberLime,
              duration: const Duration(seconds: 2),
              action: SnackBarAction(
                label: 'VIEW',
                textColor: Colors.black,
                onPressed: () {
                  // Navigate to profile tab
                  final navigator = context.findAncestorWidgetOfExactType<TabNavigator>();
                  if (navigator != null) {
                    (navigator as dynamic).changeTab(2); // Profile tab
                  }
                },
              ),
            ),
          );
        }
      } else {
        debugPrint('❌ Failed to save recording');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('❌ Recording could not be saved'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show countdown screen (elite positioning + countdown)
    if (_showCountdown) {
      return _buildCountdownScreen();
    }
    
    if (!_isWorkoutActive) {
      return _buildStartScreen();
    }

    if (_isResting) {
      return _buildRestScreen();
    }

    return _buildTrainingScreen();
  }


  Widget _buildCountdownScreen() {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
        children: [
          // Camera preview
          if (_cameraController != null && _isCameraInitialized)
            Positioned.fill(
              child: CameraPreview(_cameraController!),
            ),
          
          // Skeleton overlay (shows body detection) - hide during positioning
          if (_landmarks != null && _cameraController != null && _countdownPhase != CountdownPhase.positioning)
            Positioned.fill(
              child: CustomPaint(
                painter: SkeletonPainter(
                  landmarks: _landmarks,
                  imageSize: Size(
                    _cameraController!.value.previewSize!.height,
                    _cameraController!.value.previewSize!.width,
                  ),
                  isFrontCamera: true,
                  skeletonState: SkeletonState.normal,
                  chargeProgress: 0.0,
                ),
              ),
            ),
          
          // Elite positioning screen
          if (_countdownPhase == CountdownPhase.positioning)
            ElitePositioningScreen(
              isPositionValid: _bodyDetected,
              onAutoStart: _startEliteCountdown,
            ),
          
          // Elite countdown widget
          if (_countdownPhase == CountdownPhase.counting && _committedWorkout != null)
            EliteCountdownWidget(
              exerciseId: _committedWorkout!.exercises[_currentExerciseIndex].id,
              onComplete: _onEliteCountdownComplete,
            ),
          
          // Scanning phase
          if (_countdownPhase == CountdownPhase.scanning)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.6),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: AppColors.electricCyan,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'LOCKING ON...',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: AppColors.electricCyan,
                          letterSpacing: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
          // Cancel button
          Positioned(
            top: 60,
            left: 20,
            child: IconButton(
              onPressed: () {
                _countdownTimer?.cancel();
                setState(() {
                  _showCountdown = false;
                  _isWorkoutActive = false;
                });
                _endWorkout();
              },
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildStartScreen() {
    if (_committedWorkout == null) {
      return Material(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.calendar_today_outlined, size: 80, color: AppColors.white30),
                const SizedBox(height: 24),
                const Text(
                  'NO WORKOUT COMMITTED',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Go to WORKOUTS tab to commit a workout.',
                  style: TextStyle(fontSize: 14, color: AppColors.white60),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Material(
      child: CyberGridBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
          children: [
            // Back button
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.white5,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.white10,
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 20),
            
            // JUST THE FIRST EXERCISE GIF (large, prominent)
            if (_committedWorkout!.exercises.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: ExerciseAnimationWidget(
                  exerciseId: _committedWorkout!.exercises.first.id,
                  size: 280,
                  showWatermark: true,
                ),
              ),
            
            const SizedBox(height: 24),
            
            // ALL EXERCISES LIST with checkmarks
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white5,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.white10),
                ),
                child: ListView.separated(
                  itemCount: _committedWorkout!.exercises.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final exercise = _committedWorkout!.exercises[index];
                    return Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.cyberLime,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            exercise.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          '${exercise.sets}×${exercise.reps}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.white50,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // START WORKOUT button
            GlowButton(
              text: '⚡ START WORKOUT',
              onPressed: _startWorkout,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
        ),
      ),
    );
  }

  Widget _buildTrainingScreen() {
    if (_committedWorkout == null) return _buildStartScreen();
    
    final exercise = _committedWorkout!.exercises[_currentExerciseIndex];
    final size = MediaQuery.of(context).size;

    if (_cameraError != null) {
      return Material(
        child: Center(child: Text(_cameraError!, style: const TextStyle(color: Colors.white))),
      );
    }

    if (!_isCameraInitialized || _cameraController == null) {
      return const Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.cyberLime),
              SizedBox(height: 24),
              Text('Starting camera...', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      );
    }

    return Material(
      child: GestureDetector(
      onTap: _onScreenTap,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          // Camera preview
          Positioned.fill(child: CameraPreview(_cameraController!)),

          // Skeleton overlay (now visible during recording - screen capture includes it!)
          if (_landmarks != null)
            Positioned.fill(
              child: CustomPaint(
                painter: SkeletonPainter(
                  landmarks: _landmarks,
                  imageSize: Size(
                    _cameraController!.value.previewSize!.height,
                    _cameraController!.value.previewSize!.width,
                  ),
                  isFrontCamera: true,
                  skeletonState: _skeletonState,
                  chargeProgress: _chargeProgress,
                ),
              ),
            ),

          // GAMING: Power Gauge - Left edge (ALWAYS VISIBLE)
          Positioned(
            left: 8, // Further left
            top: 220,
            child: PowerGauge(fillPercent: _powerGaugeFill),
          ),
          
          // Exercise preview thumbnail (HIDDEN when UI hidden) - below power gauge on left
          if (!_isUIHidden)
            Positioned(
              left: 8,
              bottom: 240, // RIGHT above the timer - pushed way down
              child: GestureDetector(
                onTap: () => setState(() => _showExercisePreview = true),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.cyberLime, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.cyberLime.withOpacity(0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ExerciseAnimationWidget(
                      exerciseId: exercise.id,
                      size: 80,
                      showWatermark: false,
                    ),
                  ),
                ),
              ),
            ),

          // GAMING: Shatter Animation
          if (_showShatterAnimation)
            Positioned.fill(
              child: ShatterAnimation(
                onComplete: () {
                  if (mounted) setState(() => _showShatterAnimation = false);
                },
              ),
            ),

          // Skelatal-PT Logo at top left (VISIBLE when UI hidden)
          if (_isUIHidden)
            Positioned(
              top: 30, // Pushed higher
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.cyberLime.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/logo/playstore_icon.png',
                      width: 48,
                      height: 48,
                    ),
                    const SizedBox(width: 12),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF39FF14), // Cyber lime
                          Color(0xFF00D9FF), // Electric cyan
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        'SKELATAL-PT',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Exercise info - top left (HIDDEN when UI hidden)
          if (!_isUIHidden)
            Positioned(
              top: 50,
              left: 16,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name.toUpperCase(),
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                    Text(
                      'SET ${_session?.currentSet ?? 1}/${exercise.sets}',
                      style: const TextStyle(fontSize: 12, color: AppColors.white60),
                    ),
                  ],
                ),
              ),
            ),

          // Close button (ALWAYS VISIBLE)
          Positioned(
            top: 50,
            right: 16,
            child: GestureDetector(
              onTap: _endWorkout,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),

          // Quick Swap button - MOVED to top right under close button (HIDDEN when UI hidden)
          if (!_isUIHidden)
            Positioned(
              top: 110, // 50 + 48 (close button height) + 12 (spacing)
              right: 16, // Perfectly aligned with close button
              child: GestureDetector(
                onTap: () async {
                  HapticFeedback.mediumImpact();
                  await _showQuickSwap();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.cyberLime,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.swap_horiz,
                    color: AppColors.cyberLime,
                    size: 20,
                  ),
                ),
              ),
            ),

          // Mute button - Below Quick Swap (HIDDEN when UI hidden)
          if (!_isUIHidden)
            Positioned(
              top: 170, // 110 + 48 (swap button height) + 12 (spacing)
              right: 16, // Perfectly aligned
              child: GestureDetector(
                onTap: () {
                  setState(() => _isVoiceMuted = !_isVoiceMuted);
                  // Update voice coach mute state
                  _session?.setVoiceMute(_isVoiceMuted);
                  HapticFeedback.selectionClick();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isVoiceMuted ? AppColors.neonCrimson : AppColors.white30,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    _isVoiceMuted ? Icons.volume_off : Icons.volume_up,
                    color: _isVoiceMuted ? AppColors.neonCrimson : AppColors.white70,
                    size: 20,
                  ),
                ),
              ),
            ),

          // Angle box (HIDDEN when UI hidden)
          if (!_isUIHidden)
            Positioned(
              top: 120,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cyberLime.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Angle: ${_session?.currentAngle.toStringAsFixed(0)}°',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cyberLime,
                      ),
                    ),
                    Text(
                      'Phase: ${_session?.phase ?? ""}',
                      style: const TextStyle(fontSize: 10, color: AppColors.white60),
                    ),
                  ],
                ),
              ),
            ),

          // Exercise preview modal (fullscreen)
          if (_showExercisePreview)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => _showExercisePreview = false),
                child: Container(
                  color: Colors.black.withOpacity(0.9),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: ExerciseAnimationWidget(
                            exerciseId: exercise.id,
                            size: 300,
                            showWatermark: true,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          exercise.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () => setState(() => _showExercisePreview = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.cyberLime,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'BACK',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Form feedback (HIDDEN when UI hidden)
          if (!_isUIHidden && _feedback.isNotEmpty)
            Positioned(
              bottom: 140,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _feedback,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.electricCyan,
                    ),
                  ),
                ),
              ),
            ),

          // Rep flash animation
          if (_showRepFlash)
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.5, end: 1.5),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: 1 - ((value - 0.5) / 1.0),
                      child: const Text(
                        '+1',
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w900,
                          color: AppColors.cyberLime,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // SWAPPED POSITIONS: Rep counter on LEFT, Record button on RIGHT
          
          // Set timer - ABOVE rep counter (ALWAYS VISIBLE) with PAUSE button inside
          Positioned(
            bottom: 158,
            left: 8, // Further left, same as power gauge/gif
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _isCircuitMode
                      ? AppColors.neonOrange.withOpacity(0.5)
                      : AppColors.electricCyan.withOpacity(0.5),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pause/Resume button (disabled for HIIT)
                  GestureDetector(
                    onTap: _isCircuitMode ? null : _toggleTimerPause,
                    child: Icon(
                      _isCircuitMode
                          ? Icons.timer
                          : (_isTimerPaused ? Icons.play_arrow : Icons.pause),
                      color: _isCircuitMode
                          ? AppColors.neonOrange
                          : (_isTimerPaused ? AppColors.cyberLime : AppColors.electricCyan),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Timer text - countdown for HIIT, count-up for regular
                  Text(
                    _isCircuitMode
                        ? _formatTime(_workTimeRemaining) // HIIT: countdown
                        : _formatTime(_setElapsedSeconds), // Regular: count-up
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: _isCircuitMode ? AppColors.neonOrange : AppColors.electricCyan,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Rep counter - Bottom LEFT (ALWAYS VISIBLE)
          Positioned(
            bottom: 58,
            left: 8, // Further left, same as power gauge/gif/timer
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.cyberLime.withOpacity(0.5),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cyberLime.withOpacity(0.3),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_session?.currentReps ?? 0}',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: AppColors.cyberLime,
                      height: 1,
                    ),
                  ),
                  // ═══════════════════════════════════════════════════════════════
                  // FIX: Show "REPS" for HIIT/circuit, show "/ X" for regular
                  // ═══════════════════════════════════════════════════════════════
                  Text(
                    _isCircuitMode
                        ? 'REPS' // HIIT mode: no target, just count
                        : '/ ${exercise.reps}', // Regular mode: show target
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white50,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Quick Swap button - Above mute (ALWAYS VISIBLE)
          // Record button - Bottom RIGHT (ALWAYS VISIBLE)
          Positioned(
            bottom: 58,
            right: 8, // Further right
            child: GestureDetector(
              onTap: () async {
                await _toggleRecording();
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isRecording ? AppColors.neonCrimson : Colors.black.withOpacity(0.7),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isRecording ? AppColors.neonCrimson : AppColors.white30,
                    width: 2,
                  ),
                  boxShadow: _isRecording ? [
                    BoxShadow(
                      color: AppColors.neonCrimson.withOpacity(0.5),
                      blurRadius: 20,
                    ),
                  ] : null,
                ),
                child: Icon(
                  _isRecording ? Icons.stop : Icons.fiber_manual_record,
                  color: _isRecording ? Colors.white : AppColors.white70,
                  size: 24,
                ),
              ),
            ),
          ),

          // Bottom center button - FINISH SET (HIDDEN when UI hidden)
          if (!_isUIHidden)
            Positioned(
              bottom: 58,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: _finishSet,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.cyberLime,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'FINISH SET',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.black, letterSpacing: 1),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
    );
  }
  
  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildRestScreen() {
    // Check if the session is complete (all sets done for current exercise)
    // If session.isExerciseComplete is true, we've finished all sets and should show next exercise
    // Otherwise, we're just resting between sets of the SAME exercise
    final isExerciseComplete = _session?.isExerciseComplete ?? false;
    final hasNextExercise = _currentExerciseIndex < (_committedWorkout?.exercises.length ?? 0) - 1;
    final showNextExercisePreview = isExerciseComplete && hasNextExercise;
    final isGymWorkout = _committedWorkout?.exercises[_currentExerciseIndex].id.contains('gym') ?? false;
    
    return Material(
      child: Container(
      color: Colors.black.withOpacity(0.95),
      child: Stack(
        children: [
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Show next exercise GIF if on last set
                if (showNextExercisePreview && _committedWorkout != null) ...[
                  const Text(
                    'NEXT UP',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.white40,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ExerciseAnimationWidget(
                      exerciseId: _committedWorkout!.exercises[_currentExerciseIndex + 1].id,
                      size: 200,
                      showWatermark: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _committedWorkout!.exercises[_currentExerciseIndex + 1].name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.cyberLime,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12), // Reduced from 32
                ],
                
                const Text(
                  'REST',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: AppColors.white40),
                ),
                const SizedBox(height: 32),
                Text(
                  '$_restTimeRemaining',
                  style: const TextStyle(
                    fontSize: 140,
                    fontWeight: FontWeight.w900,
                    color: AppColors.cyberLime,
                  ),
                ),
                SizedBox(height: showNextExercisePreview ? 16 : 48), // Much less space if showing next exercise
                
                // Quick Swap button
                GestureDetector(
                  onTap: () async {
                    HapticFeedback.mediumImpact();
                    await _showQuickSwapDuringRest();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.cyberLime.withOpacity(0.8), AppColors.cyberLime],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cyberLime.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.swap_horiz, color: Colors.black, size: 20),
                        SizedBox(width: 8),
                        Text(
                          'QUICK SWAP',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                GestureDetector(
                  onTap: _skipRest,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    decoration: BoxDecoration(
                      color: AppColors.white10,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.white20),
                    ),
                    child: const Text(
                      'SKIP REST',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Weight input card at top (for gym workouts only) - CLEAN NON-INTERACTIVE CARD
          if (isGymWorkout)
            Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white5.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.cyberLime.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyberLime.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.cyberLime.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.fitness_center,
                            color: AppColors.cyberLime,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _committedWorkout?.exercises[_currentExerciseIndex].name.toUpperCase() ?? 'EXERCISE',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.5,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Set ${_session?.currentSet ?? 1} completed',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Divider(color: AppColors.white10, height: 1),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'WEIGHT',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white40,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.white10,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.cyberLime.withOpacity(0.2),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                        decoration: const InputDecoration(
                                          hintText: '0',
                                          hintStyle: TextStyle(
                                            color: AppColors.white30,
                                          ),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        onChanged: (value) {
                                          // Auto-save weight
                                          final weight = double.tryParse(value);
                                          if (weight != null && weight > 0) {
                                            final exerciseId = _committedWorkout!.exercises[_currentExerciseIndex].id;
                                            if (!_exerciseWeights.containsKey(exerciseId)) {
                                              _exerciseWeights[exerciseId] = [];
                                            }
                                            // Update or add weight for current set
                                            final currentSet = (_session?.currentSet ?? 1) - 1;
                                            if (_exerciseWeights[exerciseId]!.length > currentSet) {
                                              _exerciseWeights[exerciseId]![currentSet] = weight;
                                            } else {
                                              _exerciseWeights[exerciseId]!.add(weight);
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'lbs',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white50,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'REPS',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white40,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.white10,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: AppColors.electricCyan.withOpacity(0.2),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _session?.isTimeBased == true 
                                          ? '${_session?.timeRemaining ?? 0}'
                                          : '${_session?.currentReps ?? 0}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.electricCyan,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _session?.isTimeBased == true ? 'sec' : 'reps',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.white50,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          
          // Finish workout button - top right
          Positioned(
            top: 60,
            right: 20,
            child: GestureDetector(
              onTap: _completeWorkout,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.cyberLime.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.cyberLime.withOpacity(0.4),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyberLime.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.cyberLime,
                      size: 18,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'FINISH',
                      style: TextStyle(
                        color: AppColors.cyberLime,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildQuickSwapRestModal() {
    String selectedBodyPart = 'Chest';
    int customReps = 10;
    int customSets = 3;
    WorkoutExercise? selectedExercise;

    return StatefulBuilder(
      builder: (context, setModalState) {
        // Get exercises for selected body part
        final exercises = _getExercisesForBodyPart(selectedBodyPart);
        
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: AppColors.cyberBlack,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Drag handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.white40,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              // Title
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'QUICK SWAP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: AppColors.cyberLime,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              
              // Body part filter
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildBodyPartButton('💪 Chest', 'Chest', selectedBodyPart, (part) {
                      setModalState(() => selectedBodyPart = part);
                    }),
                    _buildBodyPartButton('🦵 Legs', 'Legs', selectedBodyPart, (part) {
                      setModalState(() => selectedBodyPart = part);
                    }),
                    _buildBodyPartButton('🔙 Back', 'Back', selectedBodyPart, (part) {
                      setModalState(() => selectedBodyPart = part);
                    }),
                    _buildBodyPartButton('💪 Shoulders', 'Shoulders', selectedBodyPart, (part) {
                      setModalState(() => selectedBodyPart = part);
                    }),
                    _buildBodyPartButton('💪 Arms', 'Arms', selectedBodyPart, (part) {
                      setModalState(() => selectedBodyPart = part);
                    }),
                    _buildBodyPartButton('🧘 Core', 'Core', selectedBodyPart, (part) {
                      setModalState(() => selectedBodyPart = part);
                    }),
                    _buildBodyPartButton('🏃 Cardio', 'Cardio', selectedBodyPart, (part) {
                      setModalState(() => selectedBodyPart = part);
                    }),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Reps and Sets controls
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'REPS',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white50,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (customReps > 1) {
                                    setModalState(() => customReps--);
                                    HapticFeedback.lightImpact();
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.white10,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.remove, color: Colors.white, size: 20),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '$customReps',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.cyberLime,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (customReps < 50) {
                                    setModalState(() => customReps++);
                                    HapticFeedback.lightImpact();
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.white10,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SETS',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white50,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (customSets > 1) {
                                    setModalState(() => customSets--);
                                    HapticFeedback.lightImpact();
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.white10,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.remove, color: Colors.white, size: 20),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '$customSets',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.cyberLime,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (customSets < 10) {
                                    setModalState(() => customSets++);
                                    HapticFeedback.lightImpact();
                                  }
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.white10,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.add, color: Colors.white, size: 20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              const Divider(color: AppColors.white10, height: 1),
              
              // Exercise list
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    final isCurrent = _committedWorkout != null &&
                        exercise.id == _committedWorkout!.exercises[_currentExerciseIndex].id;
                    final isSelected = selectedExercise?.id == exercise.id;
                    
                    return GestureDetector(
                      onTap: () {
                        setModalState(() => selectedExercise = exercise);
                        HapticFeedback.mediumImpact();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.cyberLime.withOpacity(0.2) : AppColors.white5,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? AppColors.cyberLime : 
                                   isCurrent ? AppColors.neonCrimson : AppColors.white10,
                            width: isSelected ? 3 : (isCurrent ? 2 : 1),
                          ),
                        ),
                        child: Column(
                          children: [
                            if (isCurrent)
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.neonCrimson,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'CURRENT',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: ExerciseAnimationWidget(
                                exerciseId: exercise.id,
                                size: 80,
                                showWatermark: false,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                exercise.name.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected ? AppColors.cyberLime : Colors.white,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Confirm button
              if (selectedExercise != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.pop(context, {
                        'exercise': selectedExercise,
                        'reps': customReps,
                        'sets': customSets,
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.cyberLime, AppColors.cyberLime.withOpacity(0.8)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cyberLime.withOpacity(0.3),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Text(
                        'CONFIRM SWAP',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBodyPartButton(String label, String value, String selected, Function(String) onTap) {
    final isSelected = value == selected;
    return GestureDetector(
      onTap: () {
        onTap(value);
        HapticFeedback.lightImpact();
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [AppColors.cyberLime, AppColors.cyberLime.withOpacity(0.8)])
              : null,
          color: isSelected ? null : AppColors.white10,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.cyberLime : AppColors.white20,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  List<WorkoutExercise> _getExercisesForBodyPart(String bodyPart) {
    // Return exercises based on body part
    switch (bodyPart) {
      case 'Chest':
        return [
          WorkoutExercise(id: 'pushup', name: 'Push-up', reps: 15, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'wide_pushup', name: 'Wide Push-up', reps: 12, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'diamond_pushup', name: 'Diamond Push-up', reps: 10, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'archer_pushup', name: 'Archer Push-up', reps: 8, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'decline_pushup', name: 'Decline Push-up', reps: 12, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'incline_pushup', name: 'Incline Push-up', reps: 15, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'explosive_pushup', name: 'Explosive Push-up', reps: 10, sets: 3, restSeconds: 90),
          WorkoutExercise(id: 'spiderman_pushup', name: 'Spiderman Push-up', reps: 12, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'staggered_pushup', name: 'Staggered Push-up', reps: 10, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'pseudo_planche', name: 'Pseudo Planche', reps: 8, sets: 3, restSeconds: 90),
        ];
      case 'Legs':
        return [
          WorkoutExercise(id: 'squat', name: 'Squat', reps: 20, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'lunge', name: 'Lunge', reps: 15, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'bulgarian_split_squat', name: 'Bulgarian Split Squat', reps: 12, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'jump_squat', name: 'Jump Squat', reps: 15, sets: 3, restSeconds: 90),
          WorkoutExercise(id: 'pistol_squat', name: 'Pistol Squat', reps: 8, sets: 3, restSeconds: 90),
          WorkoutExercise(id: 'calf_raise', name: 'Calf Raise', reps: 25, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', reps: 20, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'single_leg_deadlift', name: 'Single Leg Deadlift', reps: 12, sets: 3, restSeconds: 60),
          // WorkoutExercise(id: 'wall_sit', name: 'Wall Sit', reps: 60, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'side_lunge', name: 'Side Lunge', reps: 15, sets: 3, restSeconds: 60),
        ];
      case 'Back':
        return [
          WorkoutExercise(id: 'pull_up', name: 'Pull-up', reps: 10, sets: 3, restSeconds: 90),
          WorkoutExercise(id: 'chin_up', name: 'Chin-up', reps: 10, sets: 3, restSeconds: 90),
          WorkoutExercise(id: 'inverted_row', name: 'Inverted Row', reps: 15, sets: 3, restSeconds: 60),
          // WorkoutExercise(id: 'superman', name: 'Superman', reps: 20, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'wide_pull_up', name: 'Wide Pull-up', reps: 8, sets: 3, restSeconds: 90),
          WorkoutExercise(id: 'aussie_pullup', name: 'Aussie Pull-up', reps: 12, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'deadlift', name: 'Deadlift', reps: 12, sets: 3, restSeconds: 90),
          WorkoutExercise(id: 'bent_over_row', name: 'Bent Over Row', reps: 15, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'back_extension', name: 'Back Extension', reps: 20, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'reverse_snow_angel', name: 'Reverse Snow Angel', reps: 15, sets: 3, restSeconds: 45),
        ];
      case 'Shoulders':
        return [
          WorkoutExercise(id: 'pike_pushup', name: 'Pike Push-up', reps: 12, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'overhead_press', name: 'Overhead Press', reps: 12, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'lateral_raise', name: 'Lateral Raise', reps: 15, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'front_raise', name: 'Front Raise', reps: 15, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'arnold_press', name: 'Arnold Press', reps: 12, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'handstand_pushup', name: 'Handstand Push-up', reps: 8, sets: 3, restSeconds: 120),
          WorkoutExercise(id: 'shoulder_tap', name: 'Shoulder Tap', reps: 20, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'plank_to_pike', name: 'Plank to Pike', reps: 15, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'arm_circles', name: 'Arm Circles', reps: 30, sets: 3, restSeconds: 30),
          WorkoutExercise(id: 'reverse_fly', name: 'Reverse Fly', reps: 15, sets: 3, restSeconds: 45),
        ];
      case 'Arms':
        return [
          WorkoutExercise(id: 'bicep_curl', name: 'Bicep Curl', reps: 15, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'hammer_curl', name: 'Hammer Curl', reps: 15, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'tricep_dip', name: 'Tricep Dip', reps: 15, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'tricep_extension', name: 'Tricep Extension', reps: 15, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'close_grip_pushup', name: 'Close Grip Push-up', reps: 12, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'concentration_curl', name: 'Concentration Curl', reps: 12, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'overhead_tricep', name: 'Overhead Tricep', reps: 15, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'zottman_curl', name: 'Zottman Curl', reps: 12, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'wrist_curl', name: 'Wrist Curl', reps: 20, sets: 3, restSeconds: 30),
          WorkoutExercise(id: 'reverse_curl', name: 'Reverse Curl', reps: 15, sets: 3, restSeconds: 45),
        ];
      case 'Core':
        return [
          WorkoutExercise(id: 'plank', name: 'Plank', reps: 60, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'side_plank', name: 'Side Plank', reps: 45, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'crunches', name: 'Crunches', reps: 25, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'bicycle_crunches', name: 'Bicycle Crunches', reps: 20, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'leg_raises', name: 'Leg Raises', reps: 15, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'russian_twist', name: 'Russian Twist', reps: 30, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'mountain_climber', name: 'Mountain Climber', reps: 30, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'hollow_body_hold', name: 'Hollow Body Hold', reps: 45, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'v_ups', name: 'V-ups', reps: 15, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'dead_bug', name: 'Dead Bug', reps: 20, sets: 3, restSeconds: 45),
        ];
      case 'Cardio':
        return [
          WorkoutExercise(id: 'burpees', name: 'Burpees', reps: 15, sets: 3, restSeconds: 90),
          WorkoutExercise(id: 'jumping_jacks', name: 'Jumping Jacks', reps: 30, sets: 3, restSeconds: 45),
          WorkoutExercise(id: 'high_knees', name: 'High Knees', reps: 40, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'butt_kicks', name: 'Butt Kicks', reps: 40, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'jump_rope', name: 'Jump Rope', reps: 60, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'box_jumps', name: 'Box Jumps', reps: 12, sets: 3, restSeconds: 90),
          WorkoutExercise(id: 'skaters', name: 'Skaters', reps: 20, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'mountain_climber', name: 'Mountain Climber', reps: 30, sets: 3, restSeconds: 60),
          WorkoutExercise(id: 'sprint_in_place', name: 'Sprint in Place', reps: 30, sets: 3, restSeconds: 90),
          WorkoutExercise(id: 'lateral_shuffle', name: 'Lateral Shuffle', reps: 30, sets: 3, restSeconds: 60),
        ];
      default:
        return [];
    }
  }
}
