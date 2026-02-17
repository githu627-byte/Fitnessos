import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class FormScoreHUD extends StatelessWidget {
  final int score;
  const FormScoreHUD({super.key, required this.score});

  Color get _color => score >= 90 ? const Color(0xFFCCFF00) : score >= 70 ? AppColors.cyberLime : score >= 50 ? const Color(0xFFFFB800) : const Color(0xFFFF003C);
  String get _grade => score >= 95 ? 'S' : score >= 90 ? 'A+' : score >= 85 ? 'A' : score >= 80 ? 'B+' : score >= 70 ? 'B' : score >= 60 ? 'C' : score >= 50 ? 'D' : 'F';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF0A0E1A).withOpacity(0.85), borderRadius: BorderRadius.circular(16), border: Border.all(color: _color.withOpacity(0.3)), boxShadow: [BoxShadow(color: _color.withOpacity(0.2), blurRadius: 20)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: _color, shape: BoxShape.circle, boxShadow: [BoxShadow(color: _color, blurRadius: 6)])), const SizedBox(width: 8), Text('FORM SCORE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.6), letterSpacing: 1.5))]),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TweenAnimationBuilder<int>(tween: IntTween(begin: 0, end: score), duration: const Duration(milliseconds: 500), builder: (c, v, ch) => Text('$v', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: _color, height: 1, shadows: [Shadow(color: _color.withOpacity(0.5), blurRadius: 10)]))),
              Padding(padding: const EdgeInsets.only(bottom: 8, left: 2), child: Text('%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: _color.withOpacity(0.7)))),
              const SizedBox(width: 12),
              Container(width: 40, height: 40, margin: const EdgeInsets.only(bottom: 4), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _color, width: 2), boxShadow: [BoxShadow(color: _color.withOpacity(0.3), blurRadius: 8)]), child: Center(child: Text(_grade, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: _color)))),
            ],
          ),
          const SizedBox(height: 8),
          Container(width: 120, height: 4, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(2)), child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: score / 100, child: Container(decoration: BoxDecoration(color: _color, borderRadius: BorderRadius.circular(2), boxShadow: [BoxShadow(color: _color.withOpacity(0.5), blurRadius: 4)])))),
        ],
      ),
    );
  }
}

class FormAnglesHUD extends StatelessWidget {
  final Map<String, double> angles;
  const FormAnglesHUD({super.key, required this.angles});

  @override
  Widget build(BuildContext context) {
    if (angles.isEmpty) return const SizedBox();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF0A0E1A).withOpacity(0.85), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withOpacity(0.1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ANGLES', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.5), letterSpacing: 1.5)),
          const SizedBox(height: 8),
          ...angles.entries.take(4).map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(width: 70, child: Text(e.key.replaceAll('_', ' ').toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.7)))),
              const SizedBox(width: 8),
              Text('${e.value.toStringAsFixed(0)}°', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: AppColors.cyberLime, fontFamily: 'monospace')),
              const SizedBox(width: 6),
              Icon(Icons.check_circle, color: AppColors.cyberLime.withOpacity(0.7), size: 12),
            ]),
          )),
        ],
      ),
    );
  }
}

