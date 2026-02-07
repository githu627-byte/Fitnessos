import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

/// Leaderboard tab (placeholder for future)
class ExerciseLeaderboardTab extends StatelessWidget {
  const ExerciseLeaderboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.leaderboard,
            size: 64,
            color: AppColors.white30,
          ),
          SizedBox(height: 16),
          Text(
            'Coming soon!',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.white50,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Compete with friends and the community',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.white30,
            ),
          ),
        ],
      ),
    );
  }
}

