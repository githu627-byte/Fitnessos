import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_colors.dart';
import '../../services/storage_service.dart';
import '../../features/profile/my_videos_view.dart';
import '../../features/analytics/models/analytics_data.dart';
import '../../features/analytics/services/analytics_service.dart';
import '../../features/analytics/widgets/hero_stats_card.dart';
import '../../features/analytics/widgets/workout_heatmap_widget.dart';
import '../../features/analytics/widgets/charts_widget.dart';
import '../../features/analytics/widgets/pr_timeline_widget.dart';
import '../../features/analytics/widgets/form_analytics_widget.dart';
import '../../features/analytics/screens/measurements_input_screen.dart';
import '../tabs/settings_tab.dart';
import '../../services/firebase_analytics_service.dart';

/// =============================================================================
/// PROFILE TAB - Swipeable Tabs with Pressable Animations
/// =============================================================================
/// Five swipeable tabs: OVERVIEW, STRENGTH, FORM, BODY, VIDS
/// Pressable tab buttons with scale animation + haptic feedback
/// PageView for smooth swiping between sections
/// =============================================================================

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  late PageController _pageController;
  int _selectedTab = 0;
  final List<String> _tabs = ['OVERVIEW', 'STRENGTH', 'FORM', 'BODY', 'VIDS'];

  // Analytics state
  AnalyticsData? _analyticsData;
  AnalyticsPeriod _selectedPeriod = AnalyticsPeriod.allTime;
  bool _isLoading = true;
  String _userName = 'Champion';

  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsService().logScreenView(screenName: 'profile_tab', screenClass: 'ProfileTab');
    _pageController = PageController();
    _loadUserData();
    _loadAnalytics();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    final name = await StorageService.getUserName();
    if (mounted) {
      setState(() {
        _userName = name ?? 'Champion';
      });
    }
  }

  Future<void> _loadAnalytics() async {
    try {
      final data = await AnalyticsService.loadAnalytics(
        period: _selectedPeriod,
      );

      if (mounted) {
        setState(() {
          _analyticsData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading analytics: $e');
      if (mounted) {
        setState(() {
          _analyticsData = AnalyticsData.empty();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _refreshAnalytics() async {
    await _loadAnalytics();
    HapticFeedback.mediumImpact();
  }

  void _onPeriodChanged(AnalyticsPeriod period) {
    FirebaseAnalyticsService().logAnalyticsPeriodChanged(period: period.displayName);
    HapticFeedback.selectionClick();
    setState(() {
      _selectedPeriod = period;
      _isLoading = true;
    });
    _loadAnalytics();
  }

  void _openSettings(BuildContext context) {
    FirebaseAnalyticsService().logSettingsOpened();
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SettingsTab(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Tab bar at top
            _buildTabBar(),

            const SizedBox(height: 12),

            // Swipeable content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _selectedTab = index);
                  FirebaseAnalyticsService().logProfileSubTabViewed(subTab: _tabs[index].toLowerCase());
                  HapticFeedback.selectionClick();
                },
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildOverviewContent(),
                  _buildStrengthContent(),
                  _buildFormContent(),
                  _buildBodyContent(),
                  _buildVidsContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TAB BAR — Pressable tabs + settings gear
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
      child: Row(
        children: [
          // Tabs — scrollable
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: _tabs.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: _PressableTab(
                      label: entry.value,
                      isActive: _selectedTab == entry.key,
                      onTap: () {
                        setState(() => _selectedTab = entry.key);
                        _pageController.animateToPage(
                          entry.key,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                        );
                        HapticFeedback.selectionClick();
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          // Settings gear
          _PressableIcon(
            icon: Icons.settings_outlined,
            onTap: () {
              _openSettings(context);
              HapticFeedback.lightImpact();
            },
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TIME PERIOD SELECTOR — Inside each tab
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildTimePeriodSelector() {
    return Row(
      children: AnalyticsPeriod.values.map((period) {
        final isActive = _selectedPeriod == period;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: _PressableTab(
              label: period.displayName,
              isActive: isActive,
              onTap: () {
                _onPeriodChanged(period);
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // LOADING STATE
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.cyberLime),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Loading your stats...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // OVERVIEW TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildOverviewContent() {
    if (_isLoading) return _buildLoadingState();
    final data = _analyticsData!;

    return RefreshIndicator(
      onRefresh: _refreshAnalytics,
      color: AppColors.cyberLime,
      backgroundColor: const Color(0xFF1A1A2E),
      child: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.only(bottom: 100),
        children: [
          const SizedBox(height: 8),

          // Time period selector — inside the tab
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildTimePeriodSelector(),
          ),

          const SizedBox(height: 16),

          // Hero Stats Card
          HeroStatsCard(data: data),

          const SizedBox(height: 20),

          // Workout Heatmap
          WorkoutHeatmapWidget(
            workoutIntensityMap: data.workoutIntensityMap,
          ),

          const SizedBox(height: 20),

          // Weekday Distribution
          WeekdayDistributionChart(
            weekdayDistribution: data.weekdayDistribution,
          ),

          const SizedBox(height: 20),

          // Recent PRs
          if (data.recentPRs.isNotEmpty) ...[
            PRTimelineWidget(
              prs: data.recentPRs.take(5).toList(),
              title: 'RECENT PRs',
            ),
            const SizedBox(height: 20),
          ],

          // Top Exercises
          if (data.topExercises.isNotEmpty)
            TopExercisesWidget(
              topExercises: data.topExercises,
            ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // STRENGTH TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildStrengthContent() {
    if (_isLoading) return _buildLoadingState();
    final data = _analyticsData!;

    return RefreshIndicator(
      onRefresh: _refreshAnalytics,
      color: AppColors.cyberLime,
      backgroundColor: const Color(0xFF1A1A2E),
      child: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.only(bottom: 100),
        children: [
          const SizedBox(height: 8),

          // Time period selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildTimePeriodSelector(),
          ),

          const SizedBox(height: 16),

          // Volume Chart
          VolumeChartWidget(
            volumeData: data.dailyVolumeData,
            title: 'TRAINING VOLUME',
            subtitle: 'Last 30 days',
          ),

          const SizedBox(height: 20),

          // Body Part Radar Chart
          BodyRadarChartWidget(
            bodyPartPercentages: data.bodyPartPercentages,
          ),

          const SizedBox(height: 20),

          // Exercise Progressions
          if (data.exerciseProgressions.isNotEmpty) ...[
            ProgressionChartWidget(
              exerciseProgressions: data.exerciseProgressions,
              progressPercentages: data.exerciseProgressPercentages,
            ),
            const SizedBox(height: 20),
          ],

          // All Time PRs
          if (data.allTimePRs.isNotEmpty) ...[
            PRTimelineWidget(
              prs: data.allTimePRs.take(5).toList(),
              title: 'ALL-TIME PRs',
            ),
            const SizedBox(height: 20),
          ],

          // Top Exercises
          TopExercisesWidget(
            topExercises: data.topExercises,
            title: 'VOLUME BY EXERCISE',
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FORM TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildFormContent() {
    if (_isLoading) return _buildLoadingState();
    final data = _analyticsData!;

    if (!data.hasFormData) {
      return _buildEmptyFormState();
    }

    return RefreshIndicator(
      onRefresh: _refreshAnalytics,
      color: AppColors.cyberLime,
      backgroundColor: const Color(0xFF1A1A2E),
      child: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.only(bottom: 100),
        children: [
          const SizedBox(height: 8),

          // Time period selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildTimePeriodSelector(),
          ),

          const SizedBox(height: 16),

          // Form IQ Card
          FormIQCardWidget(
            formIQ: data.formIQ,
            avgFormScore: data.avgFormScore,
            longestPerfectStreak: data.longestPerfectStreak,
            totalQualityReps: data.totalQualityReps,
          ),

          const SizedBox(height: 20),

          // Rep Quality Donut
          RepQualityDonutWidget(
            perfectReps: data.perfectReps,
            goodReps: data.goodReps,
            missReps: data.missReps,
          ),

          const SizedBox(height: 20),

          // Form Score Timeline
          if (data.formScoreData.isNotEmpty)
            FormScoreTimelineWidget(
              formScoreData: data.formScoreData,
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyFormState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cyberLime.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.videocam_outlined,
                color: AppColors.cyberLime,
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Form Data Yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Use Camera Mode during workouts to track your form quality and see detailed analytics here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white.withOpacity(0.5),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BODY TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildBodyContent() {
    if (_isLoading) return _buildLoadingState();
    final data = _analyticsData!;

    if (!data.hasMeasurements) {
      return _buildEmptyBodyState();
    }

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: _refreshAnalytics,
          color: AppColors.cyberLime,
          backgroundColor: const Color(0xFF1A1A2E),
          child: ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.only(bottom: 100),
            children: [
              const SizedBox(height: 8),

              // Time period selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildTimePeriodSelector(),
              ),

              const SizedBox(height: 16),

              // Weight Trend Chart
              if (data.weightData.isNotEmpty)
                VolumeChartWidget(
                  volumeData: data.weightData,
                  title: 'WEIGHT TREND',
                  subtitle: 'Last 60 days',
                  color: AppColors.cyberLime,
                ),

              // Latest Measurement Card
              if (data.measurements.isNotEmpty)
                _buildLatestMeasurementCard(data.measurements.first),

              // Measurement Changes
              if (data.measurementChanges.isNotEmpty)
                _buildMeasurementChangesCard(data.measurementChanges),

              // Progress Photos Grid
              if (data.progressPhotos.isNotEmpty)
                _buildProgressPhotosGrid(data.progressPhotos),
            ],
          ),
        ),

        // Floating add measurement button
        Positioned(
          right: 20,
          bottom: 20,
          child: GestureDetector(
            onTap: () async {
              HapticFeedback.mediumImpact();
              final result = await MeasurementsInputScreen.show(context);
              if (result == true) {
                _refreshAnalytics();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.neonPurple,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.neonPurple.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLatestMeasurementCard(BodyMeasurement measurement) {
    final measurements = measurement.allMeasurements;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'LATEST MEASUREMENT',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _formatDateShort(measurement.date),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: measurements.entries.map((entry) {
                    return _buildMeasurementChip(
                      entry.key,
                      entry.value,
                      entry.key == 'Weight'
                          ? 'kg'
                          : entry.key == 'Body Fat'
                              ? '%'
                              : 'cm',
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMeasurementChip(String label, double value, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementChangesCard(Map<String, double> changes) {
    final filteredChanges =
        changes.entries.where((e) => e.value != 0).toList();

    if (filteredChanges.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CHANGES SINCE START',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          ...filteredChanges.map((entry) {
            final isPositive = entry.value > 0;
            final isGood =
                entry.key.toLowerCase() == 'waist' ? !isPositive : isPositive;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        size: 16,
                        color: isGood
                            ? AppColors.cyberLime
                            : AppColors.neonCrimson,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${isPositive ? '+' : ''}${entry.value.toStringAsFixed(1)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isGood
                              ? AppColors.cyberLime
                              : AppColors.neonCrimson,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildProgressPhotosGrid(List<ProgressPhoto> photos) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PROGRESS PHOTOS',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length.clamp(0, 10),
              itemBuilder: (context, index) {
                final photo = photos[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          File(photo.imagePath),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.white.withOpacity(0.1),
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.white.withOpacity(0.3),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  photo.typeDisplayName,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  _formatDateShort(photo.date),
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
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

  Widget _buildEmptyBodyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.neonPurple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.straighten,
                color: AppColors.neonPurple,
                size: 64,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Track Your Progress',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Add body measurements and progress photos to visualize your transformation over time.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white.withOpacity(0.5),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () async {
                final result = await MeasurementsInputScreen.show(context);
                if (result == true) {
                  _refreshAnalytics();
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.neonPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.neonPurple,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: AppColors.neonPurple,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add Measurement',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: AppColors.neonPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VIDS TAB
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildVidsContent() {
    return const MyVideosView();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  String _formatDateShort(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PRESSABLE TAB — Scale animation + haptic feedback
// ═══════════════════════════════════════════════════════════════════════════════

class _PressableTab extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _PressableTab({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_PressableTab> createState() => _PressableTabState();
}

class _PressableTabState extends State<_PressableTab> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.cyberLime
                : _isPressed
                    ? Colors.white.withOpacity(0.08)
                    : const Color(0xFF141414),
            borderRadius: BorderRadius.circular(12),
            border: widget.isActive
                ? null
                : Border.all(
                    color: Colors.white.withOpacity(0.04),
                    width: 1,
                  ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: widget.isActive
                  ? Colors.black
                  : Colors.white.withOpacity(0.5),
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// PRESSABLE ICON — Scale animation for icon buttons
// ═══════════════════════════════════════════════════════════════════════════════

class _PressableIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _PressableIcon({required this.icon, required this.onTap});

  @override
  State<_PressableIcon> createState() => _PressableIconState();
}

class _PressableIconState extends State<_PressableIcon> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.88 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isPressed
                ? Colors.white.withOpacity(0.08)
                : const Color(0xFF141414),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.04),
              width: 1,
            ),
          ),
          child: Icon(
            widget.icon,
            color: Colors.white.withOpacity(0.4),
            size: 20,
          ),
        ),
      ),
    );
  }
}
