import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../models/workout_data.dart';
import '../models/workout_models.dart';

/// Modal for selecting exercises to add to a workout
class ExerciseSelectorModal extends StatefulWidget {
  const ExerciseSelectorModal({super.key});

  @override
  State<ExerciseSelectorModal> createState() => _ExerciseSelectorModalState();
}

class _ExerciseSelectorModalState extends State<ExerciseSelectorModal> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'all';

  List<Exercise> get _allExercises {
    final Map<String, Exercise> uniqueExercises = {};
    
    // Add from muscle splits
    WorkoutData.muscleSplits.forEach((category, exercises) {
      for (final exercise in exercises) {
        uniqueExercises[exercise.id] = exercise;
      }
    });
    
    // Add cardio
    for (final exercise in WorkoutData.cardioExercises) {
      uniqueExercises[exercise.id] = exercise;
    }
    
    return uniqueExercises.values.toList();
  }
  
  List<Exercise> get _filteredExercises {
    List<Exercise> exercises = _allExercises;
    
    // Filter by category
    if (_selectedCategory != 'all') {
      if (_selectedCategory == 'upper') {
        exercises = exercises.where((e) => 
          WorkoutData.muscleSplits['chest']!.any((c) => c.id == e.id) ||
          WorkoutData.muscleSplits['back']!.any((c) => c.id == e.id) ||
          WorkoutData.muscleSplits['shoulders']!.any((c) => c.id == e.id) ||
          WorkoutData.muscleSplits['arms']!.any((c) => c.id == e.id)
        ).toList();
      } else if (_selectedCategory == 'lower') {
        exercises = exercises.where((e) => 
          WorkoutData.muscleSplits['legs']!.any((c) => c.id == e.id)
        ).toList();
      } else if (_selectedCategory == 'core') {
        exercises = exercises.where((e) => 
          WorkoutData.muscleSplits['core']!.any((c) => c.id == e.id)
        ).toList();
      } else if (_selectedCategory == 'cardio') {
        exercises = exercises.where((e) => 
          WorkoutData.cardioExercises.any((c) => c.id == e.id)
        ).toList();
      }
    }
    
    // Filter by search
    if (_searchController.text.isNotEmpty) {
      exercises = exercises.where((e) => 
        e.name.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }
    
    return exercises;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add Exercise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                onChanged: (_) => setState(() {}),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search exercises...',
                  hintStyle: const TextStyle(color: Colors.white30),
                  prefixIcon: const Icon(Icons.search, color: AppColors.cyberLime),
                  filled: true,
                  fillColor: AppColors.white10,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Category filter
            _buildCategoryFilter(),

            const SizedBox(height: 16),

            // Exercise list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _filteredExercises.length,
                itemBuilder: (context, index) {
                  final exercise = _filteredExercises[index];
                  return _buildExerciseCard(exercise);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      ('all', 'All'),
      ('upper', 'Upper'),
      ('lower', 'Lower'),
      ('core', 'Core'),
      ('cardio', 'Cardio'),
    ];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final (value, label) = categories[index];
          final isSelected = _selectedCategory == value;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = value;
                });
                HapticFeedback.selectionClick();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.cyberLime : AppColors.white10,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.cyberLime : AppColors.white20,
                  ),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white10,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            HapticFeedback.mediumImpact();
            // Return the selected exercise as WorkoutExercise
            Navigator.pop(context, WorkoutExercise(
              id: exercise.id,
              name: exercise.name,
              sets: 3,
              reps: 10,
              restSeconds: 90,
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Exercise icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    color: AppColors.cyberLime,
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Exercise name and info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${exercise.difficulty} • ${exercise.equipment}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.white50,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Add icon
                const Icon(
                  Icons.add_circle_outline,
                  color: AppColors.cyberLime,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


