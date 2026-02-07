import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../core/patterns/movement_engine.dart';
import '../core/patterns/base_pattern.dart';
import 'voice_coach.dart';
import '../models/rep_quality.dart';

// Export RepState and RepCounter for UI access
export '../core/patterns/base_pattern.dart' show RepState;

/// Manages the active workout session
/// Connects: Pose Detection → Rep Counter → Voice Coach
class WorkoutSession {
  final VoiceCoach _voice = VoiceCoach();
  MovementEngine _engine = MovementEngine();
  String _currentExerciseId = '';
  bool _baselineCaptured = false;

  // Current state
  int _currentSetIndex = 0;
  int _targetReps = 0;
  int _targetSets = 0;
  bool _isActive = false;
  bool _isResting = false;
  
  // NEW: Time-based exercise tracking for HIIT circuits
  int? _timeSeconds; // If set, exercise is time-based (ignore rep count)
  DateTime? _exerciseStartTime;
  
  // NEW: Track actual reps completed per set
  final List<int> _completedRepsPerSet = [];
  
  // GAMING: Combo tracking
  int _currentCombo = 0;
  int _maxCombo = 0;
  int _comboBrokenCount = 0;
  int _perfectReps = 0;
  int _goodReps = 0;
  int _missedReps = 0;
  List<RepData> _repHistory = [];
  DateTime? _setStartTime;
  
  // Callbacks
  Function(int reps, double formScore)? onRepCounted;
  Function(String feedback)? onFeedback;
  Function(int setComplete, int totalSets)? onSetComplete;
  Function(int combo, int maxCombo)? onComboChange;
  Function(RepQuality quality, double formScore)? onRepQuality;
  
  // Getters
  bool get isActive => _isActive;
  bool get isResting => _isResting;
  int get currentReps => _engine.repCount ?? 0;
  int get currentSet => _currentSetIndex + 1; // Returns 1-indexed set number (1, 2, 3, etc.)
  int get targetReps => _targetReps;
  int get targetSets => _targetSets;
  bool get isExerciseComplete => _currentSetIndex >= _targetSets; // Check if all sets are done
  double get currentAngle => (_engine.chargeProgress * 100) ?? 0;
  double get formScore => (_engine.chargeProgress * 100) ?? 0;
  String get feedback => _engine.feedback ?? '';
  String get exerciseName => _currentExerciseId;
  String get phase => _engine.state.name ?? '';
  
  // NEW: Time-based getters for HIIT circuits
  bool get isTimeBased => _timeSeconds != null;
  int get timeRemaining {
    if (_timeSeconds == null || _exerciseStartTime == null) return 0;
    final elapsed = DateTime.now().difference(_exerciseStartTime!).inSeconds;
    return (_timeSeconds! - elapsed).clamp(0, _timeSeconds!);
  }
  int get targetTime => _timeSeconds ?? 0;

  // GAMING: Combo getters
  int get currentCombo => _currentCombo;
  int get maxCombo => _maxCombo;
  int get perfectReps => _perfectReps;
  int get goodReps => _goodReps;
  int get missedReps => _missedReps;
  List<RepData> get repHistory => List.unmodifiable(_repHistory);
  
  // NEW: Get completed reps per set
  List<int> get completedRepsPerSet => List.unmodifiable(_completedRepsPerSet);

  // GAMING: Real-time charge progress for power gauge and skeleton state
  // Patterns already return 0.0 to 1.0, just pass through
  double get chargeProgress => _engine.chargeProgress;
  RepState? get repState => _engine.state;

  /// Initialize the session
  /// Public: Set voice coach mute state
  void setVoiceMute(bool muted) {
    _voice.setEnabled(!muted);
  }
  
  /// Helper: Strip difficulty prefix from exercise ID
  /// Converts "beginner_squat" -> "squat", "intermediate_bench_press" -> "bench_press"
  String _stripDifficultyPrefix(String exerciseId) {
    final normalized = exerciseId.toLowerCase().trim();
    
    // Remove difficulty prefixes
    if (normalized.startsWith('beginner_')) {
      return normalized.substring(9); // Remove "beginner_"
    } else if (normalized.startsWith('intermediate_')) {
      return normalized.substring(13); // Remove "intermediate_"
    } else if (normalized.startsWith('advanced_')) {
      return normalized.substring(9); // Remove "advanced_"
    }
    
    return normalized;
  }
  
  Future<void> init() async {
    await _voice.init();
  }
  
  /// Start tracking an exercise
    Future<void> startExercise({
    required String exerciseId,
    required int sets,
    required int reps,
    int? timeSeconds, // NEW: Optional time-based mode for HIIT circuits
  }) async {
    print('🚀 START EXERCISE CALLED: $exerciseId, sets=$sets, reps=$reps, time=$timeSeconds');
    
    // Strip difficulty prefix to get base exercise ID
    final baseExerciseId = _stripDifficultyPrefix(exerciseId);
    print('🔧 Base exercise ID (after stripping difficulty): $baseExerciseId');
    
    // Load the pattern for this exercise
    if (!MovementEngine.hasPattern(baseExerciseId)) {
      print('⚠️ No tracking pattern for: $baseExerciseId (original: $exerciseId)');
      return;
    }

    _currentExerciseId = baseExerciseId; // Store the base ID
    _engine.loadExercise(baseExerciseId); // Use base ID for pattern matching
    _engine.reset(); // EXPLICIT RESET
    _baselineCaptured = false;
    _targetSets = sets;
    _targetReps = reps;
    _currentSetIndex = 0;
    _isActive = true;
    _isResting = false;
    
    // NEW: Time-based mode for HIIT circuits
    _timeSeconds = timeSeconds;
    _exerciseStartTime = timeSeconds != null ? DateTime.now() : null;

    // GAMING: Reset combo tracking for new exercise
    _currentCombo = 0;
    _maxCombo = 0;
    _comboBrokenCount = 0;
    _perfectReps = 0;
    _goodReps = 0;
    _missedReps = 0;
    _repHistory = [];
    _setStartTime = DateTime.now();
    
    // NEW: Clear completed reps tracking
    _completedRepsPerSet.clear();

    print('✅ Exercise initialized: _currentSetIndex=0, _targetSets=$_targetSets, _isActive=$_isActive, _isResting=$_isResting, timeBased=${timeSeconds != null}');
    
    _voice.announceExercise(exerciseId, sets, reps);
  }
  
  /// Helper: Convert List<PoseLandmark> to Map<PoseLandmarkType, PoseLandmark>
  Map<PoseLandmarkType, PoseLandmark> _landmarksToMap(List<PoseLandmark> landmarks) {
    final map = <PoseLandmarkType, PoseLandmark>{};
    for (final landmark in landmarks) {
      map[landmark.type] = landmark;
    }
    return map;
  }

  /// Process pose landmarks from camera
  /// Call this every frame with the detected landmarks
  void processPose(List<PoseLandmark> landmarks) {
    if (!_isActive || _isResting || _engine == null) return;

    // Convert list to map
    final landmarkMap = _landmarksToMap(landmarks);

    // Capture baseline on first frame to lock on to user
    if (!_baselineCaptured) {
      _engine.captureBaseline(landmarkMap);
      _baselineCaptured = true;
      return; // Don't process first frame
    }

    bool repCompleted = _engine.processFrame(landmarkMap);

    if (repCompleted) {
      _onRepCompleted();
    }

    // Send feedback if changed
    if (_engine.feedback.isNotEmpty) {
      onFeedback?.call(_engine.feedback);
    }
  }
  
  void _onRepCompleted() {
    final reps = _engine.repCount;
    final score = (_engine.chargeProgress * 100);

    // GAMING: Classify rep quality
    final quality = classifyRep(score);

    // GAMING: Update combo
    if (quality == RepQuality.perfect || quality == RepQuality.good) {
      _currentCombo++;
      if (_currentCombo > _maxCombo) {
        _maxCombo = _currentCombo;
      }
    } else {
      // Combo broken
      if (_currentCombo >= 3) {
        _comboBrokenCount++;
      }
      _currentCombo = 0;
    }

    // GAMING: Track rep stats
    switch (quality) {
      case RepQuality.perfect:
        _perfectReps++;
        break;
      case RepQuality.good:
        _goodReps++;
        break;
      case RepQuality.miss:
        _missedReps++;
        break;
    }

    // GAMING: Store rep data
    _repHistory.add(RepData(
      quality: quality,
      formScore: score,
      angle: (_engine.chargeProgress * 100),
      timestamp: DateTime.now(),
    ));

    // GAMING: Fire callbacks
    onRepQuality?.call(quality, score);
    onComboChange?.call(_currentCombo, _maxCombo);

    // Announce rep
    _voice.announceRep(reps);

    // Callback
    onRepCounted?.call(reps, score);

    // Check if set complete
    if (reps >= _targetReps) {
      _onSetComplete();
    }
  }
  
  void _onSetComplete() {
    // Record actual reps completed for this set
    final actualReps = _engine.repCount ?? 0;
    _completedRepsPerSet.add(actualReps);
    
    // Call callback BEFORE incrementing (so it gets the COMPLETED set number)
    final completedSet = _currentSetIndex + 1; // Convert 0-indexed to 1-indexed
    print('🎯 SET COMPLETE: completedSet=$completedSet, _targetSets=$_targetSets, _currentSetIndex BEFORE=$_currentSetIndex, ACTUAL REPS=$actualReps');
    
    if (_currentSetIndex < _targetSets - 1) {
      // MORE SETS TO GO - Increment and enter rest
      _currentSetIndex++; // Increment ONLY if more sets remain
      print('   _currentSetIndex AFTER increment=$_currentSetIndex');
      print('⏸️ More sets to go. _currentSetIndex=$_currentSetIndex < _targetSets=$_targetSets');
      print('   Setting _isActive=true, _isResting=true');
      _voice.announceSetComplete(completedSet, _targetSets);
      onSetComplete?.call(completedSet, _targetSets);
      _isResting = true;
      _isActive = true; // Still active, just resting
    } else {
      // LAST SET COMPLETE - DON'T INCREMENT, exercise is done
      print('✅ LAST SET DONE! completedSet=$completedSet == _targetSets=$_targetSets');
      print('   NOT incrementing _currentSetIndex (stays at $_currentSetIndex)');
      print('   Setting _isActive=false, _isResting=false');
      _voice.announceSetComplete(completedSet, _targetSets);
      onSetComplete?.call(completedSet, _targetSets);
      _isActive = false;
      _isResting = false; // Not resting, exercise is done
      // _currentSetIndex stays at its current value until next exercise starts
    }
  }
  
  /// Call when rest is complete and ready for next set
  void startNextSet() {
    print('📢 START NEXT SET CALLED: _isResting=$_isResting, _currentSetIndex=$_currentSetIndex, _targetSets=$_targetSets');
    
    if (!_isResting) return;

    _isResting = false;

    // CRITICAL FIX: Reset the pattern state AND force baseline recapture
    // This allows the engine to lock onto the user's current position for the new set
    _engine.reset();  // Resets rep count and pattern state to ready
    _baselineCaptured = false;  // Forces baseline recapture on next frame

    // Reset combo tracking for new set
    _currentCombo = 0;
    _repHistory = [];
    _setStartTime = DateTime.now();

    print('   Starting set ${_currentSetIndex + 1}/${_targetSets}');
    _voice.speakNow('Set ${_currentSetIndex + 1}. Go!');
  }
  
  /// Manually skip to next set (if user wants to end set early)
  void skipToNextSet() {
    // Record actual reps completed before moving to next set
    final actualReps = _engine.repCount ?? 0;
    _completedRepsPerSet.add(actualReps);
    print('⏭️ SKIPPED SET: Completed $actualReps reps (target was $_targetReps)');
    
    // Don't call _onSetComplete as it will duplicate the recording
    // Instead, manually handle the transition
    final completedSet = _currentSetIndex + 1;
    
    if (_currentSetIndex < _targetSets - 1) {
      // MORE SETS TO GO
      _currentSetIndex++;
      _voice.announceSetComplete(completedSet, _targetSets);
      onSetComplete?.call(completedSet, _targetSets);
      _isResting = true;
      _isActive = true;
    } else {
      // LAST SET COMPLETE
      _voice.announceSetComplete(completedSet, _targetSets);
      onSetComplete?.call(completedSet, _targetSets);
      _isActive = false;
      _isResting = false;
    }
  }
  
  /// Reset the current exercise (start over)
  void resetExercise() {
    _engine.reset();
    _baselineCaptured = false;
    _currentSetIndex = 0;
    _isResting = false;
  }
  
  /// Stop the session
  void stop() {
    _isActive = false;
    _isResting = false;
    _engine.reset();
    _currentExerciseId = '';
  }
  
  Future<void> dispose() async {
    await _voice.dispose();
  }
}
