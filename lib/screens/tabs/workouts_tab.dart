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
// body_part_icon.dart removed — now using neon skeleton JPG icons
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

/// Maps every workout preset to the correct neon skeleton icon
String getPresetIconPath(String presetId, String presetName, String subcategory) {
  final id = presetId.toLowerCase();
  final name = presetName.toLowerCase();

  // GYM: MUSCLE SPLITS
  if (subcategory == 'muscle_splits') {
    if (id.contains('chest')) return 'assets/images/icons/chest.jpg';
    if (id.contains('back')) return 'assets/images/icons/back.jpg';
    if (id.contains('shoulder')) return 'assets/images/icons/shoulders.jpg';
    if (id.contains('leg')) return 'assets/images/icons/legs.jpg';
    if (id.contains('arm')) return 'assets/images/icons/arms.jpg';
    if (id.contains('core')) return 'assets/images/icons/core.jpg';
    return 'assets/images/icons/splits.jpg';
  }

  // GYM: MUSCLE GROUPINGS
  if (subcategory == 'muscle_groupings') {
    if (name.contains('pull')) return 'assets/images/icons/back.jpg';
    if (name.contains('push')) return 'assets/images/icons/chest.jpg';
    if (name.contains('upper')) return 'assets/images/icons/chest.jpg';
    if (name.contains('lower')) return 'assets/images/icons/legs.jpg';
    if (name.contains('full')) return 'assets/images/icons/splits.jpg';
    if (name.contains('glute')) return 'assets/images/icons/glutes.jpg';
    return 'assets/images/icons/splits.jpg';
  }

  // GYM: GYM CIRCUITS
  if (subcategory == 'gym_circuits') {
    if (name.contains('lower')) return 'assets/images/icons/legs.jpg';
    if (name.contains('upper')) return 'assets/images/icons/chest.jpg';
    if (name.contains('full')) return 'assets/images/icons/splits.jpg';
    if (name.contains('core')) return 'assets/images/icons/core.jpg';
    return 'assets/images/icons/circuits.jpg';
  }

  // GYM: BOOTY BUILDER
  if (subcategory == 'booty_builder') {
    return 'assets/images/icons/booty.jpg';
  }

  // GYM: GIRL POWER
  if (subcategory == 'girl_power') {
    if (name.contains('glute') || name.contains('peach') || name.contains('booty') || name.contains('sculpt')) return 'assets/images/icons/glutes.jpg';
    if (name.contains('push')) return 'assets/images/icons/chest.jpg';
    if (name.contains('pull')) return 'assets/images/icons/back.jpg';
    if (name.contains('upper')) return 'assets/images/icons/shoulders.jpg';
    if (name.contains('lower') || name.contains('leg')) return 'assets/images/icons/legs.jpg';
    if (name.contains('full') && name.contains('circuit')) return 'assets/images/icons/circuits.jpg';
    if (name.contains('full')) return 'assets/images/icons/splits.jpg';
    if (name.contains('ppl')) return 'assets/images/icons/splits.jpg';
    return 'assets/images/icons/girlpower.jpg';
  }

  // HOME: BODYWEIGHT BASICS
  if (subcategory == 'bodyweight_basics') {
    if (name.contains('upper')) return 'assets/images/icons/chest.jpg';
    if (name.contains('lower')) return 'assets/images/icons/legs.jpg';
    if (name.contains('core')) return 'assets/images/icons/core.jpg';
    if (name.contains('bro') || name.contains('circuit')) return 'assets/images/icons/circuits.jpg';
    if (name.contains('full')) return 'assets/images/icons/splits.jpg';
    return 'assets/images/icons/bodyweight.jpg';
  }

  // HOME: HIIT CIRCUITS
  if (subcategory == 'hiit_circuits') {
    if (name.contains('cardio')) return 'assets/images/icons/bodyweight.jpg';
    return 'assets/images/icons/circuits.jpg';
  }

  // HOME: HOME BOOTY
  if (subcategory == 'home_booty') {
    if (name.contains('burner') || name.contains('burn')) return 'assets/images/icons/booty.jpg';
    return 'assets/images/icons/glutes.jpg';
  }

  // SMART FALLBACK
  if (name.contains('chest') || name.contains('bench') || (name.contains('push') && !name.contains('pull'))) return 'assets/images/icons/chest.jpg';
  if (name.contains('back') || name.contains('pull') || name.contains('row')) return 'assets/images/icons/back.jpg';
  if (name.contains('shoulder') || name.contains('delt') || name.contains('ohp')) return 'assets/images/icons/shoulders.jpg';
  if (name.contains('leg') || name.contains('squat') || name.contains('lunge') || name.contains('lower')) return 'assets/images/icons/legs.jpg';
  if (name.contains('arm') || name.contains('bicep') || name.contains('tricep') || name.contains('curl')) return 'assets/images/icons/arms.jpg';
  if (name.contains('core') || name.contains('ab') || name.contains('plank') || name.contains('crunch')) return 'assets/images/icons/core.jpg';
  if (name.contains('glute') || name.contains('peach') || name.contains('booty') || name.contains('hip thrust')) return 'assets/images/icons/glutes.jpg';
  if (name.contains('circuit') || name.contains('hiit') || name.contains('burn') || name.contains('blast') || name.contains('torch') || name.contains('destroyer') || name.contains('tabata')) return 'assets/images/icons/circuits.jpg';
  if (name.contains('full body') || name.contains('total')) return 'assets/images/icons/splits.jpg';
  if (name.contains('upper')) return 'assets/images/icons/chest.jpg';

  // Ultimate fallback
  return 'assets/images/icons/splits.jpg';
}

class WorkoutsTab extends ConsumerStatefulWidget {
  const WorkoutsTab({super.key});

  @override
  ConsumerState<WorkoutsTab> createState() => _WorkoutsTabState();
}

class _WorkoutsTabState extends ConsumerState<WorkoutsTab> {
  String _selectedMode = 'gym'; // 'gym' or 'home'
  String? _selectedCategory;
  String? _selectedSplitKey; // For muscle splits inner navigation
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
    } else if (_selectedCategory == 'muscle_splits' && _selectedSplitKey == null) {
      return _buildSplitSelectionList();
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
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
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
                          const SizedBox(width: 6),
                          Flexible(
                            flex: 1,
                            child: _buildToggleButton('HOME', 'home', Icons.home),
                          ),
                          const SizedBox(width: 6),
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

          // AI tracking tagline
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              child: Text(
                'All presets can be tracked with AI Camera',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFCCFF00).withOpacity(0.35),
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

          // Category Cards
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildCategoryCard(categories[index]);
                },
                childCount: categories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSplitSelectionList() {
    final splits = ['chest', 'back', 'shoulders', 'legs', 'arms', 'core'];
    final splitNames = {
      'chest': 'Chest',
      'back': 'Back',
      'shoulders': 'Shoulders',
      'legs': 'Legs',
      'arms': 'Arms',
      'core': 'Core',
    };

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
                const Expanded(
                  child: Text(
                    'MUSCLE SPLITS',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Split cards
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
              child: Column(
                children: splits.map((key) => _buildSplitCard(key, splitNames[key]!)).toList(),
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
          _selectedSplitKey = null;
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
          'icon': 'assets/images/icons/splits.jpg',
          'desc': 'TARGET SPECIFIC MUSCLE GROUPS',
        },
        {
          'id': 'muscle_groupings',
          'name': 'MUSCLE GROUPINGS',
          'icon': 'assets/images/icons/groupings.jpg',
          'desc': 'PRE-BUILT WORKOUT COMBINATIONS',
        },
        {
          'id': 'gym_circuits',
          'name': 'GYM CIRCUITS',
          'icon': 'assets/images/icons/circuits.jpg',
          'desc': 'HIGH-INTENSITY TIMED WORKOUTS',
        },
        {
          'id': 'booty_builder',
          'name': 'BOOTY BUILDER',
          'icon': 'assets/images/icons/booty.jpg',
          'desc': "WOMEN'S GLUTE-FOCUSED WORKOUTS",
        },
        {
          'id': 'girl_power',
          'name': 'GIRL POWER',
          'icon': 'assets/images/icons/girlpower.jpg',
          'desc': 'ELITE WOMEN-FOCUSED TRAINING',
        },
      ];
    } else if (_selectedMode == 'home') {
      return [
        {
          'id': 'bodyweight_basics',
          'name': 'BODYWEIGHT BASICS',
          'icon': 'assets/images/icons/bodyweight.jpg',
          'desc': 'NO EQUIPMENT NEEDED',
        },
        {
          'id': 'hiit_circuits',
          'name': 'HIIT CIRCUITS',
          'icon': 'assets/images/icons/circuits.jpg',
          'desc': 'HIGH INTENSITY, NO EQUIPMENT',
        },
        {
          'id': 'home_booty',
          'name': 'HOME BOOTY',
          'icon': 'assets/images/icons/glutes.jpg',
          'desc': 'GLUTE WORKOUTS AT HOME',
        },
        {
          'id': 'girl_power',
          'name': 'GIRL POWER',
          'icon': 'assets/images/icons/girlpower.jpg',
          'desc': 'ELITE WOMEN-FOCUSED HOME TRAINING',
        },
      ];
    } else {
      return [
        {
          'id': 'ai_workouts',
          'name': 'MY AI WORKOUTS',
          'icon': 'assets/images/icons/bodyweight.jpg',
          'desc': 'AI-TRACKED CUSTOM WORKOUTS',
        },
        {
          'id': 'manual_workouts',
          'name': 'MY MANUAL WORKOUTS',
          'icon': 'assets/images/icons/splits.jpg',
          'desc': 'MANUAL LOGGING WORKOUTS',
        },
        {
          'id': 'create_new',
          'name': 'CREATE NEW',
          'icon': 'assets/images/icons/circuits.jpg',
          'desc': 'BUILD A CUSTOM WORKOUT',
        },
      ];
    }
  }

  Widget _buildCategoryCard(Map<String, String> category) {
    return GestureDetector(
      onTap: () => _navigateToCategory(category['id']!),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 120, // Fixed height — icon fills top to bottom
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.06),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // ═══════════════════════════════════════════
            // ICON — Big square, fills card height
            // ═══════════════════════════════════════════
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.asset(
                category['icon']!,
                width: 120, // Square: same as card height
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 120,
                    height: 120,
                    color: const Color(0xFF111111),
                    child: Icon(
                      Icons.fitness_center,
                      color: AppColors.cyberLime,
                      size: 32,
                    ),
                  );
                },
              ),
            ),

            // ═══════════════════════════════════════════
            // TEXT — Elite typography
            // ═══════════════════════════════════════════
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category['name']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.0,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['desc']!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.cyberLime.withOpacity(0.6),
                        letterSpacing: 0.8,
                      ),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ),

            // Arrow
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                Icons.chevron_right,
                color: Colors.white.withOpacity(0.15),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToCategory(String categoryId) async {
    if (categoryId == 'create_new') {
      HapticFeedback.mediumImpact();
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CustomWorkoutsScreen(),
        ),
      );
      if (result == true && mounted) {
        await _loadCustomWorkouts();
      }
    } else {
      setState(() {
        _selectedCategory = categoryId;
      });
      HapticFeedback.lightImpact();
    }
  }

  String _getSplitIcon(String splitKey) {
    switch (splitKey.toLowerCase()) {
      case 'chest': return 'assets/images/icons/chest.jpg';
      case 'back': return 'assets/images/icons/back.jpg';
      case 'shoulders': return 'assets/images/icons/shoulders.jpg';
      case 'legs': return 'assets/images/icons/legs.jpg';
      case 'arms': return 'assets/images/icons/arms.jpg';
      case 'core': return 'assets/images/icons/core.jpg';
      default: return 'assets/images/icons/splits.jpg';
    }
  }

  Widget _buildSplitCard(String splitKey, String splitName) {
    return GestureDetector(
      onTap: () => _navigateToSplit(splitKey),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        height: 100, // Slightly smaller for inner cards
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.cyberLime.withOpacity(0.08),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Icon — square
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
              child: Image.asset(
                _getSplitIcon(splitKey),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: const Color(0xFF111111),
                    child: Icon(Icons.fitness_center, color: AppColors.cyberLime, size: 28),
                  );
                },
              ),
            ),
            // Text
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      splitName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '5 EXERCISES',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppColors.cyberLime.withOpacity(0.5),
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: Icon(
                Icons.chevron_right,
                color: Colors.white.withOpacity(0.15),
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToSplit(String splitKey) {
    setState(() {
      _selectedSplitKey = splitKey;
    });
    HapticFeedback.lightImpact();
  }

  Widget _buildExerciseThumbnail(WorkoutExercise exercise) {
    // Always use GIF/animation thumbnail for exercise rows, never body icon
    return ExerciseAnimationWidget(
      exerciseId: exercise.id,
      size: 60,
      showWatermark: false,
    );
  }

  /// Derive body part from preset name for muscle split headers
  String _getBodyPartForPreset(WorkoutPreset preset) {
    final name = preset.name.toLowerCase();
    if (name.contains('chest')) return 'chest';
    if (name.contains('back')) return 'back';
    if (name.contains('shoulder')) return 'shoulders';
    if (name.contains('leg') || name.contains('quad')) return 'legs';
    if (name.contains('arm') || name.contains('bicep') || name.contains('tricep')) return 'arms';
    if (name.contains('core') || name.contains('abs')) return 'core';
    if (name.contains('glute') || name.contains('booty')) return 'glutes';
    if (name.contains('hamstring')) return 'hamstrings';
    if (name.contains('calv')) return 'calves';
    return 'full_body';
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
                    if (_selectedSplitKey != null) {
                      _selectedSplitKey = null; // Go back to split selection
                    } else {
                      _selectedCategory = null;
                    }
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
        final allSplits = WorkoutData.getGymMuscleSplits('intermediate');
        if (_selectedSplitKey != null) {
          // Filter to just the selected split
          return allSplits.where((p) {
            final bodyPart = _getBodyPartForPreset(p);
            return bodyPart == _selectedSplitKey;
          }).toList();
        }
        return allSplits;
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
    // When viewing a specific muscle split, show the split name
    if (_selectedCategory == 'muscle_splits' && _selectedSplitKey != null) {
      return _selectedSplitKey!.toUpperCase();
    }
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

  /// Get all presets for the current category at a specific difficulty level.
  /// Uses _selectedCategory (navigation state) to ensure consistency with _getPresetsForCategory().
  List<WorkoutPreset> _getPresetsAtDifficulty(String difficulty) {
    switch (_selectedCategory) {
      case 'muscle_splits':
        return WorkoutData.getGymMuscleSplits(difficulty);
      case 'muscle_groupings':
        return WorkoutData.getGymMuscleGroupings(difficulty);
      case 'gym_circuits':
        return WorkoutData.getGymCircuits(difficulty);
      case 'booty_builder':
        return WorkoutData.getGymBootyBuilder(difficulty);
      case 'girl_power':
        if (_selectedMode == 'gym') {
          return WorkoutData.getGymGirlPower(difficulty);
        } else {
          return WorkoutData.getHomeGirlPower(difficulty);
        }
      case 'bodyweight_basics':
        return WorkoutData.getHomeBodyweightBasics(difficulty);
      case 'hiit_circuits':
        return WorkoutData.getHomeHIITCircuits(difficulty);
      case 'home_booty':
        return WorkoutData.getHomeBooty(difficulty);
      case 'recovery':
        return WorkoutData.getHomeRecovery();
      default:
        return [];
    }
  }

  /// Adjust exercises based on difficulty.
  /// Completely replaces exercises by fetching a fresh preset at the selected
  /// difficulty from WorkoutData, matching by exact preset ID.
  List<WorkoutExercise> _getAdjustedExercises(WorkoutPreset preset, String difficulty) {
    // Recovery and custom workouts are not difficulty-dependent
    if (_selectedCategory == 'recovery' ||
        _selectedCategory == 'ai_workouts' ||
        _selectedCategory == 'manual_workouts') {
      return preset.exercises;
    }

    // Get fresh presets at the selected difficulty
    final presetsAtDifficulty = _getPresetsAtDifficulty(difficulty);

    // Find the matching preset by exact ID and return its exercises
    final matchingPreset = presetsAtDifficulty.firstWhere(
      (p) => p.id == preset.id,
      orElse: () => preset,
    );

    return matchingPreset.exercises;
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
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  getPresetIconPath(preset.id, preset.name, preset.subcategory),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: const Color(0xFF111111),
                      child: Icon(Icons.fitness_center, color: AppColors.cyberLime, size: 24),
                    );
                  },
                ),
              ),
              const SizedBox(width: 14),
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
                ),

                const SizedBox(height: 12),

                // Card 2 - Secondary
                _buildSlotOption(
                  context: context,
                  slot: 'secondary',
                  icon: Icons.bolt,
                  title: 'ACCESSORY',
                  subtitle: 'Secondary exercises, cardio',
                ),

                const SizedBox(height: 12),

                // Card 3 - Tertiary
                _buildSlotOption(
                  context: context,
                  slot: 'tertiary',
                  icon: Icons.self_improvement,
                  title: 'STRETCHING',
                  subtitle: 'Mobility, flexibility, recovery',
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
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).pop(slot);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0D0D0D),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFCCFF00).withOpacity(0.12),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFCCFF00).withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: const Color(0xFFCCFF00), size: 24),
            ),

            const SizedBox(width: 14),

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
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.35),
                    ),
                  ),
                ],
              ),
            ),

            Icon(
              Icons.chevron_right,
              color: Colors.white.withOpacity(0.15),
              size: 24,
            ),
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
                ),
                const SizedBox(height: 12),
                _buildSlotOption(
                  context: context,
                  slot: 'tertiary',
                  icon: Icons.self_improvement,
                  title: 'STRETCHING',
                  subtitle: 'Mobility, flexibility, recovery',
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
