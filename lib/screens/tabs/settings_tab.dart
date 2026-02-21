import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_review/in_app_review.dart';
import '../../utils/app_colors.dart';
import 'settings_detail_screens.dart';
import '../../services/firebase_analytics_service.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAnalyticsService().logScreenView(screenName: 'settings', screenClass: 'SettingsTab');
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100, left: 20, right: 20, top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ═══════════════════════════════════════════
              // HEADER: Back button + Title
              // ═══════════════════════════════════════════
              Row(
                children: [
                  Text(
                    'Settings',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ═══════════════════════════════════════════
              // PROFILE
              // ═══════════════════════════════════════════
              _buildSectionHeader('PROFILE'),
              const SizedBox(height: 12),
              _buildSettingsCard(
                context,
                items: [
                  _SettingsItem(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    subtitle: 'Name, age, fitness goals',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // TODO: Navigate to edit profile
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.fitness_center,
                    title: 'Fitness Preferences',
                    subtitle: 'Equipment, experience level',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // TODO: Navigate to fitness preferences
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ═══════════════════════════════════════════
              // APP SETTINGS (Voice Coach REMOVED)
              // ═══════════════════════════════════════════
              _buildSectionHeader('APP SETTINGS'),
              const SizedBox(height: 12),
              _buildSettingsCard(
                context,
                items: [
                  _SettingsItem(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    subtitle: 'Workout reminders, streak alerts',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const NotificationSettingsScreen(),
                        ),
                      );
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.vibration,
                    title: 'Haptics',
                    subtitle: 'Vibration feedback',
                    trailing: const _HapticToggle(),
                    onTap: null,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ═══════════════════════════════════════════
              // DATA & STORAGE
              // ═══════════════════════════════════════════
              _buildSectionHeader('DATA & STORAGE'),
              const SizedBox(height: 12),
              _buildSettingsCard(
                context,
                items: [
                  _SettingsItem(
                    icon: Icons.download_outlined,
                    title: 'Export Data',
                    subtitle: 'Download your workout history',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // TODO: Export CSV
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Export coming soon'),
                          backgroundColor: AppColors.cyberLime,
                        ),
                      );
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.upload_outlined,
                    title: 'Import Data',
                    subtitle: 'Import from CSV file',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // TODO: Import CSV
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Import coming soon'),
                          backgroundColor: AppColors.cyberLime,
                        ),
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ═══════════════════════════════════════════
              // LEGAL
              // ═══════════════════════════════════════════
              _buildSectionHeader('LEGAL'),
              const SizedBox(height: 12),
              _buildSettingsCard(
                context,
                items: [
                  _SettingsItem(
                    icon: Icons.description_outlined,
                    title: 'Terms of Service',
                    subtitle: 'Read our terms',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const TermsOfServiceScreen(),
                        ),
                      );
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    subtitle: 'How we handle your data',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.gavel_outlined,
                    title: 'Licenses',
                    subtitle: 'Open source licenses',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      showLicensePage(
                        context: context,
                        applicationName: 'Skeletal-PT',
                        applicationVersion: '1.0.0',
                        applicationLegalese: '© 2026 Skeletal-PT. All rights reserved.',
                      );
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ═══════════════════════════════════════════
              // ABOUT
              // ═══════════════════════════════════════════
              _buildSectionHeader('ABOUT'),
              const SizedBox(height: 12),
              _buildSettingsCard(
                context,
                items: [
                  _SettingsItem(
                    icon: Icons.info_outline,
                    title: 'About Skeletal-PT',
                    subtitle: 'Version 1.0.0',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AboutScreen(),
                        ),
                      );
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'Get help with the app',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      // TODO: Navigate to help
                    },
                  ),
                  _SettingsItem(
                    icon: Icons.rate_review_outlined,
                    title: 'Rate Us',
                    subtitle: 'Leave a review',
                    onTap: () async {
                      HapticFeedback.lightImpact();
                      final inAppReview = InAppReview.instance;
                      if (await inAppReview.isAvailable()) {
                        inAppReview.requestReview();
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ═══════════════════════════════════════════
              // DANGER ZONE
              // ═══════════════════════════════════════════
              _buildSectionHeader('DANGER ZONE'),
              const SizedBox(height: 12),
              _buildSettingsCard(
                context,
                items: [
                  _SettingsItem(
                    icon: Icons.logout,
                    title: 'Sign Out',
                    subtitle: 'Log out of your account',
                    onTap: () {
                      HapticFeedback.lightImpact();
                      _showSignOutDialog(context);
                    },
                    textColor: AppColors.neonCrimson,
                  ),
                  _SettingsItem(
                    icon: Icons.warning_outlined,
                    title: 'Delete Account',
                    subtitle: 'Permanently delete your account',
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      _showDeleteAccountDialog(context);
                    },
                    textColor: AppColors.neonCrimson,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ═══════════════════════════════════════════
              // FOOTER — NO yellow underlines
              // ═══════════════════════════════════════════
              Center(
                child: Column(
                  children: [
                    Text(
                      'Skeletal-PT',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: AppColors.cyberLime,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Version 1.0.0 (Build 1)',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.white40,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '© 2026 All Rights Reserved',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.white30,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SHARED WIDGETS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
        color: AppColors.white50,
        letterSpacing: 2,
        decoration: TextDecoration.none,
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required List<_SettingsItem> items}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white5,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white10),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == items.length - 1;

          return Column(
            children: [
              GestureDetector(
                onTap: item.onTap,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.white10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          item.icon,
                          color: item.textColor ?? AppColors.white60,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: item.textColor ?? Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            if (item.subtitle != null)
                              Text(
                                item.subtitle!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.white40,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                          ],
                        ),
                      ),
                      item.trailing ?? Icon(
                        Icons.chevron_right,
                        color: AppColors.white30,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Divider(height: 1, color: AppColors.white10),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.slate900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Sign Out?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        content: const Text(
          'Are you sure you want to sign out?',
          style: TextStyle(color: AppColors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.white60)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement sign out when auth is built
              HapticFeedback.mediumImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Sign out coming soon — no auth yet'),
                  backgroundColor: AppColors.cyberLime,
                ),
              );
            },
            child: const Text('Sign Out', style: TextStyle(color: AppColors.neonCrimson)),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.slate900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.neonCrimson, width: 2),
        ),
        title: const Text(
          '⚠️ Delete Account?',
          style: TextStyle(color: AppColors.neonCrimson, fontWeight: FontWeight.w900),
        ),
        content: const Text(
          'This action is PERMANENT and cannot be undone. All your workout data, progress, and stats will be deleted forever.',
          style: TextStyle(color: AppColors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.white60)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement account deletion when auth is built
              HapticFeedback.heavyImpact();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account deletion coming soon — no auth yet'),
                  backgroundColor: AppColors.neonCrimson,
                ),
              );
            },
            child: const Text('Delete Forever', style: TextStyle(color: AppColors.neonCrimson, fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER CLASSES
// ═══════════════════════════════════════════════════════════════════════════════

class _SettingsItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? textColor;

  const _SettingsItem({
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.textColor,
  });
}

class _HapticToggle extends StatefulWidget {
  const _HapticToggle();

  @override
  State<_HapticToggle> createState() => _HapticToggleState();
}

class _HapticToggleState extends State<_HapticToggle> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _enabled,
      onChanged: (value) {
        setState(() => _enabled = value);
        if (value) HapticFeedback.lightImpact();
      },
      activeColor: AppColors.cyberLime,
      activeTrackColor: AppColors.cyberLime.withOpacity(0.3),
    );
  }
}
