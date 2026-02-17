import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../utils/app_colors.dart';
import '../../models/user_model.dart';
import '../../models/goal_config.dart';
import '../../providers/user_provider.dart';
import '../../providers/workout_schedule_provider.dart';
import '../../services/workout_schedule_generator.dart';
import '../home_screen.dart';
import '../auth/sign_in_screen.dart';

class V3OnboardingMain extends ConsumerStatefulWidget {
  const V3OnboardingMain({super.key});

  @override
  ConsumerState<V3OnboardingMain> createState() => _V3OnboardingMainState();
}

class _V3OnboardingMainState extends ConsumerState<V3OnboardingMain>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 6;

  // Page 4: Import
  bool _isImporting = false;
  String? _importResult;

  // Page 5: Personal info
  final TextEditingController _nameController = TextEditingController();
  String _gender = 'male';
  double _weight = 170.0;

  // Page 6: Setup
  bool _wantsHelp = true;
  String _location = 'gym';
  int _daysPerWeek = 3;
  String _focus = 'fullbody';

  // Animations
  late AnimationController _pulseController;
  late AnimationController _gaugeController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat(reverse: true);
    _gaugeController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    // Start gauge on first page
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _gaugeController.forward();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _pulseController.dispose();
    _gaugeController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      HapticFeedback.mediumImpact();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    HapticFeedback.heavyImpact();

    final user = UserModel(
      name: _nameController.text.isNotEmpty ? _nameController.text : 'Athlete',
      age: 25,
      gender: _gender,
      height: 70.0,
      weight: _weight,
      targetWeight: _weight,
      goalMode: GoalMode.recomp,
      equipmentMode: _location == 'gym' ? EquipmentMode.gym : EquipmentMode.bodyweight,
      fitnessExperience: 'beginner',
    );
    await ref.read(userProvider.notifier).updateUser(user);

    final storage = await ref.read(storageServiceProvider.future);
    await storage.setOnboardingComplete(true);

    if (_wantsHelp) {
      try {
        final schedules = WorkoutScheduleGenerator.generateSmartSchedule(
          gender: _gender,
          location: _location,
          focus: _focus,
          daysPerWeek: _daysPerWeek,
        );
        for (final schedule in schedules) {
          await ref.read(workoutSchedulesProvider.notifier).saveSchedule(schedule);
        }
      } catch (e) {
        debugPrint('Schedule gen error: $e');
      }
    }

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const SignInScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (i) => setState(() => _currentPage = i),
            children: [
              _page1AITracking(),
              _page2Library(),
              _page3Analytics(),
              _page4Import(),
              _page5PersonalInfo(),
              _page6Setup(),
            ],
          ),

          // Progress bar + back
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    GestureDetector(
                      onTap: _previousPage,
                      child: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.white10,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 18),
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (_currentPage + 1) / _totalPages,
                        backgroundColor: Colors.white.withOpacity(0.06),
                        valueColor: const AlwaysStoppedAnimation(AppColors.cyberLime),
                        minHeight: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom CTA
          Positioned(
            left: 28, right: 28, bottom: 28,
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _currentPage == _totalPages - 1 ? _completeOnboarding : _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cyberLime,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == 3
                        ? 'SKIP FOR NOW'
                        : _currentPage == _totalPages - 1
                            ? (_wantsHelp ? "LET'S GO" : 'GET STARTED')
                            : 'CONTINUE',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PAGE 1: AI-POWERED TRACKING
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _page1AITracking() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 80, 28, 90),
        child: Column(
          children: [
            const Spacer(),

            // Pulsing skull orb
            AnimatedBuilder(
              animation: _pulseController,
              builder: (context, child) {
                final scale = 1.0 + (_pulseController.value * 0.06);
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 180, height: 180,
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
                        height: 80, fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(Icons.fitness_center, size: 68, color: AppColors.cyberLime),
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            // AI ENGINE gauge
            SizedBox(
              width: 320,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('AI ENGINE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 2, color: AppColors.cyberLime.withOpacity(0.6))),
                      AnimatedBuilder(
                        animation: _gaugeController,
                        builder: (context, _) => Text(
                          '${(_gaugeController.value * 100).toInt()}%',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1, color: AppColors.cyberLime.withOpacity(0.9)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: AnimatedBuilder(
                      animation: _gaugeController,
                      builder: (context, _) => LinearProgressIndicator(
                        value: _gaugeController.value,
                        backgroundColor: Colors.white.withOpacity(0.06),
                        valueColor: const AlwaysStoppedAnimation(AppColors.cyberLime),
                        minHeight: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Feature pills
            Wrap(
              spacing: 8, runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _featurePill('CAMERA TRACKING'),
                _featurePill('SKELETON OVERLAY'),
                _featurePill('AUTO REP COUNT'),
                _featurePill('100% OFFLINE'),
                _featurePill('SHAREABLE CLIPS'),
                _featurePill('500+ EXERCISES'),
              ],
            ),

            const SizedBox(height: 28),

            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'AI-POWERED\n',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2, height: 1.2),
                  ),
                  TextSpan(
                    text: 'TRACKING',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: AppColors.cyberLime, letterSpacing: 2, height: 1.2),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5), height: 1.6),
                children: [
                  const TextSpan(text: 'Point your camera. We count your reps.\nTrack your form. Record shareable clips.\n'),
                  TextSpan(
                    text: 'No internet needed. Ever.',
                    style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.cyberLime.withOpacity(0.85)),
                  ),
                ],
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _featurePill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCCFF00).withOpacity(0.15), width: 1),
        color: const Color(0xFFCCFF00).withOpacity(0.06),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFFCCFF00), letterSpacing: 0.8),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PAGE 2: EXERCISE LIBRARY
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _page2Library() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 80, 28, 90),
        child: Column(
          children: [
            const Spacer(),

            // 500+ count box
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 28),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.cyberLime.withOpacity(0.2)),
                color: AppColors.cyberLime.withOpacity(0.04),
                boxShadow: [BoxShadow(color: AppColors.cyberLime.withOpacity(0.08), blurRadius: 50)],
              ),
              child: Column(
                children: [
                  TweenAnimationBuilder<int>(
                    tween: IntTween(begin: 0, end: 500),
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => Text(
                      '$value+',
                      style: const TextStyle(fontSize: 68, fontWeight: FontWeight.w900, color: AppColors.cyberLime, height: 1),
                    ),
                  ),
                  Text('EXERCISES', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 4, color: Colors.white.withOpacity(0.65))),
                ],
              ),
            ),

            const SizedBox(height: 28),

            Wrap(
              spacing: 7, runSpacing: 7,
              alignment: WrapAlignment.center,
              children: ['GYM', 'HOME', 'ARMS', 'LEGS', 'CORE', 'HIIT', 'GLUTES', 'CARDIO']
                  .map((c) => _buildChip(c)).toList(),
            ),

            const SizedBox(height: 32),

            const Text('MASSIVE LIBRARY', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2), textAlign: TextAlign.center),

            const SizedBox(height: 12),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5), height: 1.6),
                children: [
                  const TextSpan(text: '500+ exercises. Manual log anything.\nVisual guides for every movement.\n'),
                  TextSpan(text: '100% free. Always.', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.cyberLime.withOpacity(0.85))),
                ],
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PAGE 3: ELITE ANALYTICS
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _page3Analytics() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 80, 24, 90),
        child: Column(
          children: [
            const Spacer(),

            // Power Level card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [AppColors.cyberLime.withOpacity(0.12), AppColors.cyberLime.withOpacity(0.03)]),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cyberLime.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.bolt, color: AppColors.cyberLime, size: 22),
                  const SizedBox(width: 10),
                  Text('POWER LEVEL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 2, color: Colors.white.withOpacity(0.6))),
                  const Spacer(),
                  TweenAnimationBuilder<int>(
                    tween: IntTween(begin: 0, end: 2847),
                    duration: const Duration(milliseconds: 2000),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, _) => Text(
                      value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},'),
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.cyberLime),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Stats grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                _statCardIcon(Icons.fitness_center, '127', 'WORKOUTS'),
                _statCardIcon(Icons.repeat, '14.2K', 'REPS'),
                _statCardIcon(Icons.trending_up, '82.4t', 'VOLUME'),
                _statCardIcon(Icons.timer_outlined, '63.5', 'HOURS'),
              ],
            ),

            const SizedBox(height: 32),

            const Text('ELITE ANALYTICS', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2), textAlign: TextAlign.center),

            const SizedBox(height: 12),

            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5), height: 1.6),
                children: [
                  const TextSpan(text: 'Power Level. Personal Records.\nVolume Trends. Body Balance.\n'),
                  TextSpan(text: 'All free. Forever.', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.cyberLime.withOpacity(0.85))),
                ],
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _statCardIcon(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.cyberLime, size: 17),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.cyberLime)),
          const SizedBox(height: 3),
          Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 2, color: Colors.white.withOpacity(0.4))),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PAGE 4: IMPORT YOUR DATA
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _page4Import() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 80, 28, 90),
        child: Column(
          children: [
            const Spacer(),

            const Text('IMPORT YOUR DATA', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2), textAlign: TextAlign.center),

            const SizedBox(height: 12),

            Text('Switching from another app?\nHit the ground running.', style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5), height: 1.6), textAlign: TextAlign.center),

            const SizedBox(height: 28),

            _importRowIcon(
              icon: Icons.upload_file,
              title: 'Import Workout History',
              subtitle: 'CSV file from any fitness app',
              onTap: _pickCSV,
            ),
            const SizedBox(height: 10),
            _importRowIcon(
              icon: Icons.analytics_outlined,
              title: 'Your analytics will be filled',
              subtitle: 'Power Level, PRs, volume \u{2014} all populated',
              onTap: null,
            ),

            if (_isImporting) ...[
              const SizedBox(height: 20),
              const CircularProgressIndicator(color: AppColors.cyberLime),
            ],
            if (_importResult != null) ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.cyberLime.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cyberLime.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppColors.cyberLime, size: 20),
                    const SizedBox(width: 10),
                    Expanded(child: Text(_importResult!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 12),
            Text('You can always import later from Settings', style: TextStyle(fontSize: 11, color: AppColors.cyberLime.withOpacity(0.35))),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _importRowIcon({required IconData icon, required String title, required String subtitle, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.cyberLime.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.cyberLime, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.3))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickCSV() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
      if (result == null || result.files.single.path == null) return;
      setState(() { _isImporting = true; _importResult = null; });
      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      final lines = content.split('\n').where((l) => l.trim().isNotEmpty).toList();
      await Future.delayed(const Duration(seconds: 1));
      setState(() { _isImporting = false; _importResult = 'Found ${lines.length - 1} sets \u{2014} ready to import'; });
      HapticFeedback.mediumImpact();
    } catch (e) {
      setState(() { _isImporting = false; _importResult = 'Error: $e'; });
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PAGE 5: PERSONAL INFO
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _page5PersonalInfo() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 80, 28, 90),
        child: Column(
          children: [
            const Spacer(),

            const Text('ALMOST THERE', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text('Just a few details to personalise\nyour experience.', style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.5), height: 1.6), textAlign: TextAlign.center),

            const SizedBox(height: 28),

            // Name
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                hintText: 'Your name (optional)',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                filled: true,
                fillColor: const Color(0xFF111111),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: BorderSide(color: Colors.white.withOpacity(0.06))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: BorderSide(color: Colors.white.withOpacity(0.06))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(13), borderSide: const BorderSide(color: AppColors.cyberLime)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              ),
            ),

            const SizedBox(height: 14),

            // Gender
            Row(
              children: [
                Expanded(child: _toggleBtn('MALE', _gender == 'male', () => setState(() => _gender = 'male'))),
                const SizedBox(width: 10),
                Expanded(child: _toggleBtn('FEMALE', _gender == 'female', () => setState(() => _gender = 'female'))),
              ],
            ),

            const SizedBox(height: 14),

            // Weight
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(13)),
              child: Row(
                children: [
                  Text('WEIGHT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 2, color: Colors.white.withOpacity(0.35))),
                  const Spacer(),
                  _weightBtn('-', () { if (_weight > 80) setState(() => _weight -= 5); }),
                  const SizedBox(width: 14),
                  Text('${_weight.toInt()} lbs', style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: AppColors.cyberLime)),
                  const SizedBox(width: 14),
                  _weightBtn('+', () { if (_weight < 400) setState(() => _weight += 5); }),
                ],
              ),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // PAGE 6: SETUP HELP
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _page6Setup() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(28, 80, 28, 90),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Text('WANT US TO SET UP\nYOUR FIRST 2 WEEKS?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1, height: 1.2), textAlign: TextAlign.center),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(child: _toggleBtn('YES, SET ME UP', _wantsHelp, () => setState(() => _wantsHelp = true))),
                const SizedBox(width: 10),
                Expanded(child: _toggleBtn("I'LL DO MY OWN", !_wantsHelp, () => setState(() => _wantsHelp = false))),
              ],
            ),

            if (_wantsHelp) ...[
              const SizedBox(height: 22),
              _sectionLabel('WHERE DO YOU TRAIN?'),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _optionCardIcon(Icons.fitness_center, 'GYM', _location == 'gym', () => setState(() => _location = 'gym'))),
                  const SizedBox(width: 10),
                  Expanded(child: _optionCardIcon(Icons.home_outlined, 'HOME', _location == 'home', () => setState(() => _location = 'home'))),
                ],
              ),

              const SizedBox(height: 22),
              _sectionLabel('HOW MANY DAYS A WEEK?'),
              const SizedBox(height: 10),
              Row(
                children: [
                  for (final d in [2, 3, 4, 5]) ...[
                    Expanded(child: _dayBtn(d)),
                    if (d < 5) const SizedBox(width: 7),
                  ],
                ],
              ),

              const SizedBox(height: 22),
              _sectionLabel("WHAT'S YOUR FOCUS?"),
              const SizedBox(height: 10),
              ...[
                ['BUILD MUSCLE', 'muscle'],
                ['GET FIT', 'fitness'],
                ['BOOTY & LEGS', 'booty'],
                ['FULL BODY', 'fullbody'],
              ].map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: _focusBtnClean(item[0], item[1]),
              )),
            ],

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SHARED WIDGETS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFCCFF00).withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCCFF00).withOpacity(0.15), width: 1),
      ),
      child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFFCCFF00), letterSpacing: 0.8)),
    );
  }

  Widget _toggleBtn(String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFCCFF00).withOpacity(0.08) : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: active ? const Color(0xFFCCFF00).withOpacity(0.4) : Colors.white.withOpacity(0.06),
            width: active ? 1.5 : 1,
          ),
        ),
        child: Center(
          child: Text(label, style: TextStyle(fontSize: 12, fontWeight: active ? FontWeight.w800 : FontWeight.w700, letterSpacing: 1, color: active ? const Color(0xFFCCFF00) : Colors.white.withOpacity(0.5))),
        ),
      ),
    );
  }

  Widget _weightBtn(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34, height: 34,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.cyberLime.withOpacity(0.3)),
        ),
        child: Center(child: Text(label, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700))),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 2, color: Colors.white.withOpacity(0.4))),
    );
  }

  Widget _optionCardIcon(IconData icon, String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFCCFF00).withOpacity(0.08) : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: active ? const Color(0xFFCCFF00).withOpacity(0.4) : Colors.white.withOpacity(0.06),
            width: active ? 1.5 : 1,
          ),
          boxShadow: active ? [BoxShadow(color: AppColors.cyberLime.withOpacity(0.1), blurRadius: 25)] : null,
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: active ? AppColors.cyberLime : Colors.white),
            const SizedBox(height: 7),
            Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1, color: active ? const Color(0xFFCCFF00) : Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _dayBtn(int d) {
    final active = _daysPerWeek == d;
    return GestureDetector(
      onTap: () => setState(() => _daysPerWeek = d),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: active ? AppColors.cyberLime : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: active ? AppColors.cyberLime : Colors.white.withOpacity(0.06), width: active ? 2 : 1),
        ),
        child: Center(child: Text('$d', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: active ? Colors.black : Colors.white.withOpacity(0.5)))),
      ),
    );
  }

  Widget _focusBtnClean(String label, String value) {
    final active = _focus == value;
    return GestureDetector(
      onTap: () => setState(() => _focus = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFCCFF00).withOpacity(0.08) : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: active ? const Color(0xFFCCFF00).withOpacity(0.4) : Colors.white.withOpacity(0.06),
            width: active ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, letterSpacing: 0.5, color: active ? const Color(0xFFCCFF00) : Colors.white.withOpacity(0.5))),
            const Spacer(),
            if (active) const Icon(Icons.check, color: Color(0xFFCCFF00), size: 18),
          ],
        ),
      ),
    );
  }
}
