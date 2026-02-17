import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:ui';
import '../../utils/app_colors.dart';
import '../../providers/stats_provider.dart';
import '../../providers/workout_provider.dart';
import '../../providers/workout_schedule_provider.dart';
import '../../providers/schedule_date_provider.dart';
import '../../models/workout_schedule.dart';
import '../../models/workout_models.dart';
import '../../models/workout_data.dart';
import '../../services/storage_service.dart';
import '../../services/workout_alarm_service.dart';
import '../../widgets/animated_counter.dart';
import '../../widgets/schedule_workout_modal.dart';
import '../../widgets/workout_library_modal.dart';
import '../../widgets/workout_date_strip.dart';
import '../../widgets/muscle_body_widget.dart';
import '../../services/muscle_recovery_service.dart';
import '../../features/analytics/widgets/hero_stats_card.dart';
import '../../features/analytics/widgets/workout_heatmap_widget.dart';
import '../../features/analytics/models/analytics_data.dart';
import '../../features/analytics/services/analytics_service.dart';
import '../home_screen.dart' show TabNavigator;
import '../tabs/settings_tab.dart';
import '../../features/form_checking/form_check_exercise_picker_screen.dart';
import '../tabs/train_tab.dart';
import '../../providers/selected_card_slot_provider.dart';
import '../training_mode_selection_screen.dart';
import '../manual_training_screen.dart';
import '../hevy_manual_workout_screen.dart';

/// =============================================================================
/// HOME TAB - STUNNING PROFESSIONAL FITNESS UI
/// =============================================================================
/// Inspired by FutureYou's glassmorphism design
/// Clean, minimal, powerful
/// =============================================================================

class HomeTab extends ConsumerStatefulWidget {
  const HomeTab({super.key});

  @override
  ConsumerState<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends ConsumerState<HomeTab> {
  DateTime _selectedDate = DateTime.now();
  
  // Cache for recovery data to avoid FutureBuilder hang
  Map<String, double>? _cachedRecovery;
  String _cachedGender = 'male';
  bool _recoveryLoaded = false;
  
  // Cache for analytics data (HeroStatsCard & WorkoutHeatmapWidget)
  AnalyticsData? _cachedAnalytics;
  bool _analyticsLoaded = false;
  
  // Cache for user weight (for calorie calculations)
  double? _cachedUserWeight;
  bool _userWeightLoaded = false;

  // Cache for custom workouts (for hero card display)
  Map<String, WorkoutPreset>? _cachedCustomWorkouts;

  @override
  void initState() {
    super.initState();
    _loadRecoveryData();
    _loadAnalyticsData();
    _loadUserWeight();
    _loadCustomWorkouts();
  }

  Future<void> _loadCustomWorkouts() async {
    try {
      final storage = await StorageService.getInstance();
      // Load BOTH AI and manual workouts into cache
      final aiWorkouts = storage.getCustomWorkouts();
      final manualWorkouts = storage.getManualWorkouts();

      final Map<String, WorkoutPreset> cache = {};
      cache.addAll(aiWorkouts);
      cache.addAll(manualWorkouts);

      if (mounted) {
        setState(() {
          _cachedCustomWorkouts = cache;
        });
        debugPrint('📦 Loaded ${aiWorkouts.length} AI + ${manualWorkouts.length} manual workouts for hero card lookup');
      }
    } catch (e) {
      debugPrint('❌ Custom workouts load failed: $e');
      if (mounted) {
        setState(() {
          _cachedCustomWorkouts = {};
        });
      }
    }
  }
  
  Future<void> _loadUserWeight() async {
    try {
      final weight = await StorageService.getUserWeight();
      if (mounted) {
        setState(() {
          _cachedUserWeight = weight ?? 70.0; // Default to 70kg
          _userWeightLoaded = true;
        });
      }
    } catch (e) {
      debugPrint('❌ User weight failed: $e');
      if (mounted) {
        setState(() {
          _cachedUserWeight = 70.0; // Default
          _userWeightLoaded = true;
        });
      }
    }
  }

  Future<void> _loadRecoveryData() async {
    try {
      final results = await Future.wait([
        MuscleRecoveryService.getAllMuscleRecovery(),
        StorageService.getUserGender(),
      ]).timeout(const Duration(seconds: 5));
      
      if (mounted) {
        setState(() {
          _cachedRecovery = results[0] as Map<String, double>;
          _cachedGender = (results[1] as String?) ?? 'male';
          _recoveryLoaded = true;
        });
      }
    } catch (e) {
      debugPrint('❌ Recovery data failed: $e');
      if (mounted) {
        setState(() {
          _cachedRecovery = {};
          _recoveryLoaded = true;
        });
      }
    }
  }

  Future<void> _loadAnalyticsData() async {
    try {
      // Use allTime period - same as profile tab default
      final data = await AnalyticsService.loadAnalytics();
      
      if (mounted) {
        setState(() {
          _cachedAnalytics = data;
          _analyticsLoaded = true;
        });
      }
    } catch (e) {
      debugPrint('❌ Analytics data failed: $e');
      if (mounted) {
        setState(() {
          _cachedAnalytics = AnalyticsData.empty();
          _analyticsLoaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(workoutStatsProvider);
    final committedWorkout = ref.watch(committedWorkoutProvider);
    final allSchedules = ref.watch(workoutSchedulesProvider);
    
    // Get schedule for selected date (if any)
    final scheduleForSelectedDate = allSchedules.where((schedule) {
      return schedule.scheduledDate.year == _selectedDate.year &&
             schedule.scheduledDate.month == _selectedDate.month &&
             schedule.scheduledDate.day == _selectedDate.day;
    }).toList();
    
    // Determine which workout to display:
    // - If a schedule exists for selected date, show that
    // - Otherwise, show the committed workout (only for today)
    final isToday = _selectedDate.year == DateTime.now().year &&
                    _selectedDate.month == DateTime.now().month &&
                    _selectedDate.day == DateTime.now().day;
    
    final displayWorkout = scheduleForSelectedDate.isNotEmpty
        ? scheduleForSelectedDate.first
        : (isToday ? committedWorkout : null);

    // Get stats - use previous value while loading to prevent grey flash
    final stats = statsAsync.when(
      data: (data) => data,
      loading: () => WorkoutStats.empty(),
      error: (error, stack) {
        print('❌ Stats loading error: $error');
        return WorkoutStats.empty();
      },
    );
    final isLoading = statsAsync.isLoading && statsAsync.value == null;
    final hasError = statsAsync.hasError && statsAsync.value == null;

    // BLACK FALLBACK - prevents grey flash while CyberGridBackground initializes
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: hasError
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: AppColors.neonCrimson, size: 64),
                  const SizedBox(height: 16),
                  const Text(
                    'Error loading stats',
                    style: TextStyle(color: AppColors.white60, fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      ref.invalidate(workoutStatsProvider);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.cyberLime,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'RETRY',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () async {
                HapticFeedback.mediumImpact();
                ref.invalidate(workoutStatsProvider);
                await Future.wait([
                  _loadRecoveryData(), // Reload recovery data
                  _loadAnalyticsData(), // Reload analytics data
                  _loadUserWeight(), // Reload user weight
                  _loadCustomWorkouts(), // Reload custom workouts for hero card
                ]);
              },
              color: AppColors.cyberLime,
              backgroundColor: Colors.black,
              child: Stack(
                children: [
                  // Main content - always show even while loading
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ═══════════════════════════════════════════════
                        // HEADER: Logo + App Name + Streak + Settings
                        // ═══════════════════════════════════════════════
                        _buildHeader(context, stats),

                        const SizedBox(height: 12),

                        Column(
                          children: [
                            // ═══════════════════════════════════════════════
                            // DATE STRIP & HERO CARD: With horizontal padding
                            // ═══════════════════════════════════════════════
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  // Date Strip
                                  WorkoutDateStrip(
                                    selectedDate: _selectedDate,
                                    onDateSelected: (date) {
                                      setState(() => _selectedDate = date);
                                    },
                                    accentColor: AppColors.cyberLime,
                                  ),

                                  const SizedBox(height: 12),

                                  // 3 HERO WORKOUT CARDS
                                  _build3HeroCards(context, ref),
                                ],
                              ),
                            ),

                            const SizedBox(height: 12),

                            // ═══════════════════════════════════════════════
                            // RECOVERY BODY: Full width like profile cards
                            // ═══════════════════════════════════════════════
                            _buildSafeWidget(
                              () => _buildRecoveryStatusCard(stats, displayWorkout),
                              'Recovery Status',
                            ),

                            const SizedBox(height: 20),

                            // ═══════════════════════════════════════════════
                            // FORM CHECK: With horizontal padding
                            // ═══════════════════════════════════════════════
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: _buildEliteFormCheckCard(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Optional: Show subtle loading indicator at top while refreshing
                  if (isLoading)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation(AppColors.cyberLime.withOpacity(0.5)),
                      ),
                    ),
                ],
              ),
            ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HEADER COMPONENT
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeader(BuildContext context, WorkoutStats stats) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          // Logo — BIG, takes up most of the row
          Expanded(
            child: Image.asset(
              'assets/images/logo/skeletal_logo.png',
              height: 52,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
          ),
          const SizedBox(width: 12),
          // Streak badge
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              _showStreakAchievements(context, stats);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withOpacity(0.06),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 6),
                  Text(
                    '${stats.currentStreak}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Settings gear
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
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withOpacity(0.06),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.settings_outlined,
                color: Colors.white.withOpacity(0.5),
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // DATE STRIP COMPONENT (Smaller, like FutureYou)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildDateStrip() {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = DateTime.now().subtract(Duration(days: 3 - index));
          final isSelected = date.day == _selectedDate.day &&
                             date.month == _selectedDate.month &&
                             date.year == _selectedDate.year;
          final isToday = date.day == DateTime.now().day &&
                         date.month == DateTime.now().month &&
                         date.year == DateTime.now().year;
          
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
              HapticFeedback.selectionClick();
            },
            onLongPress: () async {
              HapticFeedback.heavyImpact();
              await _openScheduleWorkoutFlow(date);
            },
            child: Container(
              width: 50,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.cyberLime.withOpacity(0.15)
                    : AppColors.white5,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected
                      ? AppColors.cyberLime
                      : AppColors.white10,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ['S', 'M', 'T', 'W', 'T', 'F', 'S'][date.weekday % 7],
                    style: TextStyle(
                      color: isSelected ? AppColors.cyberLime : AppColors.white50,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      color: isSelected ? AppColors.cyberLime : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  if (isToday) ...[
                    const SizedBox(height: 2),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.cyberLime : AppColors.white50,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // 3 HERO CARDS LAYOUT
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _build3HeroCards(BuildContext context, WidgetRef ref) {
    final allSchedules = ref.watch(workoutSchedulesProvider);

    // Filter schedules for selected date by priority
    final mainWorkout = allSchedules.where((s) {
      return s.scheduledDate.year == _selectedDate.year &&
             s.scheduledDate.month == _selectedDate.month &&
             s.scheduledDate.day == _selectedDate.day &&
             s.priority == 'main';
    }).firstOrNull;

    final secondaryWorkout = allSchedules.where((s) {
      return s.scheduledDate.year == _selectedDate.year &&
             s.scheduledDate.month == _selectedDate.month &&
             s.scheduledDate.day == _selectedDate.day &&
             s.priority == 'secondary';
    }).firstOrNull;

    final tertiaryWorkout = allSchedules.where((s) {
      return s.scheduledDate.year == _selectedDate.year &&
             s.scheduledDate.month == _selectedDate.month &&
             s.scheduledDate.day == _selectedDate.day &&
             s.priority == 'tertiary';
    }).firstOrNull;

    // For backward compatibility: if no main schedule found, check committed workout
    final isToday = _selectedDate.year == DateTime.now().year &&
                    _selectedDate.month == DateTime.now().month &&
                    _selectedDate.day == DateTime.now().day;
    final committedWorkout = ref.watch(committedWorkoutProvider);

    // Don't show committedWorkout in hero if it's already in secondary/tertiary
    final committedId = committedWorkout?.id;
    final committedName = committedWorkout?.name;
    final isCommittedElsewhere = (secondaryWorkout != null &&
        (secondaryWorkout.workoutId == committedId || secondaryWorkout.workoutName == committedName)) ||
        (tertiaryWorkout != null &&
        (tertiaryWorkout.workoutId == committedId || tertiaryWorkout.workoutName == committedName));
    final mainDisplay = mainWorkout ??
        (isToday && committedWorkout != null && !isCommittedElsewhere ? committedWorkout : null);

    return Column(
      children: [
        // CARD 1 - MAIN (Full width - existing code)
        _buildHeroWorkoutCard(context, ref, mainDisplay),

        const SizedBox(height: 16),

        // CARDS 2 & 3 - Side by side
        Row(
          children: [
            // CARD 2 - SECONDARY
            Expanded(
              child: _buildSmallHeroCard(
                context: context,
                ref: ref,
                workout: secondaryWorkout,
                priority: 'secondary',
                emptyTitle: 'ACCESSORY',
                emptyIcon: Icons.bolt,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.cyberLime.withOpacity(0.15),
                    AppColors.cyberLime.withOpacity(0.05),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            // CARD 3 - TERTIARY
            Expanded(
              child: _buildSmallHeroCard(
                context: context,
                ref: ref,
                workout: tertiaryWorkout,
                priority: 'tertiary',
                emptyTitle: 'STRETCHING',
                emptyIcon: Icons.self_improvement,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.cyberLime.withOpacity(0.15),
                    AppColors.cyberLime.withOpacity(0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallHeroCard({
    required BuildContext context,
    required WidgetRef ref,
    required WorkoutSchedule? workout,
    required String priority,
    required String emptyTitle,
    required IconData emptyIcon,
    required Gradient gradient,
  }) {
    if (workout == null) {
      // EMPTY CARD — dark with subtle lime icon
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.04),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFCCFF00).withOpacity(0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(emptyIcon, color: const Color(0xFFCCFF00), size: 22),
            ),
            const SizedBox(height: 14),
            Text(
              emptyTitle,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Add via workout',
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.25),
              ),
            ),
          ],
        ),
      );
    }

    // FILLED CARD
    // Get workout details
    final WorkoutPreset? workoutPreset = _findWorkoutById(workout.workoutId);
    final exerciseCount = workoutPreset?.exercises.where((e) => e.included).length ?? 0;
    final totalSets = workoutPreset?.totalSets ?? 0;

    return GestureDetector(
      onTap: () async {
        HapticFeedback.mediumImpact();
        // Build LockedWorkout from schedule data
        if (workoutPreset != null) {
          final lockedWorkout = LockedWorkout.fromPreset(workoutPreset);

          // If manual-only workout, skip mode selection → go straight to ProLogger
          if (workoutPreset.isManualOnly) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HevyManualWorkoutScreen(workout: lockedWorkout),
              ),
            );
            return;
          }

          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrainingModeSelectionScreen(workout: lockedWorkout),
              fullscreenDialog: true,
            ),
          );

          // Handle mode selection result
          if (result == 'auto') {
            // Commit workout first so TrainTab picks it up
            await ref.read(committedWorkoutProvider.notifier).commitWorkout(workoutPreset);
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TrainTab(
                    onWorkoutStateChanged: (isActive) {},
                  ),
                ),
              );
            }
          } else if (result == 'manual') {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManualTrainingScreen(workout: lockedWorkout),
                ),
              );
            }
          } else if (result == 'hevy_manual') {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HevyManualWorkoutScreen(workout: lockedWorkout),
                ),
              );
            }
          }
        }
      },
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.04),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Workout name
            Text(
              workout.workoutName.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            // Stats
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$exerciseCount exercises',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$totalSets sets',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),

            // START button — cyber lime
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFCCFF00),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'START',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HERO WORKOUT CARD (Glassmorphism design inspired by FutureYou)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildHeroWorkoutCard(BuildContext context, WidgetRef ref, dynamic displayWorkout) {
    if (displayWorkout == null) {
      return _buildNoWorkoutCard(context);
    }

    // Extract workout details based on type
    String workoutName;
    int exerciseCount;
    int totalSets;
    int estimatedCalories;
    String? scheduledTime;
    bool hasAlarm = false;
    
    if (displayWorkout is WorkoutSchedule) {
      // For scheduled workouts, fetch the actual workout data
      workoutName = displayWorkout.workoutName;
      scheduledTime = displayWorkout.scheduledTime;
      hasAlarm = displayWorkout.hasAlarm;

      // ═══════════════════════════════════════════════════════════════════════════
      // FIX: For TODAY, use committedWorkout data directly (has correct difficulty)
      // instead of looking up by ID which defaults to intermediate
      // ═══════════════════════════════════════════════════════════════════════════
      final isToday = _selectedDate.year == DateTime.now().year &&
                      _selectedDate.month == DateTime.now().month &&
                      _selectedDate.day == DateTime.now().day;

      final committedWorkout = ref.read(committedWorkoutProvider);

      // Check if committed workout matches this schedule
      final isSameWorkout = committedWorkout != null &&
                            (committedWorkout.id == displayWorkout.workoutId ||
                             committedWorkout.name == displayWorkout.workoutName);

      if (isToday && isSameWorkout) {
        // ✅ USE COMMITTED WORKOUT DATA - has correct difficulty-adjusted exercises
        debugPrint('📊 Using committedWorkout for hero card: ${committedWorkout.exercises.length} exercises');
        exerciseCount = committedWorkout.exercises.length;
        totalSets = committedWorkout.totalSets;
        estimatedCalories = committedWorkout.estimatedCalories;
      } else {
        // Fallback: look up by ID (for future dates without committed workout)
        final WorkoutPreset? workoutPreset = _findWorkoutById(displayWorkout.workoutId);
        if (workoutPreset != null) {
          exerciseCount = workoutPreset.exercises.where((e) => e.included).length;
          totalSets = workoutPreset.totalSets;
          estimatedCalories = _userWeightLoaded && _cachedUserWeight != null
              ? workoutPreset.getEstimatedCalories(_cachedUserWeight!)
              : workoutPreset.estimatedCalories;
        } else {
          // Fallback if workout not found
          exerciseCount = 0;
          totalSets = 0;
          estimatedCalories = 0;
        }
      }
    } else {
      // For LockedWorkout
      workoutName = displayWorkout.name;
      exerciseCount = displayWorkout.exercises.length;
      totalSets = displayWorkout.totalSets;
      
      print('🔍 HERO CARD LockedWorkout DEBUG:');
      print('   Name: $workoutName');
      print('   Exercise count: $exerciseCount');
      print('   Total sets: $totalSets');
      print('   Exercises: ${displayWorkout.exercises.map((e) => '${e.name} (${e.id})').join(', ')}');
      
      // Use accurate calorie estimate with user weight
      estimatedCalories = _userWeightLoaded && _cachedUserWeight != null
          ? displayWorkout.getEstimatedCalories(_cachedUserWeight!)
          : displayWorkout.estimatedCalories; // Fallback to old method
      scheduledTime = null;
    }

    // Determine which icon to show based on workout name
    String heroIcon = 'assets/images/icons/splits.jpg'; // default
    final nameLower = workoutName.toLowerCase();
    if (nameLower.contains('chest')) heroIcon = 'assets/images/icons/chest.jpg';
    else if (nameLower.contains('back')) heroIcon = 'assets/images/icons/back.jpg';
    else if (nameLower.contains('shoulder')) heroIcon = 'assets/images/icons/shoulders.jpg';
    else if (nameLower.contains('leg') || nameLower.contains('lower')) heroIcon = 'assets/images/icons/legs.jpg';
    else if (nameLower.contains('arm')) heroIcon = 'assets/images/icons/arms.jpg';
    else if (nameLower.contains('core')) heroIcon = 'assets/images/icons/core.jpg';
    else if (nameLower.contains('glute') || nameLower.contains('booty') || nameLower.contains('peach')) heroIcon = 'assets/images/icons/glutes.jpg';
    else if (nameLower.contains('circuit') || nameLower.contains('hiit') || nameLower.contains('burn') || nameLower.contains('blast') || nameLower.contains('torch')) heroIcon = 'assets/images/icons/circuits.jpg';
    else if (nameLower.contains('full body')) heroIcon = 'assets/images/icons/splits.jpg';
    else if (nameLower.contains('push')) heroIcon = 'assets/images/icons/chest.jpg';
    else if (nameLower.contains('pull')) heroIcon = 'assets/images/icons/back.jpg';
    else if (nameLower.contains('upper')) heroIcon = 'assets/images/icons/chest.jpg';

    return Container(
      margin: const EdgeInsets.only(),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFCCFF00).withOpacity(0.10),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // ═══════════════════════════════════════
          // TOP SECTION — Icon + Workout Name side by side
          // ═══════════════════════════════════════
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Row(
              children: [
                // Neon skeleton icon — large, flush with card edge
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                  ),
                  child: Image.asset(
                    heroIcon,
                    width: 110,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 110,
                        height: 110,
                        color: const Color(0xFF111111),
                        child: const Icon(Icons.fitness_center, color: Color(0xFFCCFF00), size: 32),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                // Workout name + info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workoutName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$exerciseCount exercises \u2022 $totalSets sets',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.35),
                          letterSpacing: 0.3,
                        ),
                      ),
                      // Show alarm indicator if alarm is set
                      if (hasAlarm && scheduledTime != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.alarm, color: Color(0xFFCCFF00), size: 14),
                            const SizedBox(width: 4),
                            Text(
                              scheduledTime,
                              style: const TextStyle(
                                color: Color(0xFFCCFF00),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                // Streak badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF151515),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('\u{1F525}', style: TextStyle(fontSize: 14)),
                      SizedBox(width: 4),
                      Text(
                        '0',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ═══════════════════════════════════════
          // STATS ROW — Clean, no ugly borders
          // ═══════════════════════════════════════
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Row(
              children: [
                _buildStatBox('$exerciseCount', 'EXERCISES'),
                const SizedBox(width: 8),
                _buildStatBox('$totalSets', 'SETS'),
                const SizedBox(width: 8),
                _buildStatBox('$estimatedCalories', 'CALORIES'),
              ],
            ),
          ),

          // ═══════════════════════════════════════
          // BUTTONS ROW
          // ═══════════════════════════════════════
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            child: Row(
              children: [
                // Timer
                GestureDetector(
                  onTap: () async {
                    HapticFeedback.mediumImpact();

                    if (displayWorkout != null) {
                      final result = await showModalBottomSheet<Map<String, dynamic>>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => ScheduleWorkoutModal(
                          selectedDate: _selectedDate,
                        ),
                      );

                      if (result != null && mounted) {
                        final timeData = result['time'] as TimeOfDay?;

                        if (timeData != null) {
                          WorkoutSchedule? existingSchedule;
                          String wName;
                          String wId;

                          if (displayWorkout is WorkoutSchedule) {
                            existingSchedule = displayWorkout;
                            wName = displayWorkout.workoutName;
                            wId = displayWorkout.workoutId;
                          } else if (displayWorkout is LockedWorkout) {
                            wName = displayWorkout.name;
                            wId = displayWorkout.id;
                          } else {
                            return;
                          }

                          final weekday = _selectedDate.weekday == 7 ? 0 : _selectedDate.weekday;

                          final schedule = WorkoutSchedule(
                            id: existingSchedule?.id ?? '${DateTime.now().millisecondsSinceEpoch}',
                            workoutId: wId,
                            workoutName: wName,
                            scheduledDate: DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day),
                            scheduledTime: '${timeData.hour.toString().padLeft(2, '0')}:${timeData.minute.toString().padLeft(2, '0')}',
                            hasAlarm: true,
                            createdAt: existingSchedule?.createdAt ?? DateTime.now(),
                            repeatDays: [weekday],
                          );

                          await ref.read(workoutSchedulesProvider.notifier).saveSchedule(schedule);
                          await WorkoutAlarmService.scheduleAlarm(schedule);
                          debugPrint('\u{1F514} Alarm scheduled for ${schedule.workoutName} at ${schedule.scheduledTime}');

                          if (mounted) {
                            final dateStr = DateFormat('MMM d').format(_selectedDate);
                            final timeStr = timeData.format(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '\u23F0 Alarm set for $dateStr at $timeStr',
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                                backgroundColor: const Color(0xFFCCFF00),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      }
                    } else {
                      await _openScheduleWorkoutFlow(_selectedDate);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151515),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.timer_outlined,
                      color: Colors.white.withOpacity(0.4),
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // START WORKOUT — full width, cyber lime
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TrainTab(
                            onWorkoutStateChanged: (isActive) {},
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCFF00),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'START WORKOUT',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Edit
                GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref.read(selectedScheduleDateProvider.notifier).state = _selectedDate;
                    ref.read(isSchedulingModeProvider.notifier).state = true;
                    final navigator = context.findAncestorWidgetOfExactType<TabNavigator>();
                    if (navigator != null) {
                      (navigator as dynamic).changeTab(1);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151515),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.white.withOpacity(0.4),
                      size: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════
  // STAT BOX — Clean, minimal, no ugly borders
  // ═══════════════════════════════════════
  Widget _buildStatBox(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFCCFF00).withOpacity(0.35),
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoWorkoutCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFCCFF00).withOpacity(0.10),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.calendar_today_outlined,
            color: const Color(0xFFCCFF00).withOpacity(0.25),
            size: 36,
          ),
          const SizedBox(height: 16),
          const Text(
            'No Workout Today',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Schedule a workout for this date',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              // QUICK ADD — subtle dark
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    ref.read(selectedScheduleDateProvider.notifier).state = _selectedDate;
                    ref.read(isSchedulingModeProvider.notifier).state = true;
                    final navigator = context.findAncestorWidgetOfExactType<TabNavigator>();
                    if (navigator != null) {
                      (navigator as dynamic).changeTab(1);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151515),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add, color: Color(0xFFCCFF00), size: 18),
                        const SizedBox(width: 8),
                        const Text(
                          'QUICK ADD',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFCCFF00),
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // WITH ALARM — cyber lime filled
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    HapticFeedback.heavyImpact();
                    await _openScheduleWorkoutFlow(_selectedDate);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCFF00),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.alarm, color: Colors.black, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'WITH ALARM',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
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

  // ═══════════════════════════════════════════════════════════════════════════
  // STAT CARDS GRID (2x2: Workouts, Reps, Sets, Streak)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildStatCardsGrid(WorkoutStats stats) {
    return Column(
      children: [
        // Row 1: Workouts + Reps
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                label: 'WORKOUTS',
                value: '${stats.workoutsThisWeek}',
                subtitle: '/ 5 this week',
                icon: Icons.fitness_center,
                gradient: const LinearGradient(
                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                label: 'REPS',
                value: '${stats.repsThisWeek}',
                subtitle: 'total reps',
                icon: Icons.all_inclusive,
                gradient: const LinearGradient(
                  colors: [Color(0xFFCCFF00), Color(0xFFCCFF00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Row 2: Sets + Streak
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                label: 'SETS',
                value: '${(stats.repsThisWeek / 10).round()}',
                subtitle: 'total sets',
                icon: Icons.stacked_bar_chart,
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                label: 'CALORIES',
                value: '${(stats.repsThisWeek * 5).round()}',
                subtitle: 'burned',
                icon: Icons.local_fire_department,
                gradient: const LinearGradient(
                  colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                showFlame: true,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required String subtitle,
    required IconData icon,
    required Gradient gradient,
    bool showFlame = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          // Icon with gradient background
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              showFlame ? Icons.local_fire_department : icon,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(height: 12),
          // Value
          AnimatedCounter(
            target: int.tryParse(value) ?? 0,
            duration: const Duration(milliseconds: 1000),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          // Label
          Text(
            label,
            style: TextStyle(
              color: AppColors.white50,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          // Subtitle
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.white40,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // QUICK ACTIONS ROW (Browse Workouts + Create Custom)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildQuickActionsRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionCard(
            context: context,
            label: 'Browse\nWorkouts',
            icon: Icons.search,
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF059669)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () {
              final navigator = context.findAncestorWidgetOfExactType<TabNavigator>();
              if (navigator != null) {
                (navigator as dynamic).changeTab(2); // Workouts tab
              }
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildQuickActionCard(
            context: context,
            label: 'Create\nCustom',
            icon: Icons.add_circle_outline,
            gradient: const LinearGradient(
              colors: [Color(0xFFCCFF00), Color(0xFFCCFF00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            onTap: () {
              final navigator = context.findAncestorWidgetOfExactType<TabNavigator>();
              if (navigator != null) {
                (navigator as dynamic).changeTab(2); // Workouts tab
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionCard({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // RECOVERY STATUS CARD (CONTEXTUAL - Based on selected workout)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildRecoveryStatusCard(WorkoutStats stats, dynamic selectedWorkout) {
    // Use cached data - no FutureBuilder hang!
    if (!_recoveryLoaded) {
      return Container(
        height: 400,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.white10, width: 1),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.cyberLime),
          ),
        ),
      );
    }

    final muscleRecovery = _cachedRecovery ?? {};
    final gender = _cachedGender;
    
    // CONTEXTUAL RECOVERY: Get muscles for selected workout
    Map<String, double> contextualRecovery = muscleRecovery;
    String recoveryContext = 'ALL MUSCLES';
    
    if (selectedWorkout != null) {
      final exercises = _getExercisesFromWorkout(selectedWorkout);
      if (exercises.isNotEmpty) {
        // Get muscle groups for these exercises
        final Set<String> targetMuscles = {};
        for (final exerciseName in exercises) {
          final normalized = exerciseName.toLowerCase().replaceAll(' ', '_');
          if (MuscleRecoveryService.exerciseMuscleMap.containsKey(normalized)) {
            targetMuscles.addAll(MuscleRecoveryService.exerciseMuscleMap[normalized]!);
          } else {
            // Try fuzzy match
            for (final entry in MuscleRecoveryService.exerciseMuscleMap.entries) {
              if (normalized.contains(entry.key) || entry.key.contains(normalized)) {
                targetMuscles.addAll(entry.value);
                break;
              }
            }
          }
        }
        
        if (targetMuscles.isNotEmpty) {
          // Filter recovery to only show relevant muscles
          contextualRecovery = Map.fromEntries(
            muscleRecovery.entries.where((e) => targetMuscles.contains(e.key))
          );
          recoveryContext = _getMuscleGroupName(targetMuscles);
        }
      }
    }
    
    // Calculate recovery for contextual muscles
    final overallRecovery = contextualRecovery.isEmpty
        ? 1.0
        : contextualRecovery.values.reduce((a, b) => a + b) / contextualRecovery.length;

    // Determine status
    String status;
    Color statusColor;
    IconData statusIcon;

    if (overallRecovery >= 0.8) {
      status = 'READY TO TRAIN';
      statusColor = const Color(0xFF00FF00);
      statusIcon = Icons.check_circle;
    } else if (overallRecovery >= 0.6) {
      status = 'ALMOST READY';
      statusColor = AppColors.cyberLime;
      statusIcon = Icons.schedule;
    } else if (overallRecovery >= 0.3) {
      status = 'RECOVERING';
      statusColor = const Color(0xFFFF8800);
      statusIcon = Icons.hourglass_bottom;
    } else {
      status = 'NEED REST';
      statusColor = const Color(0xFFFF3333);
      statusIcon = Icons.warning;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.white10,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MUSCLE RECOVERY',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  if (recoveryContext != 'ALL MUSCLES')
                    Text(
                      recoveryContext.toUpperCase(),
                      style: TextStyle(
                        color: AppColors.cyberLime,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                ],
              ),
              Icon(
                Icons.medical_services_outlined,
                color: AppColors.white50,
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Interactive Muscle Body Diagram with FULL recovery data (not filtered)
          MuscleBodyWidget(
            muscleRecovery: muscleRecovery,
            height: 400,
            gender: gender,
          ),
          
          const SizedBox(height: 16),
          
          // Overall status badge with REAL data
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: statusColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '${(overallRecovery * 100).toInt()}%',
                  style: TextStyle(
                    color: statusColor.withOpacity(0.7),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SCHEDULING METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Open workout library to schedule workout for selected date


  /// Open schedule workout flow (date long-press)
  Future<void> _openScheduleWorkoutFlow(DateTime date) async {
    debugPrint('═══════════════════════════════════════════════════');
    debugPrint('🚀 _openScheduleWorkoutFlow STARTED for date: $date');

    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ScheduleWorkoutModal(selectedDate: date),
    );

    debugPrint('📥 ScheduleWorkoutModal returned: $result');

    if (result == null) {
      debugPrint('❌ EARLY EXIT: result is null (modal dismissed or cancelled)');
      return;
    }

    if (!mounted) {
      debugPrint('❌ EARLY EXIT: widget not mounted');
      return;
    }

    // User set time/alarm, now show workout library
    debugPrint('📖 Opening WorkoutLibraryModal...');

    final selectedWorkout = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const WorkoutLibraryModal(),
    );

    debugPrint('📥 WorkoutLibraryModal returned: $selectedWorkout');

    if (selectedWorkout == null) {
      debugPrint('❌ EARLY EXIT: selectedWorkout is null (no workout selected)');
      return;
    }

    if (!mounted) {
      debugPrint('❌ EARLY EXIT: widget not mounted after workout selection');
      return;
    }

    final timeData = result['time'] as TimeOfDay?;
    final hasAlarm = timeData != null;

    debugPrint('⏰ Time data: $timeData');
    debugPrint('🔔 Has alarm: $hasAlarm');

    // Get the weekday for repeatDays (0=Sunday, 1=Monday... 6=Saturday)
    // Dart: Monday=1, Tuesday=2... Sunday=7
    // Our model: Sunday=0, Monday=1... Saturday=6
    final weekday = date.weekday == 7 ? 0 : date.weekday;
    
    // If user sets alarm, add the weekday to repeatDays
    final repeatDays = hasAlarm ? [weekday] : <int>[];

    debugPrint('📅 Weekday for schedule: $weekday (${_getDayName(weekday)})');
    debugPrint('🔁 RepeatDays: $repeatDays');

    // Create schedule
    final schedule = WorkoutSchedule(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      workoutId: selectedWorkout['id'] as String,
      workoutName: selectedWorkout['name'] as String,
      scheduledDate: DateTime(date.year, date.month, date.day),
      scheduledTime: timeData != null
          ? '${timeData.hour.toString().padLeft(2, '0')}:${timeData.minute.toString().padLeft(2, '0')}'
          : null,
      hasAlarm: hasAlarm,
      createdAt: DateTime.now(),
      repeatDays: repeatDays, // Add the weekday so alarm schedules!
    );

    debugPrint('📋 Created schedule:');
    debugPrint('   - ID: ${schedule.id}');
    debugPrint('   - Workout: ${schedule.workoutName}');
    debugPrint('   - Date: ${schedule.scheduledDate}');
    debugPrint('   - Time: ${schedule.scheduledTime}');
    debugPrint('   - Has Alarm: ${schedule.hasAlarm}');

    // Save schedule
    debugPrint('💾 Saving schedule via provider...');
    await ref.read(workoutSchedulesProvider.notifier).saveSchedule(schedule);
    debugPrint('✅ Schedule saved!');

    // ═══════════════════════════════════════════════════════════════════
    // 🔔 FIX 1: ACTUALLY SCHEDULE THE ALARM!
    // ═══════════════════════════════════════════════════════════════════
    if (hasAlarm) {
      debugPrint('🔔 Calling WorkoutAlarmService.scheduleAlarm directly...');
      await WorkoutAlarmService.scheduleAlarm(schedule);
      debugPrint('🔔 Alarm scheduled for ${schedule.workoutName} at ${schedule.scheduledTime}');
    }
    // ═══════════════════════════════════════════════════════════════════

    if (mounted) {
      final dateStr = DateFormat('MMM d').format(date);
      final timeStr = timeData?.format(context);

      // Show enhanced confirmation snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '✅ ${selectedWorkout['name']} scheduled!',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
              if (hasAlarm) ...[
                const SizedBox(height: 4),
                Text(
                  '⏰ Alarm set for $dateStr at $timeStr',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
              ],
            ],
          ),
          backgroundColor: AppColors.cyberLime,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    debugPrint('═══════════════════════════════════════════════════');
  }
  
  /// Schedule a test alarm that fires in 1 minute
  Future<void> _scheduleTestAlarm() async {
    try {
      await WorkoutAlarmService.scheduleTestAlarm();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🧪 Test alarm scheduled for 1 minute from now!'),
            backgroundColor: AppColors.cyberLime,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      debugPrint('❌ Failed to schedule test alarm: $e');
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Test alarm failed: $e'),
            backgroundColor: AppColors.neonCrimson,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
  
  // ═══════════════════════════════════════════════════════════════════════════
  // WORKOUT ALARM PICKER
  // ═══════════════════════════════════════════════════════════════════════════
  
  // ═══════════════════════════════════════════════════════════════════════════
  // STREAK ACHIEVEMENTS MODAL
  // ═══════════════════════════════════════════════════════════════════════════
  void _showStreakAchievements(BuildContext context, WorkoutStats stats) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.cyberBlack,
              AppColors.cyberBlack.withOpacity(0.95),
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: Border.all(
            color: AppColors.cyberLime.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.white30,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          '🔥',
                          style: TextStyle(fontSize: 28), // Slightly smaller
                        ),
                        const SizedBox(width: 6), // Reduced spacing
                        Expanded( // Allow text to take remaining space
                          child: ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFFFF6B35), Color(0xFFFFD60A)],
                            ).createShader(bounds),
                            child: const Text(
                              'STREAK ACHIEVEMENTS',
                              style: TextStyle(
                                fontSize: 22, // Slightly smaller to fit better
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 0.5, // Reduced letter spacing
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Current Streak: ${stats.currentStreak} days',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            // Achievements Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: _streakAchievements.length,
                itemBuilder: (context, index) {
                  final achievement = _streakAchievements[index];
                  final isUnlocked = stats.currentStreak >= (achievement['days'] as int);

                  return TweenAnimationBuilder(
                    duration: Duration(milliseconds: 300 + (index * 50)),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: _buildAchievementCard(achievement, isUnlocked),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAchievementCard(Map<String, dynamic> achievement, bool isUnlocked) {
    return Container(
      decoration: BoxDecoration(
        gradient: isUnlocked
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (achievement['color'] as Color).withOpacity(0.3),
                  (achievement['color'] as Color).withOpacity(0.1),
                ],
              )
            : LinearGradient(
                colors: [
                  AppColors.white5,
                  AppColors.white10,
                ],
              ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUnlocked
              ? (achievement['color'] as Color).withOpacity(0.5)
              : AppColors.white20,
          width: 2,
        ),
        boxShadow: isUnlocked
            ? [
                BoxShadow(
                  color: (achievement['color'] as Color).withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder(
            duration: const Duration(seconds: 2),
            tween: Tween<double>(begin: 0, end: isUnlocked ? 1 : 0.5),
            builder: (context, double value, child) {
              return Transform.scale(
                scale: 0.9 + (0.1 * value),
                child: Text(
                  achievement['emoji'] as String,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white.withOpacity(isUnlocked ? 1.0 : 0.3),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            '${achievement['days']} DAYS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: isUnlocked ? Colors.white : AppColors.white40,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              achievement['title'] as String,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: isUnlocked ? AppColors.white90 : AppColors.white30,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // 20+ Streak Achievements
  static final List<Map<String, dynamic>> _streakAchievements = [
    {'days': 1, 'emoji': '⚡', 'title': 'First Step', 'color': Color(0xFF00D9FF)},
    {'days': 3, 'emoji': '🔥', 'title': 'Getting Hot', 'color': Color(0xFFFF6B35)},
    {'days': 5, 'emoji': '💪', 'title': 'Strong Start', 'color': Color(0xFF4ECDC4)},
    {'days': 7, 'emoji': '🌟', 'title': 'Week Warrior', 'color': Color(0xFFFFD60A)},
    {'days': 10, 'emoji': '🚀', 'title': 'Momentum', 'color': Color(0xFF00D9FF)},
    {'days': 14, 'emoji': '🏆', 'title': 'Two Weeks', 'color': Color(0xFFB7FF00)},
    {'days': 21, 'emoji': '💎', 'title': 'Habit Former', 'color': Color(0xFF00D9FF)},
    {'days': 30, 'emoji': '👑', 'title': 'Monthly King', 'color': Color(0xFFFFD60A)},
    {'days': 50, 'emoji': '🔱', 'title': 'Unstoppable', 'color': Color(0xFF4ECDC4)},
    {'days': 75, 'emoji': '⚔️', 'title': 'Warrior', 'color': Color(0xFFFF6B35)},
    {'days': 100, 'emoji': '🎯', 'title': 'Centurion', 'color': Color(0xFFB7FF00)},
    {'days': 125, 'emoji': '🌪️', 'title': 'Tornado', 'color': Color(0xFF00D9FF)},
    {'days': 150, 'emoji': '⚡', 'title': 'Lightning', 'color': Color(0xFFFFD60A)},
    {'days': 180, 'emoji': '🦾', 'title': 'Half Year', 'color': Color(0xFF4ECDC4)},
    {'days': 200, 'emoji': '🔮', 'title': 'Legendary', 'color': Color(0xFFFF6B35)},
    {'days': 250, 'emoji': '🌋', 'title': 'Volcanic', 'color': Color(0xFFB7FF00)},
    {'days': 300, 'emoji': '🦁', 'title': 'Lion Heart', 'color': Color(0xFFFFD60A)},
    {'days': 365, 'emoji': '👽', 'title': 'Year Beast', 'color': Color(0xFF00D9FF)},
    {'days': 500, 'emoji': '🌌', 'title': 'Galactic', 'color': Color(0xFF4ECDC4)},
    {'days': 750, 'emoji': '🏛️', 'title': 'Titan', 'color': Color(0xFFFF6B35)},
    {'days': 1000, 'emoji': '🌠', 'title': 'Immortal', 'color': Color(0xFFB7FF00)},
    {'days': 1500, 'emoji': '⭐', 'title': 'Transcendent', 'color': Color(0xFFFFD60A)},
  ];

  /// Helper method to find workout preset by ID
  WorkoutPreset? _findWorkoutById(String workoutId) {
    // ═══════════════════════════════════════════════════════════════════
    // FIX: Check custom workouts from cache FIRST
    // ═══════════════════════════════════════════════════════════════════
    if (workoutId.startsWith('custom_') && _cachedCustomWorkouts != null) {
      final customMatch = _cachedCustomWorkouts![workoutId];
      if (customMatch != null) {
        debugPrint('✅ Found custom workout in cache: ${customMatch.name}');
        return customMatch;
      }
    }

    try {
      // First try to find in all workout presets (static lists)
      final staticMatch = WorkoutData.allWorkoutPresets.firstWhere(
        (preset) => preset.id == workoutId,
        orElse: () => throw Exception('Not found'),
      );
      return staticMatch;
    } catch (e) {
      // If not found, try to regenerate from dynamic methods
      // Extract base ID and difficulty from workoutId
      String baseId = workoutId;
      String difficulty = 'intermediate'; // Default
      
      // Check if workoutId has a difficulty suffix
      if (workoutId.endsWith('_beginner')) {
        baseId = workoutId.replaceAll('_beginner', '');
        difficulty = 'beginner';
      } else if (workoutId.endsWith('_intermediate')) {
        baseId = workoutId.replaceAll('_intermediate', '');
        difficulty = 'intermediate';
      } else if (workoutId.endsWith('_advanced')) {
        baseId = workoutId.replaceAll('_advanced', '');
        difficulty = 'advanced';
      }
      
      // Try to find in dynamically generated workouts
      try {
        // Determine which category based on the base ID
        List<WorkoutPreset> presets = [];
        
        if (baseId.startsWith('gym_chest') || baseId.startsWith('gym_back') || 
            baseId.startsWith('gym_shoulders') || baseId.startsWith('gym_legs') || 
            baseId.startsWith('gym_arms') || baseId.startsWith('gym_core')) {
          presets = WorkoutData.getGymMuscleSplits(difficulty);
        } else if (baseId.startsWith('gym_upper') || baseId.startsWith('gym_lower') || 
                   baseId.startsWith('gym_push') || baseId.startsWith('gym_pull') || 
                   baseId.startsWith('gym_full') || baseId.startsWith('gym_glutes')) {
          presets = WorkoutData.getGymMuscleGroupings(difficulty);
        } else if (baseId.contains('blast') || baseId.contains('burner') || 
                   baseId.contains('torch') || baseId.contains('destroyer')) {
          presets = WorkoutData.getGymCircuits(difficulty);
        } else if (baseId.contains('glute') || baseId.contains('peach')) {
          presets = WorkoutData.getGymBootyBuilder(difficulty);
        } else if (baseId.startsWith('gym_girl')) {
          presets = WorkoutData.getGymGirlPower(difficulty);
        } else if (baseId.startsWith('home_full') || baseId.startsWith('home_upper') || 
                   baseId.startsWith('home_lower') || baseId.startsWith('home_core') ||
                   baseId.startsWith('home_bro')) {
          presets = WorkoutData.getHomeBodyweightBasics(difficulty);
        } else if (baseId.contains('min') || baseId.contains('tabata') || 
                   baseId.contains('cardio')) {
          presets = WorkoutData.getHomeHIITCircuits(difficulty);
        } else if (baseId.startsWith('home_glute') || baseId.startsWith('home_booty') || 
                   baseId.startsWith('home_band')) {
          presets = WorkoutData.getHomeBooty(difficulty);
        } else if (baseId.startsWith('home_girl')) {
          presets = WorkoutData.getHomeGirlPower(difficulty);
        }
        
        // Find matching preset
        return presets.firstWhere(
          (preset) => preset.id == workoutId || preset.id.startsWith(baseId),
          orElse: () => throw Exception('Not found'),
        );
      } catch (e2) {
        debugPrint('Could not find workout: $workoutId');
        return null;
      }
    }
  }

  /// Helper method to check if selected date is today
  bool _isSelectedDateToday() {
    final now = DateTime.now();
    return _selectedDate.year == now.year &&
           _selectedDate.month == now.month &&
           _selectedDate.day == now.day;
  }

  /// Get day name for logging (copied from FutureYou)
  String _getDayName(int day) {
    const days = [
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday'
    ];
    return days[day];
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ELITE FORM CHECK CARD - AI Form Analysis
  Widget _buildEliteFormCheckCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FormCheckExercisePickerScreen(),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF7C3AED).withOpacity(0.3),
                  const Color(0xFF5B21B6).withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFF7C3AED).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Stack(
              children: [
                // Background glow effect
                Positioned(
                  top: -50,
                  right: -50,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppColors.cyberLime.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row with animated power ring
                    Row(
                      children: [
                        // Animated icon container
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFCCFF00).withOpacity(0.1),
                            border: Border.all(
                              color: AppColors.cyberLime.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            Icons.psychology,
                            color: AppColors.cyberLime,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Title
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ELITE FORM',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                              Text(
                                'ANALYSIS',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'AI-Powered by MediaPipe',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white60,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildFormStatPill(
                          icon: Icons.camera_alt,
                          label: 'REAL-TIME',
                          color: const Color(0xFFCCFF00),
                        ),
                        _buildFormStatPill(
                          icon: Icons.record_voice_over,
                          label: 'VOICE AI',
                          color: AppColors.neonPurple,
                        ),
                        _buildFormStatPill(
                          icon: Icons.share,
                          label: 'SHARE',
                          color: AppColors.cyberLime,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // CTA Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            'Check your form on the Big 5',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCFF00),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cyberLime.withOpacity(0.5),
                                blurRadius: 20,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'START',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  letterSpacing: 1,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildFormStatPill({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w800,
              color: color,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturePill(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: AppColors.cyberLime,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to convert WorkoutStats to AnalyticsData format
  AnalyticsData _buildAnalyticsData(WorkoutStats stats) {
    // Use cached analytics if available (has real totalVolume)
    if (_analyticsLoaded && _cachedAnalytics != null) {
      return _cachedAnalytics!;
    }
    
    // Fallback: build from stats (will have 0 volume/calories until analytics loads)
    return AnalyticsData(
      powerLevel: stats.totalWorkouts * 10, // Simple calculation
      currentStreak: stats.currentStreak,
      longestStreak: stats.longestStreak,
      totalWorkouts: stats.totalWorkouts,
      totalReps: stats.totalLifetimeReps,
      totalVolumeKg: 0.0, // Will be replaced when analytics loads
      totalHours: stats.totalMinutes / 60,
      totalCalories: 0, // Will be replaced when analytics loads
      dailyVolumeData: [],
      weeklyVolumes: [],
      monthlyVolumes: {},
      workoutIntensityMap: {},
      weekdayDistribution: {},
      weeklyAverage: 0.0,
      recentPRs: [],
      allTimePRs: [],
      bodyPartVolumes: {},
      bodyPartPercentages: {},
      topExercises: [],
      exerciseFrequency: {},
      exerciseProgressions: {},
      exerciseProgressPercentages: {},
      formScoreData: [],
      perfectReps: 0,
      goodReps: 0,
      missReps: 0,
      formIQ: 0,
      avgFormScore: stats.avgFormScore,
      longestPerfectStreak: 0,
      measurements: [],
      weightData: [],
      progressPhotos: [],
      measurementChanges: {},
    );
  }

  /// Get exercises from workout (for contextual recovery)
  List<String> _getExercisesFromWorkout(dynamic workout) {
    if (workout == null) return [];
    
    if (workout is WorkoutSchedule) {
      final workoutPreset = _findWorkoutById(workout.workoutId);
      if (workoutPreset != null) {
        return workoutPreset.exercises
            .where((e) => e.included)
            .map((e) => e.name)
            .toList();
      }
    } else if (workout is LockedWorkout) {
      return workout.exercises.map((e) => e.name).toList();
    }
    
    return [];
  }

  /// Get readable muscle group name from set of muscles
  String _getMuscleGroupName(Set<String> muscles) {
    if (muscles.isEmpty) return 'ALL MUSCLES';
    
    // Primary muscle group detection
    final chest = ['chest'];
    final back = ['lats', 'traps', 'lower_back'];
    final shoulders = ['shoulders'];
    final arms = ['biceps', 'triceps', 'forearms'];
    final legs = ['quadriceps', 'hamstrings', 'glutes', 'calves'];
    final core = ['abs'];
    
    if (muscles.any((m) => chest.contains(m)) && muscles.length <= 2) return 'CHEST';
    if (muscles.any((m) => back.contains(m)) && muscles.length <= 3) return 'BACK';
    if (muscles.any((m) => shoulders.contains(m)) && muscles.length <= 2) return 'SHOULDERS';
    if (muscles.any((m) => arms.contains(m)) && muscles.length <= 2) return 'ARMS';
    if (muscles.any((m) => legs.contains(m)) && muscles.length <= 4) return 'LEGS';
    if (muscles.any((m) => core.contains(m)) && muscles.length <= 1) return 'CORE';
    
    // Multiple groups
    if (muscles.length <= 3) {
      return muscles.map((m) => m.toUpperCase().replaceAll('_', ' ')).join(' + ');
    }
    
    return 'MULTIPLE GROUPS';
  }

  /// Safe widget builder with error boundary
  Widget _buildSafeWidget(Widget Function() builder, String widgetName) {
    try {
      return builder();
    } catch (e, stack) {
      debugPrint('❌ Error building $widgetName: $e');
      debugPrint('Stack: $stack');
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.neonCrimson.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neonCrimson, width: 1),
        ),
        child: Column(
          children: [
            Icon(Icons.error_outline, color: AppColors.neonCrimson, size: 32),
            const SizedBox(height: 8),
            Text(
              'Error loading $widgetName',
              style: const TextStyle(
                color: AppColors.neonCrimson,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              e.toString(),
              style: TextStyle(
                color: AppColors.white60,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }
}

