import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../models/workout_data.dart';
import '../widgets/exercise_animation_widget.dart';
import 'custom_workouts_screen.dart' show ExerciseSettings;

class ExerciseConfigScreen extends StatefulWidget {
  final Exercise exercise;
  final int initialSets;
  final int initialReps;
  final int initialRest;

  const ExerciseConfigScreen({
    super.key,
    required this.exercise,
    this.initialSets = 3,
    this.initialReps = 10,
    this.initialRest = 60,
  });

  @override
  State<ExerciseConfigScreen> createState() => _ExerciseConfigScreenState();
}

class _ExerciseConfigScreenState extends State<ExerciseConfigScreen> {
  late int _sets;
  late int _reps;
  late int _rest;

  @override
  void initState() {
    super.initState();
    _sets = widget.initialSets;
    _reps = widget.initialReps;
    _rest = widget.initialRest;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back and close
            _buildTopBar(),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Large GIF (40% of screen)
                    _buildLargeGif(),

                    const SizedBox(height: 24),

                    // Exercise name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        widget.exercise.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Sets/Reps/Rest config
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          _buildConfigRow(
                            label: 'SETS',
                            value: _sets,
                            onDecrease: () {
                              if (_sets > 1) {
                                setState(() => _sets--);
                                HapticFeedback.lightImpact();
                              }
                            },
                            onIncrease: () {
                              if (_sets < 10) {
                                setState(() => _sets++);
                                HapticFeedback.lightImpact();
                              }
                            },
                          ),

                          const SizedBox(height: 16),

                          _buildConfigRow(
                            label: 'REPS',
                            value: _reps,
                            onDecrease: () {
                              if (_reps > 1) {
                                setState(() => _reps--);
                                HapticFeedback.lightImpact();
                              }
                            },
                            onIncrease: () {
                              if (_reps < 50) {
                                setState(() => _reps++);
                                HapticFeedback.lightImpact();
                              }
                            },
                          ),

                          const SizedBox(height: 16),

                          _buildConfigRow(
                            label: 'REST',
                            value: _rest,
                            unit: 's',
                            onDecrease: () {
                              if (_rest > 15) {
                                setState(() => _rest -= 15);
                                HapticFeedback.lightImpact();
                              }
                            },
                            onIncrease: () {
                              if (_rest < 300) {
                                setState(() => _rest += 15);
                                HapticFeedback.lightImpact();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom CONTINUE button
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),

          // Close button
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.white10,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeGif() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.white10,
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ExerciseAnimationWidget(
          exerciseId: widget.exercise.id,
          size: MediaQuery.of(context).size.height * 0.4,
          showWatermark: false,
        ),
      ),
    );
  }

  Widget _buildConfigRow({
    required String label,
    required int value,
    String? unit,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white10,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Label
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.white60,
                letterSpacing: 1,
              ),
            ),
          ),

          // Decrease button
          GestureDetector(
            onTap: onDecrease,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.white10,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.white20,
                ),
              ),
              child: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Value display
          Container(
            width: 80,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.cyberLime.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.cyberLime.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                unit != null ? '$value$unit' : '$value',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppColors.cyberLime,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Increase button
          GestureDetector(
            onTap: onIncrease,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.white10,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.white20,
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.white10),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();
          Navigator.pop(context, ExerciseSettings(
            sets: _sets,
            reps: _reps,
            restSeconds: _rest,
          ));
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.electricCyan, AppColors.cyberLime],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.cyberLime.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'CONTINUE',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
