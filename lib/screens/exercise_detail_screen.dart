import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../models/exercise_in_workout.dart';
import '../widgets/exercise_detail_tabs/summary_tab.dart';
import '../widgets/exercise_detail_tabs/history_tab.dart';
import '../widgets/exercise_detail_tabs/leaderboard_tab.dart';

/// Full-screen exercise detail modal with 4 tabs
class ExerciseDetailScreen extends StatelessWidget {
  final ExerciseInWorkout exercise;

  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            exercise.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onPressed: () {
                // TODO: Show menu
              },
            ),
          ],
          bottom: const TabBar(
            indicatorColor: AppColors.cyberLime,
            indicatorWeight: 3,
            labelColor: AppColors.cyberLime,
            unselectedLabelColor: AppColors.white50,
            labelStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
            tabs: [
              Tab(text: 'SUMMARY'),
              Tab(text: 'HISTORY'),
              Tab(text: 'LEADERBOARD'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ExerciseSummaryTab(exercise: exercise),
            ExerciseHistoryTab(exercise: exercise),
            const ExerciseLeaderboardTab(),
          ],
        ),
      ),
    );
  }
}
