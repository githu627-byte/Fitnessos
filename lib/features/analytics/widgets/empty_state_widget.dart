import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../utils/app_colors.dart';
import '../models/analytics_data.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// EMPTY STATE WIDGET - Beautiful Empty States
/// ═══════════════════════════════════════════════════════════════════════════

class AnalyticsEmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? buttonText;
  final VoidCallback? onButtonTap;
  final Color color;

  const AnalyticsEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.buttonText,
    this.onButtonTap,
    this.color = AppColors.electricCyan,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated icon container
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.2),
                      blurRadius: 30,
                      spreadRadius: -5,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 56,
                ),
              ),
            ),
            
            const SizedBox(height: 28),
            
            // Title
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Subtitle
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white.withOpacity(0.5),
                  height: 1.5,
                ),
              ),
            ),
            
            if (buttonText != null && onButtonTap != null) ...[
              const SizedBox(height: 32),
              
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    onButtonTap?.call();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: color,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_rounded,
                          color: color,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          buttonText!,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: color,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// ═══════════════════════════════════════════════════════════════════════════
/// SHAREABLE CARD GENERATOR - Create Instagram-Ready Share Cards
/// ═══════════════════════════════════════════════════════════════════════════

class ShareableCardGenerator {
  /// Generate and share a power level card
  static Future<void> sharePowerLevelCard(
    BuildContext context,
    AnalyticsData data,
  ) async {
    final widget = _PowerLevelShareCard(data: data);
    await _generateAndShare(context, widget, 'power_level');
  }

  /// Generate and share a PR card
  static Future<void> sharePRCard(
    BuildContext context,
    PersonalRecord pr,
  ) async {
    final widget = _PRShareCard(pr: pr);
    await _generateAndShare(context, widget, 'personal_record');
  }

  /// Generate and share a weekly summary card
  static Future<void> shareWeeklySummary(
    BuildContext context,
    AnalyticsData data,
  ) async {
    final widget = _WeeklySummaryShareCard(data: data);
    await _generateAndShare(context, widget, 'weekly_summary');
  }

  static Future<void> _generateAndShare(
    BuildContext context,
    Widget widget,
    String filename,
  ) async {
    try {
      // Create a global key for the widget
      final boundaryKey = GlobalKey();
      
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(
            color: AppColors.cyberLime,
          ),
        ),
      );

      // Create an overlay entry to render the widget off-screen
      final overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          left: -1000,
          top: -1000,
          child: RepaintBoundary(
            key: boundaryKey,
            child: Material(
              color: Colors.transparent,
              child: widget,
            ),
          ),
        ),
      );

      Overlay.of(context).insert(overlayEntry);

      // Wait for the widget to be rendered
      await Future.delayed(const Duration(milliseconds: 100));

      // Capture the widget as an image
      final boundary = boundaryKey.currentContext!.findRenderObject() 
          as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();

      // Remove the overlay entry
      overlayEntry.remove();

      // Save to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${filename}_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(pngBytes);

      // Close loading dialog
      if (context.mounted) {
        Navigator.pop(context);
      }

      // Share the file
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Check out my FitnessOS stats! 💪 #FitnessOS #Fitness',
      );
    } catch (e) {
      debugPrint('Error sharing card: $e');
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating share card: $e'),
            backgroundColor: AppColors.neonCrimson,
          ),
        );
      }
    }
  }
}

/// Power Level Share Card
class _PowerLevelShareCard extends StatelessWidget {
  final AnalyticsData data;

  const _PowerLevelShareCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final tierColor = Color(AnalyticsData.getPowerLevelColor(data.powerLevel));
    final tierName = AnalyticsData.getPowerLevelTier(data.powerLevel);

    return Container(
      width: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A0E1A),
            tierColor.withOpacity(0.2),
            const Color(0xFF0A0E1A),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: tierColor.withOpacity(0.5),
          width: 3,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Logo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fitness_center,
                color: AppColors.cyberLime,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'FitnessOS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Tier badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: tierColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: tierColor),
            ),
            child: Text(
              tierName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
                color: tierColor,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Power level
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [tierColor, Colors.white, tierColor],
              ).createShader(bounds);
            },
            child: Text(
              '${data.powerLevel}',
              style: const TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
          
          Text(
            'POWER LEVEL',
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 4,
              fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStat('${data.currentStreak}', 'STREAK', AppColors.neonOrange),
              _buildStat('${data.totalWorkouts}', 'WORKOUTS', AppColors.electricCyan),
              _buildStat(_formatNumber(data.totalReps), 'REPS', AppColors.cyberLime),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label, Color color) {
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
            fontSize: 10,
            letterSpacing: 1,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}

/// PR Share Card
class _PRShareCard extends StatelessWidget {
  final PersonalRecord pr;

  const _PRShareCard({required this.pr});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A0E1A),
            AppColors.neonOrange.withOpacity(0.2),
            const Color(0xFF0A0E1A),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.neonOrange.withOpacity(0.5),
          width: 3,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // PR Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.neonOrange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.neonOrange),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.emoji_events,
                  color: AppColors.neonOrange,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  'NEW PR',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                    color: AppColors.neonOrange,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Exercise name
          Text(
            pr.exerciseName.toUpperCase(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Colors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          
          const SizedBox(height: 20),
          
          // Weight
          ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: [AppColors.cyberLime, Colors.white],
              ).createShader(bounds);
            },
            child: Text(
              pr.displayString,
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // e1RM
          if (pr.estimated1RM > 0)
            Text(
              'Estimated 1RM: ${pr.estimated1RM.toStringAsFixed(1)} kg',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          
          const SizedBox(height: 32),
          
          // FitnessOS branding
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fitness_center,
                color: AppColors.cyberLime,
                size: 18,
              ),
              const SizedBox(width: 8),
              const Text(
                'FitnessOS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Weekly Summary Share Card
class _WeeklySummaryShareCard extends StatelessWidget {
  final AnalyticsData data;

  const _WeeklySummaryShareCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A0E1A),
            Color(0xFF1A2040),
            Color(0xFF0A0E1A),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.electricCyan.withOpacity(0.5),
          width: 3,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fitness_center,
                color: AppColors.cyberLime,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'FitnessOS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          Text(
            'WEEKLY SUMMARY',
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 4,
              fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatBox('${data.totalWorkouts}', 'Workouts', AppColors.electricCyan),
              _buildStatBox(_formatNumber(data.totalReps), 'Reps', AppColors.cyberLime),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatBox('${data.currentStreak}', 'Day Streak', AppColors.neonOrange),
              _buildStatBox('${data.totalHours.toStringAsFixed(1)}h', 'Training', AppColors.neonPurple),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String value, String label, Color color) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
