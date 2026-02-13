import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../models/workout_data.dart';
import '../../models/workout_models.dart';
import '../../models/workout_schedule.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/glassmorphism_card.dart';
import '../../widgets/glow_button.dart';
import '../../widgets/exercise_animation_widget.dart';
import '../../providers/workout_provider.dart';
import '../../providers/workout_schedule_provider.dart';
import '../../providers/schedule_date_provider.dart';
import '../../services/storage_service.dart'; // Add this import
import '../../services/calorie_calculation_service.dart'; // NEW: For accurate calorie estimates
import '../workout_editor_screen.dart';
import '../custom_workouts_screen.dart';
import '../home_screen.dart' show TabNavigator;
import '../training_mode_selection_screen.dart';
import 'settings_tab.dart';

class WorkoutsTab extends ConsumerStatefulWidget {
  const WorkoutsTab({super.key});

  @override
  ConsumerState<WorkoutsTab> createState() => _WorkoutsTabState();
}

class _WorkoutsTabState extends ConsumerState<WorkoutsTab> {
  String _selectedMode = 'gym'; // 'gym' or 'home'
  String? _selectedCategory;
  List<WorkoutPreset> _customWorkouts = []; // Store loaded custom workouts
  
  // Track difficulty selection for each workout (workoutId -> difficulty)
  final Map<String, String> _selectedDifficulties = {};
  
  // Cache user weight for accurate calorie calculations
  double? _cachedUserWeight;

  @override
  void initState() {
    super.initState();
    _loadCustomWorkouts(); // Load on init
    _loadUserWeight(); // Load user weight
  }
  
  Future<void> _loadUserWeight() async {
    try {
      final weight = await StorageService.getUserWeight();
      if (mounted) {
        setState(() {
          _cachedUserWeight = weight ?? 70.0; // Default to 70kg
        });
      }
    } catch (e) {
      debugPrint('❌ User weight failed: $e');
      if (mounted) {
        setState(() {
          _cachedUserWeight = 70.0; // Default
        });
      }
    }
  }

  Future<void> _loadCustomWorkouts() async {
    final storage = await StorageService.getInstance();
    final savedWorkouts = storage.getCustomWorkoutsList();
    if (mounted) {
      setState(() {
        _customWorkouts = savedWorkouts;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedCategory == null) {
      return _buildMainScreen();
    } else {
      return _buildPresetList();
    }
  }

  Widget _buildMainScreen() {
    final categories = _getCategoriesForMode();
    
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.white5,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.white10,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildToggleButton('GYM', 'gym', Icons.fitness_center),
                          ),
                          Expanded(
                            child: _buildToggleButton('HOME', 'home', Icons.home),
                          ),
                          Expanded(
                            child: _buildToggleButton('CUSTOM', 'custom', Icons.edit_note),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => const SettingsTab(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 200),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.white10,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.white20,
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white70,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Category Cards
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildCategoryCard(categories[index]),
                  );
                },
                childCount: categories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white10,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton('GYM', 'gym', Icons.fitness_center),
          ),
          Expanded(
            child: _buildToggleButton('HOME', 'home', Icons.home),
          ),
          Expanded(
            child: _buildToggleButton('CUSTOM', 'custom', Icons.edit_note),
          ),
        ],
      ),
    );
  }


  Widget _buildToggleButton(String label, String mode, IconData icon) {
    final isActive = _selectedMode == mode;
    
    return GestureDetector(
      onTap: () {
        // Switch mode (same behavior for all modes now)
        setState(() {
          _selectedMode = mode;
          _selectedCategory = null;
        });
        HapticFeedback.lightImpact();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isActive ? AppColors.cyberLime : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppColors.cyberLime.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 0,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.black : AppColors.white60,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.2,
                  color: isActive ? Colors.black : AppColors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, String>> _getCategoriesForMode() {
    if (_selectedMode == 'gym') {
      return [
        {
          'id': 'muscle_splits',
          'name': 'MUSCLE SPLITS',
          'icon': '💪',
          'desc': 'Target specific muscle groups',
        },
        {
          'id': 'muscle_groupings',
          'name': 'MUSCLE GROUPINGS',
          'icon': '🎯',
          'desc': 'Pre-built workout combinations',
        },
        {
          'id': 'gym_circuits',
          'name': 'GYM CIRCUITS',
          'icon': '⚡',
          'desc': 'High-intensity timed workouts',
        },
        {
          'id': 'booty_builder',
          'name': 'BOOTY BUILDER',
          'icon': '🍑',
          'desc': "Women's glute-focused workouts",
        },
        {
          'id': 'girl_power',
          'name': 'GIRL POWER',
          'icon': '👑',
          'desc': 'Elite women-focused training programs',
        },
      ];
    } else if (_selectedMode == 'home') {
      return [
        {
          'id': 'bodyweight_basics',
          'name': 'BODYWEIGHT BASICS',
          'icon': '🏠',
          'desc': 'No equipment needed',
        },
        {
          'id': 'hiit_circuits',
          'name': 'HIIT CIRCUITS',
          'icon': '⚡',
          'desc': 'High intensity, no equipment',
        },
        {
          'id': 'home_booty',
          'name': 'HOME BOOTY',
          'icon': '🍑',
          'desc': 'Glute workouts at home',
        },
        // {
        //   'id': 'recovery',
        //   'name': 'RECOVERY & MOBILITY',
        //   'icon': '🧘',
        //   'desc': 'Stretching and mobility work',
        // },
        {
          'id': 'girl_power',
          'name': 'GIRL POWER',
          'icon': '👑',
          'desc': 'Elite women-focused home training',
        },
      ];
    } else { // custom mode
      return [
        {
          'id': 'custom_workouts',
          'name': 'MY CUSTOM WORKOUTS',
          'icon': '📝',
          'desc': 'Your saved custom workouts',
        },
        {
          'id': 'create_new',
          'name': 'CREATE NEW WORKOUT',
          'icon': '➕',
          'desc': 'Build a workout from scratch',
        },
      ];
    }
  }

  Widget _buildCategoryCard(Map<String, String> category) {
    return GestureDetector(
      onTap: () async {
        // Special handling for custom mode "create new" action
        if (category['id'] == 'create_new') {
          HapticFeedback.mediumImpact();
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CustomWorkoutsScreen(),
            ),
          );
          
          // If workout was saved, reload custom workouts and switch to view them
          if (result == true && mounted) {
            await _loadCustomWorkouts(); // Reload the list
            setState(() {
              _selectedCategory = 'custom_workouts'; // Switch to custom workouts view
            });
          }
        } else {
          setState(() {
            _selectedCategory = category['id'];
          });
          HapticFeedback.lightImpact();
        }
      },
      child: GlassmorphismCard(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Text(
              category['icon']!,
              style: const TextStyle(fontSize: 56),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['name']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category['desc']!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.white60,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: AppColors.white40,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetList() {
    final presets = _getPresetsForCategory();

    return SafeArea(
      child: Column(
        children: [
          // Header with back button
          Container(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedCategory = null;
                  });
                  HapticFeedback.lightImpact();
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  _getCategoryName(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Preset cards
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
            child: Column(
              children: presets.map((preset) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildPresetCard(preset),
              )).toList(),
            ),
          ),
        ),
        ],
      ),
    );
  }

  List<WorkoutPreset> _getPresetsForCategory() {
    // Get current global difficulty (we'll filter presets by this)
    // For now, we'll generate all difficulties and filter later per preset
    // This maintains backward compatibility while using new dynamic system
    
    switch (_selectedCategory) {
      // GYM MODE - Use dynamic generation
      case 'muscle_splits':
        // We'll generate for 'intermediate' as base, then adjust per-preset in _getAdjustedExercises
        return WorkoutData.getGymMuscleSplits('intermediate');
      case 'muscle_groupings':
        return WorkoutData.getGymMuscleGroupings('intermediate');
      case 'gym_circuits':
        return WorkoutData.getGymCircuits('intermediate');
      case 'booty_builder':
        return WorkoutData.getGymBootyBuilder('intermediate');
      case 'girl_power':
        if (_selectedMode == 'gym') {
          return WorkoutData.getGymGirlPower('intermediate');
        } else {
          return WorkoutData.getHomeGirlPower('intermediate');
        }
      // HOME MODE - Use dynamic generation
      case 'bodyweight_basics':
        return WorkoutData.getHomeBodyweightBasics('intermediate');
      case 'hiit_circuits':
        return WorkoutData.getHomeHIITCircuits('intermediate');
      case 'home_booty':
        return WorkoutData.getHomeBooty('intermediate');
      case 'recovery':
        return WorkoutData.getHomeRecovery(); // Recovery not difficulty-dependent
      // CUSTOM MODE
      case 'custom_workouts':
        // Load saved custom workouts from storage
        return _customWorkouts; // Use state variable loaded from storage
      default:
        return [];
    }
  }

  String _getCategoryName() {
    final categories = _getCategoriesForMode();
    final category = categories.firstWhere(
      (c) => c['id'] == _selectedCategory,
      orElse: () => {'name': 'WORKOUTS'},
    );
    return category['name']!;
  }

  /// Build a difficulty button
  Widget _buildDifficultyButton({
    required String label,
    required String icon,
    required String difficulty,
    required Color color,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : AppColors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color : AppColors.white30,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                color: isSelected ? color : AppColors.white60,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Adjust exercises based on difficulty
  /// Now uses dynamic generation from WorkoutTemplateService
  List<WorkoutExercise> _getAdjustedExercises(WorkoutPreset preset, String difficulty) {
    // Since we're now using dynamic generation, we need to regenerate the preset
    // based on the selected difficulty level
    
    // Extract the base preset ID (without the _difficulty suffix if present)
    final baseId = preset.id.replaceAll(RegExp(r'_(beginner|intermediate|advanced)$'), '');
    
    // Regenerate the workout for the selected difficulty
    WorkoutPreset adjustedPreset;
    
    // Determine workout type and muscle groups from the original preset
    switch (preset.subcategory) {
      case 'muscle_splits':
        if (_selectedMode == 'gym') {
          adjustedPreset = WorkoutData.getGymMuscleSplits(difficulty)
              .firstWhere((p) => p.id.startsWith(baseId), orElse: () => preset);
        } else {
          adjustedPreset = preset; // Fallback
        }
        break;
      case 'muscle_groupings':
        adjustedPreset = WorkoutData.getGymMuscleGroupings(difficulty)
            .firstWhere((p) => p.id.startsWith(baseId), orElse: () => preset);
        break;
      case 'gym_circuits':
        adjustedPreset = WorkoutData.getGymCircuits(difficulty)
            .firstWhere((p) => p.id.startsWith(baseId), orElse: () => preset);
        break;
      case 'booty_builder':
        adjustedPreset = WorkoutData.getGymBootyBuilder(difficulty)
            .firstWhere((p) => p.id.startsWith(baseId), orElse: () => preset);
        break;
      case 'girl_power':
        if (_selectedMode == 'gym') {
          adjustedPreset = WorkoutData.getGymGirlPower(difficulty)
              .firstWhere((p) => p.id.startsWith(baseId), orElse: () => preset);
        } else {
          adjustedPreset = WorkoutData.getHomeGirlPower(difficulty)
              .firstWhere((p) => p.id.startsWith(baseId), orElse: () => preset);
        }
        break;
      case 'bodyweight_basics':
        adjustedPreset = WorkoutData.getHomeBodyweightBasics(difficulty)
            .firstWhere((p) => p.id.startsWith(baseId), orElse: () => preset);
        break;
      case 'hiit_circuits':
        adjustedPreset = WorkoutData.getHomeHIITCircuits(difficulty)
            .firstWhere((p) => p.id.startsWith(baseId), orElse: () => preset);
        break;
      case 'home_booty':
        adjustedPreset = WorkoutData.getHomeBooty(difficulty)
            .firstWhere((p) => p.id.startsWith(baseId), orElse: () => preset);
        break;
      case 'recovery':
        // Recovery workouts are not difficulty-dependent
        return preset.exercises;
      default:
        // For custom or unknown types, return original
        return preset.exercises;
    }
    
    return adjustedPreset.exercises;
  }

  /// Get accurate calorie estimate using science-based MET formula
  int _getAccurateCalories(List<WorkoutExercise> exercises, WorkoutPreset preset) {
    if (_cachedUserWeight == null) {
      // Fallback to old method if user weight not loaded yet
      return _calculateCalories(exercises, preset.isCircuit, preset.rounds);
    }
    
    // Create a temporary WorkoutPreset with the adjusted exercises
    final adjustedPreset = preset.copyWith(exercises: exercises);
    
    // Use the new science-based service
    return CalorieCalculationService.estimateCalories(
      workout: adjustedPreset,
      userWeightKg: _cachedUserWeight!,
    );
  }
  
  /// Calculate calories for adjusted exercises
  int _calculateCalories(List<WorkoutExercise> exercises, bool isCircuit, int? rounds) {
    int totalCalories = 0;
    
    for (final exercise in exercises) {
      if (!exercise.included) continue;
      
      int caloriesPerSet = _getCaloriesPerSet(exercise.name);
      
      if (isCircuit && exercise.timeSeconds != null) {
        totalCalories += ((exercise.timeSeconds! / 60) * 6 * (rounds ?? 1)).round();
      } else {
        final repMultiplier = (exercise.reps / 10).clamp(0.5, 2.0);
        totalCalories += (exercise.sets * caloriesPerSet * repMultiplier).round();
      }
    }
    
    return totalCalories;
  }

  int _getCaloriesPerSet(String exerciseName) {
    final name = exerciseName.toLowerCase();
    
    if (name.contains('squat') || name.contains('deadlift') || 
        name.contains('clean') || name.contains('snatch') ||
        name.contains('thruster') || name.contains('burpee')) {
      return 12;
    }
    
    if (name.contains('bench press') || name.contains('overhead press') ||
        name.contains('military press') || name.contains('row') ||
        name.contains('pull-up') || name.contains('chin-up') ||
        name.contains('lunge') || name.contains('leg press')) {
      return 9;
    }
    
    if (name.contains('dip') || name.contains('push-up') ||
        name.contains('cable') || name.contains('machine') ||
        name.contains('leg curl') || name.contains('leg extension')) {
      return 7;
    }
    
    return 5;
  }

  Widget _buildPresetCard(WorkoutPreset preset) {
    // Get current difficulty (default to intermediate)
    final currentDifficulty = _selectedDifficulties[preset.id] ?? 'intermediate';
    
    // Get the exercises adjusted for the current difficulty
    final adjustedExercises = _getAdjustedExercises(preset, currentDifficulty);
    // Show first 6 exercises on card (user can add/remove more in editor)
    final includedExercises = adjustedExercises.take(6).toList();
    
    return GlassmorphismCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preset name and icon
          Row(
            children: [
              if (preset.icon != null) ...[
                Text(
                  preset.icon!,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  preset.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
              // Delete button for custom workouts only
              if (preset.subcategory == 'custom')
                IconButton(
                  onPressed: () async {
                    // Confirm deletion
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: AppColors.slate900,
                        title: const Text(
                          'Delete Workout?',
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Text(
                          'Are you sure you want to delete "${preset.name}"?',
                          style: const TextStyle(color: AppColors.white70),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel', style: TextStyle(color: AppColors.white70)),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete', style: TextStyle(color: AppColors.neonCrimson)),
                          ),
                        ],
                      ),
                    );

                    if (confirmed == true) {
                      HapticFeedback.mediumImpact();
                      final storage = await StorageService.getInstance();
                      await storage.deleteCustomWorkout(preset.id);
                      
                      // Reload custom workouts list
                      await _loadCustomWorkouts();
                      
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleted "${preset.name}"'),
                            backgroundColor: AppColors.white10,
                          ),
                        );
                      }
                    }
                  },
                  icon: const Icon(Icons.delete_outline, color: AppColors.neonCrimson),
                  tooltip: 'Delete workout',
                ),
            ],
          ),
          const SizedBox(height: 16),

          // DIFFICULTY BUTTONS (only for preset workouts, not custom)
          if (preset.subcategory != 'custom') ...[
            Row(
              children: [
                Expanded(
                  child: _buildDifficultyButton(
                    label: 'BEGINNER',
                    icon: '🌱',
                    difficulty: 'beginner',
                    color: Colors.green,
                    isSelected: currentDifficulty == 'beginner',
                    onTap: () {
                      setState(() {
                        _selectedDifficulties[preset.id] = 'beginner';
                      });
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDifficultyButton(
                    label: 'INTERMEDIATE',
                    icon: '💪',
                    difficulty: 'intermediate',
                    color: Colors.blue,
                    isSelected: currentDifficulty == 'intermediate',
                    onTap: () {
                      setState(() {
                        _selectedDifficulties[preset.id] = 'intermediate';
                      });
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDifficultyButton(
                    label: 'ADVANCED',
                    icon: '🔥',
                    difficulty: 'advanced',
                    color: Colors.orange,
                    isSelected: currentDifficulty == 'advanced',
                    onTap: () {
                      setState(() {
                        _selectedDifficulties[preset.id] = 'advanced';
                      });
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],

          // Exercise count and calories
          Row(
            children: [
              _buildInfoBadge('${includedExercises.length} exercises'),
              const SizedBox(width: 8),
              _buildInfoBadge('🔥 ~${_getAccurateCalories(adjustedExercises, preset)} cal'),
              if (preset.isCircuit && preset.rounds != null) ...[
                const SizedBox(width: 8),
                _buildInfoBadge('${preset.rounds} rounds'),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // Exercise list with animations (ONE PER EXERCISE)
          ...includedExercises.map((ex) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                // Exercise Animation (left)
                ExerciseAnimationWidget(
                  exerciseId: ex.id,
                  size: 60,
                  showWatermark: false,
                ),
                const SizedBox(width: 12),
                // Exercise Details (right)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ex.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        preset.isCircuit
                            ? '${ex.timeSeconds}s work / ${ex.restSeconds}s rest'
                            : '${ex.sets} sets × ${ex.reps} reps',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),

          const SizedBox(height: 20),

          // COMMIT and EDIT buttons
          Row(
            children: [
              Expanded(
                flex: 2,
                child: GlowButton(
                  text: '✅ COMMIT',
                  onPressed: () => _commitWorkout(preset),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => _editWorkout(preset),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.cyberLime,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '✏️ EDIT',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: AppColors.cyberLime,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.white10,
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.white70,
        ),
      ),
    );
  }

  Future<void> _commitWorkout(WorkoutPreset preset) async {
    HapticFeedback.mediumImpact();
    
    // Get the current difficulty and adjust exercises accordingly
    final currentDifficulty = _selectedDifficulties[preset.id] ?? 'intermediate';
    final adjustedExercises = _getAdjustedExercises(preset, currentDifficulty);
    
    // Create preset with adjusted exercises
    final adjustedPreset = preset.copyWith(exercises: adjustedExercises);
    
    // Check if we're in scheduling mode (user came from home tab)
    final scheduleDate = ref.read(selectedScheduleDateProvider);
    final isScheduling = ref.read(isSchedulingModeProvider);
    
    if (isScheduling && scheduleDate != null) {
      // SCHEDULING MODE: Create or update workout schedule for the selected date
      debugPrint('📅 Scheduling workout ${preset.name} for date: $scheduleDate');
      
      // Check if there's an existing schedule for this date
      final allSchedules = ref.read(workoutSchedulesProvider);
      WorkoutSchedule? existingSchedule = allSchedules.where((s) {
        return s.scheduledDate.year == scheduleDate.year &&
               s.scheduledDate.month == scheduleDate.month &&
               s.scheduledDate.day == scheduleDate.day;
      }).firstOrNull;
      
      // Create or update schedule for the selected date
      final schedule = WorkoutSchedule(
        id: existingSchedule?.id ?? '${DateTime.now().millisecondsSinceEpoch}_${scheduleDate.millisecondsSinceEpoch}',
        workoutId: preset.id,
        workoutName: preset.name,
        scheduledDate: DateTime(scheduleDate.year, scheduleDate.month, scheduleDate.day),
        scheduledTime: existingSchedule?.scheduledTime, // Preserve existing time
        hasAlarm: existingSchedule?.hasAlarm ?? false, // Preserve existing alarm setting
        createdAt: existingSchedule?.createdAt ?? DateTime.now(),
        repeatDays: existingSchedule?.repeatDays ?? [], // Preserve existing repeat days
      );
      
      // Save schedule to Hive
      await ref.read(workoutSchedulesProvider.notifier).saveSchedule(schedule);
      
      // If scheduling for TODAY, also commit to global provider (with adjusted exercises)
      final now = DateTime.now();
      final isSchedulingForToday = scheduleDate.year == now.year &&
                                  scheduleDate.month == now.month &&
                                  scheduleDate.day == now.day;
      
      if (isSchedulingForToday) {
        await ref.read(committedWorkoutProvider.notifier).commitWorkout(adjustedPreset);
      }
      
      // Clear the scheduling state
      ref.read(selectedScheduleDateProvider.notifier).state = null;
      ref.read(isSchedulingModeProvider.notifier).state = false;
      
      // Show confirmation
      if (mounted) {
        final dateStr = DateFormat('MMM d').format(scheduleDate);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.cyberLime),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Scheduled ${preset.name} for $dateStr! ✅',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.white10,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppColors.cyberLime.withOpacity(0.3)),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        
        // Navigate back to home tab
        final navigator = context.findAncestorWidgetOfExactType<TabNavigator>();
        if (navigator != null) {
          (navigator as dynamic).changeTab(0); // Home tab
        }
      }
    } else {
      // NORMAL MODE: Commit workout and also create a schedule for TODAY
      // This ensures the hero card on home tab updates correctly
      await ref.read(committedWorkoutProvider.notifier).commitWorkout(adjustedPreset);
      
      // CRITICAL FIX: Create a schedule for TODAY so the hero card shows the workout
      final now = DateTime.now();
      final todayDate = DateTime(now.year, now.month, now.day);
      
      // Check if there's already a schedule for today
      final allSchedules = ref.read(workoutSchedulesProvider);
      WorkoutSchedule? existingTodaySchedule = allSchedules.where((s) {
        return s.scheduledDate.year == todayDate.year &&
               s.scheduledDate.month == todayDate.month &&
               s.scheduledDate.day == todayDate.day;
      }).firstOrNull;
      
      // Create or update schedule for today
      final todaySchedule = WorkoutSchedule(
        id: existingTodaySchedule?.id ?? '${DateTime.now().millisecondsSinceEpoch}_${todayDate.millisecondsSinceEpoch}',
        workoutId: preset.id,
        workoutName: preset.name,
        scheduledDate: todayDate,
        scheduledTime: existingTodaySchedule?.scheduledTime, // Preserve existing time
        hasAlarm: existingTodaySchedule?.hasAlarm ?? false, // Preserve existing alarm
        createdAt: existingTodaySchedule?.createdAt ?? DateTime.now(),
        repeatDays: existingTodaySchedule?.repeatDays ?? [], // Preserve repeat settings
      );
      
      // Save schedule for today
      await ref.read(workoutSchedulesProvider.notifier).saveSchedule(todaySchedule);
      debugPrint('📅 Auto-created schedule for TODAY when committing: ${preset.name}');
      
      // Show confirmation
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: AppColors.cyberLime),
                const SizedBox(width: 12),
                Text(
                  'Workout Committed! ✅',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.white10,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppColors.cyberLime.withOpacity(0.3)),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
        
        // Navigate to home tab, which will show the mode selection screen
        final navigator = context.findAncestorWidgetOfExactType<TabNavigator>();
        if (navigator != null) {
          (navigator as dynamic).changeTab(0); // Home tab

          // Get the committed workout from provider
          final committedWorkout = ref.read(committedWorkoutProvider);

          // Show mode selection screen after a short delay
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted && committedWorkout != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrainingModeSelectionScreen(workout: committedWorkout),
                  fullscreenDialog: true,
                ),
              );
            }
          });
        }
      }
    }
  }

  Future<void> _editWorkout(WorkoutPreset preset) async {
    HapticFeedback.lightImpact();
    
    // Get the current difficulty and adjust exercises accordingly
    final currentDifficulty = _selectedDifficulties[preset.id] ?? 'intermediate';
    final adjustedExercises = _getAdjustedExercises(preset, currentDifficulty);
    
    // Create preset with adjusted exercises
    final adjustedPreset = preset.copyWith(exercises: adjustedExercises);
    
    // Navigate to editor
    final result = await Navigator.push<WorkoutPreset>(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutEditorScreen(preset: adjustedPreset),
      ),
    );
    
    // If user locked from editor, result will be returned
    if (result != null) {
      // Already locked in editor screen
    }
  }
}
