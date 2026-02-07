import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';
import 'form_check_achievement_service.dart';
import 'achievement_widgets.dart';

/// =============================================================================
/// ACHIEVEMENTS SCREEN - Trophy Room
/// =============================================================================
/// Shows all unlocked and locked achievements.
/// Access from Profile tab or Form Check results.
/// =============================================================================

class FormCheckAchievementsScreen extends StatefulWidget {
  const FormCheckAchievementsScreen({super.key});

  @override
  State<FormCheckAchievementsScreen> createState() => _FormCheckAchievementsScreenState();
}

class _FormCheckAchievementsScreenState extends State<FormCheckAchievementsScreen> {
  List<FormAchievement> _allAchievements = [];
  List<FormAchievement> _unlockedAchievements = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAchievements();
  }

  Future<void> _loadAchievements() async {
    setState(() => _isLoading = true);
    
    final allAchievements = FormCheckAchievementService.getAllAchievements();
    final unlocked = await FormCheckAchievementService.getUnlockedAchievements();
    
    setState(() {
      _allAchievements = allAchievements;
      _unlockedAchievements = unlocked;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final unlockedCount = _unlockedAchievements.length;
    final totalCount = _allAchievements.length;
    final progressPercent = totalCount > 0 ? (unlockedCount / totalCount * 100).toInt() : 0;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'ACHIEVEMENTS',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.cyberLime),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Card
                  _buildProgressCard(unlockedCount, totalCount, progressPercent),
                  
                  const SizedBox(height: 24),
                  
                  // Rarity Filters (Optional)
                  _buildRarityTabs(),
                  
                  const SizedBox(height: 16),
                  
                  // Achievements Grid
                  AchievementsGrid(
                    allAchievements: _allAchievements,
                    unlockedAchievements: _unlockedAchievements,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProgressCard(int unlocked, int total, int percent) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.cyberLime.withOpacity(0.2),
            AppColors.electricCyan.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.cyberLime.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'COMPLETION',
                    style: TextStyle(
                      color: AppColors.white60,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$unlocked / $total',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.cyberLime,
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$percent%',
                    style: const TextStyle(
                      color: AppColors.cyberLime,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: unlocked / total,
              minHeight: 8,
              backgroundColor: AppColors.white10,
              valueColor: const AlwaysStoppedAnimation(AppColors.cyberLime),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRarityTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildRarityChip('All', AppColors.white70, true),
          const SizedBox(width: 8),
          _buildRarityChip('Common', const Color(0xFF888888), false),
          const SizedBox(width: 8),
          _buildRarityChip('Rare', const Color(0xFF00F0FF), false),
          const SizedBox(width: 8),
          _buildRarityChip('Epic', const Color(0xFFAA66FF), false),
          const SizedBox(width: 8),
          _buildRarityChip('Legendary', const Color(0xFFCCFF00), false),
        ],
      ),
    );
  }

  Widget _buildRarityChip(String label, Color color, bool isSelected) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        // TODO: Implement filtering
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : AppColors.white30,
            width: 1.5,
          ),
        ),
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            color: isSelected ? color : AppColors.white60,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
