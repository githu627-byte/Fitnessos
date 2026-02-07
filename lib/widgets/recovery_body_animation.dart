import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../utils/app_colors.dart';

/// 🔥 CYBERPUNK ANATOMICAL BODY - NEON MUSCLE RECOVERY VISUALIZATION
/// Electric glowing muscles with real-time pulse & breathing animations
/// Muscle contractions show recovery status
/// Red (depleted) → Orange → Yellow → Green (ready to train)
class RecoveryBodyAnimation extends StatefulWidget {
  final Map<String, double> muscleRecovery; // muscle group → recovery % (0.0 to 1.0)
  final double overallRecovery; // 0.0 to 1.0

  const RecoveryBodyAnimation({
    super.key,
    required this.muscleRecovery,
    required this.overallRecovery,
  });

  @override
  State<RecoveryBodyAnimation> createState() => _RecoveryBodyAnimationState();
}

class _RecoveryBodyAnimationState extends State<RecoveryBodyAnimation>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _breathController;
  late AnimationController _scanlineController;
  late AnimationController _energyFlowController;

  @override
  void initState() {
    super.initState();
    
    // Pulse animation - muscles glow in rhythm
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);
    
    // Breathing animation - chest expansion
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat(reverse: true);
    
    // Scanline effect - cyberpunk aesthetic
    _scanlineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
    
    // Energy flow through muscles
    _energyFlowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _breathController.dispose();
    _scanlineController.dispose();
    _energyFlowController.dispose();
    super.dispose();
  }

  /// Get color based on recovery percentage
  /// 0% = Deep Red (inflamed/depleted)
  /// 50% = Orange/Yellow (recovering)
  /// 100% = Vibrant Neon Green (ready to train!)
  Color _getRecoveryColor(double recovery) {
    if (recovery < 0.25) {
      // Deep red → Bright red (severe depletion)
      return Color.lerp(
        const Color(0xFF8B0000), // Dark red
        const Color(0xFFFF1744), // Bright red
        recovery / 0.25,
      )!;
    } else if (recovery < 0.5) {
      // Red → Orange (still recovering)
      return Color.lerp(
        const Color(0xFFFF1744), // Bright red
        const Color(0xFFFF6D00), // Orange
        (recovery - 0.25) / 0.25,
      )!;
    } else if (recovery < 0.75) {
      // Orange → Yellow (getting better)
      return Color.lerp(
        const Color(0xFFFF6D00), // Orange
        const Color(0xFFFFD600), // Yellow
        (recovery - 0.5) / 0.25,
      )!;
    } else {
      // Yellow → Neon Green (ready to go!)
      return Color.lerp(
        const Color(0xFFFFD600), // Yellow
        const Color(0xFF39FF14), // NEON GREEN (matches your app theme!)
        (recovery - 0.75) / 0.25,
      )!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _pulseController,
        _breathController,
        _scanlineController,
        _energyFlowController,
      ]),
      builder: (context, child) {
        final pulse = _pulseController.value * 0.05; // Stronger pulse for neon effect
        final breath = _breathController.value * 0.03; // Breathing expansion
        final scanline = _scanlineController.value; // Scanline position
        final energyFlow = _energyFlowController.value; // Energy pulse

        return SizedBox(
          height: 380,
          width: 240,
          child: CustomPaint(
            size: const Size(240, 380),
            painter: CyberpunkAnatomyPainter(
              muscleRecovery: widget.muscleRecovery,
              overallRecovery: widget.overallRecovery,
              pulse: pulse,
              breath: breath,
              scanline: scanline,
              energyFlow: energyFlow,
              getRecoveryColor: _getRecoveryColor,
            ),
          ),
        );
      },
    );
  }
}

/// 🔥 CYBERPUNK ANATOMICAL BODY PAINTER
/// Neon glow effects, muscle contractions, energy flow
class CyberpunkAnatomyPainter extends CustomPainter {
  final Map<String, double> muscleRecovery;
  final double overallRecovery;
  final double pulse;
  final double breath;
  final double scanline;
  final double energyFlow;
  final Color Function(double) getRecoveryColor;

  CyberpunkAnatomyPainter({
    required this.muscleRecovery,
    required this.overallRecovery,
    required this.pulse,
    required this.breath,
    required this.scanline,
    required this.energyFlow,
    required this.getRecoveryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    
    // Cyberpunk electric outline
    final outlinePaint = Paint()
      ..color = const Color(0xFF00D9FF).withOpacity(0.3) // Electric blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 2);

    // Draw detailed anatomical body with CYBERPUNK effects
    
    // HEAD - with electric glow
    _drawHead(canvas, centerX, 25, outlinePaint);
    
    // NECK - energy conduit
    _drawNeck(canvas, centerX, 42);
    
    // SHOULDERS & DELTOIDS - with contraction animation
    _drawMuscleGroup(canvas, 'Shoulders', centerX - 42, 58, 22, 18, true); // Left delt
    _drawMuscleGroup(canvas, 'Shoulders', centerX + 42, 58, 22, 18, true); // Right delt
    
    // CHEST - PECTORALS (with breathing animation)
    _drawPectorals(canvas, centerX, 72);
    
    // ARMS - BICEPS & TRICEPS (with contraction)
    _drawArm(canvas, 'Arms', centerX - 58, 85, true); // Left arm
    _drawArm(canvas, 'Arms', centerX + 58, 85, false); // Right arm
    
    // CORE - ABS (6-pack with definition)
    _drawCore(canvas, centerX, 105);
    
    // BACK - LATS (V-taper with glow)
    _drawBack(canvas, centerX, 95);
    
    // LEGS - QUADS & HAMSTRINGS (powerful glow)
    _drawLeg(canvas, 'Legs', centerX - 18, 165, true); // Left leg
    _drawLeg(canvas, 'Legs', centerX + 18, 165, false); // Right leg
    
    // Energy veins connecting muscles
    _drawEnergyVeins(canvas, centerX, size);
    
    // Overall body outline for definition
    _drawBodyOutline(canvas, size, outlinePaint);
    
    // SCANLINE EFFECT (cyberpunk aesthetic)
    _drawScanline(canvas, size);
  }

  void _drawHead(Canvas canvas, double x, double y, Paint paint) {
    // Head with electric glow
    final glowPaint = Paint()
      ..color = const Color(0xFF00D9FF).withOpacity(0.1 + pulse)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    
    canvas.drawCircle(Offset(x, y), 20, glowPaint);
    canvas.drawCircle(Offset(x, y), 18, paint);
  }

  void _drawNeck(Canvas canvas, double x, double y) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(
      Rect.fromCenter(center: Offset(x, y), width: 16, height: 12),
      paint,
    );
  }

  void _drawPectorals(Canvas canvas, double centerX, double y) {
    final recovery = muscleRecovery['Chest'] ?? overallRecovery;
    final color = getRecoveryColor(recovery);
    
    // Breathing animation - chest expands
    final breathExpansion = 1.0 + (breath * 0.5);
    
    // Left pec
    _drawMuscleShape(canvas, centerX - 16, y, 24 * breathExpansion, 20, color, isRounded: true);
    // Right pec
    _drawMuscleShape(canvas, centerX + 16, y, 24 * breathExpansion, 20, color, isRounded: true);
  }

  void _drawCore(Canvas canvas, double centerX, double y) {
    final recovery = muscleRecovery['Core'] ?? overallRecovery;
    final color = getRecoveryColor(recovery);
    
    // Draw 6-pack abs with contraction effect
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 2; col++) {
        final x = centerX + (col == 0 ? -10 : 10);
        final yPos = y + (row * 16);
        
        // Contraction - muscles tighten when recovered
        final contraction = 1.0 - (recovery * 0.15 * pulse);
        _drawMuscleShape(canvas, x, yPos, 14 * contraction, 12, color);
      }
    }
  }

  void _drawBack(Canvas canvas, double centerX, double y) {
    final recovery = muscleRecovery['Back'] ?? overallRecovery;
    final color = getRecoveryColor(recovery);
    
    // V-taper lats with neon glow
    final path = Path()
      ..moveTo(centerX - 25, y)
      ..lineTo(centerX - 35, y + 35)
      ..lineTo(centerX - 20, y + 50)
      ..lineTo(centerX, y + 45)
      ..close();
    
    // Glow effect
    final glowPaint = Paint()
      ..color = color.withOpacity(0.3 + pulse)
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
    
    // Mirror for right side
    canvas.save();
    canvas.translate(centerX * 2, 0);
    canvas.scale(-1, 1);
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawArm(Canvas canvas, String group, double x, double y, bool isLeft) {
    final recovery = muscleRecovery[group] ?? overallRecovery;
    final color = getRecoveryColor(recovery);
    
    // Muscle contraction - pumped when recovered
    final contraction = 1.0 + (recovery * 0.2 * pulse);
    
    // Bicep (bigger when recovered)
    _drawMuscleShape(canvas, x, y, 16 * contraction, 22, color, isRounded: true);
    // Forearm
    _drawMuscleShape(canvas, x, y + 32, 14, 28, color, isRounded: true);
  }

  void _drawLeg(Canvas canvas, String group, double x, double y, bool isLeft) {
    final recovery = muscleRecovery[group] ?? overallRecovery;
    final color = getRecoveryColor(recovery);
    
    // Muscle contraction
    final contraction = 1.0 + (recovery * 0.15 * pulse);
    
    // Quad (powerful glow)
    _drawMuscleShape(canvas, x, y, 16 * contraction, 45, color, isRounded: true);
    // Calf
    _drawMuscleShape(canvas, x, y + 65, 14, 35, color, isRounded: true);
  }

  void _drawMuscleGroup(Canvas canvas, String group, double x, double y, double width, double height, bool rounded) {
    final recovery = muscleRecovery[group] ?? overallRecovery;
    final color = getRecoveryColor(recovery);
    
    // Contraction effect
    final contraction = 1.0 + (recovery * 0.2 * pulse);
    _drawMuscleShape(canvas, x, y, width * contraction, height, color, isRounded: rounded);
  }

  void _drawMuscleShape(Canvas canvas, double x, double y, double width, double height, Color color, {bool isRounded = false}) {
    // INTENSE NEON GLOW - Cyberpunk style
    final outerGlowPaint = Paint()
      ..color = color.withOpacity(0.15 + (pulse * 0.2))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    final innerGlowPaint = Paint()
      ..color = color.withOpacity(0.3 + (pulse * 0.3))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    // Muscle fill with gradient effect
    final musclePaint = Paint()
      ..color = color.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    // Electric border
    final borderPaint = Paint()
      ..color = color.withOpacity(0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final rect = Rect.fromCenter(center: Offset(x, y), width: width, height: height);
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(isRounded ? width / 3 : 4));

    // Draw layers for depth
    canvas.drawRRect(rRect, outerGlowPaint); // Outer glow
    canvas.drawRRect(rRect, innerGlowPaint); // Inner glow
    canvas.drawRRect(rRect, musclePaint);     // Muscle fill
    canvas.drawRRect(rRect, borderPaint);     // Electric border
    
    // Energy spark effect for highly recovered muscles
    if (muscleRecovery.values.any((r) => r > 0.8)) {
      final sparkPaint = Paint()
        ..color = Colors.white.withOpacity(0.3 * pulse)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
      canvas.drawCircle(Offset(x, y), 3, sparkPaint);
    }
  }

  void _drawEnergyVeins(Canvas canvas, double centerX, Size size) {
    // Energy lines connecting major muscle groups (blood flow visualization)
    final energyPaint = Paint()
      ..color = const Color(0xFF00D9FF).withOpacity(0.2 + (energyFlow * 0.3))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 3);

    final path = Path()
      // Spine - central energy line
      ..moveTo(centerX, 45)
      ..lineTo(centerX, 165)
      // Left side connections
      ..moveTo(centerX, 72) // Chest
      ..lineTo(centerX - 42, 58) // To left shoulder
      ..moveTo(centerX, 105) // Core
      ..lineTo(centerX - 18, 165) // To left leg
      // Right side connections
      ..moveTo(centerX, 72) // Chest
      ..lineTo(centerX + 42, 58) // To right shoulder
      ..moveTo(centerX, 105) // Core
      ..lineTo(centerX + 18, 165); // To right leg

    canvas.drawPath(path, energyPaint);
    
    // Pulsing energy nodes at key points
    _drawEnergyNode(canvas, centerX, 72); // Heart
    _drawEnergyNode(canvas, centerX, 105); // Solar plexus
  }

  void _drawEnergyNode(Canvas canvas, double x, double y) {
    final nodePaint = Paint()
      ..color = const Color(0xFF00D9FF).withOpacity(0.5 + (energyFlow * 0.5))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    
    canvas.drawCircle(Offset(x, y), 3, nodePaint);
  }

  void _drawBodyOutline(Canvas canvas, Size size, Paint paint) {
    final centerX = size.width / 2;
    
    final path = Path()
      // Left side of torso
      ..moveTo(centerX - 48, 55)
      ..lineTo(centerX - 40, 145)
      // Left leg
      ..lineTo(centerX - 22, 150)
      ..lineTo(centerX - 22, 240)
      // Bottom
      ..lineTo(centerX - 18, 265)
      ..lineTo(centerX + 18, 265)
      // Right leg
      ..lineTo(centerX + 22, 240)
      ..lineTo(centerX + 22, 150)
      // Right side of torso
      ..lineTo(centerX + 40, 145)
      ..lineTo(centerX + 48, 55)
      // Top shoulders
      ..lineTo(centerX + 35, 50)
      ..lineTo(centerX, 45)
      ..lineTo(centerX - 35, 50)
      ..close();

    canvas.drawPath(path, paint);
  }

  void _drawScanline(Canvas canvas, Size size) {
    // Cyberpunk scanline effect that sweeps down the body
    final scanY = size.height * scanline;
    
    final scanPaint = Paint()
      ..color = const Color(0xFF00D9FF).withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    
    canvas.drawLine(
      Offset(0, scanY),
      Offset(size.width, scanY),
      scanPaint,
    );
    
    // Brighter line at center
    final brightScanPaint = Paint()
      ..color = const Color(0xFF00D9FF).withOpacity(0.4)
      ..strokeWidth = 2
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    
    canvas.drawLine(
      Offset(0, scanY),
      Offset(size.width, scanY),
      brightScanPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CyberpunkAnatomyPainter oldDelegate) {
    return oldDelegate.pulse != pulse ||
        oldDelegate.breath != breath ||
        oldDelegate.scanline != scanline ||
        oldDelegate.energyFlow != energyFlow ||
        oldDelegate.overallRecovery != overallRecovery;
  }
}
