import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../utils/app_colors.dart';
import 'form_checker.dart';
import 'form_rules.dart';
import 'premium_skeleton_painter.dart';
import 'form_hud_widgets.dart';
import 'viral_results_card.dart';
import 'form_check_achievement_service.dart';
import 'achievement_widgets.dart';

enum FormCheckPhase { positioning, countdown, analyzing, capturing }

class FormCheckCameraScreen extends StatefulWidget {
  final String exerciseName;
  const FormCheckCameraScreen({super.key, required this.exerciseName});
  @override
  State<FormCheckCameraScreen> createState() => _FormCheckCameraScreenState();
}

class _FormCheckCameraScreenState extends State<FormCheckCameraScreen> with TickerProviderStateMixin {
  CameraController? _cameraController;
  bool _isCameraReady = false, _isProcessing = false;
  final PoseDetector _poseDetector = PoseDetector(options: PoseDetectorOptions(mode: PoseDetectionMode.stream, model: PoseDetectionModel.accurate));
  Map<PoseLandmarkType, PoseLandmark>? _landmarks;
  Size? _imageSize;
  FormChecker? _formChecker;
  FormCheckResult? _currentResult;
  final FlutterTts _tts = FlutterTts();
  FormCheckPhase _phase = FormCheckPhase.positioning;
  int _countdownValue = 3;
  bool _isPositionValid = false;
  late AnimationController _pulseController, _hudController;
  late Animation<double> _pulseAnimation;
  String? _currentWarning;
  Timer? _warningTimer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.97, end: 1.03).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
    _hudController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _initCamera();
    final rules = FormRules.getRules(widget.exerciseName);
    if (rules != null) _formChecker = FormChecker(rules);
    _tts.setLanguage('en-US'); _tts.setSpeechRate(0.5); _tts.setVolume(1.0);
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      final cam = cameras.firstWhere((c) => c.lensDirection == CameraLensDirection.front, orElse: () => cameras.first);
      _cameraController = CameraController(cam, ResolutionPreset.high, enableAudio: false, imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888);
      await _cameraController!.initialize();
      if (mounted) { setState(() => _isCameraReady = true); _cameraController?.startImageStream(_processImage); }
    } catch (e) { debugPrint('Camera error: $e'); }
  }

  Future<void> _processImage(CameraImage image) async {
    if (_isProcessing || _phase == FormCheckPhase.capturing) return;
    _isProcessing = true;
    try {
      final cam = _cameraController?.description;
      if (cam == null) { _isProcessing = false; return; }
      final rotation = InputImageRotationValue.fromRawValue(cam.sensorOrientation);
      final format = InputImageFormatValue.fromRawValue(image.format.raw);
      if (rotation == null || format == null) { _isProcessing = false; return; }
      final inputImage = InputImage.fromBytes(bytes: image.planes.first.bytes, metadata: InputImageMetadata(size: Size(image.width.toDouble(), image.height.toDouble()), rotation: rotation, format: format, bytesPerRow: image.planes.first.bytesPerRow));
      final poses = await _poseDetector.processImage(inputImage);
      if (poses.isNotEmpty && mounted) {
        final lm = <PoseLandmarkType, PoseLandmark>{};
        for (final l in poses.first.landmarks.values) lm[l.type] = l;
        setState(() { 
          _landmarks = lm; 
          // FIXED: imageSize needs to be (height, width) to match train tab's working skeleton
          _imageSize = Size(image.height.toDouble(), image.width.toDouble()); 
        });
        _checkPosition();
        if (_phase == FormCheckPhase.analyzing && _formChecker != null) {
          final result = _formChecker!.analyzeForm(lm);
          setState(() => _currentResult = result);
          if (result.voiceWarning != null) { _showWarning(result.voiceWarning!); _tts.speak(result.voiceWarning!); }
        }
      }
    } catch (e) { debugPrint('Process error: $e'); }
    _isProcessing = false;
  }

  void _checkPosition() {
    if (_landmarks == null) { setState(() => _isPositionValid = false); return; }
    int valid = 0;
    for (final t in [PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder, PoseLandmarkType.leftHip, PoseLandmarkType.rightHip, PoseLandmarkType.leftKnee, PoseLandmarkType.rightKnee, PoseLandmarkType.leftAnkle, PoseLandmarkType.rightAnkle]) {
      final l = _landmarks![t];
      if (l != null && l.likelihood > 0.6) valid++;
    }
    final isValid = valid >= 6;
    if (isValid != _isPositionValid) { 
      setState(() => _isPositionValid = isValid); 
      if (isValid && _phase == FormCheckPhase.positioning) {
        HapticFeedback.mediumImpact();
        // AUTO-START countdown after 1 second of being in position (no button press needed!)
        Future.delayed(const Duration(seconds: 1), () {
          if (_isPositionValid && _phase == FormCheckPhase.positioning && mounted) {
            _startCountdown();
          }
        });
      }
    }
  }

  void _startCountdown() {
    HapticFeedback.heavyImpact();
    setState(() { _phase = FormCheckPhase.countdown; _countdownValue = 3; });
    _tts.speak('Get ready');
    Timer.periodic(const Duration(seconds: 1), (t) {
      if (_countdownValue > 1) { setState(() => _countdownValue--); HapticFeedback.mediumImpact(); }
      else { t.cancel(); HapticFeedback.heavyImpact(); _tts.speak('Analyzing'); setState(() => _phase = FormCheckPhase.analyzing); _hudController.forward(); _formChecker?.reset(); }
    });
  }

  Future<void> _capture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;
    HapticFeedback.heavyImpact();
    setState(() => _phase = FormCheckPhase.capturing);
    try {
      await _cameraController!.stopImageStream();
      final img = await _cameraController!.takePicture();
      
      // Record session and detect achievements
      final exerciseId = widget.exerciseName.toLowerCase().replaceAll(' ', '_');
      final score = _currentResult?.formScore ?? 100;
      final sessionResult = await FormCheckAchievementService.recordSession(
        exerciseId: exerciseId,
        exerciseName: widget.exerciseName,
        score: score,
        reps: 1,
        perfectReps: score >= 90 ? 1 : 0,
      );
      
      // Show achievement popups for new achievements
      if (sessionResult.newAchievements.isNotEmpty && mounted) {
        AchievementUnlockedPopup.showMultiple(context, sessionResult.newAchievements);
      }
      
      if (mounted) {
        Navigator.push(context, PageRouteBuilder(
          pageBuilder: (c, a, s) => ViralResultsCard(
            capturedImage: File(img.path),
            result: _currentResult ?? FormCheckResult(formScore: 100, faults: [], angles: {}),
            landmarks: _landmarks ?? {},
            imageSize: _imageSize ?? const Size(1080, 1920),
            exerciseName: widget.exerciseName,
            isFrontCamera: true,
          ),
          transitionsBuilder: (c, a, s, ch) => FadeTransition(opacity: a, child: ch),
          transitionDuration: const Duration(milliseconds: 500),
        )).then((_) { _cameraController?.startImageStream(_processImage); setState(() => _phase = FormCheckPhase.analyzing); });
      }
    } catch (e) { debugPrint('Capture error: $e'); _cameraController?.startImageStream(_processImage); setState(() => _phase = FormCheckPhase.analyzing); }
  }

  void _showWarning(String msg) {
    setState(() => _currentWarning = msg);
    _warningTimer?.cancel();
    _warningTimer = Timer(const Duration(seconds: 3), () { if (mounted) setState(() => _currentWarning = null); });
  }

  @override
  void dispose() { _cameraController?.dispose(); _poseDetector.close(); _tts.stop(); _pulseController.dispose(); _hudController.dispose(); _warningTimer?.cancel(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final score = _currentResult?.formScore ?? 100;
    final color = score >= 90 ? const Color(0xFFCCFF00) : score >= 70 ? AppColors.cyberLime : score >= 50 ? const Color(0xFFFFB800) : const Color(0xFFFF003C);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Stack(
        children: [
          if (_isCameraReady) Positioned.fill(child: ClipRect(child: OverflowBox(alignment: Alignment.center, child: FittedBox(fit: BoxFit.cover, child: SizedBox(width: _cameraController!.value.previewSize!.height, height: _cameraController!.value.previewSize!.width, child: CameraPreview(_cameraController!)))))),
          if (_landmarks != null && _imageSize != null && _phase != FormCheckPhase.positioning) Positioned.fill(child: CustomPaint(painter: PremiumSkeletonPainter(landmarks: _landmarks!, imageSize: _imageSize!, isFrontCamera: true, formScore: score, faults: _currentResult?.faults ?? [], showAngles: _phase == FormCheckPhase.analyzing))),
          if (_phase == FormCheckPhase.positioning) Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(animation: _pulseAnimation, builder: (c, ch) => Transform.scale(scale: _pulseAnimation.value, child: Container(width: 200, height: 300, decoration: BoxDecoration(border: Border.all(color: _isPositionValid ? AppColors.cyberLime : Colors.white.withOpacity(0.5), width: 3), borderRadius: BorderRadius.circular(20)), child: CustomPaint(painter: _SilhouettePainter(color: _isPositionValid ? AppColors.cyberLime : Colors.white.withOpacity(0.5)))))),
                  const SizedBox(height: 40),
                  Text(_isPositionValid ? 'PERFECT POSITION!' : 'POSITION YOURSELF', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: _isPositionValid ? AppColors.cyberLime : Colors.white, letterSpacing: 2)),
                  const SizedBox(height: 12),
                  Text('Stand sideways • Full body in frame', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.7))),
                  const SizedBox(height: 40),
                  // AUTO-START: No button needed! Countdown starts automatically after 1 second
                  if (_isPositionValid) 
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.cyberLime.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.cyberLime, width: 2),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(AppColors.cyberLime),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'STARTING IN 1 SECOND...',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.cyberLime,
                                  letterSpacing: 1,
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
          if (_phase == FormCheckPhase.countdown) Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.7),
              child: Center(
                child: TweenAnimationBuilder<double>(key: ValueKey(_countdownValue), tween: Tween(begin: 2.0, end: 1.0), duration: const Duration(milliseconds: 400), curve: Curves.elasticOut, builder: (c, scale, ch) {
                  final col = _countdownValue == 3 ? const Color(0xFFCCFF00) : _countdownValue == 2 ? const Color(0xFFFFB800) : AppColors.cyberLime;
                  return Transform.scale(scale: scale, child: Column(mainAxisSize: MainAxisSize.min, children: [Container(width: 150, height: 150, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: col, width: 4), boxShadow: [BoxShadow(color: col.withOpacity(0.5), blurRadius: 30)]), child: Center(child: Text('$_countdownValue', style: TextStyle(fontSize: 80, fontWeight: FontWeight.w900, color: col)))), const SizedBox(height: 30), Text('GET READY...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.7), letterSpacing: 3))]));
                }),
              ),
            ),
          ),
          if (_phase == FormCheckPhase.analyzing) FadeTransition(opacity: _hudController, child: Stack(children: [Positioned(top: 100, left: 16, child: FormScoreHUD(score: score)), if (_currentResult != null && _currentResult!.angles.isNotEmpty) Positioned(bottom: 140, left: 16, child: FormAnglesHUD(angles: _currentResult!.angles))])),
          Positioned(top: 0, left: 0, right: 0, child: Container(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 16, right: 16, bottom: 10), decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black.withOpacity(0.7), Colors.transparent])), child: Row(children: [GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.arrow_back, color: Colors.white, size: 22))), const SizedBox(width: 16), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.exerciseName.toUpperCase(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.cyberLime, letterSpacing: 1)), Text(_phase == FormCheckPhase.positioning ? 'GET IN POSITION' : _phase == FormCheckPhase.countdown ? 'STARTING...' : _phase == FormCheckPhase.analyzing ? 'ANALYZING FORM' : 'CAPTURING...', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.6)))])), Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.flip_camera_ios, color: Colors.white, size: 22))]))),
          Positioned(bottom: 0, left: 0, right: 0, child: Container(padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 20, top: 20, left: 30, right: 30), decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: [Colors.black.withOpacity(0.8), Colors.transparent])), child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [GestureDetector(onTap: () => Navigator.pop(context), child: Column(mainAxisSize: MainAxisSize.min, children: [Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle), child: const Icon(Icons.close, color: Colors.white, size: 24)), const SizedBox(height: 6), const Text('END', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white70))])), if (_phase == FormCheckPhase.analyzing) GestureDetector(onTap: _capture, child: Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: color, width: 4), boxShadow: [BoxShadow(color: color.withOpacity(0.5), blurRadius: 20)]), child: Container(margin: const EdgeInsets.all(8), decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(0.3)), child: Icon(Icons.camera_alt, color: color, size: 32)))) else const SizedBox(width: 80), GestureDetector(onTap: () {}, child: Column(mainAxisSize: MainAxisSize.min, children: [Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle), child: const Icon(Icons.info_outline, color: Colors.white, size: 24)), const SizedBox(height: 6), const Text('TIPS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white70))]))]))),
          if (_currentWarning != null) Positioned(bottom: 200, left: 20, right: 20, child: TweenAnimationBuilder<double>(tween: Tween(begin: 0, end: 1), duration: const Duration(milliseconds: 300), curve: Curves.easeOut, builder: (c, v, ch) { final fault = _currentResult?.faults.firstOrNull; final col = fault?.severity == FaultSeverity.critical ? const Color(0xFFFF003C) : const Color(0xFFFFB800); return Transform.translate(offset: Offset(0, 20 * (1 - v)), child: Opacity(opacity: v, child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF1A1F35), borderRadius: BorderRadius.circular(16), border: Border(left: BorderSide(color: col, width: 4)), boxShadow: [BoxShadow(color: col.withOpacity(0.3), blurRadius: 20)]), child: Row(children: [Icon(Icons.warning_amber, color: col, size: 28), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [Text(_currentWarning!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white)), if (fault?.correction != null) Text(fault!.correction!, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)))]))]))));})),
        ],
      ),
    );
  }
}

class _SilhouettePainter extends CustomPainter {
  final Color color;
  _SilhouettePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2..strokeCap = StrokeCap.round;
    final cx = size.width / 2;
    canvas.drawCircle(Offset(cx, size.height * 0.12), 25, paint);
    canvas.drawLine(Offset(cx, size.height * 0.17), Offset(cx, size.height * 0.22), paint);
    canvas.drawLine(Offset(cx - 40, size.height * 0.22), Offset(cx + 40, size.height * 0.22), paint);
    canvas.drawLine(Offset(cx, size.height * 0.22), Offset(cx, size.height * 0.55), paint);
    canvas.drawLine(Offset(cx - 40, size.height * 0.22), Offset(cx - 50, size.height * 0.40), paint);
    canvas.drawLine(Offset(cx - 50, size.height * 0.40), Offset(cx - 45, size.height * 0.55), paint);
    canvas.drawLine(Offset(cx + 40, size.height * 0.22), Offset(cx + 50, size.height * 0.40), paint);
    canvas.drawLine(Offset(cx + 50, size.height * 0.40), Offset(cx + 45, size.height * 0.55), paint);
    canvas.drawLine(Offset(cx - 30, size.height * 0.55), Offset(cx + 30, size.height * 0.55), paint);
    canvas.drawLine(Offset(cx - 30, size.height * 0.55), Offset(cx - 35, size.height * 0.75), paint);
    canvas.drawLine(Offset(cx - 35, size.height * 0.75), Offset(cx - 30, size.height * 0.95), paint);
    canvas.drawLine(Offset(cx + 30, size.height * 0.55), Offset(cx + 35, size.height * 0.75), paint);
    canvas.drawLine(Offset(cx + 35, size.height * 0.75), Offset(cx + 30, size.height * 0.95), paint);
  }
  @override
  bool shouldRepaint(_SilhouettePainter old) => old.color != color;
}

