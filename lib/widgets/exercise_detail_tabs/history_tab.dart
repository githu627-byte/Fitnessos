import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/app_colors.dart';
import '../../models/exercise_in_workout.dart';
import '../../features/analytics/services/analytics_service.dart';

/// History tab showing past workout performances with real data
class ExerciseHistoryTab extends StatelessWidget {
  final ExerciseInWorkout exercise;

  const ExerciseHistoryTab({
    super.key,
    required this.exercise,
  });

  Future<List<ExerciseHistoryEntry>> _loadHistory() async {
    return await AnalyticsService.getExerciseHistory(exercise.name);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ExerciseHistoryEntry>>(
      future: _loadHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.cyberLime,
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return _buildEmptyState();
        }

        final history = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: history.length,
          itemBuilder: (context, index) => _buildHistoryCard(history[index]),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.history,
            size: 64,
            color: AppColors.white30,
          ),
          const SizedBox(height: 16),
          const Text(
            'No history yet',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.white50,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Complete a workout with ${exercise.name} to see your history',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.white30,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(ExerciseHistoryEntry entry) {
    final dateFormat = DateFormat('MMM dd, yyyy');
    final timeFormat = DateFormat('HH:mm');
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.white5,
            AppColors.white5.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white10,
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cyberLime.withOpacity(0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.cyberLime.withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateFormat.format(entry.date),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      timeFormat.format(entry.date),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.white50,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (entry.workoutMode != null)
                      _buildModeBadge(entry.workoutMode!),
                    const SizedBox(width: 12),
                    _buildStatPill(
                      icon: Icons.fitness_center,
                      value: '${entry.sets.length}',
                      label: 'sets',
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Sets list
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Column headers
                Row(
                  children: [
                    const SizedBox(width: 40),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'WEIGHT',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white50,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'REPS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white50,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: Text(
                        'VOLUME',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white50,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Sets data
                ...entry.sets.map((set) => _buildSetRow(
                  set,
                  showFormScore: false,
                )),
                
                const SizedBox(height: 12),
                const Divider(color: AppColors.white10, height: 1),
                const SizedBox(height: 12),
                
                // Totals
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTotalStat(
                      label: 'Avg Weight',
                      value: '${entry.avgWeight.toStringAsFixed(1)} kg',
                      color: AppColors.cyberLime,
                    ),
                    _buildTotalStat(
                      label: 'Total Reps',
                      value: '${entry.totalReps}',
                      color: AppColors.electricCyan,
                    ),
                    _buildTotalStat(
                      label: 'Total Volume',
                      value: '${entry.totalVolume.toStringAsFixed(0)} kg',
                      color: AppColors.cyberLime,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeBadge(String mode) {
    Color color;
    String label;
    
    switch (mode.toLowerCase()) {
      case 'auto':
        color = AppColors.cyberLime;
        label = 'AUTO';
        break;
      case 'visual_guide':
        color = AppColors.electricCyan;
        label = 'VISUAL';
        break;
      case 'pro_logger':
        color = const Color(0xFFFF9500);
        label = 'PRO';
        break;
      default:
        color = AppColors.white50;
        label = mode.toUpperCase();
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: color,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildStatPill({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.cyberLime, size: 16),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.cyberLime,
          ),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.white50,
          ),
        ),
      ],
    );
  }

  Widget _buildSetRow(ExerciseSetDetail set, {required bool showFormScore}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // Set number
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white10,
              border: Border.all(color: AppColors.white20),
            ),
            child: Center(
              child: Text(
                '${set.setNumber}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          
          // Weight
          Expanded(
            flex: 2,
            child: Text(
              '${set.weight.toStringAsFixed(1)} kg',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          
          // Reps
          Expanded(
            flex: 2,
            child: Text(
              '${set.reps}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          
          // Volume
          Expanded(
            flex: 2,
            child: Text(
              '${set.volume.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.electricCyan,
              ),
            ),
          ),
          
          // Form score (if available)
          if (showFormScore)
            Expanded(
              flex: 2,
              child: set.formScore != null
                  ? Row(
                      children: [
                        Text(
                          '${set.formScore!.toInt()}%',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: _getFormScoreColor(set.formScore!),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          set.formScore! >= 90 ? Icons.check_circle : Icons.warning,
                          size: 14,
                          color: _getFormScoreColor(set.formScore!),
                        ),
                      ],
                    )
                  : const Text(
                      '--',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.white30,
                      ),
                    ),
            ),
        ],
      ),
    );
  }

  Widget _buildTotalStat({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.white50,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Color _getFormScoreColor(double score) {
    if (score >= 90) return AppColors.cyberLime;
    if (score >= 70) return const Color(0xFFFFDD00);
    if (score >= 50) return const Color(0xFFFF9500);
    return const Color(0xFFFF003C);
  }
}
