import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;
import '../utils/app_colors.dart';

/// Interactive Muscle Body Diagram with Recovery Visualization
/// Shows front/back views with color-coded recovery status
class MuscleBodyWidget extends StatefulWidget {
  final Map<String, double> muscleRecovery; // muscle group -> recovery % (0.0-1.0)
  final double height;
  final String gender; // 'male' or 'female'

  const MuscleBodyWidget({
    super.key,
    required this.muscleRecovery,
    this.height = 400,
    this.gender = 'male', // Default to male
  });

  @override
  State<MuscleBodyWidget> createState() => _MuscleBodyWidgetState();
}

class _MuscleBodyWidgetState extends State<MuscleBodyWidget>
    with SingleTickerProviderStateMixin {
  bool _showFront = true;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  String? _frontSvg;
  String? _backSvg;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _flipAnimation = Tween<double>(begin: 0, end: math.pi).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
    _loadSvgs();
  }

  Future<void> _loadSvgs() async {
    try {
      final prefix = widget.gender == 'female' ? 'woman' : 'man';
      final front = await rootBundle.loadString('assets/images/$prefix-front.svg');
      final back = await rootBundle.loadString('assets/images/$prefix-back.svg');

      setState(() {
        _frontSvg = front;
        _backSvg = back;
        _isLoading = false;
      });
      _debugSvgIds();
    } catch (e) {
      debugPrint('Error loading SVGs: $e');
      setState(() => _isLoading = false);
    }
  }

  void _debugSvgIds() {
    if (_frontSvg == null) return;

    // Check front SVG
    final frontMuscleMap = _getMuscleMap(true);
    final frontIds = RegExp(r'id="(muscle-\d+)"').allMatches(_frontSvg!).map((m) => m.group(1)!).toSet();

    debugPrint('🔍 SVG FRONT contains ${frontIds.length} muscle IDs');

    for (final entry in frontMuscleMap.entries) {
      for (final id in entry.value) {
        if (!frontIds.contains(id)) {
          debugPrint('❌ MISSING: $id (mapped to ${entry.key}) NOT FOUND in front SVG!');
        }
      }
    }

    final frontMappedIds = frontMuscleMap.values.expand((ids) => ids).toSet();
    final frontUnmapped = frontIds.difference(frontMappedIds);
    if (frontUnmapped.isNotEmpty) {
      debugPrint('⚠️ UNMAPPED front SVG IDs: ${frontUnmapped.toList()..sort()}');
    }

    // Check back SVG
    if (_backSvg == null) return;
    final backMuscleMap = _getMuscleMap(false);
    final backIds = RegExp(r'id="(bMuscle-\d+)"').allMatches(_backSvg!).map((m) => m.group(1)!).toSet();

    debugPrint('🔍 SVG BACK contains ${backIds.length} muscle IDs');

    for (final entry in backMuscleMap.entries) {
      for (final id in entry.value) {
        if (!backIds.contains(id)) {
          debugPrint('❌ MISSING: $id (mapped to ${entry.key}) NOT FOUND in back SVG!');
        }
      }
    }

    final backMappedIds = backMuscleMap.values.expand((ids) => ids).toSet();
    final backUnmapped = backIds.difference(backMappedIds);
    if (backUnmapped.isNotEmpty) {
      debugPrint('⚠️ UNMAPPED back SVG IDs: ${backUnmapped.toList()..sort()}');
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flip() {
    if (_flipController.isAnimating) return;

    setState(() => _showFront = !_showFront);

    if (_showFront) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }

    HapticFeedback.mediumImpact();
  }

  Color _getColorForRecovery(double recovery) {
    if (recovery <= 0.3) return const Color(0xFFFF3333); // Red - Tired
    if (recovery <= 0.6) return const Color(0xFFFF8800); // Orange - Recovering
    if (recovery <= 0.8) return const Color(0xFFCCFF00); // Yellow - Almost ready
    return const Color(0xFF00FF00); // Green - Ready
  }

  String _colorizedSvg(String svg, bool isFront) {
    final muscleMap = _getMuscleMap(isFront);
    String colorized = svg;

    for (final entry in muscleMap.entries) {
      final muscleIds = entry.value;
      final muscleGroup = entry.key;
      final recovery = widget.muscleRecovery[muscleGroup] ?? 1.0;
      final color = _getColorForRecovery(recovery);
      final colorHex = '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

      for (final muscleId in muscleIds) {
        // APPROACH: Find the ENTIRE element tag containing this id, then replace fill within it
        // This handles ANY order of attributes and ANY fill format

        final elementPattern = RegExp(
          r'(<(?:path|polygon|ellipse|rect|circle|g)\b[^>]*\bid="' + RegExp.escape(muscleId) + r'"[^>]*>)',
          caseSensitive: true,
        );

        colorized = colorized.replaceAllMapped(elementPattern, (match) {
          String element = match.group(0)!;

          // Replace fill="..." attribute (any value including url(...))
          element = element.replaceAll(RegExp(r'fill="[^"]*"'), 'fill="$colorHex"');

          // Replace fill inside style="..."
          element = element.replaceAllMapped(
            RegExp(r'(style="[^"]*?)fill\s*:\s*[^;"]*'),
            (m) => '${m.group(1)}fill:$colorHex',
          );

          // If NO fill attribute exists at all, add one before the closing >
          if (!element.contains('fill=')) {
            element = element.replaceFirst('>', ' fill="$colorHex">');
          }

          return element;
        });

        // ALSO handle elements where id comes AFTER other attributes
        // Pattern: <path fill="..." ... id="muscleId" ...>
        final reversePattern = RegExp(
          r'(<(?:path|polygon|ellipse|rect|circle|g)\b[^>]*?)fill="[^"]*"([^>]*\bid="' + RegExp.escape(muscleId) + r'"[^>]*>)',
          caseSensitive: true,
        );

        colorized = colorized.replaceAllMapped(reversePattern, (match) {
          return '${match.group(1)}fill="$colorHex"${match.group(2)}';
        });
      }
    }

    return colorized;
  }

  Map<String, List<String>> _getMuscleMap(bool isFront) {
    if (isFront) {
      // Front view muscle mappings - ALL muscle IDs mapped for complete coverage
      return {
        'chest': ['muscle-0', 'muscle-19', 'muscle-35', 'muscle-36'], // Pectorals
        'shoulders': ['muscle-3', 'muscle-17', 'muscle-18', 'muscle-4', 'muscle-5', 'muscle-6', 'muscle-37', 'muscle-38'], // Deltoids
        'biceps': ['muscle-7', 'muscle-8', 'muscle-9', 'muscle-39', 'muscle-40'], // Biceps
        'forearms': ['muscle-10', 'muscle-11', 'muscle-12', 'muscle-24', 'muscle-41', 'muscle-42'], // Forearms
        'abs': ['muscle-20', 'muscle-21', 'muscle-27', 'muscle-28', 'muscle-43', 'muscle-44', 'muscle-45'], // Abdominals & obliques
        'quadriceps': ['muscle-13', 'muscle-14', 'muscle-15', 'muscle-16', 'muscle-29', 'muscle-30', 'muscle-31', 'muscle-32'], // Quads
        'calves': ['muscle-25', 'muscle-26', 'muscle-33', 'muscle-34'], // Gastrocnemius
        'neck': ['muscle-22', 'muscle-23'], // Neck muscles
      };
    } else {
      // Back view muscle mappings - ALL bMuscle IDs for complete coverage
      return {
        'traps': ['bMuscle-0', 'bMuscle-18'], // Trapezius (both sides)
        'lats': ['bMuscle-3', 'bMuscle-4', 'bMuscle-19', 'bMuscle-30', 'bMuscle-31'], // Latissimus dorsi
        'shoulders': ['bMuscle-5', 'bMuscle-6', 'bMuscle-20', 'bMuscle-32', 'bMuscle-33'], // Rear deltoids
        'triceps': ['bMuscle-7', 'bMuscle-8', 'bMuscle-21', 'bMuscle-22', 'bMuscle-34', 'bMuscle-35'], // Triceps
        'lower_back': ['bMuscle-10', 'bMuscle-11', 'bMuscle-12', 'bMuscle-36', 'bMuscle-37'], // Erector spinae
        'glutes': ['bMuscle-13', 'bMuscle-14', 'bMuscle-38'], // Gluteus maximus
        'hamstrings': ['bMuscle-15', 'bMuscle-16', 'bMuscle-17', 'bMuscle-23', 'bMuscle-24'], // Hamstrings
        'calves': ['bMuscle-9', 'bMuscle-25', 'bMuscle-26', 'bMuscle-27'], // Gastrocnemius & soleus
        'forearms': ['bMuscle-28', 'bMuscle-29'], // Forearms back
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return SizedBox(
        height: widget.height,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColors.cyberLime),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: _flip,
      child: SizedBox(
        height: widget.height,
        child: Stack(
          children: [
            // The rotating body diagram
            AnimatedBuilder(
              animation: _flipAnimation,
              builder: (context, child) {
                final angle = _flipAnimation.value;
                final isFrontVisible = angle < math.pi / 2;

                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  child: Container(
                    height: widget.height,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 2,
                      ),
                    ),
                    child: isFrontVisible && _frontSvg != null
                        ? Center(
                            child: SizedBox(
                              height: widget.height * 0.9,
                              child: _buildSvgWidget(_colorizedSvg(_frontSvg!, true)),
                            ),
                          )
                        : (!isFrontVisible && _backSvg != null
                            ? Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                                child: Center(
                                  child: SizedBox(
                                    height: widget.height * 0.9,
                                    child: _buildSvgWidget(_colorizedSvg(_backSvg!, false)),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink()),
                  ),
                );
              },
            ),

            // Legend — NOT inside the rotating transform
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: _buildLegend(),
            ),

            // Flip indicator — NOT inside the rotating transform
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cyberLime, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.autorenew,
                      color: AppColors.cyberLime,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _showFront ? 'FRONT' : 'BACK',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.cyberLime,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSvgWidget(String svgString) {
    return SvgPicture.string(
      svgString,
      fit: BoxFit.contain,
      placeholderBuilder: (context) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.cyberLime),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLegendItem('Ready', const Color(0xFF00FF00)),
          const SizedBox(width: 8),
          _buildLegendItem('Almost', const Color(0xFFCCFF00)),
          const SizedBox(width: 8),
          _buildLegendItem('Recovering', const Color(0xFFFF8800)),
          const SizedBox(width: 8),
          _buildLegendItem('Tired', const Color(0xFFFF3333)),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
