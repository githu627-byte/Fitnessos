import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../services/voice_recognition_service.dart';

/// Weight input dialog shown after completing a set
/// Supports both manual text input and voice input via wake word
class WeightInputDialog extends StatefulWidget {
  final String exerciseName;
  final int setNumber;
  final Function(double weight) onWeightEntered;
  final VoidCallback onSkip;

  const WeightInputDialog({
    super.key,
    required this.exerciseName,
    required this.setNumber,
    required this.onWeightEntered,
    required this.onSkip,
  });

  @override
  State<WeightInputDialog> createState() => _WeightInputDialogState();
}

class _WeightInputDialogState extends State<WeightInputDialog>
    with SingleTickerProviderStateMixin {
  final TextEditingController _weightController = TextEditingController();
  final VoiceRecognitionService _voiceService = VoiceRecognitionService();
  bool _isListening = false;
  late AnimationController _pulseController;
  String _voiceStatus = '';

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    // Listen to voice state changes FIRST
    _voiceService.stateStream.listen((state) {
      if (!mounted) return;

      setState(() {
        switch (state.status) {
          case VoiceRecognitionStatus.listening:
            _voiceStatus = 'Listening for "skelatal"...';
            debugPrint('🎤 Status: Listening for wake word');
            break;
          case VoiceRecognitionStatus.wakeWordDetected:
            _voiceStatus = 'Wake word detected! Say weight...';
            debugPrint('🔥 Status: Wake word detected');
            break;
          case VoiceRecognitionStatus.weightDetected:
            _voiceStatus = 'Got it!';
            debugPrint('✅ Status: Weight detected');
            if (state.detectedWeight != null) {
              _weightController.text = state.detectedWeight.toString();
              HapticFeedback.lightImpact();
            }
            _stopVoiceInput();
            break;
          case VoiceRecognitionStatus.error:
            _voiceStatus = 'Error: ${state.errorMessage ?? "Unknown error"}';
            debugPrint('❌ Status: ${state.errorMessage}');
            _stopVoiceInput();
            break;
          case VoiceRecognitionStatus.idle:
            _voiceStatus = '';
            break;
        }
      });
    });
    
    // Initialize voice service
    _initializeVoiceService();
  }

  @override
  void dispose() {
    _weightController.dispose();
    _pulseController.dispose();
    _voiceService.stopListening();
    super.dispose();
  }
  
  Future<void> _initializeVoiceService() async {
    final initialized = await _voiceService.initialize();
    if (!initialized) {
      debugPrint('⚠️ Voice service failed to initialize');
    }
  }

  Future<void> _startVoiceInput() async {
    setState(() {
      _isListening = true;
      _voiceStatus = 'Initializing...';
    });
    HapticFeedback.mediumImpact();
    
    debugPrint('🎤 Starting voice input...');
    
    // Start listening (free tier - isPremium: false)
    await _voiceService.startListening(isPremium: false);
  }

  void _stopVoiceInput() {
    _voiceService.stopListening();
    setState(() {
      _isListening = false;
      _voiceStatus = '';
    });
  }

  void _submitWeight() {
    final weight = double.tryParse(_weightController.text);
    if (weight != null && weight > 0) {
      HapticFeedback.lightImpact();
      widget.onWeightEntered(weight);
      Navigator.of(context).pop();
    } else {
      HapticFeedback.heavyImpact();
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid weight'),
          backgroundColor: AppColors.neonCrimson,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.cyberLime, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyberLime.withOpacity(0.3),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.cyberLime.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    color: AppColors.cyberLime,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.exerciseName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white60,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'SET ${widget.setNumber}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Question
            const Text(
              'What weight did you use?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Manual Input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: AppColors.white20,
                      ),
                      suffixText: 'lbs',
                      suffixStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white60,
                      ),
                      filled: true,
                      fillColor: AppColors.white5,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: AppColors.white20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: AppColors.cyberLime, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // OR divider
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.white20, thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'OR',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white40,
                    ),
                  ),
                ),
                Expanded(child: Divider(color: AppColors.white20, thickness: 1)),
              ],
            ),
            const SizedBox(height: 16),

            // Voice Input Button
            GestureDetector(
              onTap: _isListening ? _stopVoiceInput : _startVoiceInput,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    decoration: BoxDecoration(
                      gradient: _isListening
                          ? LinearGradient(
                              colors: [
                                AppColors.cyberLime
                                    .withOpacity(0.3 + _pulseController.value * 0.3),
                                AppColors.cyberLime
                                    .withOpacity(0.3 + _pulseController.value * 0.3),
                              ],
                            )
                          : null,
                      color: _isListening ? null : AppColors.white10,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: _isListening ? AppColors.cyberLime : AppColors.white20,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          color: _isListening ? AppColors.cyberLime : AppColors.white60,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _isListening
                              ? (_voiceStatus.isNotEmpty ? _voiceStatus.toUpperCase() : 'LISTENING...')
                              : 'SAY "SKELATAL" + WEIGHT',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: _isListening ? AppColors.cyberLime : AppColors.white60,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                // Skip button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).pop();
                      widget.onSkip();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.white10,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.white20),
                      ),
                      child: const Text(
                        'SKIP',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Submit button
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: _submitWeight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.cyberLime, AppColors.cyberLime],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cyberLime.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Text(
                        'CONFIRM',
                        style: TextStyle(
                          fontSize: 14,
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
            const SizedBox(height: 12),

            // Skip all weights option
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Set flag to skip all weight inputs
              },
              child: const Text(
                'Enter all weights at the end',
                style: TextStyle(
                  color: AppColors.white40,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

