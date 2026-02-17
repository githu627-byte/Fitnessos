import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/app_colors.dart';
import '../models/analytics_data.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// PR TIMELINE - Personal Records Timeline
/// ═══════════════════════════════════════════════════════════════════════════
/// A beautiful timeline showing recent PRs with animated entrance.
/// Each PR shows exercise name, weight x reps, and date.
/// ═══════════════════════════════════════════════════════════════════════════

class PRTimelineWidget extends StatefulWidget {
  final List<PersonalRecord> prs;
  final String title;
  final VoidCallback? onViewAll;

  const PRTimelineWidget({
    super.key,
    required this.prs,
    this.title = 'RECENT PRs',
    this.onViewAll,
  });

  @override
  State<PRTimelineWidget> createState() => _PRTimelineWidgetState();
}

class _PRTimelineWidgetState extends State<PRTimelineWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.neonOrange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: AppColors.neonOrange,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    if (widget.onViewAll != null)
                      GestureDetector(
                        onTap: widget.onViewAll,
                        child: Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.cyberLime,
                          ),
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Timeline
                if (widget.prs.isEmpty)
                  _buildEmptyState()
                else
                  ...widget.prs.asMap().entries.map((entry) {
                    final index = entry.key;
                    final pr = entry.value;
                    return _buildTimelineItem(pr, index, widget.prs.length);
                  }),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTimelineItem(PersonalRecord pr, int index, int total) {
    final isLast = index == total - 1;
    
    // Calculate staggered animation
    final startDelay = index * 0.15;
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = ((_controller.value - startDelay) / 0.3).clamp(0.0, 1.0);
        final curvedProgress = Curves.easeOutCubic.transform(progress);
        
        return Opacity(
          opacity: curvedProgress,
          child: Transform.translate(
            offset: Offset(20 * (1 - curvedProgress), 0),
            child: child,
          ),
        );
      },
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline line and dot
            Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.neonOrange,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.neonOrange.withOpacity(0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Colors.white.withOpacity(0.15),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(width: 16),
            
            // PR Card
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: isLast ? 0 : 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.neonOrange.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            pr.exerciseName,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.neonOrange.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'PR',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: AppColors.neonOrange,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          pr.displayString,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.cyberLime,
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (pr.estimated1RM > 0)
                          Text(
                            'e1RM: ${pr.estimated1RM.toStringAsFixed(1)} kg',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatDate(pr.date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.emoji_events_outlined,
              color: Colors.white.withOpacity(0.2),
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'No PRs yet',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Keep training to set new records!',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// TOP EXERCISES - Horizontal Bar Chart
/// ═══════════════════════════════════════════════════════════════════════════

class TopExercisesWidget extends StatefulWidget {
  final List<ExerciseVolume> topExercises;
  final String title;

  const TopExercisesWidget({
    super.key,
    required this.topExercises,
    this.title = 'TOP EXERCISES',
  });

  @override
  State<TopExercisesWidget> createState() => _TopExercisesWidgetState();
}

class _TopExercisesWidgetState extends State<TopExercisesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxVolume = widget.topExercises.isEmpty
        ? 1.0
        : widget.topExercises.first.totalVolume;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.cyberLime.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        color: AppColors.cyberLime,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                if (widget.topExercises.isEmpty)
                  _buildEmptyState()
                else
                  ...widget.topExercises.asMap().entries.map((entry) {
                    return _buildExerciseBar(
                      entry.value,
                      entry.key,
                      maxVolume,
                    );
                  }),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildExerciseBar(ExerciseVolume exercise, int index, double maxVolume) {
    final percentage = maxVolume > 0 ? exercise.totalVolume / maxVolume : 0.0;
    
    // Staggered animation
    final startDelay = index * 0.1;
    
    // Gradient colors for ranking
    final colors = [
      [AppColors.cyberLime, AppColors.cyberLime.withOpacity(0.7)],
      [AppColors.cyberLime, AppColors.cyberLime.withOpacity(0.7)],
      [AppColors.neonOrange, AppColors.neonOrange.withOpacity(0.7)],
      [AppColors.neonPurple, AppColors.neonPurple.withOpacity(0.7)],
      [Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.3)],
    ];
    
    final barColors = colors[index.clamp(0, colors.length - 1)];
    
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final progress = ((_controller.value - startDelay) / 0.3).clamp(0.0, 1.0);
        final curvedProgress = Curves.easeOutCubic.transform(progress);
        final barProgress = percentage * curvedProgress;
        
        return Opacity(
          opacity: curvedProgress,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: barColors[0].withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: barColors[0],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          exercise.exerciseName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      exercise.formattedVolume,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: barColors[0],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    // Background bar
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Progress bar
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 8,
                      width: MediaQuery.of(context).size.width * 0.7 * barProgress,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: barColors,
                        ),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: barColors[0].withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${exercise.setCount} sets • ${exercise.totalReps} reps',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.fitness_center_outlined,
              color: Colors.white.withOpacity(0.2),
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'No exercises logged',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete workouts to see your top exercises',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// EXERCISE PROGRESSION CHART
/// ═══════════════════════════════════════════════════════════════════════════

class ProgressionChartWidget extends StatefulWidget {
  final Map<String, List<dynamic>> exerciseProgressions;
  final Map<String, double> progressPercentages;
  final String title;

  const ProgressionChartWidget({
    super.key,
    required this.exerciseProgressions,
    required this.progressPercentages,
    this.title = 'STRENGTH PROGRESSION',
  });

  @override
  State<ProgressionChartWidget> createState() => _ProgressionChartWidgetState();
}

class _ProgressionChartWidgetState extends State<ProgressionChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String? _selectedExercise;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
    
    if (widget.exerciseProgressions.isNotEmpty) {
      _selectedExercise = widget.exerciseProgressions.keys.first;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.cyberLime.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.trending_up,
                        color: AppColors.cyberLime,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Exercise selector chips
                if (widget.exerciseProgressions.isNotEmpty) ...[
                  SizedBox(
                    height: 36,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: widget.exerciseProgressions.keys.map((exercise) {
                        final isSelected = _selectedExercise == exercise;
                        final progress = widget.progressPercentages[exercise] ?? 0;
                        
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            setState(() {
                              _selectedExercise = exercise;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.cyberLime.withOpacity(0.2)
                                  : Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.cyberLime
                                    : Colors.white.withOpacity(0.1),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  exercise,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? AppColors.cyberLime
                                        : Colors.white.withOpacity(0.6),
                                  ),
                                ),
                                if (progress != 0) ...[
                                  const SizedBox(width: 6),
                                  Icon(
                                    progress > 0
                                        ? Icons.arrow_upward
                                        : Icons.arrow_downward,
                                    size: 12,
                                    color: progress > 0
                                        ? AppColors.cyberLime
                                        : AppColors.neonCrimson,
                                  ),
                                  Text(
                                    '${progress.abs().toStringAsFixed(0)}%',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: progress > 0
                                          ? AppColors.cyberLime
                                          : AppColors.neonCrimson,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Progression indicator
                  if (_selectedExercise != null) ...[
                    _buildProgressionInfo(),
                  ],
                ] else
                  _buildEmptyState(),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildProgressionInfo() {
    final data = widget.exerciseProgressions[_selectedExercise!];
    if (data == null || data.isEmpty) return const SizedBox();
    
    final progress = widget.progressPercentages[_selectedExercise!] ?? 0;
    
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProgressStat(
                'Sessions',
                '${data.length}',
                AppColors.cyberLime,
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withOpacity(0.1),
              ),
              _buildProgressStat(
                'Progress',
                data.length < 2 ? '—' : '${progress > 0 ? '+' : ''}${progress.toStringAsFixed(1)}%',
                data.length < 2 ? Colors.white.withOpacity(0.5) : (progress >= 0 ? AppColors.cyberLime : AppColors.neonCrimson),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Simple progress visualization
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.cyberLime.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.cyberLime.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppColors.cyberLime,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  data.length < 2
                      ? 'Need 2+ sessions to calculate progress'
                      : progress > 0
                          ? 'You\'ve increased your max weight by ${progress.toStringAsFixed(1)}%!'
                          : progress < 0
                              ? 'Focus on progressive overload to get back on track'
                              : 'Keep training to track your progress',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildProgressStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
  
  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.show_chart_outlined,
              color: Colors.white.withOpacity(0.2),
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Track your Big 3',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Log Bench, Squat, and Deadlift to see progression',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white.withOpacity(0.3),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
