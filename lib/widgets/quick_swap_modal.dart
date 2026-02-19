import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../models/workout_models.dart';
import '../models/workout_data.dart';
import '../widgets/exercise_animation_widget.dart';

/// 🔥 QUICK SWAP MODAL - Beautiful exercise swapper
/// Body part icons → Exercise list → Instant swap
class QuickSwapModal extends StatefulWidget {
  final WorkoutExercise currentExercise;

  const QuickSwapModal({
    super.key,
    required this.currentExercise,
  });

  @override
  State<QuickSwapModal> createState() => _QuickSwapModalState();
}

class _QuickSwapModalState extends State<QuickSwapModal> {
  String _selectedBodyPart = 'Chest';
  
  final List<String> bodyParts = [
    'Chest',
    'Back',
    'Shoulders',
    'Arms',
    'Legs',
    'Core',
    'Cardio',
  ];
  
  final Map<String, List<WorkoutExercise>> exercisesByBodyPart = {
    'Chest': [
      const WorkoutExercise(id: 'bench_press', name: 'Bench Press', sets: 3, reps: 10),
      const WorkoutExercise(id: 'incline_bench_press', name: 'Incline Bench Press', sets: 3, reps: 10),
      const WorkoutExercise(id: 'decline_bench_press', name: 'Decline Bench Press', sets: 3, reps: 10),
      const WorkoutExercise(id: 'dumbbell_press', name: 'Dumbbell Press', sets: 3, reps: 10),
      //const WorkoutExercise(id: 'cable_flyes', name: 'Cable Flyes', sets: 3, reps: 12),  // DUPLICATE - use cable_flye
      //const WorkoutExercise(id: 'dips', name: 'Chest Dips', sets: 3, reps: 12),  // DUPLICATE - use dip
      //const WorkoutExercise(id: 'pushups', name: 'Push-ups', sets: 3, reps: 15),  // DUPLICATE - use pushup
      //const WorkoutExercise(id: 'wide_pushups', name: 'Wide Push-ups', sets: 3, reps: 15),  // DUPLICATE - use wide_pushup
      //const WorkoutExercise(id: 'diamond_pushups', name: 'Diamond Push-ups', sets: 3, reps: 12),  // DUPLICATE - use diamond_pushup
      const WorkoutExercise(id: 'dumbbell_fly', name: 'Dumbbell Flyes', sets: 3, reps: 12),
    ],
    'Back': [
      const WorkoutExercise(id: 'deadlift', name: 'Deadlift', sets: 3, reps: 8),
      //const WorkoutExercise(id: 'pull_ups', name: 'Pull-ups', sets: 3, reps: 10),  // DUPLICATE - use pull_up
      //const WorkoutExercise(id: 'chin_ups', name: 'Chin-ups', sets: 3, reps: 10),  // DUPLICATE - use chin_up
      //const WorkoutExercise(id: 'bent_over_rows', name: 'Bent Over Rows', sets: 3, reps: 10),  // DUPLICATE - use bent_over_row
      //const WorkoutExercise(id: 'lat_pulldowns', name: 'Lat Pulldowns', sets: 3, reps: 12),  // DUPLICATE - use lat_pulldown
      //const WorkoutExercise(id: 'cable_rows', name: 'Cable Rows', sets: 3, reps: 12),  // DUPLICATE - use cable_row
      const WorkoutExercise(id: 'dumbbell_row', name: 'Dumbbell Row', sets: 3, reps: 10),
      //const WorkoutExercise(id: 't_bar_rows', name: 'T-Bar Rows', sets: 3, reps: 10),  // DUPLICATE - use tbar_row
      //const WorkoutExercise(id: 'face_pulls', name: 'Face Pulls', sets: 3, reps: 15),  // DUPLICATE - use face_pull
      //const WorkoutExercise(id: 'reverse_flys', name: 'Reverse Flyes', sets: 3, reps: 12),  // DUPLICATE - use reverse_fly
    ],
    'Shoulders': [
      const WorkoutExercise(id: 'overhead_press', name: 'Overhead Press', sets: 3, reps: 10),
      const WorkoutExercise(id: 'shoulder_press', name: 'Dumbbell Shoulder Press', sets: 3, reps: 10),
      const WorkoutExercise(id: 'arnold_press', name: 'Arnold Press', sets: 3, reps: 10),
      //const WorkoutExercise(id: 'lateral_raises', name: 'Lateral Raises', sets: 3, reps: 15),  // DUPLICATE - use lateral_raise
      //const WorkoutExercise(id: 'front_raises', name: 'Front Raises', sets: 3, reps: 15),  // DUPLICATE - use front_raise
      //const WorkoutExercise(id: 'rear_delt_flys', name: 'Rear Delt Flyes', sets: 3, reps: 15),  // DUPLICATE - use rear_delt_fly
      //const WorkoutExercise(id: 'cable_lateral_raises', name: 'Cable Lateral Raises', sets: 3, reps: 15),  // DUPLICATE - use cable_lateral_raise
      //const WorkoutExercise(id: 'pike_pushups', name: 'Pike Push-ups', sets: 3, reps: 12),  // DUPLICATE - use pike_pushup
      //const WorkoutExercise(id: 'upright_rows', name: 'Upright Rows', sets: 3, reps: 12),  // DUPLICATE - use upright_row
      //const WorkoutExercise(id: 'shrugs', name: 'Shrugs', sets: 3, reps: 15),  // DUPLICATE - use shrug
    ],
    'Arms': [
      //const WorkoutExercise(id: 'bicep_curls', name: 'Bicep Curls', sets: 3, reps: 12),  // DUPLICATE - use bicep_curl
      //const WorkoutExercise(id: 'hammer_curls', name: 'Hammer Curls', sets: 3, reps: 12),  // DUPLICATE - use hammer_curl
      //const WorkoutExercise(id: 'preacher_curls', name: 'Preacher Curls', sets: 3, reps: 12),  // DUPLICATE - use preacher_curl
      //const WorkoutExercise(id: 'cable_curls', name: 'Cable Curls', sets: 3, reps: 15),  // DUPLICATE - use cable_curl
      //const WorkoutExercise(id: 'tricep_dips', name: 'Tricep Dips', sets: 3, reps: 12),  // DUPLICATE - use tricep_dip
      //const WorkoutExercise(id: 'tricep_pushdowns', name: 'Tricep Pushdowns', sets: 3, reps: 15),  // DUPLICATE - use tricep_pushdown
      const WorkoutExercise(id: 'overhead_tricep_extension', name: 'Overhead Tricep Extension', sets: 3, reps: 12),
      //const WorkoutExercise(id: 'skull_crushers', name: 'Skull Crushers', sets: 3, reps: 12),  // DUPLICATE - use skull_crusher
      const WorkoutExercise(id: 'close_grip_bench_press', name: 'Close Grip Bench Press', sets: 3, reps: 10),
      //const WorkoutExercise(id: 'concentration_curls', name: 'Concentration Curls', sets: 3, reps: 12),  // DUPLICATE - use concentration_curl
    ],
    'Legs': [
      //const WorkoutExercise(id: 'squats', name: 'Squats', sets: 3, reps: 10),  // DUPLICATE - use squat
      const WorkoutExercise(id: 'front_squat', name: 'Front Squat', sets: 3, reps: 10),
      const WorkoutExercise(id: 'leg_press', name: 'Leg Press', sets: 3, reps: 12),
      //const WorkoutExercise(id: 'lunges', name: 'Lunges', sets: 3, reps: 12),  // DUPLICATE - use lunge
      //const WorkoutExercise(id: 'bulgarian_split_squats', name: 'Bulgarian Split Squats', sets: 3, reps: 10),  // DUPLICATE - use bulgarian_split_squat
      //const WorkoutExercise(id: 'leg_extensions', name: 'Leg Extensions', sets: 3, reps: 15),  // DUPLICATE - use leg_extension
      //const WorkoutExercise(id: 'leg_curls', name: 'Leg Curls', sets: 3, reps: 15),  // DUPLICATE - use leg_curl
      const WorkoutExercise(id: 'barbell_romanian_deadlift', name: 'Romanian Deadlift', sets: 3, reps: 10),
      //const WorkoutExercise(id: 'calf_raises', name: 'Calf Raises', sets: 3, reps: 20),  // DUPLICATE - use calf_raise
      const WorkoutExercise(id: 'glute_bridge', name: 'Glute Bridge', sets: 3, reps: 15),
    ],
    'Core': [
      //const WorkoutExercise(id: 'planks', name: 'Planks', sets: 3, reps: 60, timeSeconds: 60),  // DUPLICATE - use plank
      const WorkoutExercise(id: 'crunch', name: 'Crunches', sets: 3, reps: 20),
      //const WorkoutExercise(id: 'russian_twists', name: 'Russian Twists', sets: 3, reps: 30),  // DUPLICATE - use russian_twist
      //const WorkoutExercise(id: 'leg_raises', name: 'Leg Raises', sets: 3, reps: 15),  // DUPLICATE - use leg_raise
      //const WorkoutExercise(id: 'mountain_climbers', name: 'Mountain Climbers', sets: 3, reps: 30),  // DUPLICATE - use mountain_climber
      const WorkoutExercise(id: 'bicycle_crunch', name: 'Bicycle Crunches', sets: 3, reps: 30),
      //const WorkoutExercise(id: 'side_planks', name: 'Side Planks', sets: 3, reps: 45, timeSeconds: 45),  // DUPLICATE - use side_plank
      // const WorkoutExercise(id: 'ab_wheel', name: 'Ab Wheel Rollouts', sets: 3, reps: 12),
      //const WorkoutExercise(id: 'hanging_leg_raises', name: 'Hanging Leg Raises', sets: 3, reps: 12),  // DUPLICATE - use hanging_leg_raise
      const WorkoutExercise(id: 'cable_crunch', name: 'Cable Crunches', sets: 3, reps: 15),
    ],
    'Cardio': [
      //const WorkoutExercise(id: 'burpees', name: 'Burpees', sets: 3, reps: 15),  // DUPLICATE - use burpee
      //const WorkoutExercise(id: 'jumping_jacks', name: 'Jumping Jacks', sets: 3, reps: 30),  // DUPLICATE - use jumping_jack
      //const WorkoutExercise(id: 'high_knees', name: 'High Knees', sets: 3, reps: 30),  // DUPLICATE - use high_knee
      //const WorkoutExercise(id: 'box_jumps', name: 'Box Jumps', sets: 3, reps: 15),  // DUPLICATE - use box_jump
      const WorkoutExercise(id: 'jump_rope', name: 'Jump Rope', sets: 3, reps: 100),
      const WorkoutExercise(id: 'battle_ropes', name: 'Battle Ropes', sets: 3, reps: 30, timeSeconds: 30),
      const WorkoutExercise(id: 'sprints', name: 'Sprints', sets: 5, reps: 1, timeSeconds: 30),
      const WorkoutExercise(id: 'rowing', name: 'Rowing Machine', sets: 3, reps: 1, timeSeconds: 120),
      const WorkoutExercise(id: 'bike_intervals', name: 'Bike Intervals', sets: 5, reps: 1, timeSeconds: 60),
      const WorkoutExercise(id: 'stair_climber', name: 'Stair Climber', sets: 1, reps: 1, timeSeconds: 300),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.white20,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.cyberLime, AppColors.cyberLime],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.swap_horiz_rounded, color: Colors.black, size: 24),
                ),
                const SizedBox(width: 16),
                const Text(
                  'QUICK SWAP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: AppColors.white60),
                ),
              ],
            ),
          ),
          
          // Body part filters
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: bodyParts.map((bodyPart) {
                final isSelected = _selectedBodyPart == bodyPart;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedBodyPart = bodyPart);
                    HapticFeedback.selectionClick();
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(
                              colors: [AppColors.cyberLime, AppColors.cyberLime],
                            )
                          : null,
                      color: isSelected ? null : AppColors.white10,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.transparent : AppColors.white20,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        bodyPart.toUpperCase(),
                        style: TextStyle(
                          color: isSelected ? Colors.black : Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Exercises list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: exercisesByBodyPart[_selectedBodyPart]!.length,
              itemBuilder: (context, index) {
                final exercise = exercisesByBodyPart[_selectedBodyPart]![index];
                final isCurrent = exercise.id == widget.currentExercise.id;
                
                return GestureDetector(
                  onTap: () {
                    if (!isCurrent) {
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).pop(exercise);
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isCurrent 
                          ? AppColors.cyberLime.withOpacity(0.1)
                          : AppColors.white5,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isCurrent 
                            ? AppColors.cyberLime.withOpacity(0.5)
                            : AppColors.white10,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Exercise GIF thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: ExerciseAnimationWidget(
                            exerciseId: exercise.id,
                            size: 60,
                            showWatermark: false,
                          ),
                        ),
                        
                        const SizedBox(width: 16),
                        
                        // Exercise info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exercise.name,
                                style: TextStyle(
                                  color: isCurrent ? AppColors.cyberLime : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${exercise.sets} sets × ${exercise.reps} reps',
                                style: const TextStyle(
                                  color: AppColors.white40,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Current indicator or swap icon
                        if (isCurrent)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.cyberLime,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'CURRENT',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                          )
                        else
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.white30,
                            size: 16,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

