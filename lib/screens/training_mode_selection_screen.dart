import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../models/workout_models.dart';

/// 🔥 Mode selection screen - Choose Auto AI or Manual training
class TrainingModeSelectionScreen extends StatelessWidget {
  final LockedWorkout? workout;

  const TrainingModeSelectionScreen({
    super.key,
    this.workout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Title
                const Text(
                  'READY TO TRAIN?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 12),
                
                if (workout != null) ...[
                  Text(
                    workout!.name.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.cyberLime,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    '${workout!.exercises.length} exercises • ${workout!.exercises.fold<int>(0, (sum, ex) => sum + ex.sets)} sets',
                    style: const TextStyle(
                      color: AppColors.white60,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                
                const SizedBox(height: 40),
              
              // Mode buttons - conditionally show based on isManualOnly
              if (workout?.isManualOnly != true) ...[
                // Show AI Rep Counter only for non-manual workouts
                _buildModeButton(
                  context: context,
                  icon: Icons.videocam,
                  title: 'AI REP COUNTER',
                  subtitle: 'Auto Tracking',
                  description: 'Camera counts your reps automatically\nVoice coaching • No logging needed',
                  gradient: const LinearGradient(
                    colors: [AppColors.cyberLime, AppColors.cyberLime],
                  ),
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Navigator.of(context).pop('auto');
                  },
                ),
                
                const SizedBox(height: 20),
              ],
              
              _buildModeButton(
                context: context,
                icon: Icons.ondemand_video,
                title: 'VISUAL GUIDE',
                subtitle: 'Exercise-by-Exercise',
                description: 'Large GIF shows perfect form\nLog as you go • Quick & focused',
                gradient: LinearGradient(
                  colors: [
                    AppColors.neonCrimson.withOpacity(0.8),
                    const Color(0xFFFF6B35),
                  ],
                ),
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.of(context).pop('manual');
                },
              ),
              
              const SizedBox(height: 20),
              
              _buildModeButton(
                context: context,
                icon: Icons.analytics,
                title: 'PRO LOGGER',
                subtitle: 'Detailed Manual Logger',
                description: 'See all exercises at once\nTrack progress • Analytics & PRs',
                gradient: const LinearGradient(
                  colors: [Color(0xFFCCFF00), Color(0xFFCCFF00)],
                ),
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.of(context).pop('hevy_manual');
                },
              ),
              
              const SizedBox(height: 40),
              
              // Tip - only show for AI-enabled workouts
              if (workout?.isManualOnly != true)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white5,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.white10),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: AppColors.cyberLime.withOpacity(0.7),
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Tip: AI Rep Counter works best in good lighting with full body visible',
                          style: TextStyle(
                            color: AppColors.white60,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              
              const SizedBox(height: 24),
            ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

