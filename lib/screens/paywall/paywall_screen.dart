import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';

/// ═══════════════════════════════════════════════════════════════════════════════
/// PAYWALL SCREEN - Premium Upgrade
/// ═══════════════════════════════════════════════════════════════════════════════
/// Clean modal-style paywall. Black + cyber lime. No fluff.
/// For now: user skips past. Later: RevenueCat integration.
/// ═══════════════════════════════════════════════════════════════════════════════

class PaywallScreen extends StatefulWidget {
  /// If true, shows as a full screen (e.g. from onboarding).
  /// If false, shows with X close button (e.g. from settings/feature gate).
  final bool fullScreen;

  const PaywallScreen({super.key, this.fullScreen = false});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> with SingleTickerProviderStateMixin {
  int _selectedPlan = 1; // 0 = monthly, 1 = yearly (default yearly)
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _subscribe() {
    HapticFeedback.heavyImpact();
    // TODO: RevenueCat purchase logic
    // For now, just close
    Navigator.of(context).pop();
  }

  void _restore() {
    HapticFeedback.mediumImpact();
    // TODO: RevenueCat restore
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Restore coming soon'),
        backgroundColor: AppColors.cyberLime,
      ),
    );
  }

  void _skip() {
    HapticFeedback.lightImpact();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _fadeController,
        child: SafeArea(
          child: Column(
            children: [
              // Close / Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12, right: 16),
                  child: GestureDetector(
                    onTap: _skip,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white10,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.close, color: AppColors.white60, size: 20),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      const Spacer(flex: 1),

                      // ═══════════════════════════════════════════
                      // ICON
                      // ═══════════════════════════════════════════
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              AppColors.cyberLime.withOpacity(0.25),
                              AppColors.cyberLime.withOpacity(0.05),
                              Colors.transparent,
                            ],
                          ),
                          border: Border.all(
                            color: AppColors.cyberLime.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo/skeletal_logo.png',
                            height: 40,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Text('💀', style: TextStyle(fontSize: 32)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ═══════════════════════════════════════════
                      // TITLE
                      // ═══════════════════════════════════════════
                      const Text(
                        'UNLOCK PRO',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 3,
                          decoration: TextDecoration.none,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'AI-powered training.\nZero limits.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.5),
                          height: 1.5,
                          decoration: TextDecoration.none,
                        ),
                      ),

                      const SizedBox(height: 36),

                      // ═══════════════════════════════════════════
                      // FEATURES
                      // ═══════════════════════════════════════════
                      _featureRow(Icons.videocam_outlined, 'AI camera tracking'),
                      const SizedBox(height: 16),
                      _featureRow(Icons.wifi_off_outlined, 'Fully offline experience'),
                      const SizedBox(height: 16),
                      _featureRow(Icons.fitness_center, '500+ exercises supported'),
                      const SizedBox(height: 16),
                      _featureRow(Icons.share_outlined, 'Shareable skeleton clips'),

                      const SizedBox(height: 40),

                      // ═══════════════════════════════════════════
                      // PLAN SELECTOR
                      // ═══════════════════════════════════════════
                      Row(
                        children: [
                          Expanded(child: _planCard(
                            index: 0,
                            label: 'Monthly',
                            price: '\u00A32.99',
                            sub: 'per month',
                          )),
                          const SizedBox(width: 12),
                          Expanded(child: _planCard(
                            index: 1,
                            label: 'Yearly',
                            price: '\u00A319.99',
                            sub: 'Save 44%',
                            badge: 'BEST VALUE',
                          )),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ═══════════════════════════════════════════
                      // SUBSCRIBE BUTTON
                      // ═══════════════════════════════════════════
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _subscribe,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.cyberLime,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'SUBSCRIBE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Restore
                      GestureDetector(
                        onTap: _restore,
                        child: Text(
                          'Restore Purchase',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.4),
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white.withOpacity(0.2),
                          ),
                        ),
                      ),

                      const Spacer(flex: 2),

                      // Legal
                      Text(
                        'Cancel anytime. Auto-renews until cancelled.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white.withOpacity(0.2),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _featureRow(IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.cyberLime.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.cyberLime.withOpacity(0.2)),
          ),
          child: Icon(icon, color: AppColors.cyberLime, size: 20),
        ),
        const SizedBox(width: 14),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ],
    );
  }

  Widget _planCard({
    required int index,
    required String label,
    required String price,
    required String sub,
    String? badge,
  }) {
    final selected = _selectedPlan == index;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        setState(() => _selectedPlan = index);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            decoration: BoxDecoration(
              color: selected ? AppColors.cyberLime.withOpacity(0.08) : AppColors.white5,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? AppColors.cyberLime : AppColors.white15,
                width: selected ? 2 : 1,
              ),
              boxShadow: selected
                  ? [BoxShadow(color: AppColors.cyberLime.withOpacity(0.1), blurRadius: 20)]
                  : null,
            ),
            child: Column(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: selected ? AppColors.cyberLime : AppColors.white60,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: selected ? Colors.white : AppColors.white60,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  sub,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: selected && badge != null ? AppColors.cyberLime : AppColors.white40,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          if (badge != null)
            Positioned(
              top: -10,
              left: 0, right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.cyberLime,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      letterSpacing: 1,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
