import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../utils/app_colors.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// REP QUALITY DONUT CHART - Perfect/Good/Miss Distribution
/// ═══════════════════════════════════════════════════════════════════════════
/// A stunning animated donut chart showing rep quality breakdown.
/// Only visible for users who have used camera mode.
/// ═══════════════════════════════════════════════════════════════════════════

class RepQualityDonutWidget extends StatefulWidget {
  final int perfectReps;
  final int goodReps;
  final int missReps;
  final String title;

  const RepQualityDonutWidget({
    super.key,
    required this.perfectReps,
    required this.goodReps,
    required this.missReps,
    this.title = 'REP QUALITY',
  });

  @override
  State<RepQualityDonutWidget> createState() => _RepQualityDonutWidgetState();
}

class _RepQualityDonutWidgetState extends State<RepQualityDonutWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int? _touchedIndex;

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

  int get _total => widget.perfectReps + widget.goodReps + widget.missReps;

  @override
  Widget build(BuildContext context) {
    if (_total == 0) {
      return const SizedBox.shrink();
    }

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
                        Icons.analytics,
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
                
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    // Donut Chart
                    Expanded(
                      flex: 3,
                      child: SizedBox(
                        height: 180,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback: (event, response) {
                                        setState(() {
                                          if (!event.isInterestedForInteractions ||
                                              response == null ||
                                              response.touchedSection == null) {
                                            _touchedIndex = -1;
                                            return;
                                          }
                                          _touchedIndex = response
                                              .touchedSection!.touchedSectionIndex;
                                        });
                                      },
                                    ),
                                    borderData: FlBorderData(show: false),
                                    sectionsSpace: 3,
                                    centerSpaceRadius: 50,
                                    sections: _buildSections(_controller.value),
                                  ),
                                ),
                                // Center text
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${(widget.perfectReps / _total * 100).toStringAsFixed(0)}%',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.cyberLime,
                                      ),
                                    ),
                                    Text(
                                      'PERFECT',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 24),
                    
                    // Legend
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLegendItem(
                            'Perfect',
                            widget.perfectReps,
                            AppColors.cyberLime,
                            _touchedIndex == 0,
                          ),
                          const SizedBox(height: 16),
                          _buildLegendItem(
                            'Good',
                            widget.goodReps,
                            AppColors.electricCyan,
                            _touchedIndex == 1,
                          ),
                          const SizedBox(height: 16),
                          _buildLegendItem(
                            'Missed',
                            widget.missReps,
                            AppColors.neonCrimson,
                            _touchedIndex == 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildSections(double progress) {
    final isTouched0 = _touchedIndex == 0;
    final isTouched1 = _touchedIndex == 1;
    final isTouched2 = _touchedIndex == 2;
    
    return [
      PieChartSectionData(
        color: AppColors.cyberLime,
        value: widget.perfectReps.toDouble() * progress,
        title: '',
        radius: isTouched0 ? 35 : 28,
        badgeWidget: isTouched0 ? _buildBadge('${widget.perfectReps}') : null,
        badgePositionPercentageOffset: 1.3,
      ),
      PieChartSectionData(
        color: AppColors.electricCyan,
        value: widget.goodReps.toDouble() * progress,
        title: '',
        radius: isTouched1 ? 35 : 28,
        badgeWidget: isTouched1 ? _buildBadge('${widget.goodReps}') : null,
        badgePositionPercentageOffset: 1.3,
      ),
      PieChartSectionData(
        color: AppColors.neonCrimson,
        value: widget.missReps.toDouble() * progress,
        title: '',
        radius: isTouched2 ? 35 : 28,
        badgeWidget: isTouched2 ? _buildBadge('${widget.missReps}') : null,
        badgePositionPercentageOffset: 1.3,
      ),
    ];
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, int count, Color color, bool isSelected) {
    final percentage = _total > 0 ? (count / _total * 100) : 0.0;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? color.withOpacity(0.15) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.5),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                Text(
                  '$count (${percentage.toStringAsFixed(0)}%)',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// FORM IQ CARD - Your Movement Intelligence Score
/// ═══════════════════════════════════════════════════════════════════════════
/// A gamified score showing overall form quality.
/// Includes animated gauge and breakdown.
/// ═══════════════════════════════════════════════════════════════════════════

class FormIQCardWidget extends StatefulWidget {
  final int formIQ;
  final double avgFormScore;
  final int longestPerfectStreak;
  final int totalQualityReps;

  const FormIQCardWidget({
    super.key,
    required this.formIQ,
    required this.avgFormScore,
    required this.longestPerfectStreak,
    required this.totalQualityReps,
  });

  @override
  State<FormIQCardWidget> createState() => _FormIQCardWidgetState();
}

class _FormIQCardWidgetState extends State<FormIQCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gaugeAnimation;
  late Animation<int> _countAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _gaugeAnimation = Tween<double>(
      begin: 0,
      end: widget.formIQ / 100,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    _countAnimation = IntTween(
      begin: 0,
      end: widget.formIQ,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.totalQualityReps == 0) {
      return const SizedBox.shrink();
    }

    final tierInfo = _getTierInfo(widget.formIQ);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.5,
                colors: [
                  tierInfo.color.withOpacity(0.15),
                  Colors.black.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: tierInfo.color.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: tierInfo.color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.psychology,
                        color: tierInfo.color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'FORM IQ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Movement Intelligence Score',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 28),
                
                // Gauge
                SizedBox(
                  height: 160,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        size: const Size(double.infinity, 160),
                        painter: _FormIQGaugePainter(
                          progress: _gaugeAnimation.value,
                          color: tierInfo.color,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 20),
                              Text(
                                '${_countAnimation.value}',
                                style: TextStyle(
                                  fontSize: 56,
                                  fontWeight: FontWeight.w900,
                                  color: tierInfo.color,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: tierInfo.color.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  tierInfo.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 2,
                                    color: tierInfo.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Stats row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatBox(
                        'Avg Score',
                        '${widget.avgFormScore.toStringAsFixed(0)}%',
                        Icons.show_chart,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatBox(
                        'Best Streak',
                        '${widget.longestPerfectStreak}',
                        Icons.local_fire_department,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatBox(
                        'Analyzed',
                        '${widget.totalQualityReps}',
                        Icons.analytics,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Tip
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.tips_and_updates,
                        color: tierInfo.color,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          tierInfo.tip,
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(0.4),
            size: 18,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  _FormIQTier _getTierInfo(int formIQ) {
    if (formIQ >= 90) {
      return _FormIQTier(
        name: 'MASTER',
        color: const Color(0xFFFFD700),
        tip: 'Exceptional form! You\'re in the top 1%.',
      );
    } else if (formIQ >= 75) {
      return _FormIQTier(
        name: 'ELITE',
        color: AppColors.neonPurple,
        tip: 'Outstanding form quality. Keep refining!',
      );
    } else if (formIQ >= 60) {
      return _FormIQTier(
        name: 'ADVANCED',
        color: AppColors.electricCyan,
        tip: 'Good form! Focus on consistency.',
      );
    } else if (formIQ >= 40) {
      return _FormIQTier(
        name: 'DEVELOPING',
        color: AppColors.cyberLime,
        tip: 'You\'re improving! Watch for common mistakes.',
      );
    } else {
      return _FormIQTier(
        name: 'BEGINNER',
        color: AppColors.neonOrange,
        tip: 'Focus on slow, controlled movements.',
      );
    }
  }
}

class _FormIQTier {
  final String name;
  final Color color;
  final String tip;

  _FormIQTier({
    required this.name,
    required this.color,
    required this.tip,
  });
}

class _FormIQGaugePainter extends CustomPainter {
  final double progress;
  final Color color;

  _FormIQGaugePainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 20);
    final radius = size.width / 2 - 30;
    
    // Background arc
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi,
      false,
      bgPaint,
    );
    
    // Progress arc with gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final progressPaint = Paint()
      ..shader = SweepGradient(
        startAngle: math.pi,
        endAngle: 2 * math.pi,
        colors: [
          AppColors.neonCrimson,
          AppColors.neonOrange,
          AppColors.cyberLime,
          color,
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round;
    
    final sweepAngle = math.pi * progress;
    canvas.drawArc(
      rect,
      math.pi,
      sweepAngle,
      false,
      progressPaint,
    );
    
    // End dot with glow
    if (progress > 0) {
      final endAngle = math.pi + sweepAngle;
      final endX = center.dx + radius * math.cos(endAngle);
      final endY = center.dy + radius * math.sin(endAngle);
      
      // Glow
      final glowPaint = Paint()
        ..color = color.withOpacity(0.6)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(Offset(endX, endY), 10, glowPaint);
      
      // Dot
      final dotPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(endX, endY), 6, dotPaint);
    }
    
    // Tick marks
    for (int i = 0; i <= 10; i++) {
      final tickAngle = math.pi + (math.pi * i / 10);
      final innerRadius = radius - 24;
      final outerRadius = radius - (i % 5 == 0 ? 32 : 28);
      
      final innerX = center.dx + innerRadius * math.cos(tickAngle);
      final innerY = center.dy + innerRadius * math.sin(tickAngle);
      final outerX = center.dx + outerRadius * math.cos(tickAngle);
      final outerY = center.dy + outerRadius * math.sin(tickAngle);
      
      final tickPaint = Paint()
        ..color = Colors.white.withOpacity(i % 5 == 0 ? 0.3 : 0.15)
        ..strokeWidth = i % 5 == 0 ? 2 : 1;
      
      canvas.drawLine(Offset(innerX, innerY), Offset(outerX, outerY), tickPaint);
    }
  }

  @override
  bool shouldRepaint(_FormIQGaugePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// FORM SCORE TIMELINE - Track Form Improvement Over Time
/// ═══════════════════════════════════════════════════════════════════════════

class FormScoreTimelineWidget extends StatefulWidget {
  final List<dynamic> formScoreData; // FlSpot list
  final String title;

  const FormScoreTimelineWidget({
    super.key,
    required this.formScoreData,
    this.title = 'FORM SCORE TREND',
  });

  @override
  State<FormScoreTimelineWidget> createState() => _FormScoreTimelineWidgetState();
}

class _FormScoreTimelineWidgetState extends State<FormScoreTimelineWidget>
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
    if (widget.formScoreData.isEmpty) {
      return const SizedBox.shrink();
    }

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
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 20),
                
                SizedBox(
                  height: 150,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 25,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                color: Colors.white.withOpacity(0.05),
                                strokeWidth: 1,
                              );
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 35,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    '${value.toInt()}%',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: 10,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          minY: 0,
                          maxY: 100,
                          lineBarsData: [
                            LineChartBarData(
                              spots: _getAnimatedSpots(_controller.value),
                              isCurved: true,
                              curveSmoothness: 0.3,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.electricCyan,
                                  AppColors.cyberLime,
                                ],
                              ),
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: const FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    AppColors.cyberLime.withOpacity(0.2),
                                    AppColors.cyberLime.withOpacity(0.0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _getAnimatedSpots(double progress) {
    return widget.formScoreData.map((spot) {
      final flSpot = spot as FlSpot;
      return FlSpot(flSpot.x, flSpot.y * progress);
    }).toList();
  }
}
