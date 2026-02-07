import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/app_colors.dart';
import '../models/analytics_data.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// HERO STATS CARD - The Crown Jewel of Analytics
/// ═══════════════════════════════════════════════════════════════════════════
/// Features:
/// - Animated power level counter with glow
/// - Radial progress ring animation
/// - Particle effects on milestone
/// - Glassmorphism with depth
/// ═══════════════════════════════════════════════════════════════════════════

class HeroStatsCard extends StatefulWidget {
  final AnalyticsData data;
  final VoidCallback? onTap;

  const HeroStatsCard({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  State<HeroStatsCard> createState() => _HeroStatsCardState();
}

class _HeroStatsCardState extends State<HeroStatsCard>
    with TickerProviderStateMixin {
  late AnimationController _powerLevelController;
  late AnimationController _ringController;
  late AnimationController _glowController;
  late AnimationController _particleController;
  
  late Animation<int> _powerLevelAnimation;
  late Animation<double> _ringAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    
    // Power level counter animation
    _powerLevelController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _powerLevelAnimation = IntTween(
      begin: 0,
      end: widget.data.powerLevel,
    ).animate(CurvedAnimation(
      parent: _powerLevelController,
      curve: Curves.easeOutCubic,
    ));
    
    // Ring progress animation
    _ringController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _ringAnimation = Tween<double>(
      begin: 0,
      end: (widget.data.powerLevel % 100) / 100,
    ).animate(CurvedAnimation(
      parent: _ringController,
      curve: Curves.easeOutCubic,
    ));
    
    // Glow pulse animation
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    
    _glowAnimation = Tween<double>(
      begin: 0.3,
      end: 0.8,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: Curves.easeInOut,
    ));
    
    // Particle burst animation
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    // Start animations with delay
    Future.delayed(const Duration(milliseconds: 300), () {
      _powerLevelController.forward();
      _ringController.forward();
    });
  }

  @override
  void didUpdateWidget(HeroStatsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.data.powerLevel != widget.data.powerLevel) {
      _powerLevelAnimation = IntTween(
        begin: oldWidget.data.powerLevel,
        end: widget.data.powerLevel,
      ).animate(CurvedAnimation(
        parent: _powerLevelController,
        curve: Curves.easeOutCubic,
      ));
      
      _ringAnimation = Tween<double>(
        begin: (oldWidget.data.powerLevel % 100) / 100,
        end: (widget.data.powerLevel % 100) / 100,
      ).animate(CurvedAnimation(
        parent: _ringController,
        curve: Curves.easeOutCubic,
      ));
      
      _powerLevelController.forward(from: 0);
      _ringController.forward(from: 0);
      
      // Trigger particle burst if increased
      if (widget.data.powerLevel > oldWidget.data.powerLevel) {
        HapticFeedback.heavyImpact();
        _particleController.forward(from: 0);
      }
    }
  }

  @override
  void dispose() {
    _powerLevelController.dispose();
    _ringController.dispose();
    _glowController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tierColor = Color(AnalyticsData.getPowerLevelColor(widget.data.powerLevel));
    final tierName = AnalyticsData.getPowerLevelTier(widget.data.powerLevel);
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onTap?.call();
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AnimatedBuilder(
              animation: _glowAnimation,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1.8,
                      colors: [
                        tierColor.withOpacity(0.2 * _glowAnimation.value),
                        AppColors.electricCyan.withOpacity(0.08),
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(
                      color: tierColor.withOpacity(0.4),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: tierColor.withOpacity(0.3 * _glowAnimation.value),
                        blurRadius: 50,
                        spreadRadius: -5,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: child,
                );
              },
              child: Column(
                children: [
                  // Power Level Section with Ring
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Particle effects
                      AnimatedBuilder(
                        animation: _particleController,
                        builder: (context, child) {
                          if (_particleController.value == 0) return const SizedBox();
                          return CustomPaint(
                            size: const Size(200, 200),
                            painter: _ParticleBurstPainter(
                              progress: _particleController.value,
                              color: tierColor,
                            ),
                          );
                        },
                      ),
                      
                      // Progress ring
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: AnimatedBuilder(
                          animation: _ringAnimation,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: _PowerRingPainter(
                                progress: _ringAnimation.value,
                                color: tierColor,
                                glowIntensity: _glowAnimation.value,
                              ),
                              child: child,
                            );
                          },
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Tier badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: tierColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: tierColor.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    tierName,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2,
                                      color: tierColor,
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(height: 8),
                                
                                // Power level number
                                AnimatedBuilder(
                                  animation: _powerLevelAnimation,
                                  builder: (context, child) {
                                    return ShaderMask(
                                      shaderCallback: (bounds) {
                                        return LinearGradient(
                                          colors: [
                                            tierColor,
                                            tierColor.withOpacity(0.8),
                                            Colors.white,
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(bounds);
                                      },
                                      child: Text(
                                        '${_powerLevelAnimation.value}',
                                        style: const TextStyle(
                                          fontSize: 64,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white,
                                          height: 1.0,
                                          letterSpacing: -2,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                
                                Text(
                                  'POWER LEVEL',
                                  style: TextStyle(
                                    fontSize: 11,
                                    letterSpacing: 3,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Stats Grid
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _StatPill(
                        icon: Icons.whatshot_rounded,
                        value: _formatCalories(widget.data.totalCalories),
                        label: 'CALORIES',
                        color: AppColors.neonOrange,
                        delay: 0,
                      ),
                      _StatPill(
                        icon: Icons.fitness_center_rounded,
                        value: '${widget.data.totalWorkouts}',
                        label: 'WORKOUTS',
                        color: AppColors.electricCyan,
                        delay: 100,
                      ),
                      _StatPill(
                        icon: Icons.repeat_rounded,
                        value: _formatNumber(widget.data.totalReps),
                        label: 'REPS',
                        color: AppColors.cyberLime,
                        delay: 200,
                      ),
                      _StatPill(
                        icon: Icons.timer_rounded,
                        value: widget.data.totalHours.toStringAsFixed(1),
                        label: 'HOURS',
                        color: AppColors.neonPurple,
                        delay: 300,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Volume stat
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.trending_up_rounded,
                          color: AppColors.cyberLime,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'TOTAL VOLUME',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w700,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _formatVolume(widget.data.totalVolumeKg),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: AppColors.cyberLime,
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
      ),
    );
  }
  
  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
  
  String _formatVolume(double volume) {
    if (volume >= 1000000) {
      return '${(volume / 1000000).toStringAsFixed(2)}M kg';
    } else if (volume >= 1000) {
      return '${(volume / 1000).toStringAsFixed(1)}K kg';
    }
    return '${volume.toStringAsFixed(0)} kg';
  }
  
  String _formatCalories(int calories) {
    if (calories >= 1000000) {
      return '${(calories / 1000000).toStringAsFixed(1)}M';
    } else if (calories >= 1000) {
      return '${(calories / 1000).toStringAsFixed(1)}K';
    }
    return calories.toString();
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// STAT PILL WIDGET
/// ═══════════════════════════════════════════════════════════════════════════

class _StatPill extends StatefulWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final int delay;

  const _StatPill({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    this.delay = 0,
  });

  @override
  State<_StatPill> createState() => _StatPillState();
}

class _StatPillState extends State<_StatPill>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));
    
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));
    
    Future.delayed(Duration(milliseconds: 500 + widget.delay), () {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.color.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Icon(
              widget.icon,
              color: widget.color,
              size: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: widget.color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 9,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// POWER RING PAINTER
/// ═══════════════════════════════════════════════════════════════════════════

class _PowerRingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double glowIntensity;

  _PowerRingPainter({
    required this.progress,
    required this.color,
    required this.glowIntensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 20) / 2;
    
    // Background ring
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    
    canvas.drawCircle(center, radius, bgPaint);
    
    // Progress ring with gradient
    final rect = Rect.fromCircle(center: center, radius: radius);
    final progressPaint = Paint()
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: [
          color.withOpacity(0.3),
          color,
          color.withOpacity(0.8),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    
    // Draw progress arc
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
    
    // Glow effect at the end
    if (progress > 0) {
      final endAngle = -math.pi / 2 + sweepAngle;
      final endX = center.dx + radius * math.cos(endAngle);
      final endY = center.dy + radius * math.sin(endAngle);
      
      final glowPaint = Paint()
        ..color = color.withOpacity(0.6 * glowIntensity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      
      canvas.drawCircle(Offset(endX, endY), 8, glowPaint);
      
      // Bright center
      final dotPaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(Offset(endX, endY), 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_PowerRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
           oldDelegate.glowIntensity != glowIntensity;
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// PARTICLE BURST PAINTER
/// ═══════════════════════════════════════════════════════════════════════════

class _ParticleBurstPainter extends CustomPainter {
  final double progress;
  final Color color;
  static const int particleCount = 24;

  _ParticleBurstPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * math.pi;
      final distance = progress * size.width * 0.6;
      
      final x = center.dx + math.cos(angle) * distance;
      final y = center.dy + math.sin(angle) * distance;

      // Fade out as particles move away
      final opacity = (1.0 - progress).clamp(0.0, 1.0);
      
      // Alternate colors
      final colors = [
        color,
        AppColors.electricCyan,
        Colors.white,
      ];
      
      paint.color = colors[i % colors.length].withOpacity(opacity);

      // Vary particle sizes
      final radius = (4.0 + (i % 4) * 1.5) * (1.0 - progress * 0.7);
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(_ParticleBurstPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
