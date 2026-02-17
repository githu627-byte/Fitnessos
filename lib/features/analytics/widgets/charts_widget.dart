import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../utils/app_colors.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// BODY RADAR CHART - Spider Web Visualization
/// ═══════════════════════════════════════════════════════════════════════════
/// Shows muscle group balance across all body parts.
/// Perfectly balanced = perfect hexagon.
/// ═══════════════════════════════════════════════════════════════════════════

class BodyRadarChartWidget extends StatefulWidget {
  final Map<String, double> bodyPartPercentages;
  final String title;

  const BodyRadarChartWidget({
    super.key,
    required this.bodyPartPercentages,
    this.title = 'MUSCLE BALANCE',
  });

  @override
  State<BodyRadarChartWidget> createState() => _BodyRadarChartWidgetState();
}

class _BodyRadarChartWidgetState extends State<BodyRadarChartWidget>
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
    // Default body parts if empty
    final bodyParts = widget.bodyPartPercentages.isEmpty
        ? {'Chest': 0.0, 'Back': 0.0, 'Shoulders': 0.0, 'Arms': 0.0, 'Legs': 0.0, 'Core': 0.0}
        : widget.bodyPartPercentages;

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    _buildBalanceIndicator(bodyParts),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Radar chart
                SizedBox(
                  height: 250,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return CustomPaint(
                        size: const Size(double.infinity, 250),
                        painter: _RadarChartPainter(
                          values: bodyParts,
                          progress: Curves.easeOutCubic.transform(_controller.value),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Legend
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: bodyParts.entries.map((entry) {
                    return _buildLegendItem(entry.key, entry.value);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildBalanceIndicator(Map<String, double> bodyParts) {
    final values = bodyParts.values.toList();
    if (values.isEmpty || values.every((v) => v == 0)) {
      return const SizedBox();
    }
    
    final avg = values.reduce((a, b) => a + b) / values.length;
    final variance = values.map((v) => (v - avg).abs()).reduce((a, b) => a + b) / values.length;
    
    // Lower variance = more balanced
    final balanceScore = (100 - variance * 2).clamp(0, 100).toInt();
    
    Color color;
    String label;
    if (balanceScore >= 80) {
      color = AppColors.cyberLime;
      label = 'Excellent';
    } else if (balanceScore >= 60) {
      color = AppColors.cyberLime;
      label = 'Good';
    } else if (balanceScore >= 40) {
      color = AppColors.neonOrange;
      label = 'Fair';
    } else {
      color = AppColors.neonCrimson;
      label = 'Needs Work';
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.balance, color: color, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLegendItem(String label, double percentage) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.cyberLime,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$label ${percentage.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  final Map<String, double> values;
  final double progress;

  _RadarChartPainter({
    required this.values,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width < size.height ? size.width : size.height) / 2 - 40;
    final sides = values.length;
    
    if (sides < 3) return;
    
    // Draw background web
    _drawWeb(canvas, center, radius, sides);
    
    // Draw data polygon
    _drawDataPolygon(canvas, center, radius, sides);
    
    // Draw labels
    _drawLabels(canvas, center, radius, sides, size);
  }
  
  void _drawWeb(Canvas canvas, Offset center, double radius, int sides) {
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    
    // Draw concentric polygons
    for (int ring = 1; ring <= 4; ring++) {
      final ringRadius = radius * ring / 4;
      final path = Path();
      
      for (int i = 0; i <= sides; i++) {
        final angle = (2 * math.pi * i / sides) - math.pi / 2;
        final x = center.dx + ringRadius * math.cos(angle);
        final y = center.dy + ringRadius * math.sin(angle);
        
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      
      canvas.drawPath(path, bgPaint);
    }
    
    // Draw spokes
    for (int i = 0; i < sides; i++) {
      final angle = (2 * math.pi * i / sides) - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      
      canvas.drawLine(center, Offset(x, y), bgPaint);
    }
  }
  
  void _drawDataPolygon(Canvas canvas, Offset center, double radius, int sides) {
    if (values.values.every((v) => v == 0)) return;
    
    final entries = values.entries.toList();
    final maxValue = entries.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    if (maxValue == 0) return;
    
    // Fill
    final fillPath = Path();
    for (int i = 0; i <= sides; i++) {
      final index = i % sides;
      final normalizedValue = entries[index].value / maxValue;
      final animatedValue = normalizedValue * progress;
      
      final angle = (2 * math.pi * i / sides) - math.pi / 2;
      final pointRadius = radius * animatedValue * 0.9;
      final x = center.dx + pointRadius * math.cos(angle);
      final y = center.dy + pointRadius * math.sin(angle);
      
      if (i == 0) {
        fillPath.moveTo(x, y);
      } else {
        fillPath.lineTo(x, y);
      }
    }
    
    // Gradient fill
    final fillPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.cyberLime.withOpacity(0.3),
          AppColors.cyberLime.withOpacity(0.05),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(fillPath, fillPaint);
    
    // Stroke
    final strokePaint = Paint()
      ..color = AppColors.cyberLime
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawPath(fillPath, strokePaint);
    
    // Draw points
    for (int i = 0; i < sides; i++) {
      final normalizedValue = entries[i].value / maxValue;
      final animatedValue = normalizedValue * progress;
      
      final angle = (2 * math.pi * i / sides) - math.pi / 2;
      final pointRadius = radius * animatedValue * 0.9;
      final x = center.dx + pointRadius * math.cos(angle);
      final y = center.dy + pointRadius * math.sin(angle);
      
      // Glow
      final glowPaint = Paint()
        ..color = AppColors.cyberLime.withOpacity(0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
      canvas.drawCircle(Offset(x, y), 6, glowPaint);
      
      // Point
      final pointPaint = Paint()
        ..color = AppColors.cyberLime
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), 4, pointPaint);
    }
  }
  
  void _drawLabels(Canvas canvas, Offset center, double radius, int sides, Size size) {
    final entries = values.entries.toList();
    
    for (int i = 0; i < sides; i++) {
      final angle = (2 * math.pi * i / sides) - math.pi / 2;
      final labelRadius = radius + 25;
      var x = center.dx + labelRadius * math.cos(angle);
      var y = center.dy + labelRadius * math.sin(angle);
      
      final textPainter = TextPainter(
        text: TextSpan(
          text: entries[i].key,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      
      // Center text on point
      x -= textPainter.width / 2;
      y -= textPainter.height / 2;
      
      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(_RadarChartPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.values != values;
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// VOLUME LINE CHART - Beautiful Trend Visualization
/// ═══════════════════════════════════════════════════════════════════════════

class VolumeChartWidget extends StatefulWidget {
  final List<FlSpot> volumeData;
  final String title;
  final String subtitle;
  final Color color;

  const VolumeChartWidget({
    super.key,
    required this.volumeData,
    this.title = 'TRAINING VOLUME',
    this.subtitle = 'Last 30 days',
    this.color = AppColors.cyberLime,
  });

  @override
  State<VolumeChartWidget> createState() => _VolumeChartWidgetState();
}

class _VolumeChartWidgetState extends State<VolumeChartWidget>
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
    // Calculate stats
    final totalVolume = widget.volumeData.isEmpty
        ? 0.0
        : widget.volumeData.fold<double>(0, (sum, spot) => sum + spot.y);
    final avgVolume = widget.volumeData.isEmpty
        ? 0.0
        : totalVolume / widget.volumeData.length;
    final trend = _calculateTrend();

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
                          widget.subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    _buildTrendBadge(trend),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Stats row
                Row(
                  children: [
                    _buildStatChip(
                      'Total',
                      _formatVolume(totalVolume),
                      widget.color,
                    ),
                    const SizedBox(width: 12),
                    _buildStatChip(
                      'Average',
                      _formatVolume(avgVolume),
                      AppColors.cyberLime,
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // Chart
                SizedBox(
                  height: 180,
                  child: widget.volumeData.isEmpty
                      ? _buildEmptyChart()
                      : AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return LineChart(
                              LineChartData(
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: false,
                                  horizontalInterval: _calculateInterval(),
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
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 45,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          _formatVolumeShort(value),
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.4),
                                            fontSize: 10,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  bottomTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: _getAnimatedSpots(_controller.value),
                                    isCurved: true,
                                    curveSmoothness: 0.3,
                                    color: widget.color,
                                    barWidth: 3,
                                    isStrokeCapRound: true,
                                    dotData: FlDotData(
                                      show: true,
                                      getDotPainter: (spot, percent, barData, index) {
                                        return FlDotCirclePainter(
                                          radius: index == widget.volumeData.length - 1 ? 5 : 0,
                                          color: widget.color,
                                          strokeWidth: 2,
                                          strokeColor: Colors.white,
                                        );
                                      },
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          widget.color.withOpacity(0.3),
                                          widget.color.withOpacity(0.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                                lineTouchData: LineTouchData(
                                  touchTooltipData: LineTouchTooltipData(
                                    getTooltipColor: (spot) => Colors.black.withOpacity(0.8),
                                    tooltipRoundedRadius: 8,
                                    getTooltipItems: (touchedSpots) {
                                      return touchedSpots.map((spot) {
                                        return LineTooltipItem(
                                          _formatVolume(spot.y),
                                          TextStyle(
                                            color: widget.color,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }).toList();
                                    },
                                  ),
                                ),
                              ),
                              duration: const Duration(milliseconds: 300),
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
    return widget.volumeData.map((spot) {
      return FlSpot(spot.x, spot.y * progress);
    }).toList();
  }
  
  double _calculateInterval() {
    if (widget.volumeData.isEmpty) return 1000;
    final maxY = widget.volumeData.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    return (maxY / 4).ceilToDouble().clamp(100, 10000);
  }
  
  double _calculateTrend() {
    if (widget.volumeData.length < 2) return 0;
    
    final halfPoint = widget.volumeData.length ~/ 2;
    final firstHalf = widget.volumeData.sublist(0, halfPoint);
    final secondHalf = widget.volumeData.sublist(halfPoint);
    
    final firstAvg = firstHalf.fold<double>(0, (sum, s) => sum + s.y) / firstHalf.length;
    final secondAvg = secondHalf.fold<double>(0, (sum, s) => sum + s.y) / secondHalf.length;
    
    if (firstAvg == 0) return 0;
    return ((secondAvg - firstAvg) / firstAvg) * 100;
  }
  
  Widget _buildTrendBadge(double trend) {
    final isPositive = trend >= 0;
    final color = isPositive ? AppColors.cyberLime : AppColors.neonCrimson;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.trending_up : Icons.trending_down,
            color: color,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            '${isPositive ? '+' : ''}${trend.toStringAsFixed(1)}%',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildStatChip(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.white.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmptyChart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.show_chart,
            color: Colors.white.withOpacity(0.2),
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            'No data yet',
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Complete workouts to see your progress',
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatVolume(double volume) {
    if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(1)}M kg';
    } else if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K kg';
    }
    return '${volume.toStringAsFixed(0)} kg';
  }
  
  String _formatVolumeShort(double volume) {
    if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(0)}M';
    } else if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(0)}K';
    }
    return volume.toStringAsFixed(0);
  }
}
