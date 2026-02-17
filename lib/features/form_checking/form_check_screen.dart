import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share_plus/share_plus.dart';
import '../../utils/app_colors.dart';
import '../../widgets/glassmorphism_card.dart';
import '../../widgets/glow_button.dart';
import 'form_checker.dart';
import 'form_rules.dart';
import 'form_skeleton_painter.dart';
import 'movement_phase_detector.dart';
import 'viral_results_card.dart';
import 'form_check_achievement_service.dart';
import 'achievement_widgets.dart';

/// =============================================================================
/// FORM CHECK SCREEN - The Viral Feature
/// =============================================================================
/// Real-time form analysis with:
/// - Color-coded skeleton overlay (Red/Yellow/Green)
/// - Voice coaching ("FLAT BACK!", "Perfect form!")
/// - Live form score (0-100%)
/// - "Strike a Pose" photo capture with analytics overlay
/// - Shareable results for social media
/// =============================================================================

class FormCheckScreen extends StatefulWidget {
  final String exerciseName;
  
  const FormCheckScreen({
    super.key,
    required this.exerciseName,
  });

  @override
  State<FormCheckScreen> createState() => _FormCheckScreenState();
}

class _FormCheckScreenState extends State<FormCheckScreen> {
  // Camera
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  
  // Pose Detection
  final PoseDetector _poseDetector = PoseDetector(
    options: PoseDetectorOptions(
      mode: PoseDetectionMode.stream,
      model: PoseDetectionModel.accurate,
    ),
  );
  
  // Form Checking
  FormChecker? _formChecker;
  MovementPhaseDetector? _phaseDetector;
  FormCheckResult? _currentResult;
  Map<PoseLandmarkType, PoseLandmark>? _currentLandmarks;
  Size? _imageSize;
  MovementPhase _currentPhase = MovementPhase.setup;
  int _repCount = 0;
  
  // EMA Smoothing for stable skeleton
  Map<PoseLandmarkType, _SmoothedLandmark>? _smoothedLandmarks;
  static const double _smoothingAlpha = 0.3; // 0.2-0.4 works well, lower = smoother but laggier
  
  // Voice Coaching
  final FlutterTts _tts = FlutterTts();
  String? _lastSpokenWarning;
  DateTime? _lastSpeakTime;
  
  // UI State
  bool _isAnalyzing = false;
  bool _showInstructions = true;
  
  // "Strike a Pose" - Analytics Capture
  bool _capturingPose = false;
  File? _capturedImage;
  FormCheckResult? _capturedResult;
  
  // Cumulative stats
  int _totalReps = 0;
  int _goodFormReps = 0;
  double _averageFormScore = 0;
  final List<double> _formScores = [];
  
  // Per-rep tracking (P3)
  final List<RepFormData> _repDataHistory = [];
  List<int> _currentRepFrameScores = [];
  List<FormFault> _currentRepFaults = [];
  double? _currentRepBottomAngle;
  int _currentRepNumber = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _initializeTTS();
    _initializeFormChecker();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _poseDetector.close();
    _tts.stop();
    super.dispose();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras == null || _cameras!.isEmpty) return;

    // Use front camera for form checking (selfie view)
    final camera = _cameras!.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
      orElse: () => _cameras!.first,
    );

    _cameraController = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.nv21,
    );

    await _cameraController!.initialize();
    
    if (!mounted) return;
    
    setState(() {
      _isCameraInitialized = true;
    });

    // Start pose detection stream
    _cameraController!.startImageStream(_processCameraImage);
  }

  Future<void> _initializeTTS() async {
    await _tts.setLanguage("en-US");
    await _tts.setSpeechRate(0.5); // Slightly slower for clarity
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  void _initializeFormChecker() {
    final rules = FormRules.getRules(widget.exerciseName);
    if (rules != null) {
      _formChecker = FormChecker(rules);
      _phaseDetector = MovementPhaseDetector(widget.exerciseName);
    }
  }

  /// Process each camera frame for pose detection
  Future<void> _processCameraImage(CameraImage image) async {
    if (_isAnalyzing || _formChecker == null) return;
    
    _isAnalyzing = true;

    try {
      // Convert camera image to InputImage for MLKit
      final inputImage = _convertToInputImage(image);
      if (inputImage == null) {
        _isAnalyzing = false;
        return;
      }

      // Detect pose
      final poses = await _poseDetector.processImage(inputImage);
      
      if (poses.isNotEmpty && mounted) {
        final pose = poses.first;
        // pose.landmarks is already a Map<PoseLandmarkType, PoseLandmark>
        final rawLandmarks = pose.landmarks;
        final landmarks = _applySmoothingToLandmarks(rawLandmarks);
        
        // Detect movement phase
        PhaseDetectionResult? phaseResult;
        if (_phaseDetector != null) {
          phaseResult = _phaseDetector!.detectPhase(landmarks);
          _currentPhase = phaseResult.phase;
          _repCount = phaseResult.repCount;
        }
        
        // Analyze form
        final result = _formChecker!.analyzeForm(landmarks);
        
        setState(() {
          _currentResult = result;
          _currentLandmarks = landmarks;
          _imageSize = Size(image.width.toDouble(), image.height.toDouble());
        });
        
        // Track per-rep data (P3)
        if (result.formScore < 100) {
          _currentRepFrameScores.add(result.formScore);
          _currentRepFaults.addAll(result.faults);
        }
        
        // Track bottom position angle for depth feedback (P3)
        if (phaseResult != null && phaseResult.phase == MovementPhase.bottom) {
          _currentRepBottomAngle = phaseResult.primaryAngle;
        }
        
        // Handle new rep completion (P3 + P5)
        if (phaseResult != null && phaseResult.isNewRep) {
          _finalizeRep(phaseResult.primaryAngle);
        }
        
        // Voice feedback
        if (result.voiceWarning != null) {
          _speakWarning(result.voiceWarning!);
        }
        
        // Track stats
        _formScores.add(result.formScore.toDouble());
        if (_formScores.length > 100) _formScores.removeAt(0); // Keep last 100
        _averageFormScore = _formScores.reduce((a, b) => a + b) / _formScores.length;
      }
    } catch (e) {
      debugPrint('Error processing image: $e');
    }

    _isAnalyzing = false;
  }

  /// Speak warning (with throttle to avoid spam)
  void _speakWarning(String warning) {
    final now = DateTime.now();
    
    // Don't repeat same warning within 2 seconds
    if (_lastSpokenWarning == warning && 
        _lastSpeakTime != null && 
        now.difference(_lastSpeakTime!).inSeconds < 2) {
      return;
    }
    
    _tts.speak(warning);
    _lastSpokenWarning = warning;
    _lastSpeakTime = now;
  }

  /// Called when a rep is completed (P3 + P5)
  void _finalizeRep(double? bottomAngle) {
    if (_currentRepFrameScores.isEmpty) return;
    
    _currentRepNumber++;
    
    final repData = RepFormData(
      repNumber: _currentRepNumber,
      frameScores: List.from(_currentRepFrameScores),
      faults: List.from(_currentRepFaults),
      bottomAngle: bottomAngle ?? _currentRepBottomAngle,
    );
    
    _repDataHistory.add(repData);
    
    // Reset for next rep
    _currentRepFrameScores.clear();
    _currentRepFaults.clear();
    _currentRepBottomAngle = null;
    
    // Haptic + voice feedback based on quality (P5)
    final score = repData.averageScore;
    if (score >= 90) {
      HapticFeedback.heavyImpact();
      _tts.speak('Rep $_currentRepNumber. Perfect!');
    } else if (score >= 75) {
      HapticFeedback.mediumImpact();
      _tts.speak('Rep $_currentRepNumber. Good.');
    } else {
      HapticFeedback.lightImpact();
      _tts.speak('Rep $_currentRepNumber. ${repData.worstFault?.message ?? "Check form."}');
    }
    
    setState(() {});
  }

  /// Apply EMA smoothing to landmarks for stable skeleton rendering
  Map<PoseLandmarkType, PoseLandmark> _applySmoothingToLandmarks(
    Map<PoseLandmarkType, PoseLandmark> rawLandmarks,
  ) {
    // Initialize smoothed landmarks on first frame
    if (_smoothedLandmarks == null) {
      _smoothedLandmarks = {};
      for (final entry in rawLandmarks.entries) {
        _smoothedLandmarks![entry.key] = _SmoothedLandmark(
          x: entry.value.x,
          y: entry.value.y,
          z: entry.value.z,
          likelihood: entry.value.likelihood,
        );
      }
      return rawLandmarks;
    }
    
    // Apply EMA: smoothed = alpha * new + (1 - alpha) * old
    final result = <PoseLandmarkType, PoseLandmark>{};
    
    for (final entry in rawLandmarks.entries) {
      final type = entry.key;
      final raw = entry.value;
      final smoothed = _smoothedLandmarks![type];
      
      if (smoothed != null) {
        // Only smooth if confidence is high enough
        if (raw.likelihood > 0.5) {
          smoothed.x = _smoothingAlpha * raw.x + (1 - _smoothingAlpha) * smoothed.x;
          smoothed.y = _smoothingAlpha * raw.y + (1 - _smoothingAlpha) * smoothed.y;
          smoothed.z = _smoothingAlpha * raw.z + (1 - _smoothingAlpha) * smoothed.z;
          smoothed.likelihood = raw.likelihood;
        }
        // If low confidence, keep previous position (reduces jumpiness)
        
        result[type] = smoothed.toPoseLandmark(type);
      } else {
        // New landmark we haven't seen before
        _smoothedLandmarks![type] = _SmoothedLandmark(
          x: raw.x,
          y: raw.y,
          z: raw.z,
          likelihood: raw.likelihood,
        );
        result[type] = raw;
      }
    }
    
    return result;
  }

  /// Convert CameraImage to InputImage for MLKit
  InputImage? _convertToInputImage(CameraImage image) {
    if (_cameraController == null) return null;

    final camera = _cameraController!.description;
    final rotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (rotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(image.format.raw);
    if (format == null) return null;

    final plane = image.planes.first;
    
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  /// "STRIKE A POSE" - Capture current frame with analytics overlay
  Future<void> _strikeAPose() async {
    if (_cameraController == null || _currentResult == null) return;
    
    setState(() {
      _capturingPose = true;
    });
    
    HapticFeedback.heavyImpact();
    
    // Speak dramatic cue
    await _tts.speak("Strike a pose!");
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      // Capture photo
      final image = await _cameraController!.takePicture();
      
      setState(() {
        _capturedImage = File(image.path);
        _capturedResult = _currentResult;
        _capturingPose = false;
      });
      
      // Show results screen
      _showCaptureResults();
      
    } catch (e) {
      debugPrint('Error capturing image: $e');
      setState(() {
        _capturingPose = false;
      });
    }
  }

  /// Show captured pose with analytics overlay
  void _showCaptureResults() async {
    if (_capturedImage == null || _capturedResult == null || _currentLandmarks == null) {
      return;
    }
    
    // Calculate session stats for achievement tracking
    final repScores = _repDataHistory.map((rep) => rep.averageScore).toList();
    final totalReps = repScores.length;
    final perfectReps = repScores.where((score) => score >= 90).length;
    final avgScore = repScores.isEmpty ? _capturedResult!.formScore : (repScores.reduce((a, b) => a + b) / repScores.length).round();
    
    // Record session and detect achievements
    final exerciseId = widget.exerciseName.toLowerCase().replaceAll(' ', '_');
    final sessionResult = await FormCheckAchievementService.recordSession(
      exerciseId: exerciseId,
      exerciseName: widget.exerciseName,
      score: avgScore,
      reps: totalReps > 0 ? totalReps : 1,
      perfectReps: perfectReps,
    );
    
    // Show achievement popups for new achievements
    if (sessionResult.newAchievements.isNotEmpty && mounted) {
      AchievementUnlockedPopup.showMultiple(context, sessionResult.newAchievements);
    }
    
    // Navigate to results card
    if (mounted) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ViralResultsCard(
            capturedImage: _capturedImage!,
            result: _capturedResult!,
            landmarks: _currentLandmarks!,
            imageSize: _imageSize!,
            exerciseName: widget.exerciseName,
            isFrontCamera: true,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27), // Dark background
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview with Skeleton Overlay
            if (_isCameraInitialized) _buildCameraPreview(),
            
            // Top Bar
            _buildTopBar(),
            
            // Instructions Overlay (dismissible)
            if (_showInstructions) _buildInstructions(),
            
            // Live Form Score HUD
            if (!_showInstructions && _currentResult != null) _buildFormScoreHUD(),
            
            // Rep History Bar (NEW!)
            if (!_showInstructions && _repDataHistory.isNotEmpty) _buildRepHistoryBar(),
            
            // Bottom Controls
            _buildBottomControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    return Positioned.fill(
      child: Stack(
        children: [
          // Camera
          CameraPreview(_cameraController!),
          
          // Skeleton Overlay with Color-Coded Form
          if (_currentLandmarks != null && _imageSize != null)
            CustomPaint(
              painter: FormSkeletonPainter(
                landmarks: _currentLandmarks!,
                imageSize: _imageSize!,
                isFrontCamera: true,
                formScore: _currentResult?.formScore ?? 100,
                faults: _currentResult?.faults ?? [],
              ),
              child: Container(),
            ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          children: [
            // Back Button
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white10,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            
            // Exercise Name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.exerciseName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: AppColors.cyberLime,
                    ),
                  ),
                  const Text(
                    'FORM CHECK',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.white60,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Positioned.fill(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showInstructions = false;
          });
          HapticFeedback.lightImpact();
        },
        child: Container(
          color: Colors.black.withOpacity(0.85),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: GlassmorphismCard(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.camera_front,
                      size: 64,
                      color: AppColors.cyberLime,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'FORM CHECK MODE',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '1. Stand sideways to camera\n'
                      '2. Perform the exercise\n'
                      '3. Listen to real-time coaching\n'
                      '4. Press "Strike a Pose" to capture',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.white70,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    GlowButton(
                      text: 'START',
                      onPressed: () {
                        setState(() {
                          _showInstructions = false;
                        });
                        HapticFeedback.mediumImpact();
                      },
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormScoreHUD() {
    final score = _currentResult!.formScore;
    final color = _getFormScoreColor(score);
    
    return Positioned(
      top: 120,
      right: 20,
      child: GlassmorphismCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // REP COUNT (NEW!)
            if (_repCount > 0) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.cyberLime.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cyberLime, width: 2),
                ),
                child: Text(
                  'REP $_repCount',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppColors.cyberLime,
                    letterSpacing: 1,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
            
            // MOVEMENT PHASE (NEW!)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _currentPhase.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Form Score Circle
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color,
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$score',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: color,
                      ),
                    ),
                    Text(
                      'FORM',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: color.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Current Faults
            if (_currentResult!.faults.isNotEmpty) ...[
              const SizedBox(height: 12),
              ..._currentResult!.faults.take(3).map((fault) => Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  fault.message,
                  style: TextStyle(
                    fontSize: 10,
                    color: _getFaultColor(fault.severity),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRepHistoryBar() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 120,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.white10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'REPS: ${_repDataHistory.length}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  'AVG: ${_calculateOverallAverage()}%',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: AppColors.cyberLime,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: _repDataHistory.map((rep) {
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 32,
                    decoration: BoxDecoration(
                      color: rep.qualityColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: rep.qualityColor, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '${rep.averageScore}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          color: rep.qualityColor,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  int _calculateOverallAverage() {
    if (_repDataHistory.isEmpty) return 100;
    final total = _repDataHistory.fold<int>(0, (sum, rep) => sum + rep.averageScore);
    return (total / _repDataHistory.length).round();
  }

  Widget _buildBottomControls() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Stats Button
            _buildControlButton(
              icon: Icons.analytics,
              label: 'STATS',
              onTap: _showStats,
            ),
            
            // STRIKE A POSE Button (center, large)
            GestureDetector(
              onTap: _capturingPose ? null : _strikeAPose,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _capturingPose 
                      ? AppColors.white20 
                      : AppColors.cyberLime,
                  boxShadow: _capturingPose ? null : [
                    BoxShadow(
                      color: AppColors.cyberLime.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: _capturingPose
                      ? const CircularProgressIndicator(
                          color: AppColors.cyberLime,
                        )
                      : const Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.black,
                        ),
                ),
              ),
            ),
            
            // Share Button
            _buildControlButton(
              icon: Icons.share,
              label: 'SHARE',
              onTap: () {
                // TODO: Share last captured pose
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white10,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.white20,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaptureResultsSheet() {
    if (_capturedImage == null || _capturedResult == null) {
      return const SizedBox();
    }
    
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Color(0xFF0A0E27), // Dark background
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.white20,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'FORM ANALYSIS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
          ),
          
          // Captured Image with Skeleton Overlay
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Image
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _getFormScoreColor(_capturedResult!.formScore),
                        width: 3,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(13),
                      child: Image.file(_capturedImage!),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Form Score
                  _buildScoreCard(),
                  
                  const SizedBox(height: 16),
                  
                  // Fault Breakdown
                  if (_capturedResult!.faults.isNotEmpty)
                    _buildFaultsList(),
                  
                  const SizedBox(height: 16),
                  
                  // Angle Details (for nerds)
                  _buildAngleDetails(),
                  
                  const SizedBox(height: 24),
                  
                  // Share Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GlowButton(
                      text: 'SHARE TO SOCIAL',
                      onPressed: () {
                        // Share functionality can be implemented here
                        debugPrint('Share button pressed');
                      },
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard() {
    final score = _capturedResult!.formScore;
    final color = _getFormScoreColor(score);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          // Score Circle
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.2),
              border: Border.all(color: color, width: 3),
            ),
            child: Center(
              child: Text(
                '$score',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 20),
          
          // Label
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getFormScoreLabel(score),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getFormScoreFeedback(score),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.white60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaultsList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FORM FAULTS DETECTED',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.white70,
            ),
          ),
          const SizedBox(height: 12),
          ..._capturedResult!.faults.map((fault) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getFaultColor(fault.severity),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    fault.message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  fault.severity.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: _getFaultColor(fault.severity),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAngleDetails() {
    if (_capturedResult!.angles.isEmpty) return const SizedBox();
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.show_chart, color: AppColors.white70, size: 18),
              SizedBox(width: 8),
              Text(
                'ANGLE MEASUREMENTS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppColors.white70,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._capturedResult!.angles.entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry.key.replaceAll('_', ' ').toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.white60,
                  ),
                ),
                Text(
                  '${entry.value.toStringAsFixed(1)}°',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.cyberLime,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  void _showStats() {
    // TODO: Show cumulative stats modal
  }

  Color _getFormScoreColor(int score) {
    if (score >= 90) return const Color(0xFF00FF66); // Green
    if (score >= 70) return const Color(0xFFFFDD00); // Yellow
    if (score >= 50) return const Color(0xFFFF9500); // Orange
    return const Color(0xFFFF003C); // Red
  }

  String _getFormScoreLabel(int score) {
    if (score >= 90) return 'PERFECT FORM';
    if (score >= 70) return 'GOOD FORM';
    if (score >= 50) return 'FORM BREAKDOWN';
    return 'DANGEROUS';
  }

  String _getFormScoreFeedback(int score) {
    if (score >= 90) return 'Keep it up! Textbook execution.';
    if (score >= 70) return 'Minor issues. Check the faults below.';
    if (score >= 50) return 'Form is breaking down. Fix these issues.';
    return 'Stop! Fix your form before injury occurs.';
  }

  Color _getFaultColor(FaultSeverity severity) {
    switch (severity) {
      case FaultSeverity.critical:
        return const Color(0xFFFF003C);
      case FaultSeverity.high:
        return const Color(0xFFFF9500);
      case FaultSeverity.medium:
        return const Color(0xFFFFDD00);
      case FaultSeverity.low:
        return const Color(0xFFCCFF00);
    }
  }
}

/// Stores form data for a single rep
class RepFormData {
  final int repNumber;
  final List<int> frameScores;
  final List<FormFault> faults;
  final double? bottomAngle;
  final DateTime timestamp;
  
  RepFormData({
    required this.repNumber,
    required this.frameScores,
    required this.faults,
    this.bottomAngle,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
  
  /// Average form score for this rep
  int get averageScore {
    if (frameScores.isEmpty) return 100;
    return (frameScores.reduce((a, b) => a + b) / frameScores.length).round();
  }
  
  /// Worst score during this rep
  int get worstScore {
    if (frameScores.isEmpty) return 100;
    return frameScores.reduce((a, b) => a < b ? a : b);
  }
  
  /// Most severe fault during this rep
  FormFault? get worstFault {
    if (faults.isEmpty) return null;
    final sortedFaults = List<FormFault>.from(faults);
    sortedFaults.sort((a, b) => a.severity.index.compareTo(b.severity.index));
    return sortedFaults.first;
  }
  
  /// Quality rating
  String get qualityLabel {
    final score = averageScore;
    if (score >= 90) return 'PERFECT';
    if (score >= 75) return 'GOOD';
    if (score >= 60) return 'OKAY';
    return 'POOR';
  }
  
  Color get qualityColor {
    final score = averageScore;
    if (score >= 90) return const Color(0xFF00FF66);
    if (score >= 75) return const Color(0xFFFFDD00);
    if (score >= 60) return const Color(0xFFFF9500);
    return const Color(0xFFFF003C);
  }
}

/// Smoothed landmark point using EMA
class _SmoothedLandmark {
  double x;
  double y;
  double z;
  double likelihood;
  
  _SmoothedLandmark({
    required this.x,
    required this.y,
    required this.z,
    required this.likelihood,
  });
  
  /// Convert back to a format compatible with PoseLandmark for the painter
  PoseLandmark toPoseLandmark(PoseLandmarkType type) {
    return PoseLandmark(
      type: type,
      x: x,
      y: y,
      z: z,
      likelihood: likelihood,
    );
  }
}

