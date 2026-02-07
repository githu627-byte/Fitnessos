import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../models/exercise_in_workout.dart';
import 'exercise_video_player.dart';
import 'exercise_list_thumbnail.dart';
import '../widgets/hevy_set_table.dart';
import '../widgets/rest_timer_overlay.dart';
import '../widgets/exercise_menu_sheet.dart';
import '../screens/exercise_detail_screen.dart';

/// Hevy-style exercise card with expand/collapse functionality
class HevyExerciseCard extends StatelessWidget {
  final ExerciseInWorkout exercise;
  final VoidCallback onToggleExpand;
  final Function(int setIndex) onCompleteSet;
  final VoidCallback onAddSet;
  final Function(int setIndex, double? weight) onUpdateWeight;
  final Function(int setIndex, int? reps) onUpdateReps;
  final VoidCallback? onReplace;  // ← ADDED
  final VoidCallback? onRemove;   // ← ADDED

  const HevyExerciseCard({
    super.key,
    required this.exercise,
    required this.onToggleExpand,
    required this.onCompleteSet,
    required this.onAddSet,
    required this.onUpdateWeight,
    required this.onUpdateReps,
    this.onReplace,  // ← ADDED
    this.onRemove,   // ← ADDED
  });

  String _getPreviousPerformanceText() {
    if (exercise.previousSets == null || exercise.previousSets!.isEmpty) {
      return 'No previous data';
    }
    
    final lastSet = exercise.previousSets!.first;
    return 'Previous: ${lastSet.weight ?? 0} kg × ${lastSet.reps ?? 0}';
  }

  void _handleCompleteSet(BuildContext context, int setIndex) {
    // Mark set as complete
    onCompleteSet(setIndex);
    
    // Haptic feedback
    HapticFeedback.mediumImpact();
    
    // Show rest timer if not the last exercise
    final isLastSet = setIndex >= exercise.sets.length - 1;
    if (!isLastSet && exercise.defaultRestSeconds > 0) {
      showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black87,
        builder: (context) => RestTimerOverlay(
          duration: Duration(seconds: exercise.defaultRestSeconds),
          exerciseName: exercise.name,
          nextSetNumber: setIndex + 2,
          onComplete: () {
            Navigator.of(context).pop();
          },
          onSkip: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: exercise.isExpanded ? AppColors.cyberLime : AppColors.white10,
          width: exercise.isExpanded ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          // Header - always visible
          _buildHeader(context),
          
          // Set logging table - only when expanded
          if (exercise.isExpanded) _buildExpandedContent(context),
        ],
      ),
    );
  }

  /// Build static thumbnail (NO VIDEO - performance fix)
  Widget _buildGifWithLogo(String exerciseId) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 60,
        height: 60,
        child: ExerciseListThumbnail(
          exerciseId: exerciseId,
          size: 60,
          exerciseName: exercise.name,
          showBorder: false,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return GestureDetector(
      onTap: onToggleExpand,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Square GIF with logo watermark
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.white10,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.cyberLime.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: _buildGifWithLogo(exercise.exerciseId),
            ),
            
            const SizedBox(width: 12),
            
            // Exercise name + previous performance
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ExerciseDetailScreen(
                        exercise: exercise,
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getPreviousPerformanceText(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.white50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Menu button
            IconButton(
              icon: const Icon(
                Icons.more_vert,
                color: AppColors.white50,
                size: 20,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => ExerciseMenuSheet(
                    onReplace: () {
                      if (onReplace != null) onReplace!();
                    },
                    onRemove: () {
                      if (onRemove != null) onRemove!();
                    },
                    onViewDetails: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ExerciseDetailScreen(
                            exercise: exercise,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            
            // Expand/collapse arrow
            Icon(
              exercise.isExpanded
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down,
              color: AppColors.white50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Divider(color: AppColors.white10, height: 1),
          const SizedBox(height: 16),
          
          // Set logging table
          HevySetTable(
            sets: exercise.sets,
            previousSets: exercise.previousSets,
            onCompleteSet: (setIndex) => _handleCompleteSet(context, setIndex),
            onUpdateWeight: onUpdateWeight,
            onUpdateReps: onUpdateReps,
          ),
          
          const SizedBox(height: 12),
          
          // Add set button
          _buildAddSetButton(),
        ],
      ),
    );
  }

  Widget _buildAddSetButton() {
    return GestureDetector(
      onTap: onAddSet,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColors.cyberLime.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppColors.cyberLime, size: 18),
            SizedBox(width: 8),
            Text(
              'ADD SET',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.cyberLime,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

