import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import '../../utils/app_colors.dart';

/// =============================================================================
/// VIRAL SHARE CARD WIDGET
/// =============================================================================
/// Live preview of the share card that will be generated.
/// Shows the skeleton overlay, score, metrics, and branding.
/// Used in the session summary to preview what will be shared.
/// =============================================================================

class ViralShareCardPreview extends StatelessWidget {
  final String exerciseName;
  final int score;
  final String scoreLabel;
  final Color scoreColor;
  final List<String> passedMetrics;
  final bool isPersonalBest;
  final String? progressText;
  final Map<PoseLandmarkType, PoseLandmark>? landmarks;
  final bool isStoryFormat; // true = 9:16, false = 4:5
  
  const ViralShareCardPreview({
    super.key,
    required this.exerciseName,
    required this.score,
    required this.scoreLabel,
    required this.scoreColor,
    this.passedMetrics = const [],
    this.isPersonalBest = false,
    this.progressText,
    this.landmarks,
    this.isStoryFormat = true,
  });
  
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: isStoryFormat ? 9 / 16 : 4 / 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0A0A0A), Color(0xFF1A1A2E)],
          ),
          border: Border.all(color: AppColors.white20, width: 1),
          boxShadow: [
            BoxShadow(
              color: scoreColor.withOpacity(0.2),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Photo/Skeleton section
              Positioned(
                top: 12,
                left: 12,
                right: 12,
                height: isStoryFormat ? 220 : 180,
                child: _buildPhotoSection(),
              ),
              
              // Perfect badge
              if (score >= 90)
                Positioned(
                  top: 20,
                  right: 20,
                  child: _buildPerfectBadge(),
                ),
              
              // Stats section
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: _buildStatsSection(),
              ),
              
              // Branding
              Positioned(
                left: 0,
                right: 0,
                bottom: isStoryFormat ? 12 : 8,
                child: _buildBranding(),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildPhotoSection() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: landmarks != null 
          ? CustomPaint(
              painter: _ShareCardSkeletonPainter(landmarks: landmarks!),
              child: Container(),
            )
          : const Center(
              child: Icon(
                Icons.accessibility_new,
                size: 80,
                color: AppColors.cyberLime,
              ),
            ),
    );
  }
  
  Widget _buildPerfectBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.cyberLime, Color(0xFFCCFF00)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyberLime.withOpacity(0.4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Text(
        score >= 95 ? '⭐ PERFECT' : '🔥 ELITE',
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: Colors.black,
          letterSpacing: 1,
        ),
      ),
    );
  }
  
  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Exercise label
        Text(
          'FORM CHECK',
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: Colors.white.withOpacity(0.5),
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 2),
        
        // Exercise name
        Text(
          exerciseName.toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Score and context row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Score circle
            _buildScoreCircle(),
            const SizedBox(width: 16),
            
            // Context (badges, progress)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isPersonalBest)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: scoreColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '🏆 NEW PR',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: scoreColor,
                        ),
                      ),
                    ),
                  if (progressText != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      progressText!,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 12),
        
        // Metrics row
        if (passedMetrics.isNotEmpty) _buildMetricsRow(),
      ],
    );
  }
  
  Widget _buildScoreCircle() {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: scoreColor, width: 3),
        boxShadow: [
          BoxShadow(
            color: scoreColor.withOpacity(0.4),
            blurRadius: 15,
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
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: scoreColor,
                height: 1,
              ),
            ),
            Text(
              score >= 95 ? 'PERF' : 'FORM',
              style: TextStyle(
                fontSize: 7,
                fontWeight: FontWeight.w800,
                color: scoreColor,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildMetricsRow() {
    final metrics = passedMetrics.take(4).toList();
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: metrics.map((metric) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check, color: AppColors.cyberLime, size: 10),
            const SizedBox(width: 4),
            Text(
              metric,
              style: TextStyle(
                fontSize: 9,
                color: Colors.white.withOpacity(0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
  
  Widget _buildBranding() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColors.cyberLime, Color(0xFFCCFF00)],
      ).createShader(bounds),
      child: const Text(
        'SKELETON',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w900,
          letterSpacing: 5,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Skeleton painter for the share card preview
class _ShareCardSkeletonPainter extends CustomPainter {
  final Map<PoseLandmarkType, PoseLandmark> landmarks;
  
  _ShareCardSkeletonPainter({required this.landmarks});
  
  @override
  void paint(Canvas canvas, Size size) {
    final bonePaint = Paint()
      ..color = const Color(0xFFCCFF00)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    
    final glowPaint = Paint()
      ..color = const Color(0xFFCCFF00).withOpacity(0.3)
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    
    final jointPaint = Paint()..color = const Color(0xFFCCFF00);
    final jointGlowPaint = Paint()
      ..color = const Color(0xFFCCFF00).withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    
    // Scale landmarks to fit the preview
    Offset? scalePoint(PoseLandmarkType type) {
      final lm = landmarks[type];
      if (lm == null) return null;
      // Assume landmarks are normalized 0-1000, scale to widget size
      return Offset(
        (lm.x / 1000) * size.width,
        (lm.y / 1000) * size.height,
      );
    }
    
    void drawBone(PoseLandmarkType from, PoseLandmarkType to) {
      final fromPt = scalePoint(from);
      final toPt = scalePoint(to);
      if (fromPt != null && toPt != null) {
        canvas.drawLine(fromPt, toPt, glowPaint);
        canvas.drawLine(fromPt, toPt, bonePaint);
      }
    }
    
    // Draw skeleton connections
    final connections = [
      [PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder],
      [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow],
      [PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist],
      [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow],
      [PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist],
      [PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip],
      [PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip],
      [PoseLandmarkType.leftHip, PoseLandmarkType.rightHip],
      [PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee],
      [PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle],
      [PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee],
      [PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle],
    ];
    
    for (final conn in connections) {
      drawBone(conn[0], conn[1]);
    }
    
    // Draw joints
    for (final entry in landmarks.entries) {
      final pt = scalePoint(entry.key);
      if (pt != null) {
        canvas.drawCircle(pt, 8, jointGlowPaint);
        canvas.drawCircle(pt, 5, jointPaint);
      }
    }
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// =============================================================================
/// FULL-SCREEN SHARE CARD (for screenshots)
/// =============================================================================

class FullScreenShareCard extends StatelessWidget {
  final String exerciseName;
  final int score;
  final List<String> passedMetrics;
  final bool isPersonalBest;
  final String? progressText;
  final Map<PoseLandmarkType, PoseLandmark>? landmarks;
  final bool isStoryFormat;
  
  const FullScreenShareCard({
    super.key,
    required this.exerciseName,
    required this.score,
    this.passedMetrics = const [],
    this.isPersonalBest = false,
    this.progressText,
    this.landmarks,
    this.isStoryFormat = true,
  });
  
  Color get _scoreColor {
    if (score >= 95) return const Color(0xFFCCFF00);
    if (score >= 90) return const Color(0xFFFF9500);
    if (score >= 85) return const Color(0xFFCCFF00);
    return const Color(0xFF888888);
  }
  
  String get _scoreLabel {
    if (score >= 98) return "💎 FLAWLESS";
    if (score >= 95) return "⭐ PERFECT FORM";
    if (score >= 90) return "🔥 ELITE";
    if (score >= 85) return "✓ DIALED IN";
    return "SOLID";
  }
  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: isStoryFormat ? size.width : size.width * 0.9,
          height: isStoryFormat ? size.height : size.width * 0.9 * (5/4),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0A0A0A), Color(0xFF1A1A2E)],
            ),
          ),
          child: Stack(
            children: [
              // Skeleton section (top 55%)
              Positioned(
                top: 40,
                left: 24,
                right: 24,
                height: isStoryFormat ? size.height * 0.48 : size.width * 0.6,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF16213E),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: landmarks != null
                      ? CustomPaint(
                          painter: _ShareCardSkeletonPainter(landmarks: landmarks!),
                          child: Container(),
                        )
                      : Center(
                          child: Icon(
                            Icons.accessibility_new,
                            size: 120,
                            color: _scoreColor.withOpacity(0.5),
                          ),
                        ),
                ),
              ),
              
              // Perfect badge
              if (score >= 90)
                Positioned(
                  top: 56,
                  right: 40,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFCCFF00), Color(0xFFCCFF00)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFCCFF00).withOpacity(0.5),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Text(
                      _scoreLabel.replaceAll(RegExp(r'[^\w\s]'), '').trim(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              
              // Stats panel
              Positioned(
                left: 24,
                right: 24,
                bottom: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Label
                    Text(
                      'FORM CHECK',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withOpacity(0.5),
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Exercise name
                    Text(
                      exerciseName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Score row
                    Row(
                      children: [
                        // Big score circle
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: _scoreColor, width: 5),
                            boxShadow: [
                              BoxShadow(
                                color: _scoreColor.withOpacity(0.5),
                                blurRadius: 30,
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
                                    fontSize: 40,
                                    fontWeight: FontWeight.w900,
                                    color: _scoreColor,
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  score >= 95 ? 'PERFECT' : 'FORM',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    color: _scoreColor,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 24),
                        
                        // Context
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isPersonalBest)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: _scoreColor.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: _scoreColor.withOpacity(0.3)),
                                  ),
                                  child: Text(
                                    '🏆 NEW PERSONAL BEST',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: _scoreColor,
                                    ),
                                  ),
                                ),
                              if (progressText != null) ...[
                                const SizedBox(height: 8),
                                Text(
                                  progressText!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Metrics
                    if (passedMetrics.isNotEmpty)
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: passedMetrics.take(4).map((metric) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.15)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.check_circle, color: Color(0xFFCCFF00), size: 16),
                              const SizedBox(width: 8),
                              Text(
                                metric,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),
                  ],
                ),
              ),
              
              // Branding
              Positioned(
                left: 0,
                right: 0,
                bottom: 28,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFCCFF00), Color(0xFFCCFF00)],
                  ).createShader(bounds),
                  child: const Text(
                    'SKELETON',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
