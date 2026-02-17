import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/app_colors.dart';
import '../../../services/storage_service.dart';
import '../analytics/models/analytics_data.dart';
import '../analytics/services/analytics_service.dart';
import '../analytics/widgets/hero_stats_card.dart';
import '../analytics/widgets/workout_heatmap_widget.dart';
import '../analytics/widgets/charts_widget.dart';
import '../analytics/widgets/pr_timeline_widget.dart';
import '../analytics/widgets/form_analytics_widget.dart';
import '../analytics/screens/measurements_input_screen.dart';
import '../../screens/tabs/settings_tab.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// PROFILE ANALYTICS VIEW - The Ultimate Fitness Dashboard
/// ═══════════════════════════════════════════════════════════════════════════
/// Features:
/// - Beautiful tab navigation (Overview, Strength, Form, Body)
/// - Pull to refresh
/// - Period selector
/// - Stunning animations throughout
/// ═══════════════════════════════════════════════════════════════════════════

class ProfileAnalyticsView extends StatefulWidget {
  const ProfileAnalyticsView({super.key});

  @override
  State<ProfileAnalyticsView> createState() => _ProfileAnalyticsViewState();
}

class _ProfileAnalyticsViewState extends State<ProfileAnalyticsView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _refreshController;
  
  AnalyticsData? _analyticsData;
  AnalyticsPeriod _selectedPeriod = AnalyticsPeriod.allTime;
  bool _isLoading = true;
  String _userName = 'Champion';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _loadUserData();
    _loadAnalytics();
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
    _refreshController.repeat();
    
    await _loadAnalytics();
    
    _refreshController.stop();
    HapticFeedback.mediumImpact();
  }

  void _onPeriodChanged(AnalyticsPeriod period) {
    HapticFeedback.selectionClick();
    setState(() {
      _selectedPeriod = period;
      _isLoading = true;
    });
    _loadAnalytics();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab Bar
        _buildTabBar(),
        
        const SizedBox(height: 8),
        
        // Content (scrollable)
        Expanded(
          child: _isLoading
              ? _buildLoadingState()
              : RefreshIndicator(
                  onRefresh: _refreshAnalytics,
                  color: AppColors.cyberLime,
                  backgroundColor: const Color(0xFF1A1A2E),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOverviewTab(),
                      _buildStrengthTab(),
                      _buildFormTab(),
                      _buildBodyTab(),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: AnalyticsPeriod.values.map((period) {
          final isSelected = _selectedPeriod == period;
          
          return GestureDetector(
            onTap: () => _onPeriodChanged(period),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.cyberLime.withOpacity(0.2)
                    : Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? AppColors.cyberLime
                      : Colors.white.withOpacity(0.1),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Text(
                period.displayName,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: isSelected
                      ? AppColors.cyberLime
                      : Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.cyberLime,
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab, // Make indicator fill the full tab
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white.withOpacity(0.5),
        labelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.8,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
        dividerColor: Colors.transparent,
        labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        tabs: const [
          Tab(text: 'OVERVIEW'),
          Tab(text: 'STRENGTH'),
          Tab(text: 'FORM'),
          Tab(text: 'BODY'),
        ],
      ),
    );
  }

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

  /// ═══════════════════════════════════════════════════════════════════════════
  /// OVERVIEW TAB
  /// ═══════════════════════════════════════════════════════════════════════════
  Widget _buildOverviewTab() {
    final data = _analyticsData!;
    
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        const SizedBox(height: 8),
        
        // Period Selector
        _buildPeriodSelector(),
        
        const SizedBox(height: 8),
        
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
    );
  }

  /// ═══════════════════════════════════════════════════════════════════════════
  /// STRENGTH TAB
  /// ═══════════════════════════════════════════════════════════════════════════
  Widget _buildStrengthTab() {
    final data = _analyticsData!;
    
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        const SizedBox(height: 8),
        
        // Period Selector
        _buildPeriodSelector(),
        
        const SizedBox(height: 8),
        
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
    );
  }

  /// ═══════════════════════════════════════════════════════════════════════════
  /// FORM TAB (Camera Mode Users Only)
  /// ═══════════════════════════════════════════════════════════════════════════
  Widget _buildFormTab() {
    final data = _analyticsData!;
    
    if (!data.hasFormData) {
      return _buildEmptyFormState();
    }
    
    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        const SizedBox(height: 8),
        
        // Period Selector
        _buildPeriodSelector(),
        
        const SizedBox(height: 8),
        
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

  /// ═══════════════════════════════════════════════════════════════════════════
  /// BODY TAB
  /// ═══════════════════════════════════════════════════════════════════════════
  Widget _buildBodyTab() {
    final data = _analyticsData!;
    
    if (!data.hasMeasurements) {
      return _buildEmptyBodyState();
    }
    
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            const SizedBox(height: 8),
            
            // Period Selector
            _buildPeriodSelector(),
            
            const SizedBox(height: 8),
            
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
        
        // PERMANENT ADD MEASUREMENT BUTTON (FLOATING)
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
                
                // Measurements Grid
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: measurements.entries.map((entry) {
                    return _buildMeasurementChip(
                      entry.key,
                      entry.value,
                      entry.key == 'Weight' ? 'kg' : 
                      entry.key == 'Body Fat' ? '%' : 'cm',
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
    final filteredChanges = changes.entries
        .where((e) => e.value != 0)
        .toList();
    
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
            final isGood = entry.key.toLowerCase() == 'waist' 
                ? !isPositive 
                : isPositive;
            
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
                        color: isGood ? AppColors.cyberLime : AppColors.neonCrimson,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${isPositive ? '+' : ''}${entry.value.toStringAsFixed(1)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isGood ? AppColors.cyberLime : AppColors.neonCrimson,
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

  String _formatDateShort(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day}';
  }
  
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cyberLime.withOpacity(0.15),
            AppColors.cyberLime.withOpacity(0.05),
          ],
        ),
      ),
      child: Column(
        children: [
          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PROFILE',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _userName,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              // Settings button
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsTab(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Segment toggle
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    decoration: BoxDecoration(
                      color: AppColors.cyberLime,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.insights,
                          size: 18,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'ANALYTICS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.video_library,
                          size: 18,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'MY VIDEOS',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
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

  @override
  void dispose() {
    _tabController.dispose();
    _refreshController.dispose();
    super.dispose();
  }
}
