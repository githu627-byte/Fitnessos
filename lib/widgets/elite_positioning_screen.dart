import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../utils/app_colors.dart';

/// Elite positioning screen adapted from form analysis
/// Auto-triggers countdown INSTANTLY when full body is detected
class ElitePositioningScreen extends StatefulWidget {
  final bool isPositionValid;
  final VoidCallback onAutoStart;

  const ElitePositioningScreen({
    super.key,
    required this.isPositionValid,
    required this.onAutoStart,
  });

  @override
  State<ElitePositioningScreen> createState() => _ElitePositioningScreenState();
}

class _ElitePositioningScreenState extends State<ElitePositioningScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _hasTriggered = false;
  final FlutterTts _tts = FlutterTts();
  bool _hasSpoken = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.97, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    // Initialize TTS and speak instructions
    _initializeTTS();
  }
  
  Future<void> _initializeTTS() async {
    await _tts.setLanguage("en-US");
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    
    // Speak instructions after a brief delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && !_hasSpoken) {
        _hasSpoken = true;
        _tts.speak("Place phone on the floor. Step back until full body is in frame.");
      }
    });
  }

  @override
  void didUpdateWidget(ElitePositioningScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    // INSTANT trigger - no delay, no frame counting
    if (widget.isPositionValid && !_hasTriggered) {
      _hasTriggered = true;
      HapticFeedback.heavyImpact();
      _tts.speak("Perfect! Starting now.");
      // Small delay for haptic feedback to register
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          widget.onAutoStart();
        }
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pulsing body silhouette
            AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (c, ch) => Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: widget.isPositionValid
                          ? AppColors.cyberLime
                          : Colors.white.withOpacity(0.5),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomPaint(
                    painter: _SilhouettePainter(
                      color: widget.isPositionValid
                          ? AppColors.cyberLime
                          : Colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Status text
            Text(
              widget.isPositionValid ? 'PERFECT! STARTING...' : 'POSITION YOURSELF',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: widget.isPositionValid
                    ? AppColors.cyberLime
                    : Colors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),

            // Clear Instructions (BIGGER, MORE VISIBLE)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cyberLime.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.cyberLime.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone_android,
                        color: AppColors.cyberLime,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '1. Place phone on the floor',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.accessibility_new,
                        color: AppColors.cyberLime,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '2. Step back until full body in frame',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Simple checkmark when detected - NO LOADING SPINNER
            if (widget.isPositionValid)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cyberLime.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.cyberLime, width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.cyberLime,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'DETECTED! STARTING...',
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
      ),
    );
  }
}

/// Silhouette painter for body outline
class _SilhouettePainter extends CustomPainter {
  final Color color;

  _SilhouettePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;

    // Head
    canvas.drawCircle(Offset(cx, size.height * 0.12), 25, paint);

    // Neck
    canvas.drawLine(
      Offset(cx, size.height * 0.17),
      Offset(cx, size.height * 0.22),
      paint,
    );

    // Shoulders
    canvas.drawLine(
      Offset(cx - 40, size.height * 0.22),
      Offset(cx + 40, size.height * 0.22),
      paint,
    );

    // Torso
    canvas.drawLine(
      Offset(cx, size.height * 0.22),
      Offset(cx, size.height * 0.55),
      paint,
    );

    // Left arm
    canvas.drawLine(
      Offset(cx - 40, size.height * 0.22),
      Offset(cx - 50, size.height * 0.40),
      paint,
    );
    canvas.drawLine(
      Offset(cx - 50, size.height * 0.40),
      Offset(cx - 45, size.height * 0.55),
      paint,
    );

    // Right arm
    canvas.drawLine(
      Offset(cx + 40, size.height * 0.22),
      Offset(cx + 50, size.height * 0.40),
      paint,
    );
    canvas.drawLine(
      Offset(cx + 50, size.height * 0.40),
      Offset(cx + 45, size.height * 0.55),
      paint,
    );

    // Hips
    canvas.drawLine(
      Offset(cx - 30, size.height * 0.55),
      Offset(cx + 30, size.height * 0.55),
      paint,
    );

    // Left leg
    canvas.drawLine(
      Offset(cx - 30, size.height * 0.55),
      Offset(cx - 35, size.height * 0.75),
      paint,
    );
    canvas.drawLine(
      Offset(cx - 35, size.height * 0.75),
      Offset(cx - 30, size.height * 0.95),
      paint,
    );

    // Right leg
    canvas.drawLine(
      Offset(cx + 30, size.height * 0.55),
      Offset(cx + 35, size.height * 0.75),
      paint,
    );
    canvas.drawLine(
      Offset(cx + 35, size.height * 0.75),
      Offset(cx + 30, size.height * 0.95),
      paint,
    );
  }

  @override
  bool shouldRepaint(_SilhouettePainter old) => old.color != color;
}
