import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'form_skeleton_painter.dart';
import 'form_checker.dart';

/// =============================================================================
/// VIRAL RESULTS CARD - Instagram-Ready Shareable Form Analysis
/// =============================================================================
/// Creates a beautiful, animated results screen with stats BURNED INTO the image.
/// When shared, everything is captured as one stunning image.
///
/// Features:
/// - Full image with skeleton overlay
/// - Animated score reveal (counts up)
/// - Gaming-style tier grade (S/A/B/C/D)
/// - Stats in corners
/// - One-tap share
/// =============================================================================

class ViralResultsCard extends StatefulWidget {
  final File capturedImage;
  final FormCheckResult result;
  final Map<PoseLandmarkType, PoseLandmark> landmarks;
  final Size imageSize;
  final String exerciseName;
  final bool isFrontCamera;

  const ViralResultsCard({
    super.key,
    required this.capturedImage,
    required this.result,
    required this.landmarks,
    required this.imageSize,
    required this.exerciseName,
    this.isFrontCamera = true,
  });

  @override
  State<ViralResultsCard> createState() => _ViralResultsCardState();
}

class _ViralResultsCardState extends State<ViralResultsCard>
    with TickerProviderStateMixin {
  
  final GlobalKey _captureKey = GlobalKey();
  
  // Animation controllers
  late AnimationController _scoreController;
  late AnimationController _gradeController;
  late AnimationController _statsController;
  late AnimationController _pulseController;
  
  // Animations
  late Animation<double> _scoreAnimation;
  late Animation<double> _gradeScale;
  late Animation<double> _gradeOpacity;
  late Animation<double> _statsOpacity;
  late Animation<double> _pulseAnimation;
  
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startAnimationSequence();
  }

  void _initAnimations() {
    // Score counter (0 to actual score)
    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _scoreAnimation = Tween<double>(
      begin: 0,
      end: widget.result.formScore.toDouble(),
    ).animate(CurvedAnimation(
      parent: _scoreController,
      curve: Curves.easeOutCubic,
    ));

    // Grade drop-in
    _gradeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _gradeScale = Tween<double>(begin: 3.0, end: 1.0).animate(
      CurvedAnimation(parent: _gradeController, curve: Curves.elasticOut),
    );
    _gradeOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _gradeController, curve: Curves.easeIn),
    );

    // Stats fade in
    _statsController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _statsOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _statsController, curve: Curves.easeOut),
    );

    // Pulse effect for grade
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _startAnimationSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _scoreController.forward();
    
    await Future.delayed(const Duration(milliseconds: 800));
    _gradeController.forward();
    HapticFeedback.heavyImpact();
    
    await Future.delayed(const Duration(milliseconds: 400));
    _statsController.forward();
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _gradeController.dispose();
    _statsController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  /// Get letter grade from score
  String _getGrade(int score) {
    if (score >= 95) return 'S';
    if (score >= 85) return 'A';
    if (score >= 70) return 'B';
    if (score >= 50) return 'C';
    return 'D';
  }

  /// Get grade color
  Color _getGradeColor(int score) {
    if (score >= 95) return const Color(0xFFFFD700); // Gold for S
    if (score >= 85) return const Color(0xFF00FF66); // Green for A
    if (score >= 70) return const Color(0xFFCCFF00); // Cyan for B
    if (score >= 50) return const Color(0xFFFF9500); // Orange for C
    return const Color(0xFFFF003C); // Red for D
  }

  /// Get grade subtitle
  String _getGradeSubtitle(int score) {
    if (score >= 95) return 'PERFECT';
    if (score >= 85) return 'EXCELLENT';
    if (score >= 70) return 'GOOD';
    if (score >= 50) return 'NEEDS WORK';
    return 'POOR';
  }

  /// Capture and share the results
  Future<void> _shareResults() async {
    if (_isSharing) return;
    
    setState(() => _isSharing = true);
    HapticFeedback.mediumImpact();

    try {
      // Capture the widget as image
      final boundary = _captureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();

      // Save to temp file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/fitnessos_form_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(bytes);

      // Share
      await Share.shareXFiles(
        [XFile(file.path)],
        text: '${widget.exerciseName} Form Check\n'
              'Score: ${widget.result.formScore}% (${_getGrade(widget.result.formScore)}-Tier)\n\n'
              '#FitnessOS #FormCheck #SkeletonMode',
      );
    } catch (e) {
      debugPrint('Error sharing: $e');
    } finally {
      setState(() => _isSharing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Main card (capturable area)
            Expanded(
              child: RepaintBoundary(
                key: _captureKey,
                child: _buildResultCard(),
              ),
            ),
            
            // Bottom buttons (not captured)
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    final score = widget.result.formScore;
    final gradeColor = _getGradeColor(score);

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: gradeColor.withOpacity(0.5), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // === LAYER 1: Captured Image ===
            Image.file(
              widget.capturedImage,
              fit: BoxFit.cover,
            ),

            // === LAYER 2: Dark gradient overlays for text readability ===
            _buildGradientOverlays(),

            // === LAYER 3: Skeleton Overlay ===
            CustomPaint(
              painter: FormSkeletonPainter(
                landmarks: widget.landmarks,
                imageSize: widget.imageSize,
                isFrontCamera: widget.isFrontCamera,
                formScore: score,
                faults: widget.result.faults,
              ),
            ),

            // === LAYER 4: Stats Overlay ===
            _buildStatsOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientOverlays() {
    return Stack(
      children: [
        // Top gradient (for header)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 150,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Bottom gradient (for stats)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.9),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsOverlay() {
    final score = widget.result.formScore;
    final gradeColor = _getGradeColor(score);

    return Stack(
      children: [
        // === TOP LEFT: Exercise Name + Branding ===
        Positioned(
          top: 20,
          left: 20,
          child: FadeTransition(
            opacity: _statsOpacity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo/Brand
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCDFF00),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'FITNESSOS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white30),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'FORM CHECK',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: Colors.white70,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Exercise name
                Text(
                  widget.exerciseName.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1,
                    shadows: [
                      Shadow(color: Colors.black, blurRadius: 10),
                      Shadow(color: Colors.black, blurRadius: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // === TOP RIGHT: Score + Grade Badge ===
        Positioned(
          top: 20,
          right: 20,
          child: _buildGradeBadge(),
        ),

        // === BOTTOM LEFT: Angle Stats ===
        Positioned(
          bottom: 20,
          left: 20,
          child: FadeTransition(
            opacity: _statsOpacity,
            child: _buildAngleStats(),
          ),
        ),

        // === BOTTOM RIGHT: Faults ===
        Positioned(
          bottom: 20,
          right: 20,
          child: FadeTransition(
            opacity: _statsOpacity,
            child: _buildFaultsList(),
          ),
        ),
      ],
    );
  }

  Widget _buildGradeBadge() {
    final score = widget.result.formScore;
    final grade = _getGrade(score);
    final gradeColor = _getGradeColor(score);
    final subtitle = _getGradeSubtitle(score);

    return AnimatedBuilder(
      animation: Listenable.merge([_scoreController, _gradeController, _pulseController]),
      builder: (context, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Score number
            Text(
              '${_scoreAnimation.value.toInt()}',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: gradeColor,
                height: 1,
                shadows: [
                  Shadow(color: gradeColor.withOpacity(0.5), blurRadius: 20),
                  const Shadow(color: Colors.black, blurRadius: 10),
                ],
              ),
            ),
            
            // Grade letter
            Transform.scale(
              scale: _gradeScale.value * _pulseAnimation.value,
              child: Opacity(
                opacity: _gradeOpacity.value,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: gradeColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: gradeColor.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        grade,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: grade == 'S' ? Colors.black : Colors.white,
                          height: 1,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w700,
                          color: grade == 'S' ? Colors.black54 : Colors.white70,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAngleStats() {
    final angles = widget.result.angles;
    if (angles.isEmpty) return const SizedBox();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ANGLES',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white54,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          ...angles.entries.take(4).map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatAngleName(entry.key),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${entry.value.toStringAsFixed(0)}°',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFCDFF00),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildFaultsList() {
    final faults = widget.result.faults;
    if (faults.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF00FF66).withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF00FF66).withOpacity(0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check_circle, color: Color(0xFF00FF66), size: 20),
            SizedBox(width: 8),
            Text(
              'NO FAULTS',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF00FF66),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      constraints: const BoxConstraints(maxWidth: 160),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'FIX THIS',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white54,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          ...faults.take(3).map((fault) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _getFaultColor(fault.severity),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    fault.message,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Close button
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Center(
                  child: Text(
                    'CLOSE',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Share button
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: _shareResults,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFCDFF00), Color(0xFF9EFF00)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCDFF00).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: _isSharing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.share, color: Colors.black, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'SHARE',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Retry button
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context); // Go back to camera
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              child: const Icon(
                Icons.refresh,
                color: Colors.white70,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAngleName(String name) {
    return name
        .replaceAll('_', ' ')
        .split(' ')
        .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
        .join(' ');
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
