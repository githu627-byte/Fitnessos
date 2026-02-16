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
import '../../widgets/body_part_icon.dart';
import '../../services/exercise_video_service.dart';
import '../../providers/workout_provider.dart';
import '../../providers/workout_schedule_provider.dart';
import '../../providers/schedule_date_provider.dart';
import '../../services/storage_service.dart'; // Add this import
import '../../services/calorie_calculation_service.dart'; // NEW: For accurate calorie estimates
import '../workout_editor_screen.dart';
import '../custom_workouts_screen.dart';
import '../home_screen.dart' show TabNavigator;
import '../training_mode_selection_screen.dart';
import '../../providers/selected_card_slot_provider.dart';
import 'settings_tab.dart';

class WorkoutsTab extends ConsumerStatefulWidget {
  const WorkoutsTab({super.key});

  @override
  ConsumerState<WorkoutsTab> createState() => _WorkoutsTabState();
}

class _WorkoutsTabState extends ConsumerState<WorkoutsTab> {
  String _selectedMode = 'gym'; // 'gym' or 'home'
  String? _selectedCategory;
  List<WorkoutPreset> _customWorkouts = []; // AI workouts
  List<WorkoutPreset> _manualWorkouts = []; // Manual workouts
  
  // Track difficulty selection for each workout (workoutId -> difficulty)
  final Map<String, String> _selectedDifficulties = {};

  // Track user-edited presets (workoutId -> edited WorkoutPreset)
  // When user edits exercises in WorkoutEditorScreen, store the result here
  // so COMMIT uses the edited version, not the original template
  final Map<String, WorkoutPreset> _editedPresets = {};
  
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
    final savedAiWorkouts = storage.getCustomWorkoutsList();
    final savedManualWorkouts = storage.getManualWorkoutsList();
    
    if (mounted) {
      setState(() {
        _customWorkouts = savedAiWorkouts;
        _manualWorkouts = savedManualWorkouts;
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
                          Flexible(
                            flex: 1,
                            child: _buildToggleButton('GYM', 'gym', Icons.fitness_center),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            flex: 1,
                            child: _buildToggleButton('HOME', 'home', Icons.home),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            flex: 1,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
              Flexible(
                flex: 1,
                child: _buildToggleButton('GYM', 'gym', Icons.fitness_center),
              ),
              const SizedBox(width: 4),
              Flexible(
                flex: 1,
                child: _buildToggleButton('HOME', 'home', Icons.home),
              ),
              const SizedBox(width: 4),
              Flexible(
                flex: 1,
                child: _buildToggleButton('CUSTOM', 'custom', Icons.edit_note),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }


  Widget _buildToggleButton(String label, String mode, IconData icon) {
    final isActive = _selectedMode == mode;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMode = mode;
          _selectedCategory = null;
        });
        HapticFeedback.lightImpact();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.cyberLime : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.black : AppColors.white50,
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                  color: isActive ? Colors.black : AppColors.white50,
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
          'bodyPart': 'full_body',
          'desc': 'Target specific muscle groups',
        },
        {
          'id': 'muscle_groupings',
          'name': 'MUSCLE GROUPINGS',
          'bodyPart': 'chest',
          'desc': 'Pre-built workout combinations',
        },
        {
          'id': 'gym_circuits',
          'name': 'GYM CIRCUITS',
          'bodyPart': 'full_body',
          'desc': 'High-intensity timed workouts',
        },
        {
          'id': 'booty_builder',
          'name': 'BOOTY BUILDER',
          'bodyPart': 'glutes',
          'desc': "Women's glute-focused workouts",
        },
        {
          'id': 'girl_power',
          'name': 'GIRL POWER',
          'bodyPart': 'full_body',
          'desc': 'Elite women-focused training programs',
        },
      ];
    } else if (_selectedMode == 'home') {
      return [
        {
          'id': 'bodyweight_basics',
          'name': 'BODYWEIGHT BASICS',
          'bodyPart': 'full_body',
          'desc': 'No equipment needed',
        },
        {
          'id': 'hiit_circuits',
          'name': 'HIIT CIRCUITS',
          'bodyPart': 'full_body',
          'desc': 'High intensity, no equipment',
        },
        {
          'id': 'home_booty',
          'name': 'HOME BOOTY',
          'bodyPart': 'glutes',
          'desc': 'Glute workouts at home',
        },
        // {
        //   'id': 'recovery',
        //   'name': 'RECOVERY & MOBILITY',
        //   'bodyPart': 'full_body',
        //   'desc': 'Stretching and mobility work',
        // },
        {
          'id': 'girl_power',
          'name': 'GIRL POWER',
          'bodyPart': 'full_body',
          'desc': 'Elite women-focused home training',
        },
      ];
    } else { // custom mode
      return [
        {
          'id': 'ai_workouts',
          'name': 'MY AI WORKOUTS',
          'bodyPart': 'full_body',
          'desc': 'AI-tracked custom workouts',
        },
        {
          'id': 'manual_workouts',
          'name': 'MY MANUAL WORKOUTS',
          'bodyPart': 'full_body',
          'desc': 'Manual log workouts',
        },
        {
          'id': 'create_new',
          'name': 'CREATE NEW WORKOUT',
          'bodyPart': 'full_body',
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
          
          // If workout was saved, reload both workout lists
          if (result == true && mounted) {
            await _loadCustomWorkouts(); // Reload both lists
            // Don't auto-switch - let user navigate to appropriate list
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
            BodyPartIcon(
              bodyPart: category['bodyPart'] ?? 'full_body',
              size: 52,
              highlightColor: _getCategoryColor(category['id']!),
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

  Color _getCategoryColor(String categoryId) {
    switch (categoryId) {
      case 'muscle_splits': return AppColors.cyberLime;
      case 'muscle_groupings': return const Color(0xFF00F0FF); // cyan
      case 'gym_circuits': return const Color(0xFFFF8C00); // orange
      case 'booty_builder': return const Color(0xFFEC4899); // pink
      case 'girl_power': return const Color(0xFFA855F7); // purple
      case 'home_booty': return const Color(0xFFEC4899); // pink
      case 'hiit_circuits': return const Color(0xFFFF8C00); // orange
      default: return AppColors.cyberLime;
    }
  }

  Widget _buildExerciseThumbnail(WorkoutExercise exercise) {
    if (ExerciseVideoService.hasVideo(exercise.id)) {
      return ExerciseAnimationWidget(
        exerciseId: exercise.id,
        size: 60,
        showWatermark: false,
      );
    }
    return BodyPartIcon(
      bodyPart: _getBodyPartForExercise(exercise),
      size: 48,
    );
  }

  String _getBodyPartForExercise(WorkoutExercise exercise) {
    final primary = exercise.primaryMuscles.firstOrNull ?? '';
    switch (primary.toLowerCase()) {
      case 'chest': return 'chest';
      case 'back': return 'back';
      case 'shoulders': return 'shoulders';
      case 'legs': case 'quadriceps': case 'quads': return 'legs';
      case 'arms': case 'biceps': case 'triceps': return 'arms';
      case 'core': case 'abs': return 'core';
      case 'glutes': return 'glutes';
      case 'hamstrings': return 'hamstrings';
      case 'calves': return 'calves';
      default: return 'full_body';
    }
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
      case 'ai_workouts':
        // Load saved AI workouts from storage
        return _customWorkouts; // Use state variable loaded from storage
      case 'manual_workouts':
        // Load saved manual workouts from storage
        return _manualWorkouts; // Use state variable loaded from storage
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

    // Use edited exercises if user has customized, otherwise use difficulty template
    final List<WorkoutExercise> adjustedExercises;
    if (_editedPresets.containsKey(preset.id)) {
      adjustedExercises = _editedPresets[preset.id]!.exercises.where((e) => e.included).toList();
    } else {
      adjustedExercises = _getAdjustedExercises(preset, currentDifficulty);
    }
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
                      
                      // Delete from correct storage based on category
                      if (_selectedCategory == 'manual_workouts') {
                        await storage.deleteManualWorkout(preset.id);
                      } else {
                        await storage.deleteCustomWorkout(preset.id);
                      }
                      
                      // Reload workouts list
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
                        _editedPresets.remove(preset.id); // Clear edits on difficulty change
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
                        _editedPresets.remove(preset.id); // Clear edits on difficulty change
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
                        _editedPresets.remove(preset.id); // Clear edits on difficulty change
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
                // Exercise Animation (left) — video if available, body icon fallback
                _buildExerciseThumbnail(ex),
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

    // Use user-edited preset if available, otherwise use difficulty-adjusted template
    final WorkoutPreset adjustedPreset;
    if (_editedPresets.containsKey(preset.id)) {
      adjustedPreset = _editedPresets[preset.id]!;
    } else {
      final currentDifficulty = _selectedDifficulties[preset.id] ?? 'intermediate';
      final adjustedExercises = _getAdjustedExercises(preset, currentDifficulty);
      adjustedPreset = preset.copyWith(exercises: adjustedExercises);
    }

    // Check if user came from an empty card (has pre-selected slot)
    String? selectedSlot = ref.read(selectedCardSlotProvider);

    // If no pre-selected slot, show modal
    // Manual-only workouts only go to secondary/tertiary cards
    if (selectedSlot == null) {
      if (preset.isManualOnly) {
        selectedSlot = await _showManualSlotSelectionModal();
      } else {
        selectedSlot = await _showSlotSelectionModal();
      }
      // If user cancelled, return
      if (selectedSlot == null) return;
    } else {
      // Clear the pre-selected slot
      ref.read(selectedCardSlotProvider.notifier).state = null;
    }

    // Check if we're in scheduling mode (user came from home tab)
    final scheduleDate = ref.read(selectedScheduleDateProvider);
    final isScheduling = ref.read(isSchedulingModeProvider);
    
    if (isScheduling && scheduleDate != null) {
      // SCHEDULING MODE: Create or update workout schedule for the selected date
      debugPrint('📅 Scheduling workout ${preset.name} for date: $scheduleDate');
      
      // Check if there's an existing schedule for this date and priority
      final allSchedules = ref.read(workoutSchedulesProvider);
      WorkoutSchedule? existingSchedule = allSchedules.where((s) {
        return s.scheduledDate.year == scheduleDate.year &&
               s.scheduledDate.month == scheduleDate.month &&
               s.scheduledDate.day == scheduleDate.day &&
               s.priority == selectedSlot;
      }).firstOrNull;

      // Create or update schedule for the selected date with priority
      final schedule = WorkoutSchedule(
        id: existingSchedule?.id ?? '${DateTime.now().millisecondsSinceEpoch}_${scheduleDate.millisecondsSinceEpoch}_$selectedSlot',
        workoutId: preset.id,
        workoutName: preset.name,
        scheduledDate: DateTime(scheduleDate.year, scheduleDate.month, scheduleDate.day),
        scheduledTime: existingSchedule?.scheduledTime, // Preserve existing time
        hasAlarm: existingSchedule?.hasAlarm ?? false, // Preserve existing alarm setting
        createdAt: existingSchedule?.createdAt ?? DateTime.now(),
        repeatDays: existingSchedule?.repeatDays ?? [], // Preserve existing repeat days
        priority: selectedSlot, // Use selected slot
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
      
      // Check if there's already a schedule for today with the same priority
      final allSchedules = ref.read(workoutSchedulesProvider);
      WorkoutSchedule? existingTodaySchedule = allSchedules.where((s) {
        return s.scheduledDate.year == todayDate.year &&
               s.scheduledDate.month == todayDate.month &&
               s.scheduledDate.day == todayDate.day &&
               s.priority == selectedSlot;
      }).firstOrNull;

      // Create or update schedule for today with selected priority
      final todaySchedule = WorkoutSchedule(
        id: existingTodaySchedule?.id ?? '${DateTime.now().millisecondsSinceEpoch}_${todayDate.millisecondsSinceEpoch}_$selectedSlot',
        workoutId: preset.id,
        workoutName: preset.name,
        scheduledDate: todayDate,
        scheduledTime: existingTodaySchedule?.scheduledTime, // Preserve existing time
        hasAlarm: existingTodaySchedule?.hasAlarm ?? false, // Preserve existing alarm
        createdAt: existingTodaySchedule?.createdAt ?? DateTime.now(),
        repeatDays: existingTodaySchedule?.repeatDays ?? [], // Preserve repeat settings
        priority: selectedSlot, // Use selected slot
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

  Future<String?> _showSlotSelectionModal() async {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                const Text(
                  'COMMIT TO WHICH CARD?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Choose where to save this workout',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.white60,
                  ),
                ),

                const SizedBox(height: 24),

                // Card 1 - Main
                _buildSlotOption(
                  context: context,
                  slot: 'main',
                  icon: Icons.fitness_center,
                  title: 'MAIN WORKOUT',
                  subtitle: 'Your primary training session',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0EA5E9), Color(0xFF06B6D4)],
                  ),
                ),

                const SizedBox(height: 12),

                // Card 2 - Secondary
                _buildSlotOption(
                  context: context,
                  slot: 'secondary',
                  icon: Icons.bolt,
                  title: 'ACCESSORY',
                  subtitle: 'Secondary exercises, cardio',
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
                  ),
                ),

                const SizedBox(height: 12),

                // Card 3 - Tertiary
                _buildSlotOption(
                  context: context,
                  slot: 'tertiary',
                  icon: Icons.self_improvement,
                  title: 'STRETCHING',
                  subtitle: 'Mobility, flexibility, recovery',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSlotOption({
    required BuildContext context,
    required String slot,
    required IconData icon,
    required String title,
    required String subtitle,
    required Gradient gradient,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).pop(slot);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
          ],
        ),
      ),
    );
  }

  Future<String?> _showManualSlotSelectionModal() async {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'COMMIT TO WHICH CARD?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose where to save this workout',
                  style: TextStyle(fontSize: 14, color: AppColors.white60),
                ),
                const SizedBox(height: 24),
                // Only secondary and tertiary for manual workouts
                _buildSlotOption(
                  context: context,
                  slot: 'secondary',
                  icon: Icons.bolt,
                  title: 'ACCESSORY',
                  subtitle: 'Secondary exercises, cardio',
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF59E0B), Color(0xFFEF4444)],
                  ),
                ),
                const SizedBox(height: 12),
                _buildSlotOption(
                  context: context,
                  slot: 'tertiary',
                  icon: Icons.self_improvement,
                  title: 'STRETCHING',
                  subtitle: 'Mobility, flexibility, recovery',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFFEC4899)],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _editWorkout(WorkoutPreset preset) async {
    HapticFeedback.lightImpact();

    // Get the current difficulty and adjust exercises accordingly
    final currentDifficulty = _selectedDifficulties[preset.id] ?? 'intermediate';
    final adjustedExercises = _getAdjustedExercises(preset, currentDifficulty);

    // If user already edited this preset, use their edits as the starting point
    final startingPreset = _editedPresets[preset.id] ?? preset.copyWith(exercises: adjustedExercises);

    // Navigate to editor
    final result = await Navigator.push<WorkoutPreset>(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutEditorScreen(preset: startingPreset),
      ),
    );

    // Store the edited preset so COMMIT and the card display use it
    if (result != null) {
      setState(() {
        _editedPresets[preset.id] = result;
      });
    }
  }
}
