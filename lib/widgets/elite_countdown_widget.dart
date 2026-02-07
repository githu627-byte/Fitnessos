import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../utils/app_colors.dart';
import '../widgets/exercise_animation_widget.dart';

/// Elite 6-second countdown with exercise GIF and spoken advice
/// TTS flow: Continuous advice (6-5-4-3-2) → "Get into position" (1) → "GO!" (0)
class EliteCountdownWidget extends StatefulWidget {
  final String exerciseId;
  final VoidCallback onComplete;

  const EliteCountdownWidget({
    super.key,
    required this.exerciseId,
    required this.onComplete,
  });

  @override
  State<EliteCountdownWidget> createState() => _EliteCountdownWidgetState();
}

class _EliteCountdownWidgetState extends State<EliteCountdownWidget> {
  int _countdownValue = 6;
  Timer? _countdownTimer;
  final FlutterTts _tts = FlutterTts();
  bool _hasSpokenAdvice = false;

  @override
  void initState() {
    super.initState();
    _initTTS();
    _startCountdown();
  }

  Future<void> _initTTS() async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
  }

  void _startCountdown() {
    // Speak all advice at the start (plays during 6-5-4-3-2-1)
    if (!_hasSpokenAdvice) {
      _hasSpokenAdvice = true;
      _tts.speak('Full body in view. Good lighting needed. Keep clear view.');
    }

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      setState(() {
        _countdownValue--;
      });

      if (_countdownValue == 1) {
        // At 1 second: "Get into position"
        HapticFeedback.mediumImpact();
        _tts.stop(); // Stop any remaining advice
        _tts.speak('Get into position');
      } else if (_countdownValue == 0) {
        // At 0: "GO!"
        timer.cancel();
        HapticFeedback.heavyImpact();
        _tts.speak('GO!');
        
        // Wait a moment then complete
        Future.delayed(const Duration(milliseconds: 800), () {
          if (mounted) {
            widget.onComplete();
          }
        });
      } else if (_countdownValue > 1) {
        // Visual feedback for 6-2
        HapticFeedback.lightImpact();
      }
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _tts.stop();
    super.dispose();
  }

  Color _getColorForValue(int value) {
    if (value >= 5) return const Color(0xFF00F0FF); // Electric cyan (6-5)
    if (value >= 3) return const Color(0xFFFFB800); // Orange (4-3)
    if (value >= 1) return AppColors.cyberLime; // Lime (2-1)
    return AppColors.cyberLime; // GO
  }
  
  String _getAdviceText(int value) {
    if (value >= 2) return 'FULL BODY • GOOD LIGHTING • CLEAR VIEW';
    if (value == 1) return 'GET INTO POSITION';
    return 'GO!';
  }

  @override
  Widget build(BuildContext context) {
    if (_countdownValue <= 0) {
      // Show GO! screen
      return Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.7),
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.5, end: 1.8),
              duration: const Duration(milliseconds: 800),
              curve: Curves.elasticOut,
              builder: (c, scale, ch) {
                return Transform.scale(
                  scale: scale,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'GO!',
                        style: TextStyle(
                          fontSize: 120,
                          fontWeight: FontWeight.w900,
                          color: AppColors.cyberLime,
                          shadows: [
                            Shadow(
                              color: AppColors.cyberLime.withOpacity(0.8),
                              blurRadius: 50,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.cyberLime.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.cyberLime,
                            width: 3,
                          ),
                        ),
                        child: const Text(
                          'START MOVING!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: AppColors.cyberLime,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    final color = _getColorForValue(_countdownValue);
    final adviceText = _getAdviceText(_countdownValue);

    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Exercise GIF
              ExerciseAnimationWidget(
                exerciseId: widget.exerciseId,
                size: 200,
                showWatermark: true,
              ),
              const SizedBox(height: 40),

              // Countdown number with elastic animation
              TweenAnimationBuilder<double>(
                key: ValueKey(_countdownValue),
                tween: Tween(begin: 2.0, end: 1.0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.elasticOut,
                builder: (c, scale, ch) {
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: color, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: color.withOpacity(0.5),
                            blurRadius: 30,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '$_countdownValue',
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w900,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),

              // Advice text
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: color.withOpacity(0.5),
                    width: 2,
                  ),
                ),
                child: Text(
                  adviceText,
                  style: TextStyle(
                    fontSize: _countdownValue == 1 ? 18 : 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.9),
                    letterSpacing: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
