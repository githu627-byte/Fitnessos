import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import '../utils/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/// Stunning workout summary report shown after completing a workout
/// Highly shareable with beautiful visuals and stats
class WorkoutSummaryScreen extends StatefulWidget {
  final String workoutName;
  final int totalSets;
  final int totalReps;
  final int durationSeconds;
  final int caloriesBurned;
  final List<ExerciseSummary> exercises;
  final int? milestoneWorkoutNumber; // e.g., 100th workout
  final String? milestoneText; // e.g., "First 100 Workouts!"

  const WorkoutSummaryScreen({
    super.key,
    required this.workoutName,
    required this.totalSets,
    required this.totalReps,
    required this.durationSeconds,
    required this.caloriesBurned,
    required this.exercises,
    this.milestoneWorkoutNumber,
    this.milestoneText,
  });

  @override
  State<WorkoutSummaryScreen> createState() => _WorkoutSummaryScreenState();
}

class _WorkoutSummaryScreenState extends State<WorkoutSummaryScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  final GlobalKey _summaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    if (minutes > 0) {
      return '${minutes}m ${secs}s';
    }
    return '${secs}s';
  }

  Future<void> _shareWorkout() async {
    try {
      HapticFeedback.mediumImpact();
      
      // Capture the summary as an image
      final boundary = _summaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;
      
      final pngBytes = byteData.buffer.asUint8List();
      
      // Save to temp directory
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/workout_summary.png');
      await file.writeAsBytes(pngBytes);
      
      // Share
      await Share.shareXFiles(
        [XFile(file.path)],
        text: '💀 Just crushed a workout with Skelatal-PT! ${widget.totalReps} reps, ${widget.totalSets} sets, ${_formatDuration(widget.durationSeconds)} 🔥',
      );
    } catch (e) {
      print('Error sharing workout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Header with close button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40), // Spacer
                  const Text(
                    'WORKOUT COMPLETE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppColors.cyberLime,
                      letterSpacing: 1.5,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: RepaintBoundary(
                  key: _summaryKey,
                  child: Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 32),
                        _buildStatsGrid(),
                        const SizedBox(height: 32),
                        _buildExerciseBreakdown(),
                        if (widget.milestoneWorkoutNumber != null) ...[
                          const SizedBox(height: 32),
                          _buildMilestoneBadge(),
                        ],
                        const SizedBox(height: 32),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom action buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Share button
                  GestureDetector(
                    onTap: _shareWorkout,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.cyberLime, AppColors.cyberLime],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cyberLime.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.share, color: Colors.black, size: 20),
                          SizedBox(width: 12),
                          Text(
                            'SHARE WORKOUT',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Done button
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.white10,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.white20),
                      ),
                      child: const Text(
                        'DONE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.white60,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _fadeController,
      child: Column(
        children: [
          // Skull with glow effect
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyberLime.withOpacity(0.5),
                  blurRadius: 40,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                '💀',
                style: TextStyle(fontSize: 70),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Workout name
          Text(
            widget.workoutName.toUpperCase(),
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          // Completion message
          const Text(
            'CRUSHED IT! 🔥',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.cyberLime,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut)),
      child: FadeTransition(
        opacity: _fadeController,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.cyberLime.withOpacity(0.1),
                AppColors.cyberLime.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.cyberLime, width: 2),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _buildStatCard('⏱️', _formatDuration(widget.durationSeconds), 'TIME')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard('🔥', '${widget.caloriesBurned}', 'CALORIES')),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _buildStatCard('💪', '${widget.totalReps}', 'REPS')),
                  const SizedBox(width: 12),
                  Expanded(child: _buildStatCard('📊', '${widget.totalSets}', 'SETS')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String emoji, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white10),
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.white40,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseBreakdown() {
    return FadeTransition(
      opacity: _fadeController,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'EXERCISE BREAKDOWN',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: AppColors.white60,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            ...widget.exercises.map((exercise) => _buildExerciseRow(exercise)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseRow(ExerciseSummary exercise) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.cyberLime.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(Icons.fitness_center, color: AppColors.cyberLime, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${exercise.sets} sets × ${exercise.reps} reps${exercise.weight != null ? " @ ${exercise.weight} lbs" : ""}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.white60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneBadge() {
    return FadeTransition(
      opacity: _fadeController,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFD700).withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            const Text(
              '🏆',
              style: TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 12),
            Text(
              widget.milestoneText ?? 'MILESTONE ACHIEVED!',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.black,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
            if (widget.milestoneWorkoutNumber != null) ...[
              const SizedBox(height: 4),
              Text(
                'Workout #${widget.milestoneWorkoutNumber}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return FadeTransition(
      opacity: _fadeController,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo/playstore_icon.png',
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 8),
              const Text(
                'Skelatal-PT',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppColors.cyberLime,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Your AI Personal Trainer',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.white40,
            ),
          ),
        ],
      ),
    );
  }
}

/// Data model for exercise summary
class ExerciseSummary {
  final String name;
  final int sets;
  final int reps;
  final double? weight;

  ExerciseSummary({
    required this.name,
    required this.sets,
    required this.reps,
    this.weight,
  });
}

