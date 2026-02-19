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
import '../data/exercise_display_names.dart';
import 'exercise_explanation_screen.dart';
import 'exercise_config_screen.dart';
import 'workout_review_screen.dart';

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
      try {
        // Skip duplicate versions
        if (id.contains('_version_') ||
            id.endsWith('_ii') ||
            id.endsWith('_iii') ||
            id.endsWith('_iv')) {
          return; // Skip this exercise
        }

        final name = ExerciseDisplayNames.getName(id);

        manualExercises.add(Exercise(
          id: id,
          name: name,
          difficulty: 'intermediate',
          equipment: _inferEquipment(id),
        ));
      } catch (e) {
        // Skip any exercise that crashes during name conversion
        debugPrint('Skipped exercise: $id - $e');
      }
    });

    // Sort alphabetically
    manualExercises.sort((a, b) => a.name.compareTo(b.name));

    return manualExercises;
  }
  
  String _inferEquipment(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('barbell')) return 'barbell';
    if (lower.contains('dumbbell')) return 'dumbbell';
    if (lower.contains('cable')) return 'cable';
    if (lower.contains('band')) return 'band';
    if (lower.contains('kettlebell')) return 'kettlebell';
    if (lower.contains('machine') || lower.contains('lever') || lower.contains('smith')) return 'machine';
    return 'bodyweight';
  }
  
  List<Exercise> get _filteredExercises {
    // Use manual exercises if in manual mode, otherwise use AI exercises
    List<Exercise> exercises = _workoutMode == 'manual' 
      ? _getAllManualExercises() 
      : _allExercises;
    
    // Filter by category - for manual mode, only use name-based filtering
    if (_selectedCategory != 'all') {
      if (_workoutMode == 'manual') {
        // Manual mode: IRONCLAD name-based filtering
        if (_selectedCategory == 'chest') {
          exercises = exercises.where((e) {
            final lower = e.name.toLowerCase();
            // Must contain chest-specific keywords
            return (lower.contains('bench press') || 
                    lower.contains('chest press') ||
                    lower.contains('chest fly') ||
                    lower.contains('chest flye') ||
                    lower.contains('pec fly') ||
                    lower.contains('pec deck') ||
                    lower.contains('pec') && lower.contains('fly') ||
                    (lower.contains('dip') && lower.contains('chest')) ||
                    lower.contains('push up') ||
                    lower.contains('pushup') ||
                    lower.contains('svend press') ||
                    lower.contains('landmine press') && lower.contains('chest') ||
                    lower.contains('squeeze press') ||
                    lower.contains('hex press') ||
                    lower.contains('guillotine press') ||
                    lower.contains('crossover') && !lower.contains('leg') ||
                    lower.contains('pullover') && !lower.contains('tricep')) &&
                   // Exclude non-chest exercises - STRICT
                   !lower.contains('shoulder press') &&
                   !lower.contains('overhead press') &&
                   !lower.contains('military press') &&
                   !lower.contains('leg press') &&
                   !lower.contains('tricep') &&
                   !lower.contains('upright row');
          }).toList();
        } else if (_selectedCategory == 'back') {
          exercises = exercises.where((e) {
            final lower = e.name.toLowerCase();
            return (lower.contains('row') && !lower.contains('upright row') ||
                    lower.contains('pulldown') ||
                    lower.contains('lat pull') ||
                    lower.contains('pull up') ||
                    lower.contains('pullup') ||
                    lower.contains('chin up') ||
                    lower.contains('chinup') ||
                    lower.contains('deadlift') ||
                    lower.contains('shrug') && !lower.contains('shoulder') ||
                    lower.contains('back extension') ||
                    lower.contains('reverse fly') ||
                    lower.contains('rear delt') && lower.contains('row') ||
                    lower.contains('t-bar row') ||
                    lower.contains('seal row') ||
                    lower.contains('inverted row') ||
                    lower.contains('pendlay') ||
                    (lower.contains('pull') && (lower.contains('back') || lower.contains('lat'))) && !lower.contains('pullover')) &&
                   // Exclude non-back exercises - STRICT
                   !lower.contains('hip thrust') &&
                   !lower.contains('pullover') && // pec exercise
                   !lower.contains('leg') &&
                   !lower.contains('calf') &&
                   !lower.contains('chest') &&
                   !lower.contains('tricep');
          }).toList();
        } else if (_selectedCategory == 'shoulders') {
          exercises = exercises.where((e) {
            final lower = e.name.toLowerCase();
            return (lower.contains('shoulder') && !lower.contains('blade') ||
                    lower.contains('delt') && !lower.contains('deltoid stretch') ||
                    lower.contains('lateral raise') ||
                    lower.contains('front raise') ||
                    lower.contains('rear raise') ||
                    lower.contains('overhead press') ||
                    lower.contains('military press') ||
                    lower.contains('arnold press') ||
                    lower.contains('bradford press') ||
                    lower.contains('upright row') ||
                    lower.contains('face pull') ||
                    lower.contains('shrug') && !lower.contains('trap bar deadlift') ||
                    lower.contains('reverse fly') && !lower.contains('chest')) &&
                   // Exclude non-shoulder exercises - STRICT
                   !lower.contains('bench press') &&
                   !lower.contains('chest press') &&
                   !lower.contains('tricep') &&
                   !lower.contains('bicep') &&
                   (lower.contains('upright row') || !lower.contains('row')) && // Allow upright row but exclude other rows
                   !lower.contains('pulldown') &&
                   !lower.contains('leg') &&
                   !lower.contains('press up'); // exclude push ups
          }).toList();
        } else if (_selectedCategory == 'arms') {
          exercises = exercises.where((e) {
            final lower = e.name.toLowerCase();
            
            // Include criteria
            final hasArmKeyword = lower.contains('bicep') ||
                                  lower.contains('tricep') ||
                                  lower.contains('preacher') ||
                                  lower.contains('concentration') ||
                                  lower.contains('skull crusher') ||
                                  lower.contains('hammer curl') ||
                                  lower.contains('pushdown') ||
                                  lower.contains('close grip bench') ||
                                  lower.contains('french press') ||
                                  lower.contains('drag curl') ||
                                  lower.contains('zottman') ||
                                  lower.contains('reverse curl') ||
                                  (lower.contains('curl') && !lower.contains('leg') && !lower.contains('hamstring') && !lower.contains('wrist')) ||
                                  (lower.contains('extension') && lower.contains('tricep')) ||
                                  (lower.contains('overhead extension')) ||
                                  (lower.contains('kickback') && lower.contains('tricep')) ||
                                  (lower.contains('dip') && !lower.contains('hip') && !lower.contains('landmine'));
            
            // Exclude criteria
            final isNotArm = lower.contains('leg extension') ||
                            lower.contains('leg curl') ||
                            lower.contains('back extension') ||
                            lower.contains('hip extension') ||
                            lower.contains('wrist') ||
                            lower.contains('shoulder press') ||
                            lower.contains('row') ||
                            lower.contains('raise') ||
                            lower.contains('shrug') ||
                            lower.contains('lat pulldown');
            
            return hasArmKeyword && !isNotArm;
          }).toList();
        } else if (_selectedCategory == 'legs') {
          exercises = exercises.where((e) {
            final lower = e.name.toLowerCase();
            
            // Include criteria
            final hasLegKeyword = lower.contains('squat') ||
                                 lower.contains('lunge') ||
                                 lower.contains('leg press') ||
                                 lower.contains('leg curl') ||
                                 lower.contains('leg extension') ||
                                 lower.contains('calf raise') ||
                                 lower.contains('calf press') ||
                                 lower.contains('hack squat') ||
                                 lower.contains('bulgarian') ||
                                 lower.contains('step up') ||
                                 lower.contains('wall sit') ||
                                 lower.contains('hip thrust') ||
                                 lower.contains('hip abduct') ||
                                 lower.contains('hip adduct') ||
                                 lower.contains('romanian deadlift') ||
                                 lower.contains('stiff leg') ||
                                 lower.contains('sissy squat') ||
                                 lower.contains('goblet squat') ||
                                 lower.contains('sumo') && (lower.contains('squat') || lower.contains('deadlift')) ||
                                 (lower.contains('glute') && !lower.contains('raise'));
            
            // Exclude criteria  
            final isNotLeg = lower.contains('leg raise') || // core exercise
                            lower.contains('pull') ||
                            lower.contains('row') ||
                            lower.contains('chest') ||
                            lower.contains('bench') ||
                            lower.contains('shoulder') ||
                            lower.contains('bicep') ||
                            lower.contains('tricep');
            
            return hasLegKeyword && !isNotLeg;
          }).toList();
        } else if (_selectedCategory == 'core') {
          exercises = exercises.where((e) {
            final lower = e.name.toLowerCase();
            
            // Include criteria
            final hasCoreKeyword = lower.contains('crunch') ||
                                  lower.contains('sit up') ||
                                  lower.contains('situp') ||
                                  lower.contains('plank') ||
                                  lower.contains('leg raise') ||
                                  lower.contains('knee raise') ||
                                  lower.contains('ab wheel') ||
                                  lower.contains('russian twist') ||
                                  lower.contains('bicycle') && !lower.contains('machine') ||
                                  lower.contains('mountain climber') ||
                                  lower.contains('dead bug') ||
                                  lower.contains('bird dog') ||
                                  lower.contains('hollow') ||
                                  lower.contains('v-up') ||
                                  lower.contains('v up') ||
                                  lower.contains('toe touch') ||
                                  lower.contains('jackknife') ||
                                  lower.contains('wiper') ||
                                  lower.contains('windshield') ||
                                  lower.contains('hanging') && lower.contains('knee') ||
                                  lower.contains('dragon flag') ||
                                  lower.contains('oblique') ||
                                  lower.contains('side bend') ||
                                  lower.contains('wood chop') ||
                                  lower.contains('pallof') ||
                                  lower.contains('abs') ||
                                  lower.contains('abdominal');
            
            // Exclude non-core
            final isNotCore = lower.contains('bench') ||
                             lower.contains('squat') ||
                             lower.contains('press') && !lower.contains('pallof') ||
                             lower.contains('row') ||
                             lower.contains('pull up') ||
                             lower.contains('chin up');
            
            return hasCoreKeyword && !isNotCore;
          }).toList();
        } else if (_selectedCategory == 'home') {
          // For manual mode home, STRICT bodyweight only - NO equipment in name at all
          exercises = exercises.where((e) {
            final lower = e.name.toLowerCase();
            // MUST NOT contain ANY equipment indicators
            return !lower.contains('(barbell)') &&
                   !lower.contains('(dumbbell)') &&
                   !lower.contains('(cable)') &&
                   !lower.contains('(kettlebell)') &&
                   !lower.contains('(machine)') &&
                   !lower.contains('(lever)') &&
                   !lower.contains('(smith)') &&
                   !lower.contains('(band)') &&
                   !lower.contains('(ez barbell)') &&
                   !lower.contains('(trap bar)') &&
                   // Additional exclusions for weighted exercises
                   !lower.contains('weighted') &&
                   !lower.contains('plate') &&
                   // MUST be truly bodyweight movements
                   (lower.contains('push up') ||
                    lower.contains('pushup') ||
                    lower.contains('pull up') ||
                    lower.contains('pullup') ||
                    lower.contains('chin up') ||
                    lower.contains('chinup') ||
                    lower.contains('dip') ||
                    lower.contains('squat') && !lower.contains('(') || // bodyweight squat only
                    lower.contains('lunge') && !lower.contains('(') ||
                    lower.contains('plank') ||
                    lower.contains('crunch') ||
                    lower.contains('sit up') ||
                    lower.contains('situp') ||
                    lower.contains('burpee') ||
                    lower.contains('mountain climber') ||
                    lower.contains('jumping jack') ||
                    lower.contains('high knee') ||
                    lower.contains('butt kick') ||
                    lower.contains('leg raise') ||
                    lower.contains('knee raise') ||
                    lower.contains('pike') ||
                    lower.contains('bear crawl') ||
                    lower.contains('crab walk') ||
                    lower.contains('inchworm') ||
                    lower.contains('jump') && !lower.contains('rope') ||
                    lower.contains('step up') && !lower.contains('(') ||
                    lower.contains('wall sit') ||
                    lower.contains('handstand') ||
                    lower.contains('l-sit') ||
                    lower.contains('tuck') ||
                    lower.contains('bridge') ||
                    lower.contains('reverse crunch') ||
                    lower.contains('bicycle') ||
                    lower.contains('flutter kick') ||
                    lower.contains('scissor kick') ||
                    lower.contains('v-up') ||
                    lower.contains('v up') ||
                    lower.contains('hollow') ||
                    lower.contains('superman') ||
                    lower.contains('bird dog') ||
                    lower.contains('dead bug') ||
                    lower.contains('glute bridge') && !lower.contains('('));
          }).toList();
        }
      } else {
        // AI mode: use original filtering with WorkoutData
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
    }
    
    // Filter by equipment - SMART FILTERING
    if (_selectedEquipment != 'all') {
      if (_workoutMode == 'manual') {
        // Manual mode: check parenthetical equipment name
        if (_selectedEquipment == 'barbell') {
          exercises = exercises.where((e) => 
            e.name.toLowerCase().contains('(barbell)') ||
            e.equipment.toLowerCase() == 'barbell'
          ).toList();
        } else if (_selectedEquipment == 'dumbbell') {
          exercises = exercises.where((e) => 
            e.name.toLowerCase().contains('(dumbbell)') ||
            e.equipment.toLowerCase() == 'dumbbell'
          ).toList();
        } else if (_selectedEquipment == 'bands') {
          exercises = exercises.where((e) => 
            e.name.toLowerCase().contains('(band)') ||
            e.equipment.toLowerCase() == 'band'
          ).toList();
        } else if (_selectedEquipment == 'bodyweight') {
          exercises = exercises.where((e) => 
            e.equipment.toLowerCase() == 'bodyweight' &&
            !e.name.toLowerCase().contains('(barbell)') &&
            !e.name.toLowerCase().contains('(dumbbell)') &&
            !e.name.toLowerCase().contains('(cable)') &&
            !e.name.toLowerCase().contains('(machine)') &&
            !e.name.toLowerCase().contains('(smith)')
          ).toList();
        }
      } else {
        // AI mode: use original helper methods
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

    // ═══════════════════════════════════════════════════════════════════════════
    // Ask user which card to commit to (same as workouts_tab does)
    // ═══════════════════════════════════════════════════════════════════════════
    if (!mounted) return;

    // For manual workouts, only show card 2 and 3 (no main/hero)
    final selectedSlot = await _showSlotSelectionModal(isManual: _workoutMode == 'manual');
    if (selectedSlot == null) return; // User cancelled

    // Only commit to committedWorkoutProvider if user chose 'main' (hero card)
    if (selectedSlot == 'main') {
      await ref.read(committedWorkoutProvider.notifier).commitWorkout(customPreset);
    }

    // Create schedule for TODAY with the correct priority
    final now = DateTime.now();
    final todayDate = DateTime(now.year, now.month, now.day);

    // Check if there's already a schedule for today with this priority
    final allSchedules = ref.read(workoutSchedulesProvider);
    WorkoutSchedule? existingTodaySchedule;
    for (final s in allSchedules) {
      if (s.scheduledDate.year == todayDate.year &&
          s.scheduledDate.month == todayDate.month &&
          s.scheduledDate.day == todayDate.day &&
          s.priority == selectedSlot) {
        existingTodaySchedule = s;
        break;
      }
    }

    // Create schedule with correct priority
    final todaySchedule = WorkoutSchedule(
      id: existingTodaySchedule?.id ?? '${DateTime.now().millisecondsSinceEpoch}_${todayDate.millisecondsSinceEpoch}_$selectedSlot',
      workoutId: customPreset.id,
      workoutName: customPreset.name,
      scheduledDate: todayDate,
      scheduledTime: existingTodaySchedule?.scheduledTime,
      hasAlarm: existingTodaySchedule?.hasAlarm ?? false,
      createdAt: existingTodaySchedule?.createdAt ?? DateTime.now(),
      repeatDays: existingTodaySchedule?.repeatDays ?? [],
      priority: selectedSlot, // ← THIS IS THE KEY FIX
    );

    // Save schedule for today
    await ref.read(workoutSchedulesProvider.notifier).saveSchedule(todaySchedule);
    debugPrint('📅 Custom workout committed to $selectedSlot: ${customPreset.name}');

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

  Future<String?> _showSlotSelectionModal({bool isManual = false}) async {
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

                const SizedBox(height: 24),

                // Card 1 - Main (ONLY for AI-tracked, hidden for manual)
                if (!isManual) ...[
                  _buildSlotOption(
                    context: context,
                    slot: 'main',
                    icon: Icons.fitness_center,
                    title: 'MAIN WORKOUT',
                    subtitle: 'Your primary training session',
                    color: const Color(0xFFCCFF00),
                  ),
                  const SizedBox(height: 12),
                ],

                // Card 2 - Secondary
                _buildSlotOption(
                  context: context,
                  slot: 'secondary',
                  icon: Icons.bolt,
                  title: 'ACCESSORY',
                  subtitle: 'Secondary exercises',
                  color: const Color(0xFFCCFF00),
                ),

                const SizedBox(height: 12),

                // Card 3 - Tertiary
                _buildSlotOption(
                  context: context,
                  slot: 'tertiary',
                  icon: Icons.self_improvement,
                  title: 'STRETCHING',
                  subtitle: 'Mobility & recovery',
                  color: const Color(0xFFCCFF00),
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
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.of(context).pop(slot);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 24),
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
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.white60,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: AppColors.white40, size: 16),
          ],
        ),
      ),
    );
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildHeader()),
                  SliverToBoxAdapter(child: _buildCategoryFilter()),
                  SliverToBoxAdapter(child: _buildSearchBar()),
                  SliverPadding(
                    padding: EdgeInsets.only(
                      bottom: _selectedExercises.isNotEmpty ? 80 : 20,
                    ),
                    sliver: _buildExerciseLibrarySliver(),
                  ),
                ],
              ),
            ),
            if (_selectedExercises.isNotEmpty)
              _buildWorkoutFAB(),
          ],
        ),
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
                'AI TRACKED',
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
                'MANUAL LOG',
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
      {'id': 'all', 'name': 'ALL', 'icon': ''},
      {'id': 'barbell', 'name': 'BARBELL', 'icon': ''},
      {'id': 'dumbbell', 'name': 'DUMBBELL', 'icon': ''},
      {'id': 'bands', 'name': 'BANDS', 'icon': ''},
      {'id': 'bodyweight', 'name': 'BODYWEIGHT', 'icon': ''},
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
                child: Text(
                  equipment['name']!,
                  style: TextStyle(
                    color: isSelected ? AppColors.cyberLime : Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
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
      {'id': 'all', 'name': 'All', 'icon': ''},
      {'id': 'chest', 'name': 'Chest', 'icon': ''},
      {'id': 'back', 'name': 'Back', 'icon': ''},
      {'id': 'shoulders', 'name': 'Shoulders', 'icon': ''},
      {'id': 'arms', 'name': 'Arms', 'icon': ''},
      {'id': 'legs', 'name': 'Legs', 'icon': ''},
      {'id': 'core', 'name': 'Core', 'icon': ''},
      {'id': 'home', 'name': 'Home', 'icon': ''},
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
              child: Center(
                child: Text(
                  category['name']!,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? AppColors.cyberLime : AppColors.white70,
                  ),
                ),
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
          onTap: () async {
            HapticFeedback.selectionClick();

            // Open full-screen config
            final settings = await Navigator.push<ExerciseSettings>(
              context,
              MaterialPageRoute(
                builder: (context) => ExerciseConfigScreen(
                  exercise: exercise,
                  initialSets: 3,
                  initialReps: 10,
                  initialRest: 60,
                ),
                fullscreenDialog: true,
              ),
            );

            // If user configured settings, add the exercise
            if (settings != null) {
              _addExercise(exercise);
              _updateExerciseSettings(exercise.id, settings);
            }
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
                          _buildBadge(exercise.equipment, AppColors.cyberLime),
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

  Widget _buildWorkoutFAB() {
    return GestureDetector(
      onTap: _openWorkoutReview,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1a1a1a), Color(0xFF111111)],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.cyberLime, width: 2),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyberLime.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              _emojiController.text.isEmpty ? '💪' : _emojiController.text,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _workoutNameController.text.isEmpty
                        ? 'My Custom Workout'
                        : _workoutNameController.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${_selectedExercises.length} exercise${_selectedExercises.length == 1 ? '' : 's'} · Tap to review',
                    style: const TextStyle(
                      color: AppColors.cyberLime,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.cyberLime,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '${_selectedExercises.length}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: AppColors.cyberLime, size: 24),
          ],
        ),
      ),
    );
  }

  Future<void> _openWorkoutReview() async {
    HapticFeedback.mediumImpact();

    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutReviewScreen(
          selectedExercises: _selectedExercises,
          exerciseSettings: _exerciseSettings,
          workoutName: _workoutNameController.text.isEmpty
              ? 'My Custom Workout'
              : _workoutNameController.text,
          workoutEmoji: _emojiController.text.isEmpty ? '💪' : _emojiController.text,
          workoutMode: _workoutMode,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _selectedExercises = List<Exercise>.from(result['exercises'] ?? []);
        _exerciseSettings = Map<String, ExerciseSettings>.from(result['settings'] ?? {});
      });

      // If user hit COMMIT from the review screen
      if (result['commit'] == true) {
        _commitWorkout();
      }
    }
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

