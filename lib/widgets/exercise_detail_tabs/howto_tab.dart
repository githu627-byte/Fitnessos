import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../models/exercise_in_workout.dart';
import '../exercise_video_player.dart';

/// How To tab with exercise instructions
class ExerciseHowToTab extends StatelessWidget {
  final ExerciseInWorkout exercise;

  const ExerciseHowToTab({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Exercise visual
          _buildExerciseVisual(),
          
          // Instructions
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Numbered steps
                if (exercise.instructions != null && exercise.instructions!.isNotEmpty)
                  ...exercise.instructions!.asMap().entries.map((entry) {
                    return _buildInstructionStep(entry.key + 1, entry.value);
                  }).toList()
                else
                  const Text(
                    'No instructions available yet',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.white50,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseVisual() {
    return Container(
      height: 420,
      decoration: const BoxDecoration(
        color: AppColors.white5,
      ),
      child: ExerciseVideoPlayer(
        exerciseId: exercise.exerciseId,
        width: double.infinity,
        height: 420,
        fit: BoxFit.contain,
        showWatermark: true,
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center,
            size: 64,
            color: AppColors.cyberLime,
          ),
          SizedBox(height: 12),
          Text(
            'GIF COMING SOON',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.white50,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionStep(int number, String instruction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number circle
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.cyberLime,
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.cyberLime,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Instruction text
          Expanded(
            child: Text(
              instruction,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

