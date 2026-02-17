import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../paywall/paywall_screen.dart';

/// ═══════════════════════════════════════════════════════════════════════════════
/// SIGN IN SCREEN - Elite Black + Cyber Lime
/// ═══════════════════════════════════════════════════════════════════════════════
/// Email/password, Google, Apple, skip button, terms/privacy, forgot password.
/// Basic logic only — user can skip past during onboarding.
/// Real auth wired up later.
/// ═══════════════════════════════════════════════════════════════════════════════

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreedToTerms = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _goToPaywall() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const PaywallScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // ═══════════════════════════════════
              // LOGO — centered, with glow
              // ═══════════════════════════════════
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFCCFF00).withOpacity(0.1),
                        blurRadius: 40,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/logo/skeletal_logo.png',
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ═══════════════════════════════════
              // TITLE
              // ═══════════════════════════════════
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign in to sync your progress',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.4),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 36),

              // ═══════════════════════════════════
              // EMAIL FIELD
              // ═══════════════════════════════════
              _buildInputField(
                controller: _emailController,
                hint: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 14),

              // ═══════════════════════════════════
              // PASSWORD FIELD
              // ═══════════════════════════════════
              _buildInputField(
                controller: _passwordController,
                hint: 'Password',
                icon: Icons.lock_outlined,
                obscure: _obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                  child: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white.withOpacity(0.3),
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // ═══════════════════════════════════
              // FORGOT PASSWORD
              // ═══════════════════════════════════
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Forgot password flow
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFCCFF00).withOpacity(0.6),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ═══════════════════════════════════
              // SIGN IN BUTTON — Cyber lime
              // ═══════════════════════════════════
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  // TODO: Real auth logic
                  // For now, navigate to paywall
                  _goToPaywall();
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCFF00),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'SIGN IN',
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

              const SizedBox(height: 20),

              // ═══════════════════════════════════
              // OR divider
              // ═══════════════════════════════════
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white.withOpacity(0.08))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white.withOpacity(0.08))),
                ],
              ),

              const SizedBox(height: 20),

              // ═══════════════════════════════════
              // GOOGLE SIGN IN
              // ═══════════════════════════════════
              _buildSocialButton(
                label: 'Continue with Google',
                icon: 'assets/images/icons/google_icon.png',
                onTap: () {
                  HapticFeedback.lightImpact();
                  // TODO: Google sign in
                  _goToPaywall();
                },
              ),

              const SizedBox(height: 12),

              // ═══════════════════════════════════
              // APPLE SIGN IN
              // ═══════════════════════════════════
              _buildSocialButton(
                label: 'Continue with Apple',
                icon: null,
                appleIcon: true,
                onTap: () {
                  HapticFeedback.lightImpact();
                  // TODO: Apple sign in
                  _goToPaywall();
                },
              ),

              const SizedBox(height: 24),

              // ═══════════════════════════════════
              // TERMS & PRIVACY CHECKBOX
              // ═══════════════════════════════════
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: _agreedToTerms
                            ? const Color(0xFFCCFF00)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _agreedToTerms
                              ? const Color(0xFFCCFF00)
                              : Colors.white.withOpacity(0.2),
                          width: 1.5,
                        ),
                      ),
                      child: _agreedToTerms
                          ? const Icon(Icons.check, size: 16, color: Colors.black)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.35),
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: const Color(0xFFCCFF00).withOpacity(0.6),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                            // TODO: Add GestureRecognizer to open terms
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: const Color(0xFFCCFF00).withOpacity(0.6),
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                            // TODO: Add GestureRecognizer to open privacy policy
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ═══════════════════════════════════
              // DON'T HAVE AN ACCOUNT?
              // ═══════════════════════════════════
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.35),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to sign up
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFCCFF00),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ═══════════════════════════════════
              // SKIP BUTTON — For now, lets users bypass
              // ═══════════════════════════════════
              Center(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    _goToPaywall();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Skip for now',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.2),
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════
  // INPUT FIELD HELPER
  // ═══════════════════════════════════
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscure = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withOpacity(0.06),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscure,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.white.withOpacity(0.2),
          ),
          prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.2), size: 20),
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }

  // ═══════════════════════════════════
  // SOCIAL BUTTON HELPER
  // ═══════════════════════════════════
  Widget _buildSocialButton({
    required String label,
    String? icon,
    bool appleIcon = false,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFF111111),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.white.withOpacity(0.06),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (appleIcon)
              const Icon(Icons.apple, color: Colors.white, size: 22)
            else if (icon != null)
              Image.asset(icon, height: 20, width: 20,
                errorBuilder: (_, __, ___) => const Icon(Icons.g_mobiledata, color: Colors.white, size: 22),
              ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
