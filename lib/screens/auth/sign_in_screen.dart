import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';

/// ═══════════════════════════════════════════════════════════════════════════════
/// SIGN IN SCREEN - Clean, minimal
/// ═══════════════════════════════════════════════════════════════════════════════
/// For now: just a Continue button that skips to the next screen.
/// Later: Google Sign-In, Apple Sign-In, email.
/// ═══════════════════════════════════════════════════════════════════════════════

class SignInScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const SignInScreen({super.key, required this.onContinue});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _fadeController,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const Spacer(flex: 3),

                // ═══════════════════════════════════════════
                // LOGO
                // ═══════════════════════════════════════════
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.cyberLime.withOpacity(0.2),
                        AppColors.cyberLime.withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo/skeletal_logo.png',
                      height: 60,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Text('\u{1F480}', style: TextStyle(fontSize: 48)),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // ═══════════════════════════════════════════
                // TITLE
                // ═══════════════════════════════════════════
                Text(
                  'SKELETAL-PT',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppColors.cyberLime,
                    letterSpacing: 4,
                    decoration: TextDecoration.none,
                    shadows: [
                      Shadow(
                        color: AppColors.cyberLime.withOpacity(0.4),
                        blurRadius: 24,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Your AI Personal Trainer',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.45),
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),

                const Spacer(flex: 2),

                // ═══════════════════════════════════════════
                // SIGN IN BUTTONS (disabled for now)
                // ═══════════════════════════════════════════

                // Google Sign In (disabled — placeholder)
                _signInButton(
                  icon: Icons.g_mobiledata,
                  label: 'Continue with Google',
                  enabled: false,
                ),

                const SizedBox(height: 12),

                // Apple Sign In (disabled — placeholder)
                _signInButton(
                  icon: Icons.apple,
                  label: 'Continue with Apple',
                  enabled: false,
                ),

                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.white15)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.3),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.white15)),
                  ],
                ),

                const SizedBox(height: 24),

                // Continue button (WORKS — skips auth)
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      HapticFeedback.mediumImpact();
                      widget.onContinue();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cyberLime,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'CONTINUE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 1),

                // Legal
                Text(
                  'By continuing you agree to our Terms of Service\nand Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.white.withOpacity(0.2),
                    height: 1.5,
                    decoration: TextDecoration.none,
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButton({
    required IconData icon,
    required String label,
    required bool enabled,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: enabled
            ? () {
                HapticFeedback.mediumImpact();
                // TODO: Auth logic
              }
            : null,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: enabled ? AppColors.white30 : AppColors.white10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          backgroundColor: AppColors.white5,
          disabledForegroundColor: AppColors.white30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: enabled ? Colors.white : AppColors.white30),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: enabled ? Colors.white : AppColors.white30,
              ),
            ),
            if (!enabled) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.white10,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'SOON',
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: AppColors.white40, letterSpacing: 1),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
