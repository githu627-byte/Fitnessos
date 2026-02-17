import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import '../models/workout_data.dart';
import '../utils/app_colors.dart';
import '../widgets/exercise_animation_widget.dart';
import '../widgets/cyber_grid_background.dart';
import '../data/exercise_muscle_database.dart';

/// Beautiful exercise explanation screen with animation and floating bubbles
class ExerciseExplanationScreen extends StatefulWidget {
  final Exercise exercise;

  const ExerciseExplanationScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<ExerciseExplanationScreen> createState() => _ExerciseExplanationScreenState();
}

class _ExerciseExplanationScreenState extends State<ExerciseExplanationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CyberGridBackground(
        child: FadeTransition(
          opacity: _fadeController,
          child: SafeArea(
            child: Column(
              children: [
                // Header with back button
                _buildHeader(),
                
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Large animation
                        _buildAnimation(),
                        
                        const SizedBox(height: 32),
                        
                        // Exercise name
                        _buildExerciseName(),
                        
                        const SizedBox(height: 24),
                        
                        // Equipment & difficulty badges
                        _buildBadges(),
                        
                        const SizedBox(height: 32),
                        
                        // Explanation text
                        _buildExplanation(),
                        
                        const SizedBox(height: 24),
                        
                        // Muscle focus section
                        _buildMuscleFocus(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              Navigator.pop(context);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.white5,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.white10,
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimation() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.cyberLime.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: ExerciseAnimationWidget(
          exerciseId: widget.exercise.id,
          size: 300,
          showWatermark: false,
        ),
      ),
    );
  }

  Widget _buildExerciseName() {
    return Text(
      widget.exercise.name,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBadges() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildBadge(
          _getEquipmentLabel(widget.exercise.equipment),
          AppColors.cyberLime,
        ),
        const SizedBox(width: 12),
        _buildBadge(
          widget.exercise.difficulty.toUpperCase(),
          AppColors.white40,
        ),
      ],
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildExplanation() {
    final explanation = _getExerciseExplanation(widget.exercise);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.white10,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.cyberLime,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'HOW TO PERFORM',
                style: TextStyle(
                  color: AppColors.cyberLime,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            explanation,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleFocus() {
    // Body animation removed - descriptions and animations remain perfect
    return const SizedBox.shrink();
  }

  Map<String, double> _getTargetedMuscles(Exercise exercise) {
    final id = exercise.id.toLowerCase();
    
    // Look up exercise in our comprehensive database
    if (exerciseMuscleDatabase.containsKey(id)) {
      return exerciseMuscleDatabase[id]!.allMuscles;
    }
    
    // Fallback: Try pattern matching for unmapped exercises
    final name = exercise.name.toLowerCase();
    Map<String, double> muscles = {};
    
    // CHEST EXERCISES
    if (name.contains('bench') || name.contains('press') && name.contains('chest') ||
        name.contains('pushup') || name.contains('push-up') || name.contains('push_up') ||
        name.contains('fly') || name.contains('flye') ||
        name.contains('dip') && !name.contains('hip')) {
      muscles['chest'] = 0.0;
      muscles['shoulders'] = 0.5;
      muscles['triceps'] = 0.5;
    }
    // BACK EXERCISES  
    else if (name.contains('row') || name.contains('pulldown') ||
             name.contains('pullup') || name.contains('pull-up') || name.contains('pull_up') ||
             name.contains('chinup') || name.contains('chin-up') || name.contains('chin_up')) {
      muscles['lats'] = 0.0;
      muscles['biceps'] = 0.5;
      muscles['upper_back'] = 0.5;
    }
    // SHOULDER EXERCISES
    else if (name.contains('shoulder') || name.contains('overhead') ||
             name.contains('lateral') || name.contains('front raise') ||
             name.contains('rear delt') || name.contains('pike')) {
      muscles['shoulders'] = 0.0;
      muscles['triceps'] = 0.6;
    }
    // ARM EXERCISES
    else if (name.contains('bicep') || name.contains('curl')) {
      muscles['biceps'] = 0.0;
      muscles['forearms'] = 0.6;
    }
    else if (name.contains('tricep') || name.contains('extension')) {
      muscles['triceps'] = 0.0;
    }
    // LEG EXERCISES
    else if (name.contains('squat') || name.contains('lunge')) {
      muscles['quads'] = 0.0;
      muscles['glutes'] = 0.0;
      muscles['hamstrings'] = 0.5;
    }
    else if (name.contains('deadlift')) {
      muscles['hamstrings'] = 0.0;
      muscles['glutes'] = 0.0;
      muscles['lower_back'] = 0.5;
    }
    // CORE EXERCISES
    else if (name.contains('crunch') || name.contains('plank') || name.contains('abs')) {
      muscles['core'] = 0.0;
    }
    // DEFAULT
    else {
      muscles['core'] = 0.5;
      muscles['chest'] = 0.6;
      muscles['lats'] = 0.6;
    }
    
    return muscles;
  }

  String _getEquipmentLabel(String equipment) {
    switch (equipment.toLowerCase()) {
      case 'bodyweight':
        return 'BODYWEIGHT';
      case 'weights':
        return 'WEIGHTS';
      case 'none':
        return 'NO EQUIPMENT';
      default:
        return equipment.toUpperCase();
    }
  }

  String _getExerciseExplanation(Exercise exercise) {
    final id = exercise.id.toLowerCase();
    
    // Look up exercise in our comprehensive database with HOW TO instructions
    if (exerciseMuscleDatabase.containsKey(id)) {
      return exerciseMuscleDatabase[id]!.description;
    }
    
    // Fallback for unmapped exercises
    return 'HOW TO: This exercise requires proper form and technique. Focus on controlled movement, full range of motion, and engaging the target muscles. Start with lighter resistance to master the movement pattern before progressing to heavier loads.';
  }
}