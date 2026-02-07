import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';

/// Full-screen rest timer overlay with circular progress
class RestTimerOverlay extends StatefulWidget {
  final Duration duration;
  final String exerciseName;
  final int nextSetNumber;
  final VoidCallback onComplete;
  final VoidCallback onSkip;

  const RestTimerOverlay({
    super.key,
    required this.duration,
    required this.exerciseName,
    required this.nextSetNumber,
    required this.onComplete,
    required this.onSkip,
  });

  @override
  State<RestTimerOverlay> createState() => _RestTimerOverlayState();
}

class _RestTimerOverlayState extends State<RestTimerOverlay> {
  late Duration _remaining;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
    _startTimer();
  }
  
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds <= 0) {
        timer.cancel();
        widget.onComplete();
        return;
      }
      if (mounted) {
        setState(() => _remaining -= const Duration(seconds: 1));
      }
    });
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onSkip, // Tap anywhere to dismiss
      child: Material(
        color: Colors.black.withOpacity(0.95),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // REST label
              const Text(
                'REST',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white50,
                  letterSpacing: 2,
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Circular timer with glow
              Stack(
                alignment: Alignment.center,
                children: [
                  // Glow effect
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cyberLime.withOpacity(0.3),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  
                  // Circular progress
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: CircularProgressIndicator(
                      value: _remaining.inSeconds / widget.duration.inSeconds,
                      strokeWidth: 8,
                      backgroundColor: AppColors.white10,
                      valueColor: const AlwaysStoppedAnimation(AppColors.cyberLime),
                    ),
                  ),
                  
                  // Time remaining
                  Text(
                    _formatTime(_remaining),
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w900,
                      color: AppColors.cyberLime,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 48),
              
              // Adjust buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAdjustButton('-15s', () => _adjustTime(-15)),
                  const SizedBox(width: 16),
                  _buildAdjustButton('+15s', () => _adjustTime(15)),
                  const SizedBox(width: 16),
                  _buildAdjustButton('SKIP', widget.onSkip),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Next set info
              Text(
                'NEXT: ${widget.exerciseName} Set ${widget.nextSetNumber}',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.white50,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Dismiss hint
              const Text(
                'Tap anywhere to skip',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.white30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildAdjustButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
        HapticFeedback.selectionClick();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.white30),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  
  void _adjustTime(int seconds) {
    setState(() {
      _remaining += Duration(seconds: seconds);
      if (_remaining.inSeconds < 0) _remaining = Duration.zero;
    });
  }
  
  String _formatTime(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

