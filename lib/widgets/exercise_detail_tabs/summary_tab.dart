import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../utils/app_colors.dart';
import '../../models/exercise_in_workout.dart';
import '../../features/analytics/services/analytics_service.dart';
import '../exercise_video_player.dart';

/// Summary tab with real data from unified database
class ExerciseSummaryTab extends StatelessWidget {
  final ExerciseInWorkout exercise;

  const ExerciseSummaryTab({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<({
      ExercisePersonalRecords prs,
      List<ExerciseProgressPoint> progressData,
    })>(
      future: _loadExerciseData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.cyberLime),
          );
        }
        
        final prs = snapshot.data?.prs ?? ExercisePersonalRecords(
          heaviestWeight: 0.0,
          best1rm: 0.0,
          bestSetVolume: 0.0,
          bestSetVolumeWeight: 0.0,
          bestSetVolumeReps: 0,
          bestSessionVolume: 0.0,
        );
        final progressData = snapshot.data?.progressData ?? [];
        
        return SingleChildScrollView(
          child: Column(
            children: [
              // Exercise visual
              _buildExerciseVisual(),
              
              // Exercise info
              _buildExerciseInfo(),
              
              // Form tips
              if (exercise.formTip != null) _buildFormTips(),
              
              // Progress graph with real data
              _buildProgressGraph(progressData),
              
              // Personal records with real data
              _buildPersonalRecords(prs),
            ],
          ),
        );
      },
    );
  }
  
  Future<({
    ExercisePersonalRecords prs,
    List<ExerciseProgressPoint> progressData,
  })> _loadExerciseData() async {
    final prs = await AnalyticsService.getExercisePersonalRecords(exercise.name);
    final progressData = await AnalyticsService.getExerciseProgressData(exercise.name, daysBack: 30);
    
    return (prs: prs, progressData: progressData);
  }

  Widget _buildExerciseVisual() {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        color: AppColors.white5,
        border: Border(
          bottom: BorderSide(color: AppColors.cyberLime, width: 2),
        ),
      ),
      child: ExerciseVideoPlayer(
        exerciseId: exercise.exerciseId,
        width: double.infinity,
        height: 380,
        fit: BoxFit.cover,
        showWatermark: true,
      ),
    );
  }

  Widget _buildExerciseInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.white5,
      ),
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
          const SizedBox(height: 8),
          if (exercise.primaryMuscles.isNotEmpty)
            Text(
              'Primary: ${exercise.primaryMuscles.join(", ")}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.cyberLime,
              ),
            ),
          if (exercise.secondaryMuscles.isNotEmpty)
            Text(
              'Secondary: ${exercise.secondaryMuscles.join(", ")}',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.white60,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFormTips() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.electricCyan.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb_outline, color: AppColors.electricCyan),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              exercise.formTip ?? 'Maintain proper form throughout',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressGraph(List<ExerciseProgressPoint> progressData) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cyberLime.withOpacity(0.05),
            AppColors.electricCyan.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cyberLime.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PROGRESS GRAPH',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppColors.cyberLime,
                  letterSpacing: 1.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.white10,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.electricCyan.withOpacity(0.5),
                  ),
                ),
                child: const Text(
                  '1M',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.electricCyan,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Chart with real data
          SizedBox(
            height: 200,
            child: progressData.isEmpty
                ? _buildEmptyChartState()
                : _buildRealChart(progressData),
          ),
          
          const SizedBox(height: 16),
          
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem('Weight', AppColors.cyberLime),
              const SizedBox(width: 24),
              _buildLegendItem('Reps', AppColors.electricCyan),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyChartState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.show_chart, size: 48, color: AppColors.white30),
          const SizedBox(height: 12),
          Text(
            'No data yet',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.white50,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Complete workouts to see progress',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.white30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRealChart(List<ExerciseProgressPoint> progressData) {
    // Convert real data to chart spots
    final weightSpots = <FlSpot>[];
    final repsSpots = <FlSpot>[];
    
    for (int i = 0; i < progressData.length; i++) {
      weightSpots.add(FlSpot(i.toDouble(), progressData[i].avgWeight));
      repsSpots.add(FlSpot(i.toDouble(), progressData[i].avgReps * 5)); // Scale reps for visualization
    }
    
    if (weightSpots.isEmpty) return _buildEmptyChartState();
    
    // Calculate chart bounds
    final maxWeight = progressData.map((p) => p.avgWeight).reduce((a, b) => a > b ? a : b);
    final maxReps = progressData.map((p) => p.avgReps).reduce((a, b) => a > b ? a : b);
    final maxY = (maxWeight > maxReps * 5 ? maxWeight : maxReps * 5) * 1.2;

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY / 4,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: AppColors.white10,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: progressData.length > 5 ? (progressData.length / 5).ceilToDouble() : 1,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < progressData.length) {
                  final date = progressData[value.toInt()].date;
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${date.month}/${date.day}',
                      style: const TextStyle(
                        color: AppColors.white50,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: maxY / 4,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: const TextStyle(
                    color: AppColors.white50,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (progressData.length - 1).toDouble(),
        minY: 0,
        maxY: maxY,
        lineBarsData: [
          // Weight line
          LineChartBarData(
            spots: weightSpots,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                AppColors.cyberLime.withOpacity(0.8),
                AppColors.cyberLime,
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: AppColors.cyberLime,
                  strokeWidth: 2,
                  strokeColor: Colors.black,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  AppColors.cyberLime.withOpacity(0.2),
                  AppColors.cyberLime.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Reps line
          LineChartBarData(
            spots: repsSpots,
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                AppColors.electricCyan.withOpacity(0.8),
                AppColors.electricCyan,
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: AppColors.electricCyan,
                  strokeWidth: 2,
                  strokeColor: Colors.black,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  AppColors.electricCyan.withOpacity(0.2),
                  AppColors.electricCyan.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => AppColors.white10,
            tooltipBorder: const BorderSide(
              color: AppColors.cyberLime,
              width: 1,
            ),
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                final isWeight = spot.barIndex == 0;
                final displayValue = isWeight ? spot.y : spot.y / 5;
                return LineTooltipItem(
                  '${displayValue.toStringAsFixed(1)} ${isWeight ? 'kg' : 'reps'}',
                  TextStyle(
                    color: isWeight ? AppColors.cyberLime : AppColors.electricCyan,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalRecords(ExercisePersonalRecords prs) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.cyberLime.withOpacity(0.1),
            AppColors.electricCyan.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cyberLime,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyberLime.withOpacity(0.2),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.emoji_events, color: AppColors.cyberLime, size: 24),
              SizedBox(width: 8),
              Text(
                'PERSONAL RECORDS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: AppColors.cyberLime,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildRecordRow('Heaviest Weight', prs.heaviestWeight > 0 ? '${prs.heaviestWeight.toStringAsFixed(1)} kg' : '-- kg'),
          const Divider(color: AppColors.white10, height: 24),
          _buildRecordRow('Best 1RM', prs.best1rm > 0 ? '${prs.best1rm.toStringAsFixed(1)} kg' : '-- kg'),
          const Divider(color: AppColors.white10, height: 24),
          _buildRecordRow('Best Set Volume', prs.bestSetVolume > 0 ? '${prs.bestSetVolumeWeight.toStringAsFixed(1)} kg × ${prs.bestSetVolumeReps}' : '-- kg × --'),
          const Divider(color: AppColors.white10, height: 24),
          _buildRecordRow('Best Session Volume', prs.bestSessionVolume > 0 ? '${prs.bestSessionVolume.toStringAsFixed(1)} kg' : '-- kg'),
        ],
      ),
    );
  }

  Widget _buildRecordRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.white70,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.electricCyan,
          ),
        ),
      ],
    );
  }
}
