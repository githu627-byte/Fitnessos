import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';
import 'form_check_achievement_service.dart';

/// =============================================================================
/// ACHIEVEMENT UNLOCKED POPUP
/// =============================================================================
/// Beautiful animated popup that shows when user unlocks a new achievement.
/// Features:
/// - Dramatic entrance animation
/// - Particle effects
/// - Gradient glow based on rarity
/// - Auto-dismiss with manual dismiss option
/// =============================================================================

class AchievementUnlockedPopup extends StatefulWidget {
  final FormAchievement achievement;
  final VoidCallback? onDismiss;
  final VoidCallback? onShare;
  
  const AchievementUnlockedPopup({
    super.key,
    required this.achievement,
    this.onDismiss,
    this.onShare,
  });
  
  /// Show the popup as an overlay
  static void show(
    BuildContext context, 
    FormAchievement achievement, {
    VoidCallback? onShare,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    
    entry = OverlayEntry(
      builder: (context) => AchievementUnlockedPopup(
        achievement: achievement,
        onDismiss: () => entry.remove(),
        onShare: onShare,
      ),
    );
    
    overlay.insert(entry);
    
    // Auto dismiss after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (entry.mounted) {
        entry.remove();
      }
    });
  }
  
  /// Show multiple achievements in sequence
  static void showMultiple(
    BuildContext context,
    List<FormAchievement> achievements, {
    VoidCallback? onShare,
  }) async {
    for (final achievement in achievements) {
      show(context, achievement, onShare: onShare);
      await Future.delayed(const Duration(milliseconds: 800));
    }
  }
  
  @override
  State<AchievementUnlockedPopup> createState() => _AchievementUnlockedPopupState();
}

class _AchievementUnlockedPopupState extends State<AchievementUnlockedPopup> 
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _glowController;
  late AnimationController _particleController;
  
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  
  @override
  void initState() {
    super.initState();
    
    // Slide animation
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    
    _slideAnimation = Tween<double>(begin: -200, end: 0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
    );
    
    // Glow animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    
    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    
    // Particle animation
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    
    // Start animations
    _slideController.forward();
    
    // Haptic feedback
    HapticFeedback.heavyImpact();
  }
  
  @override
  void dispose() {
    _slideController.dispose();
    _glowController.dispose();
    _particleController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final info = FormCheckAchievementService.getAchievementInfo(widget.achievement);
    
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: AnimatedBuilder(
            animation: Listenable.merge([_slideController, _glowController]),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _slideAnimation.value),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: _buildCard(info),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
  Widget _buildCard(AchievementInfo info) {
    return GestureDetector(
      onTap: widget.onDismiss,
      child: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A2E), Color(0xFF0A0A0A)],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: info.color.withOpacity(0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: info.color.withOpacity(_glowAnimation.value * 0.5),
              blurRadius: 40,
              spreadRadius: 5,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Particle effects
            if (info.rarity == AchievementRarity.legendary || 
                info.rarity == AchievementRarity.epic)
              _buildParticles(info.color),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  // Icon
                  _buildIcon(info),
                  const SizedBox(width: 16),
                  
                  // Text
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // "Achievement Unlocked" label
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [info.color, info.color.withOpacity(0.7)],
                          ).createShader(bounds),
                          child: const Text(
                            'ACHIEVEMENT UNLOCKED',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        
                        // Title
                        Text(
                          info.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        
                        // Description
                        Text(
                          info.description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Share button (optional)
                  if (widget.onShare != null)
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        widget.onShare?.call();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: info.color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.share,
                          color: info.color,
                          size: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildIcon(AchievementInfo info) {
    return AnimatedBuilder(
      animation: _glowController,
      builder: (context, child) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                info.color.withOpacity(0.3),
                info.color.withOpacity(0.1),
              ],
            ),
            border: Border.all(
              color: info.color.withOpacity(_glowAnimation.value),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: info.color.withOpacity(_glowAnimation.value * 0.5),
                blurRadius: 20,
              ),
            ],
          ),
          child: Center(
            child: Text(
              info.icon,
              style: const TextStyle(fontSize: 28),
            ),
          ),
        );
      },
    );
  }
  
  Widget _buildParticles(Color color) {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          painter: _ParticlePainter(
            progress: _particleController.value,
            color: color,
          ),
          child: Container(),
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final double progress;
  final Color color;
  final int particleCount = 12;
  
  _ParticlePainter({required this.progress, required this.color});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.fill;
    
    final random = math.Random(42); // Fixed seed for consistent particles
    
    for (var i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * math.pi + progress * 2 * math.pi;
      final radius = 20 + random.nextDouble() * 30 + math.sin(progress * math.pi * 2 + i) * 10;
      final particleSize = 2 + random.nextDouble() * 3;
      
      final x = size.width / 2 + math.cos(angle) * radius * (1 + progress * 0.5);
      final y = size.height / 2 + math.sin(angle) * radius * 0.5;
      
      paint.color = color.withOpacity((1 - progress) * 0.6);
      canvas.drawCircle(Offset(x, y), particleSize, paint);
    }
  }
  
  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

/// =============================================================================
/// ACHIEVEMENT BADGE WIDGET
/// =============================================================================
/// Small badge to display achievements in lists or grids
/// =============================================================================

class AchievementBadge extends StatelessWidget {
  final FormAchievement achievement;
  final bool isUnlocked;
  final bool showDescription;
  final VoidCallback? onTap;
  
  const AchievementBadge({
    super.key,
    required this.achievement,
    this.isUnlocked = true,
    this.showDescription = true,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final info = FormCheckAchievementService.getAchievementInfo(achievement);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnlocked 
              ? info.color.withOpacity(0.1) 
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isUnlocked 
                ? info.color.withOpacity(0.3) 
                : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isUnlocked 
                    ? info.color.withOpacity(0.2) 
                    : Colors.white.withOpacity(0.1),
              ),
              child: Center(
                child: Text(
                  isUnlocked ? info.icon : '🔒',
                  style: TextStyle(
                    fontSize: 24,
                    color: isUnlocked ? null : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Title
            Text(
              info.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: isUnlocked ? Colors.white : Colors.white.withOpacity(0.4),
              ),
              textAlign: TextAlign.center,
            ),
            
            if (showDescription) ...[
              const SizedBox(height: 4),
              Text(
                info.description,
                style: TextStyle(
                  fontSize: 11,
                  color: isUnlocked 
                      ? Colors.white.withOpacity(0.6) 
                      : Colors.white.withOpacity(0.3),
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            
            // Rarity indicator
            if (isUnlocked) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: info.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  info.rarity.name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w800,
                    color: info.color,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// =============================================================================
/// ACHIEVEMENTS GRID
/// =============================================================================
/// Grid view of all achievements with unlock status
/// =============================================================================

class AchievementsGrid extends StatelessWidget {
  final List<FormAchievement> unlockedAchievements;
  final Function(FormAchievement)? onAchievementTap;
  
  const AchievementsGrid({
    super.key,
    required this.unlockedAchievements,
    this.onAchievementTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: FormAchievement.values.length,
      itemBuilder: (context, index) {
        final achievement = FormAchievement.values[index];
        final isUnlocked = unlockedAchievements.contains(achievement);
        
        return AchievementBadge(
          achievement: achievement,
          isUnlocked: isUnlocked,
          onTap: () => onAchievementTap?.call(achievement),
        );
      },
    );
  }
}

/// =============================================================================
/// NEW ACHIEVEMENT CHIP
/// =============================================================================
/// Small chip to show in session summary for new achievements
/// =============================================================================

class NewAchievementChip extends StatelessWidget {
  final FormAchievement achievement;
  
  const NewAchievementChip({
    super.key,
    required this.achievement,
  });
  
  @override
  Widget build(BuildContext context) {
    final info = FormCheckAchievementService.getAchievementInfo(achievement);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            info.color.withOpacity(0.2),
            info.color.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: info.color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(info.icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            info.title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: info.color,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: info.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              'NEW',
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
