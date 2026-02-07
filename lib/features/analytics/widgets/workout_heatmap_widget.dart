import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/app_colors.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// WORKOUT HEATMAP - GitHub-Style Activity Calendar
/// ═══════════════════════════════════════════════════════════════════════════
/// A beautiful visualization of workout consistency over time.
/// Darker colors = higher intensity workouts.
/// ═══════════════════════════════════════════════════════════════════════════

class WorkoutHeatmapWidget extends StatefulWidget {
  final Map<DateTime, double> workoutIntensityMap;
  final int daysToShow;
  final String title;
  final VoidCallback? onDayTap;

  const WorkoutHeatmapWidget({
    super.key,
    required this.workoutIntensityMap,
    this.daysToShow = 91, // ~3 months
    this.title = 'TRAINING CONSISTENCY',
    this.onDayTap,
  });

  @override
  State<WorkoutHeatmapWidget> createState() => _WorkoutHeatmapWidgetState();
}

class _WorkoutHeatmapWidgetState extends State<WorkoutHeatmapWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  DateTime? _selectedDate;
  
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
    final today = DateTime.now();
    final startDate = today.subtract(Duration(days: widget.daysToShow));
    
    // Calculate grid dimensions
    final weeks = ((widget.daysToShow + startDate.weekday) / 7).ceil();
    
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
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_getWorkoutCount()} workouts in ${widget.daysToShow} days',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    // Legend
                    Row(
                      children: [
                        Text(
                          'Less',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(width: 6),
                        ...List.generate(5, (i) {
                          return Container(
                            margin: const EdgeInsets.only(right: 3),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: _getIntensityColor(i / 4),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          );
                        }),
                        const SizedBox(width: 3),
                        Text(
                          'More',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Day labels
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDayLabel('M'),
                          const SizedBox(height: 16),
                          _buildDayLabel('W'),
                          const SizedBox(height: 16),
                          _buildDayLabel('F'),
                          const SizedBox(height: 16),
                          _buildDayLabel('S'),
                        ],
                      ),
                    ),
                    
                    // Heatmap grid
                    Expanded(
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            reverse: true,
                            child: Row(
                              children: List.generate(weeks, (weekIndex) {
                                return _buildWeekColumn(
                                  weekIndex,
                                  startDate,
                                  today,
                                  _controller.value,
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                
                // Selected date info
                if (_selectedDate != null) ...[
                  const SizedBox(height: 16),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.cyberLime.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.cyberLime.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: AppColors.cyberLime,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _formatDate(_selectedDate!),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          _getIntensityLabel(_selectedDate!),
                          style: TextStyle(
                            color: AppColors.cyberLime,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildDayLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: Colors.white.withOpacity(0.4),
      ),
    );
  }
  
  Widget _buildWeekColumn(
    int weekIndex,
    DateTime startDate,
    DateTime today,
    double animationProgress,
  ) {
    return Column(
      children: List.generate(7, (dayIndex) {
        final daysFromStart = weekIndex * 7 + dayIndex - startDate.weekday + 1;
        final date = startDate.add(Duration(days: daysFromStart));
        
        // Skip future dates or dates before start
        if (date.isAfter(today) || date.isBefore(startDate)) {
          return Container(
            margin: const EdgeInsets.all(2),
            width: 14,
            height: 14,
          );
        }
        
        final normalizedDate = DateTime(date.year, date.month, date.day);
        final intensity = widget.workoutIntensityMap[normalizedDate] ?? 0.0;
        
        // Staggered animation
        final cellDelay = (weekIndex * 7 + dayIndex) / (widget.daysToShow);
        final cellProgress = ((animationProgress - cellDelay * 0.5) * 2).clamp(0.0, 1.0);
        
        final isSelected = _selectedDate != null &&
            normalizedDate.year == _selectedDate!.year &&
            normalizedDate.month == _selectedDate!.month &&
            normalizedDate.day == _selectedDate!.day;
        
        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            setState(() {
              _selectedDate = _selectedDate == normalizedDate ? null : normalizedDate;
            });
            widget.onDayTap?.call();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            margin: const EdgeInsets.all(2),
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: _getIntensityColor(intensity).withOpacity(cellProgress),
              borderRadius: BorderRadius.circular(3),
              border: isSelected
                  ? Border.all(color: Colors.white, width: 2)
                  : null,
              boxShadow: intensity > 0.5
                  ? [
                      BoxShadow(
                        color: AppColors.cyberLime.withOpacity(0.3 * cellProgress),
                        blurRadius: 4,
                      ),
                    ]
                  : null,
            ),
          ),
        );
      }),
    );
  }
  
  Color _getIntensityColor(double intensity) {
    if (intensity == 0) {
      return Colors.white.withOpacity(0.08);
    }
    
    // Gradient from dark to bright lime
    if (intensity < 0.25) {
      return AppColors.cyberLime.withOpacity(0.2);
    } else if (intensity < 0.5) {
      return AppColors.cyberLime.withOpacity(0.4);
    } else if (intensity < 0.75) {
      return AppColors.cyberLime.withOpacity(0.65);
    } else {
      return AppColors.cyberLime;
    }
  }
  
  int _getWorkoutCount() {
    return widget.workoutIntensityMap.values
        .where((intensity) => intensity > 0)
        .length;
  }
  
  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    return '${days[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}';
  }
  
  String _getIntensityLabel(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final intensity = widget.workoutIntensityMap[normalizedDate] ?? 0.0;
    
    if (intensity == 0) return 'Rest day';
    if (intensity < 0.25) return 'Light workout';
    if (intensity < 0.5) return 'Moderate workout';
    if (intensity < 0.75) return 'Intense workout';
    return 'Max effort! 🔥';
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// WEEKDAY DISTRIBUTION CHART
/// ═══════════════════════════════════════════════════════════════════════════

class WeekdayDistributionChart extends StatefulWidget {
  final Map<int, int> weekdayDistribution;

  const WeekdayDistributionChart({
    super.key,
    required this.weekdayDistribution,
  });

  @override
  State<WeekdayDistributionChart> createState() => _WeekdayDistributionChartState();
}

class _WeekdayDistributionChartState extends State<WeekdayDistributionChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
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
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final maxCount = widget.weekdayDistribution.values.isEmpty
        ? 1
        : widget.weekdayDistribution.values.reduce((a, b) => a > b ? a : b);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FAVORITE TRAINING DAYS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  final count = widget.weekdayDistribution[index] ?? 0;
                  final height = maxCount > 0 ? (count / maxCount) * 80 : 0.0;
                  final animatedHeight = height * _controller.value;
                  
                  return Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (count > 0 && _controller.value > 0.5)
                              Text(
                                '$count',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withOpacity(
                                    (_controller.value - 0.5) * 2,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 4),
                            Container(
                              width: 28,
                              height: animatedHeight + 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppColors.cyberLime.withOpacity(0.5),
                                    AppColors.cyberLime,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: height > 40
                                    ? [
                                        BoxShadow(
                                          color: AppColors.cyberLime.withOpacity(0.4),
                                          blurRadius: 8,
                                          spreadRadius: -2,
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        days[index],
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
