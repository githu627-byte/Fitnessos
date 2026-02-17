import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/app_colors.dart';
import '../form_checking/form_check_camera_screen.dart';

class FormCheckExercisePickerScreen extends StatefulWidget {
  const FormCheckExercisePickerScreen({super.key});

  @override
  State<FormCheckExercisePickerScreen> createState() => _FormCheckExercisePickerScreenState();
}

class _FormCheckExercisePickerScreenState extends State<FormCheckExercisePickerScreen>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  final List<_FloatingParticle> _particles = [];
  
  final List<_ExerciseData> _exercises = [
    _ExerciseData(name: 'SQUAT', subtitle: 'KING OF LEGS', tag: 'BIG 3', icon: Icons.accessibility_new, gradient: [const Color(0xFFCCFF00), const Color(0xFFCCFF00)]),
    _ExerciseData(name: 'BENCH\nPRESS', subtitle: 'CHEST BUILDER', tag: 'BIG 3', icon: Icons.airline_seat_flat, gradient: [const Color(0xFF3B82F6), const Color(0xFF1D4ED8)]),
    _ExerciseData(name: 'DEADLIFT', subtitle: 'KING OF LIFTS', tag: 'BIG 3', icon: Icons.fitness_center, gradient: [const Color(0xFFCCFF00), const Color(0xFFCCFF00)]),
    _ExerciseData(name: 'OVERHEAD\nPRESS', subtitle: 'SHOULDER POWER', tag: 'COMPOUND', icon: Icons.arrow_upward, gradient: [const Color(0xFF10B981), const Color(0xFF059669)]),
    _ExerciseData(name: 'BARBELL\nROW', subtitle: 'BACK THICKNESS', tag: 'COMPOUND', icon: Icons.rowing, gradient: [const Color(0xFFCCFF00), const Color(0xFFCCFF00)]),
  ];

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
    _fadeController.forward();
    final random = math.Random();
    for (int i = 0; i < 30; i++) {
      _particles.add(_FloatingParticle(x: random.nextDouble(), y: random.nextDouble(), size: random.nextDouble() * 4 + 2, speed: random.nextDouble() * 0.3 + 0.1, opacity: random.nextDouble() * 0.3 + 0.1));
    }
  }

  @override
  void dispose() {
    _particleController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _onExerciseSelected(_ExerciseData exercise) {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => FormCheckCameraScreen(exerciseName: exercise.name.replaceAll('\n', ' ')),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: ScaleTransition(scale: Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)), child: child)),
      transitionDuration: const Duration(milliseconds: 400),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Stack(
        children: [
          AnimatedBuilder(animation: _particleController, builder: (context, child) => CustomPaint(painter: _ParticlePainter(particles: _particles, progress: _particleController.value), size: Size.infinite)),
          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.white.withOpacity(0.1))), child: const Icon(Icons.arrow_back, color: Colors.white, size: 22))),
                            const Spacer(),
                            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.cyberLime.withOpacity(0.1), borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.cyberLime.withOpacity(0.3))), child: Icon(Icons.auto_awesome, color: AppColors.cyberLime, size: 22)),
                          ],
                        ),
                        const SizedBox(height: 32),
                        ShaderMask(shaderCallback: (bounds) => LinearGradient(colors: [AppColors.cyberLime, const Color(0xFFCCFF00)]).createShader(bounds), child: const Text('FORM CHECK', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 4))),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.cyberLime, shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppColors.cyberLime.withOpacity(0.5), blurRadius: 8)])),
                            const SizedBox(width: 12),
                            Text('POWERED BY AI VISION', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.5), letterSpacing: 2)),
                            const SizedBox(width: 12),
                            Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.cyberLime, shape: BoxShape.circle, boxShadow: [BoxShadow(color: AppColors.cyberLime.withOpacity(0.5), blurRadius: 8)])),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        padding: const EdgeInsets.only(bottom: 100),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 0.75),
                        itemCount: _exercises.length,
                        itemBuilder: (context, index) => _ExerciseCard(data: _exercises[index], onTap: () => _onExerciseSelected(_exercises[index])),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatefulWidget {
  final _ExerciseData data;
  final VoidCallback onTap;
  const _ExerciseCard({required this.data, required this.onTap});
  @override
  State<_ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<_ExerciseCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  double _rotateX = 0, _rotateY = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) { _controller.forward(); HapticFeedback.lightImpact(); },
      onTapUp: (_) { _controller.reverse(); widget.onTap(); },
      onTapCancel: () => _controller.reverse(),
      onPanUpdate: (d) { final s = context.size; if (s != null) setState(() { _rotateY = (d.localPosition.dx - s.width / 2) / s.width * 0.3; _rotateX = -(d.localPosition.dy - s.height / 2) / s.height * 0.3; }); },
      onPanEnd: (_) => setState(() { _rotateX = 0; _rotateY = 0; }),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateX(_rotateX)..rotateY(_rotateY)..scale(_scaleAnimation.value),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.white.withOpacity(0.15), Colors.white.withOpacity(0.05)]), border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  Positioned.fill(child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [widget.data.gradient[0].withOpacity(0.3), widget.data.gradient[1].withOpacity(0.1)])))),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: widget.data.gradient[0].withOpacity(0.3), borderRadius: BorderRadius.circular(20), border: Border.all(color: widget.data.gradient[0].withOpacity(0.5))), child: Text(widget.data.tag, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: widget.data.gradient[0], letterSpacing: 1))),
                        const Spacer(),
                        Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: widget.data.gradient[0].withOpacity(0.2), shape: BoxShape.circle, border: Border.all(color: widget.data.gradient[0].withOpacity(0.4))), child: Icon(widget.data.icon, color: widget.data.gradient[0], size: 28)),
                        const SizedBox(height: 16),
                        Text(widget.data.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1, letterSpacing: 0.5)),
                        const SizedBox(height: 6),
                        Text(widget.data.subtitle, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.5), letterSpacing: 1)),
                      ],
                    ),
                  ),
                  Positioned(top: -50, right: -50, child: Container(width: 100, height: 100, decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [Colors.white.withOpacity(0.15), Colors.transparent])))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExerciseData {
  final String name, subtitle, tag;
  final IconData icon;
  final List<Color> gradient;
  const _ExerciseData({required this.name, required this.subtitle, required this.tag, required this.icon, required this.gradient});
}

class _FloatingParticle {
  double x, y;
  final double size, speed, opacity;
  _FloatingParticle({required this.x, required this.y, required this.size, required this.speed, required this.opacity});
}

class _ParticlePainter extends CustomPainter {
  final List<_FloatingParticle> particles;
  final double progress;
  _ParticlePainter({required this.particles, required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final y = (p.y - progress * p.speed) % 1.0;
      canvas.drawCircle(Offset(p.x * size.width, y * size.height), p.size, Paint()..color = AppColors.cyberLime.withOpacity(p.opacity)..maskFilter = MaskFilter.blur(BlurStyle.normal, p.size));
    }
  }
  @override
  bool shouldRepaint(_ParticlePainter old) => true;
}

