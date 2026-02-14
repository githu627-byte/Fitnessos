import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workout_data.dart';
import '../models/workout_models.dart';
import '../models/workout_schedule.dart';
import '../utils/app_colors.dart';
import '../widgets/exercise_animation_widget.dart';
import '../widgets/glow_button.dart';
import '../providers/workout_provider.dart';
import '../providers/workout_schedule_provider.dart';
import '../services/storage_service.dart';
import '../data/exercise_gif_mapping.dart';
import 'exercise_explanation_screen.dart';

class CustomWorkoutsScreen extends ConsumerStatefulWidget {
  const CustomWorkoutsScreen({super.key});

  @override
  ConsumerState<CustomWorkoutsScreen> createState() => _CustomWorkoutsScreenState();
}

class _CustomWorkoutsScreenState extends ConsumerState<CustomWorkoutsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _workoutNameController = TextEditingController(text: 'My Custom Workout');
  final TextEditingController _emojiController = TextEditingController(text: '💪'); // Default emoji
  
  String _workoutMode = 'ai'; // NEW: 'ai' or 'manual'
  String _selectedCategory = 'all';
  String _selectedEquipment = 'all'; // Add equipment filter
  List<Exercise> _selectedExercises = [];
  Map<String, ExerciseSettings> _exerciseSettings = {};
  
  // Get all exercises from WorkoutData
  List<Exercise> get _allExercises => WorkoutData.getAllExercises();
  
  // Get all manual exercises from GIF library
  List<Exercise> _getAllManualExercises() {
    final List<Exercise> manualExercises = [];
    
    // Load from ExerciseGifMapping (534 exercises)
    ExerciseGifMapping.exerciseGifs.forEach((id, gifInfo) {
      // Convert snake_case id to readable name
      final name = id.split('_').map((word) => 
        word[0].toUpperCase() + word.substring(1)
      ).join(' ');
      
      manualExercises.add(Exercise(
        id: id,
        name: name,
        difficulty: 'intermediate', // Default
        equipment: _inferEquipment(name),
      ));
    });
    
    return manualExercises;
  }
  
  String _inferEquipment(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('barbell')) return 'barbell';
    if (lower.contains('dumbbell')) return 'dumbbell';
    if (lower.contains('cable')) return 'cable';
    if (lower.contains('band')) return 'band';
    return 'bodyweight';
  }
  
  List<Exercise> get _filteredExercises {
    // Use manual exercises if in manual mode, otherwise use AI exercises
    List<Exercise> exercises = _workoutMode == 'manual' 
      ? _getAllManualExercises() 
      : _allExercises;
    
    // Filter by category
    if (_selectedCategory != 'all') {
      if (_selectedCategory == 'chest') {
        exercises = exercises.where((e) => 
          WorkoutData.muscleSplits['chest']!.any((c) => c.id == e.id) ||
          e.name.toLowerCase().contains('chest') ||
          e.name.toLowerCase().contains('press') && (e.name.toLowerCase().contains('bench') || e.name.toLowerCase().contains('incline') || e.name.toLowerCase().contains('decline')) ||
          e.name.toLowerCase().contains('pushup') || e.name.toLowerCase().contains('push-up') || e.name.toLowerCase().contains('push_up') ||
          e.name.toLowerCase().contains('fly') || e.name.toLowerCase().contains('flye') ||
          e.name.toLowerCase().contains('dip') && !e.name.toLowerCase().contains('hip')
        ).toList();
      } else if (_selectedCategory == 'back') {
        exercises = exercises.where((e) => 
          WorkoutData.muscleSplits['back']!.any((c) => c.id == e.id) ||
          e.name.toLowerCase().contains('back') ||
          e.name.toLowerCase().contains('row') ||
          e.name.toLowerCase().contains('pulldown') ||
          e.name.toLowerCase().contains('pullup') || e.name.toLowerCase().contains('pull-up') || e.name.toLowerCase().contains('pull_up') ||
          e.name.toLowerCase().contains('chinup') || e.name.toLowerCase().contains('chin-up') || e.name.toLowerCase().contains('chin_up') ||
          e.name.toLowerCase().contains('deadlift') ||
          e.name.toLowerCase().contains('shrug')
        ).toList();
      } else if (_selectedCategory == 'shoulders') {
        exercises = exercises.where((e) => 
          WorkoutData.muscleSplits['shoulders']!.any((c) => c.id == e.id) ||
          e.name.toLowerCase().contains('shoulder') ||
          e.name.toLowerCase().contains('overhead') ||
          e.name.toLowerCase().contains('lateral') ||
          e.name.toLowerCase().contains('front raise') ||
          e.name.toLowerCase().contains('rear delt') ||
          e.name.toLowerCase().contains('upright row') ||
          e.name.toLowerCase().contains('pike')
        ).toList();
      } else if (_selectedCategory == 'arms') {
        exercises = exercises.where((e) => 
          WorkoutData.muscleSplits['arms']!.any((c) => c.id == e.id) ||
          e.name.toLowerCase().contains('bicep') ||
          e.name.toLowerCase().contains('tricep') ||
          e.name.toLowerCase().contains('curl') ||
          e.name.toLowerCase().contains('extension') && (e.name.toLowerCase().contains('tricep') || e.name.toLowerCase().contains('overhead')) ||
          e.name.toLowerCase().contains('hammer') ||
          e.name.toLowerCase().contains('preacher')
        ).toList();
      } else if (_selectedCategory == 'legs') {
        exercises = exercises.where((e) => 
          WorkoutData.muscleSplits['legs']!.any((c) => c.id == e.id) ||
          e.name.toLowerCase().contains('squat') ||
          e.name.toLowerCase().contains('lunge') ||
          e.name.toLowerCase().contains('leg') ||
          e.name.toLowerCase().contains('quad') ||
          e.name.toLowerCase().contains('hamstring') ||
          e.name.toLowerCase().contains('glute') ||
          e.name.toLowerCase().contains('calf') ||
          e.name.toLowerCase().contains('thigh') ||
          e.name.toLowerCase().contains('hip thrust') ||
          e.name.toLowerCase().contains('step up') ||
          e.name.toLowerCase().contains('wall sit') ||
          e.name.toLowerCase().contains('bulgarian')
        ).toList();
      } else if (_selectedCategory == 'core') {
        exercises = exercises.where((e) => 
          WorkoutData.muscleSplits['core']!.any((c) => c.id == e.id) ||
          e.name.toLowerCase().contains('core') ||
          e.name.toLowerCase().contains('abs') ||
          e.name.toLowerCase().contains('abdominal') ||
          e.name.toLowerCase().contains('crunch') ||
          e.name.toLowerCase().contains('plank') ||
          e.name.toLowerCase().contains('sit-up') || e.name.toLowerCase().contains('situp') ||
          e.name.toLowerCase().contains('russian twist') ||
          e.name.toLowerCase().contains('mountain climber') ||
          e.name.toLowerCase().contains('bicycle') ||
          e.name.toLowerCase().contains('knee raise') ||
          e.name.toLowerCase().contains('leg raise') ||
          e.name.toLowerCase().contains('dead bug') ||
          e.name.toLowerCase().contains('bird dog') ||
          e.name.toLowerCase().contains('hollow') ||
          e.name.toLowerCase().contains('v-up') ||
          e.name.toLowerCase().contains('ab wheel')
        ).toList();
      } else if (_selectedCategory == 'home') {
        // Include ALL bodyweight exercises - from atHome, cardio, and any exercise with bodyweight equipment
        exercises = exercises.where((e) => 
          WorkoutData.cardioExercises.any((c) => c.id == e.id) ||
          WorkoutData.atHomeExercises.any((c) => c.id == e.id) ||
          e.equipment.toLowerCase() == 'bodyweight'
        ).toList();
      }
    }
    
    // Filter by equipment - SMART FILTERING
    if (_selectedEquipment != 'all') {
      if (_selectedEquipment == 'barbell') {
        exercises = exercises.where((e) => _isBarbellExercise(e)).toList();
      } else if (_selectedEquipment == 'dumbbell') {
        exercises = exercises.where((e) => _isDumbbellExercise(e)).toList();
      } else if (_selectedEquipment == 'bands') {
        exercises = exercises.where((e) => _isBandExercise(e)).toList();
      } else if (_selectedEquipment == 'bodyweight') {
        exercises = exercises.where((e) => _isBodyweightExercise(e)).toList();
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
    _workoutNameController.dispose();
    _emojiController.dispose();
    super.dispose();
  }

  void _addExercise(Exercise exercise) {
    if (!_selectedExercises.any((e) => e.id == exercise.id)) {
      setState(() {
        _selectedExercises.add(exercise);
        _exerciseSettings[exercise.id] = ExerciseSettings(
          sets: 3,
          reps: 10,
          restSeconds: 60,
        );
      });
      HapticFeedback.mediumImpact();
    }
  }

  void _removeExercise(Exercise exercise) {
    setState(() {
      _selectedExercises.removeWhere((e) => e.id == exercise.id);
      _exerciseSettings.remove(exercise.id);
    });
    HapticFeedback.lightImpact();
  }

  void _updateExerciseSettings(String exerciseId, ExerciseSettings settings) {
    setState(() {
      _exerciseSettings[exerciseId] = settings;
    });
  }

  Future<void> _commitWorkout() async {
    if (_selectedExercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one exercise'),
          backgroundColor: AppColors.neonCrimson,
        ),
      );
      return;
    }

    // Ask if user wants to save the workout
    final shouldSave = await _showSaveDialog();

    HapticFeedback.heavyImpact();

    // Create WorkoutPreset from custom workout
    final customPreset = WorkoutPreset(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      name: _workoutNameController.text.isEmpty ? 'My Custom Workout' : _workoutNameController.text,
      category: 'Custom',
      subcategory: 'custom',
      icon: _emojiController.text.isEmpty ? '💪' : _emojiController.text, // Add emoji
      isCircuit: false,
      isManualOnly: _workoutMode == 'manual', // Flag manual workouts
      duration: '${_selectedExercises.length * 5} min', // Rough estimate
      exercises: _selectedExercises.map((e) {
        final settings = _exerciseSettings[e.id]!;
        return WorkoutExercise(
          id: e.id,
          name: e.name,
          sets: settings.sets,
          reps: settings.reps,
          restSeconds: settings.restSeconds,
          included: true,
        );
      }).toList(),
    );

    // Save if user chose to
    if (shouldSave == true) {
      final storage = await StorageService.getInstance();
      
      // Save to appropriate storage based on mode
      if (_workoutMode == 'manual') {
        await storage.saveManualWorkout(customPreset);
      } else {
        await storage.saveCustomWorkout(customPreset); // AI workouts
      }
    }

    // Commit the workout
    await ref.read(committedWorkoutProvider.notifier).commitWorkout(customPreset);

    // ═══════════════════════════════════════════════════════════════════════════
    // FIX: Create a schedule for TODAY so the hero card shows the workout
    // ═══════════════════════════════════════════════════════════════════════════
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);

    // Check if there's already a schedule for today
    final allSchedules = ref.read(workoutSchedulesProvider);
    WorkoutSchedule? existingTodaySchedule;
    for (final s in allSchedules) {
      if (s.scheduledDate.year == todayDate.year &&
          s.scheduledDate.month == todayDate.month &&
          s.scheduledDate.day == todayDate.day) {
        existingTodaySchedule = s;
        break;
      }
    }

    // Create or update schedule for today
    final todaySchedule = WorkoutSchedule(
      id: existingTodaySchedule?.id ?? '${DateTime.now().millisecondsSinceEpoch}_${todayDate.millisecondsSinceEpoch}',
      workoutId: customPreset.id,
      workoutName: customPreset.name,
      scheduledDate: todayDate,
      scheduledTime: existingTodaySchedule?.scheduledTime,
      hasAlarm: existingTodaySchedule?.hasAlarm ?? false,
      createdAt: existingTodaySchedule?.createdAt ?? DateTime.now(),
      repeatDays: existingTodaySchedule?.repeatDays ?? [],
    );

    // Save schedule for today
    await ref.read(workoutSchedulesProvider.notifier).saveSchedule(todaySchedule);
    debugPrint('📅 Auto-created schedule for TODAY when committing custom: ${customPreset.name}');
    // ═══════════════════════════════════════════════════════════════════════════

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.cyberLime),
              const SizedBox(width: 12),
              Text(
                shouldSave == true 
                    ? 'Custom Workout Saved & Committed! ✅'
                    : 'Custom Workout Committed! ✅',
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
        ),
      );

      // Navigate back with success = true, so workouts tab shows custom workouts list
      Navigator.of(context).pop(true);
    }
  }

  Future<bool?> _showSaveDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: AppColors.cyberLime.withOpacity(0.3), width: 2),
        ),
        title: const Text(
          'Save Workout?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        content: const Text(
          'Do you want to save this workout to use again later?',
          style: TextStyle(
            color: AppColors.white70,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'NO, JUST COMMIT',
              style: TextStyle(
                color: AppColors.white50,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.cyberLime.withOpacity(0.2),
            ),
            child: const Text(
              'YES, SAVE IT',
              style: TextStyle(
                color: AppColors.cyberLime,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SMART EQUIPMENT FILTERING METHODS
  bool _isBarbellExercise(Exercise e) {
    final name = e.name.toLowerCase();
    final id = e.id.toLowerCase();
    
    // Direct barbell mentions
    if (name.contains('barbell') || id.contains('barbell') || id.startsWith('bb_')) return true;
    
    // Classic barbell exercises (typically done with barbell)
    if (name.contains('deadlift') && !name.contains('dumbbell')) return true;
    if (name.contains('back squat') || name.contains('front squat')) return true;
    if (name.contains('bench press') && !name.contains('dumbbell')) return true;
    if (name.contains('bent-over row') || name.contains('bent over row')) return true;
    if (name.contains('overhead press') && !name.contains('dumbbell')) return true;
    if (name.contains('military press')) return true;
    if (name.contains('upright row') && !name.contains('dumbbell')) return true;
    if (name.contains('shrug') && !name.contains('dumbbell')) return true;
    if (name.contains('hip thrust') && !name.contains('dumbbell')) return true;
    if (name.contains('good morning')) return true;
    if (name.contains('power clean') || name.contains('clean and jerk')) return true;
    if (name.contains('snatch')) return true;
    if (name.contains('thruster') && !name.contains('dumbbell')) return true;
    
    return false;
  }
  
  bool _isDumbbellExercise(Exercise e) {
    final name = e.name.toLowerCase();
    final id = e.id.toLowerCase();
    
    // Direct dumbbell mentions
    if (name.contains('dumbbell') || id.contains('dumbbell') || id.startsWith('db_')) return true;
    
    // Classic dumbbell exercises
    if (name.contains('bicep curl') || name.contains('biceps curl')) return true;
    if (name.contains('hammer curl')) return true;
    if (name.contains('concentration curl')) return true;
    if (name.contains('preacher curl')) return true;
    if (name.contains('tricep extension') || name.contains('triceps extension')) return true;
    if (name.contains('skull crusher')) return true;
    if (name.contains('lateral raise')) return true;
    if (name.contains('front raise')) return true;
    if (name.contains('rear delt fly') || name.contains('reverse fly')) return true;
    if (name.contains('arnold press')) return true;
    if (name.contains('chest fly') || name.contains('chest flye')) return true;
    if (name.contains('goblet squat')) return true;
    if (name.contains('bulgarian split') && !name.contains('bodyweight')) return true;
    if (name.contains('step up') && !name.contains('bodyweight')) return true;
    if (name.contains('lunge') && (name.contains('walking') || name.contains('reverse') || name.contains('forward')) && !name.contains('bodyweight')) return true;
    if (name.contains('romanian deadlift') && name.contains('dumbbell')) return true;
    if (name.contains('renegade row')) return true;
    if (name.contains('man maker')) return true;
    if (name.contains('thrusters') && name.contains('dumbbell')) return true;
    
    return false;
  }
  
  bool _isBandExercise(Exercise e) {
    final name = e.name.toLowerCase();
    final id = e.id.toLowerCase();
    
    // Direct band mentions
    if (name.contains('band') || id.contains('band')) return true;
    if (name.contains('resistance') || id.contains('resistance')) return true;
    if (name.contains('elastic')) return true;
    
    // Band-specific exercises
    // if (name.contains('clamshell')) return true;
    if (name.contains('fire hydrant') && name.contains('band')) return true;
    if (name.contains('lateral walk') && name.contains('band')) return true;
    if (name.contains('monster walk')) return true;
    if (name.contains('glute bridge') && name.contains('band')) return true;
    
    return false;
  }
  
  bool _isBodyweightExercise(Exercise e) {
    final name = e.name.toLowerCase();
    final id = e.id.toLowerCase();
    
    // Already marked as bodyweight
    if (e.equipment.toLowerCase() == 'bodyweight') return true;
    if (e.equipment.toLowerCase() == 'none') return true;
    
    // From atHome and cardio lists
    if (WorkoutData.atHomeExercises.any((c) => c.id == e.id)) return true;
    if (WorkoutData.cardioExercises.any((c) => c.id == e.id)) return true;
    
    // Classic bodyweight exercises
    if (name.contains('push-up') || name.contains('pushup') || name.contains('push up')) return true;
    if (name.contains('pull-up') || name.contains('pullup') || name.contains('pull up')) return true;
    if (name.contains('chin-up') || name.contains('chinup') || name.contains('chin up')) return true;
    if (name.contains('dip') && !name.contains('dumbbell') && !name.contains('barbell')) return true;
    if (name.contains('squat') && (name.contains('bodyweight') || name.contains('air') || name.contains('jump') || (!name.contains('barbell') && !name.contains('dumbbell') && !name.contains('goblet')))) return true;
    if (name.contains('lunge') && !name.contains('dumbbell') && !name.contains('barbell')) return true;
    if (name.contains('plank')) return true;
    if (name.contains('sit-up') || name.contains('situp') || name.contains('sit up')) return true;
    if (name.contains('crunch')) return true;
    if (name.contains('mountain climber')) return true;
    if (name.contains('burpee')) return true;
    if (name.contains('jumping jack')) return true;
    if (name.contains('high knee')) return true;
    if (name.contains('butt kick')) return true;
    if (name.contains('bear crawl')) return true;
    if (name.contains('crab walk')) return true;
    if (name.contains('wall sit')) return true;
    if (name.contains('pike') && name.contains('push')) return true;
    if (name.contains('diamond') && name.contains('push')) return true;
    if (name.contains('wide') && name.contains('push')) return true;
    if (name.contains('decline') && name.contains('push') && !name.contains('bench')) return true;
    if (name.contains('incline') && name.contains('push') && !name.contains('bench')) return true;
    if (name.contains('handstand')) return true;
    if (name.contains('pistol squat')) return true;
    if (name.contains('archer')) return true;
    if (name.contains('muscle up')) return true;
    if (name.contains('leg raise')) return true;
    if (name.contains('russian twist')) return true;
    if (name.contains('bicycle') && name.contains('crunch')) return true;
    if (name.contains('dead bug')) return true;
    if (name.contains('bird dog')) return true;
    // if (name.contains('superman')) return true;
    if (name.contains('hollow') && name.contains('hold')) return true;
    if (name.contains('v-up') || name.contains('v up')) return true;
    if (name.contains('tuck jump')) return true;
    if (name.contains('broad jump')) return true;
    if (name.contains('box jump') && !name.contains('weighted')) return true;
    if (name.contains('step up') && name.contains('bodyweight')) return true;
    if (name.contains('calf raise') && name.contains('bodyweight')) return true;
    if (name.contains('single leg')) return true;
    if (name.contains('skater')) return true;
    if (name.contains('sprawl')) return true;
    if (name.contains('star jump')) return true;
    if (name.contains('lateral hop')) return true;
    if (name.contains('jump rope') && !name.contains('weighted')) return true;
    
    // Exclude obvious weight exercises
    if (name.contains('barbell') || name.contains('dumbbell') || name.contains('cable') || 
        name.contains('machine') || name.contains('kettlebell') || name.contains('band')) return false;
        
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Main content - now fully scrollable
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader()),
                SliverToBoxAdapter(child: _buildCategoryFilter()),
                SliverToBoxAdapter(child: _buildSearchBar()),
                SliverPadding(
                  padding: EdgeInsets.only(
                    bottom: _selectedExercises.isNotEmpty ? MediaQuery.of(context).size.height * 0.25 : 0,
                  ),
                  sliver: _buildExerciseLibrarySliver(),
                ),
              ],
            ),
          ),

          // Floating workout builder panel
          if (_selectedExercises.isNotEmpty)
            _buildWorkoutBuilderPanel(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      child: Column(
        children: [
          // Row: Title left, back button right
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _workoutMode == 'ai' ? 'AI Exercise Library' : 'Manual Exercise Library',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _workoutMode == 'ai' 
                        ? 'MediaPipe AI tracking available'
                        : 'Visual guide & manual logging only',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.white50,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (_selectedExercises.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '${_selectedExercises.length} exercises • Est. ${_calculateCalories()} cal',
                          style: const TextStyle(
                            color: AppColors.cyberLime,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white, size: 24),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.white10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // AI/Manual mode toggle
          _buildModeToggle(),
          
          const SizedBox(height: 12),
          
          // Equipment filter buttons
          _buildEquipmentFilters(),
        ],
      ),
    );
  }

  Widget _buildModeToggle() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                _workoutMode = 'ai';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _workoutMode == 'ai' ? AppColors.cyberLime.withOpacity(0.2) : AppColors.white5,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _workoutMode == 'ai' ? AppColors.cyberLime : AppColors.white10,
                  width: _workoutMode == 'ai' ? 2 : 1,
                ),
              ),
              child: Text(
                '🤖 AI TRACKED',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _workoutMode == 'ai' ? AppColors.cyberLime : Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() {
                _workoutMode = 'manual';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _workoutMode == 'manual' ? AppColors.neonCrimson.withOpacity(0.2) : AppColors.white5,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _workoutMode == 'manual' ? AppColors.neonCrimson : AppColors.white10,
                  width: _workoutMode == 'manual' ? 2 : 1,
                ),
              ),
              child: Text(
                '📝 MANUAL LOG',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _workoutMode == 'manual' ? AppColors.neonCrimson : Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentFilters() {
    final equipmentTypes = [
      {'id': 'all', 'name': 'ALL', 'icon': '💯'},
      {'id': 'barbell', 'name': 'BARBELL', 'icon': '🏋️'},
      {'id': 'dumbbell', 'name': 'DUMBBELL', 'icon': '💪'},
      {'id': 'bands', 'name': 'BANDS', 'icon': '🔗'},
      {'id': 'bodyweight', 'name': 'BODYWEIGHT', 'icon': '🤸'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: equipmentTypes.map((equipment) {
          final isSelected = _selectedEquipment == equipment['id'];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                setState(() {
                  _selectedEquipment = equipment['id']!;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.cyberLime.withOpacity(0.2) : AppColors.white5,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? AppColors.cyberLime : AppColors.white10,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      equipment['icon']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      equipment['name']!,
                      style: TextStyle(
                        color: isSelected ? AppColors.cyberLime : Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTrainingPresets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TRAINING PRESETS',
            style: TextStyle(
              color: AppColors.cyberLime,
              fontSize: 14,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          
          // Weight Training Presets
          const Text(
            'WEIGHT TRAINING',
            style: TextStyle(
              color: AppColors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildPresetButton(
                  'STRENGTH',
                  '1-5 reps • 3-5 sets • 3-5min rest',
                  '💪',
                  () => _applyStrengthPreset(),
                ),
                const SizedBox(width: 8),
                _buildPresetButton(
                  'HYPERTROPHY',
                  '6-12 reps • 3-5 sets • 1-3min rest',
                  '🔥',
                  () => _applyHypertrophyPreset(),
                ),
                const SizedBox(width: 8),
                _buildPresetButton(
                  'ENDURANCE',
                  '12-20 reps • 2-4 sets • 30-90s rest',
                  '⚡',
                  () => _applyEndurancePreset(),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Cardio Presets
          const Text(
            'CARDIO TRAINING',
            style: TextStyle(
              color: AppColors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildPresetButton(
                  'HIIT',
                  '40s work • 20s rest',
                  '🏃',
                  () => _applyHIITPreset(),
                ),
                const SizedBox(width: 8),
                _buildPresetButton(
                  'TABATA',
                  '20s work • 10s rest',
                  '💥',
                  () => _applyTabataPreset(),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildPresetButton(String title, String description, String icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(12),
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
                Text(
                  icon,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(
                color: AppColors.white50,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyStrengthPreset() {
    setState(() {
      for (final exercise in _selectedExercises) {
        _exerciseSettings[exercise.id] = ExerciseSettings(
          sets: 4, // 3-5 sets
          reps: 3, // 1-5 reps
          restSeconds: 240, // 4 minutes rest
          timeSeconds: null, // Not time-based
        );
      }
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('💪 Applied Strength preset: 3 reps, 4 sets, 4min rest'),
          backgroundColor: AppColors.cyberLime,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _applyHypertrophyPreset() {
    setState(() {
      for (final exercise in _selectedExercises) {
        _exerciseSettings[exercise.id] = ExerciseSettings(
          sets: 4, // 3-5 sets
          reps: 10, // 6-12 reps
          restSeconds: 120, // 2 minutes rest
          timeSeconds: null, // Not time-based
        );
      }
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🔥 Applied Hypertrophy preset: 10 reps, 4 sets, 2min rest'),
          backgroundColor: AppColors.cyberLime,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _applyEndurancePreset() {
    setState(() {
      for (final exercise in _selectedExercises) {
        _exerciseSettings[exercise.id] = ExerciseSettings(
          sets: 3, // 2-4 sets
          reps: 15, // 12-20 reps
          restSeconds: 60, // 1 minute rest
          timeSeconds: null, // Not time-based
        );
      }
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚡ Applied Endurance preset: 15 reps, 3 sets, 1min rest'),
          backgroundColor: AppColors.cyberLime,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _applyHIITPreset() {
    setState(() {
      for (final exercise in _selectedExercises) {
        _exerciseSettings[exercise.id] = ExerciseSettings(
          sets: 1, // Circuit style
          reps: 999, // Time-based (ignored)
          restSeconds: 20, // 20s rest
          timeSeconds: 40, // 40s work
        );
      }
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🏃 Applied HIIT preset: 40s work, 20s rest'),
          backgroundColor: AppColors.cyberLime,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _applyTabataPreset() {
    setState(() {
      for (final exercise in _selectedExercises) {
        _exerciseSettings[exercise.id] = ExerciseSettings(
          sets: 1, // Circuit style
          reps: 999, // Time-based (ignored)
          restSeconds: 10, // 10s rest
          timeSeconds: 20, // 20s work
        );
      }
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('💥 Applied Tabata preset: 20s work, 10s rest'),
          backgroundColor: AppColors.cyberLime,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _loadWorkout(WorkoutPreset workout) {
    setState(() {
      _workoutNameController.text = workout.name;
      _selectedExercises.clear();
      _exerciseSettings.clear();
      
      for (final exercise in workout.exercises) {
        // Find the matching exercise from allExercises
        final matchedExercise = _allExercises.firstWhere(
          (e) => e.id == exercise.id,
          orElse: () => Exercise(
            id: exercise.id,
            name: exercise.name,
            difficulty: 'intermediate',
            equipment: 'weights',
          ),
        );
        
        _selectedExercises.add(matchedExercise);
        _exerciseSettings[exercise.id] = ExerciseSettings(
          sets: exercise.sets,
          reps: exercise.reps,
          restSeconds: exercise.restSeconds ?? 60,
        );
      }
    });
    
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Loaded: ${workout.name}'),
        backgroundColor: AppColors.cyberLime,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categories = [
      {'id': 'all', 'name': 'All', 'icon': '💯'},
      {'id': 'chest', 'name': 'Chest', 'icon': '💪'},
      {'id': 'back', 'name': 'Back', 'icon': '🔙'},
      {'id': 'shoulders', 'name': 'Shoulders', 'icon': '🏋️'},
      {'id': 'arms', 'name': 'Arms', 'icon': '💪'},
      {'id': 'legs', 'name': 'Legs', 'icon': '🦵'},
      {'id': 'core', 'name': 'Core', 'icon': '🔥'},
      {'id': 'home', 'name': 'Home', 'icon': '🏠'},
    ];

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category['id'];

          return GestureDetector(
            onTap: () {
              setState(() => _selectedCategory = category['id']!);
              HapticFeedback.selectionClick();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.cyberLime.withOpacity(0.2) : AppColors.white5,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? AppColors.cyberLime : AppColors.white10,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category['icon']!,
                    style: const TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category['name']!,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.cyberLime : AppColors.white70,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white10),
      ),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Search exercises...',
          hintStyle: TextStyle(color: AppColors.white40),
          icon: Icon(Icons.search, color: AppColors.white40),
          border: InputBorder.none,
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildExerciseLibrary() {
    final exercises = _filteredExercises;

    if (exercises.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fitness_center, size: 64, color: AppColors.white30),
            SizedBox(height: 16),
            Text(
              'No exercises found',
              style: TextStyle(color: AppColors.white50, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(
        20,
        8,
        20,
        _selectedExercises.isEmpty ? 20 : 300, // Extra padding if panel is shown
      ),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        final exercise = exercises[index];
        final isSelected = _selectedExercises.any((e) => e.id == exercise.id);

        return _buildExerciseCard(exercise, isSelected);
      },
    );
  }

  // New sliver version for scrollable layout
  Widget _buildExerciseLibrarySliver() {
    final exercises = _filteredExercises;

    if (exercises.isEmpty) {
      return SliverFillRemaining(
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.fitness_center, size: 64, color: AppColors.white30),
              SizedBox(height: 16),
              Text(
                'No exercises found',
                style: TextStyle(color: AppColors.white50, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final exercise = exercises[index];
          final isSelected = _selectedExercises.any((e) => e.id == exercise.id);

          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: index == exercises.length - 1 ? 20 : 12,
            ),
            child: _buildExerciseCard(exercise, isSelected),
          );
        },
        childCount: exercises.length,
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? AppColors.cyberLime : AppColors.white10,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Open explanation screen instead of adding exercise
            HapticFeedback.selectionClick();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseExplanationScreen(exercise: exercise),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Exercise GIF preview
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 60,
                    height: 60,
                    color: AppColors.white10,
                    child: ExerciseAnimationWidget(
                      exerciseId: exercise.id,
                      size: 60,
                      showWatermark: false,
                    ),
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
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildBadge(exercise.equipment, AppColors.electricCyan),
                          const SizedBox(width: 8),
                          _buildBadge(exercise.difficulty, AppColors.white40),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Add/Remove button - separate tap area
                GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    if (isSelected) {
                      _removeExercise(exercise);
                    } else {
                      _addExercise(exercise);
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.cyberLime.withOpacity(0.2) : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.cyberLime : AppColors.white30,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      isSelected ? Icons.check : Icons.add,
                      color: isSelected ? AppColors.cyberLime : AppColors.white30,
                      size: 20,
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

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildWorkoutBuilderPanel() {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.35,
      maxChildSize: 0.85,
      snap: true,
      snapSizes: const [0.35, 0.45, 0.85],
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1a1a1a),
                Colors.black,
              ],
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 20,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Non-scrollable header - always draggable
              Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    // Drag handle
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.white40,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),

                    // Workout name
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          // Emoji input (limited to 2 characters)
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.transparent, // Make fully transparent
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.cyberLime.withOpacity(0.3)),
                            ),
                            child: TextField(
                              controller: _emojiController,
                              textAlign: TextAlign.center,
                              maxLength: 2,
                              style: const TextStyle(
                                fontSize: 32,
                                color: Colors.white, // Ensure text is visible
                              ),
                              decoration: const InputDecoration(
                                counterText: '', // Hide character counter
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero, // Remove padding
                                hintText: '💪',
                                hintStyle: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white54,
                                ),
                                fillColor: Colors.transparent, // Ensure fill is transparent
                                filled: false, // Don't fill background
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Workout name field
                          Expanded(
                            child: TextField(
                              controller: _workoutNameController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Workout Name',
                                hintStyle: TextStyle(color: AppColors.white40),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // Scrollable exercise list with training presets at top
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const AlwaysScrollableScrollPhysics(), // Ensures it's always scrollable
                  children: [
                    // Training presets at top of scrollable area
                    if (_selectedExercises.isNotEmpty) ...[
                      _buildTrainingPresets(),
                      const SizedBox(height: 16),
                    ],
                    
                    // Exercise list
                    ..._selectedExercises.asMap().entries.map((entry) {
                      final index = entry.key;
                      final exercise = entry.value;
                      final settings = _exerciseSettings[exercise.id]!;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildSelectedExerciseItem(exercise, settings, index),
                      );
                    }).toList(),
                  ],
                ),
              ),

              // Action buttons
              Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.white10),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '${_selectedExercises.length} exercises',
                          style: const TextStyle(
                            color: AppColors.white50,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _selectedExercises.clear();
                              _exerciseSettings.clear();
                            });
                          },
                          child: const Text(
                            'CLEAR ALL',
                            style: TextStyle(
                              color: AppColors.white40,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24), // Increased from 8 to 24 (push up 1cm)
                    GlowButton(
                      text: '✅ COMMIT WORKOUT',
                      onPressed: _commitWorkout,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSelectedExerciseItem(Exercise exercise, ExerciseSettings settings, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${index + 1}.',
                style: const TextStyle(
                  color: AppColors.cyberLime,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  exercise.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _removeExercise(exercise),
                icon: const Icon(Icons.close, color: AppColors.white40, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSettingControl(
                  'Sets',
                  settings.sets,
                  (val) => _updateExerciseSettings(
                    exercise.id,
                    settings.copyWith(sets: val),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSettingControl(
                  'Reps',
                  settings.reps,
                  (val) => _updateExerciseSettings(
                    exercise.id,
                    settings.copyWith(reps: val),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSettingControl(
                  'Rest',
                  settings.restSeconds ~/ 15, // Simplified to 15s increments
                  (val) => _updateExerciseSettings(
                    exercise.id,
                    settings.copyWith(restSeconds: val * 15),
                  ),
                  suffix: 's',
                  multiplier: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingControl(
    String label,
    int value,
    Function(int) onChanged, {
    String suffix = '',
    int multiplier = 1,
  }) {
    final displayValue = value * multiplier;
    final controller = TextEditingController(text: displayValue.toString());
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.white50,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 60,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.cyberLime.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.cyberLime, width: 1),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.cyberLime,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              suffix: suffix.isNotEmpty ? Text(
                suffix,
                style: const TextStyle(
                  color: AppColors.cyberLime,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ) : null,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onTap: () {
              // Select all text when tapped so user can immediately type new value
              controller.selection = TextSelection(
                baseOffset: 0,
                extentOffset: controller.text.length,
              );
            },
            onChanged: (text) {
              if (text.isEmpty) return; // Allow empty while typing
              
              final parsed = int.tryParse(text);
              if (parsed != null && parsed > 0) {
                final actualValue = parsed ~/ multiplier;
                onChanged(actualValue);
                HapticFeedback.selectionClick();
              }
            },
            onSubmitted: (text) {
              if (text.isEmpty) {
                controller.text = displayValue.toString();
                return;
              }
              
              final parsed = int.tryParse(text) ?? displayValue;
              final clamped = parsed < 1 ? 1 : parsed;
              controller.text = clamped.toString();
              onChanged(clamped ~/ multiplier);
            },
          ),
        ),
      ],
    );
  }

  int _calculateCalories() {
    int total = 0;
    for (final exercise in _selectedExercises) {
      final settings = _exerciseSettings[exercise.id] ?? 
          ExerciseSettings(sets: 3, reps: 10, restSeconds: 60);
      total += settings.sets * _getCaloriesPerSet(exercise.name);
    }
    return total;
  }

  int _getCaloriesPerSet(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('squat') || lower.contains('deadlift') || 
        lower.contains('burpee')) return 12;
    if (lower.contains('press') || lower.contains('row') || 
        lower.contains('pull')) return 9;
    if (lower.contains('curl') || lower.contains('extension')) return 5;
    return 7;
  }
}

class ExerciseSettings {
  final int sets;
  final int reps;
  final int restSeconds;
  final int? timeSeconds; // For time-based exercises (HIIT/Tabata)

  ExerciseSettings({
    required this.sets,
    required this.reps,
    required this.restSeconds,
    this.timeSeconds,
  });

  ExerciseSettings copyWith({
    int? sets,
    int? reps,
    int? restSeconds,
    int? timeSeconds,
  }) {
    return ExerciseSettings(
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      restSeconds: restSeconds ?? this.restSeconds,
      timeSeconds: timeSeconds ?? this.timeSeconds,
    );
  }
}

