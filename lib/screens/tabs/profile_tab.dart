import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/app_colors.dart';
import '../../services/storage_service.dart';
import '../../features/profile/profile_analytics_view.dart';
import '../../features/profile/my_videos_view.dart';
import '../../features/analytics/screens/measurements_input_screen.dart';
import '../tabs/settings_tab.dart';

/// =============================================================================
/// PROFILE TAB - Analytics & Workout Recordings
/// =============================================================================
/// Beautiful profile with toggle between Analytics dashboard and My Videos
/// =============================================================================

class ProfileTab extends ConsumerStatefulWidget {
  const ProfileTab({super.key});

  @override
  ConsumerState<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<ProfileTab> {
  String _userName = 'Champion';
  // 0 = Analytics, 1 = My Videos
  int _selectedSegment = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await StorageService.getUserName();
    if (mounted) {
      setState(() {
        _userName = name ?? 'Champion';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: _buildHeader(),
              ),
            ];
          },
          body: _selectedSegment == 0
              ? const ProfileAnalyticsView() // New analytics
              : const MyVideosView(), // Existing videos
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
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
          Row(
            children: [
              Expanded(
                child: _buildSegmentToggle(),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.push(
                    context,
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
        ],
      ),
    );
  }

  Widget _buildSegmentToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildSegmentButton(
              index: 0,
              label: 'ANALYTICS',
              icon: Icons.insights,
            ),
          ),
          Expanded(
            child: _buildSegmentButton(
              index: 1,
              label: 'MY VIDEOS',
              icon: Icons.video_library,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton({
    required int index,
    required String label,
    required IconData icon,
  }) {
    final isSelected = _selectedSegment == index;
    
    return GestureDetector(
      onTap: () {
        if (_selectedSegment != index) {
          HapticFeedback.selectionClick();
          setState(() => _selectedSegment = index);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.cyberLime
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? Colors.black
                  : Colors.white.withOpacity(0.5),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                color: isSelected
                    ? Colors.black
                    : Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

