import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ═══════════════════════════════════════════════════════════════════════════════
/// PAYWALL SCREEN - Elite Black + Cyber Lime
/// ═══════════════════════════════════════════════════════════════════════════════
/// Shows free vs PRO features, monthly/yearly toggle, subscribe button,
/// restore purchase. For now: user can dismiss and gets free features.
/// Real payments (RevenueCat) wired up later.
/// ═══════════════════════════════════════════════════════════════════════════════

class PaywallScreen extends StatefulWidget {
  /// Product IDs for RevenueCat / in_app_purchase
  static const String monthlyProductId = 'skeletal_pro_monthly';
  static const String yearlyProductId = 'skeletal_pro_yearly';

  final bool showCloseButton;
  const PaywallScreen({super.key, this.showCloseButton = true});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  bool _isYearly = true; // default to yearly (better value)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // ═══════════════════════════════════
                // CLOSE BUTTON (top right)
                // ═══════════════════════════════════
                if (widget.showCloseButton)
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        Navigator.of(context).pushReplacementNamed('/home');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close, color: Colors.white.withOpacity(0.4), size: 20),
                      ),
                    ),
                  ),

                const SizedBox(height: 12),

                // ═══════════════════════════════════
                // LOGO
                // ═══════════════════════════════════
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFCCFF00).withOpacity(0.12),
                          blurRadius: 50,
                          spreadRadius: 15,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo/skeletal_logo.png',
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ═══════════════════════════════════
                // TITLE
                // ═══════════════════════════════════
                const Text(
                  'Unlock PRO',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'AI-powered tracking for serious athletes',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.4),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 32),

                // ═══════════════════════════════════
                // PRO FEATURES LIST
                // ═══════════════════════════════════
                _buildFeatureItem(Icons.videocam, 'AI Camera Rep Counting'),
                _buildFeatureItem(Icons.accessibility_new, 'Skeleton Overlay Recording'),
                _buildFeatureItem(Icons.share, 'Shareable Workout Clips'),
                _buildFeatureItem(Icons.record_voice_over, 'Voice Coaching'),
                _buildFeatureItem(Icons.support_agent, 'Priority Support'),

                const SizedBox(height: 20),

                // ═══════════════════════════════════
                // PRICING TOGGLE — Monthly / Yearly
                // ═══════════════════════════════════
                Row(
                  children: [
                    // MONTHLY
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() => _isYearly = false);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: !_isYearly
                                ? const Color(0xFFCCFF00).withOpacity(0.08)
                                : const Color(0xFF111111),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: !_isYearly
                                  ? const Color(0xFFCCFF00).withOpacity(0.4)
                                  : Colors.white.withOpacity(0.06),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Monthly',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: !_isYearly
                                      ? const Color(0xFFCCFF00)
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 6),
                              // Price comes from store — placeholder for now
                              Text(
                                '\$2.99', // PLACEHOLDER — replace with store price
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: !_isYearly ? Colors.white : Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'per month',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // YEARLY
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          setState(() => _isYearly = true);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: _isYearly
                                ? const Color(0xFFCCFF00).withOpacity(0.08)
                                : const Color(0xFF111111),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _isYearly
                                  ? const Color(0xFFCCFF00).withOpacity(0.4)
                                  : Colors.white.withOpacity(0.06),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Yearly',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: _isYearly
                                      ? const Color(0xFFCCFF00)
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '\$24.99', // PLACEHOLDER — replace with store price
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: _isYearly ? Colors.white : Colors.white.withOpacity(0.5),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Save 30%',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: _isYearly
                                      ? const Color(0xFFCCFF00)
                                      : Colors.white.withOpacity(0.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ═══════════════════════════════════
                // SUBSCRIBE BUTTON
                // ═══════════════════════════════════
                GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    // TODO: Trigger purchase with RevenueCat
                    // final productId = _isYearly ? PaywallScreen.yearlyProductId : PaywallScreen.monthlyProductId;
                    // For now, just go home
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCCFF00),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Text(
                        'SUBSCRIBE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ═══════════════════════════════════
                // RESTORE PURCHASE
                // ═══════════════════════════════════
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Restore purchases
                    },
                    child: Text(
                      'Restore Purchase',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.3),
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white.withOpacity(0.15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ═══════════════════════════════════
                // TERMS + PRIVACY LINKS
                // ═══════════════════════════════════
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // TODO: Open terms
                      },
                      child: Text(
                        'Terms',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.2),
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Text(
                      '  \u2022  ',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.15),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Open privacy policy
                      },
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.2),
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // ═══════════════════════════════════
                // FREE FEATURES REMINDER
                // ═══════════════════════════════════
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D0D0D),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.04),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Already included FREE',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(0.35),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '500+ exercises \u2022 Full analytics \u2022 Workout scheduling \u2022 Body tracking \u2022 Unlimited manual logging',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white.withOpacity(0.25),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════
  // FEATURE ITEM HELPER
  // ═══════════════════════════════════
  Widget _buildFeatureItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFCCFF00).withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFCCFF00), size: 18),
          ),
          const SizedBox(width: 14),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
