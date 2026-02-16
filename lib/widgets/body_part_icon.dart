import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/app_colors.dart';

/// Anatomical SVG icon with highlighted muscle group.
/// Uses the same SVG files as the recovery body visualization.
/// Target muscle group glows in [highlightColor] (default cyber lime).
/// Everything else is dimmed to near-invisible.
///
/// Usage:
///   BodyPartIcon(bodyPart: 'chest', size: 80)
///   BodyPartIcon(bodyPart: 'glutes', size: 80, highlightColor: Color(0xFFEC4899))
///   BodyPartIcon(bodyPart: 'full_body', size: 80) // Everything lit
class BodyPartIcon extends StatefulWidget {
  final String bodyPart;
  final double size;
  final Color highlightColor;
  final Color dimColor;
  final String gender;
  final bool showFront;

  const BodyPartIcon({
    super.key,
    required this.bodyPart,
    this.size = 80,
    this.highlightColor = AppColors.cyberLime,
    this.dimColor = const Color(0x0FFFFFFF), // rgba(255,255,255,0.06)
    this.gender = 'male',
    this.showFront = true,
  });

  @override
  State<BodyPartIcon> createState() => _BodyPartIconState();
}

class _BodyPartIconState extends State<BodyPartIcon> {
  String? _svgString;

  // Static SVG cache — prevents re-loading from disk
  static final Map<String, String> _svgCache = {};
  static final Map<String, String> _colorizedCache = {};

  @override
  void initState() {
    super.initState();
    _loadSvg();
  }

  @override
  void didUpdateWidget(BodyPartIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bodyPart != widget.bodyPart ||
        oldWidget.gender != widget.gender ||
        oldWidget.showFront != widget.showFront ||
        oldWidget.highlightColor != widget.highlightColor) {
      _loadSvg();
    }
  }

  Future<void> _loadSvg() async {
    try {
      final useFront = _shouldUseFront();
      final prefix = widget.gender == 'female' ? 'woman' : 'man';
      final view = useFront ? 'front' : 'back';
      final cacheKey = '${prefix}_$view';

      // Check raw SVG cache
      String svgRaw;
      if (_svgCache.containsKey(cacheKey)) {
        svgRaw = _svgCache[cacheKey]!;
      } else {
        svgRaw = await rootBundle.loadString('assets/images/$prefix-$view.svg');
        _svgCache[cacheKey] = svgRaw;
      }

      // Check colorized cache
      final colorKey = '${cacheKey}_${widget.bodyPart}_${_colorToHex(widget.highlightColor)}';
      String colorized;
      if (_colorizedCache.containsKey(colorKey)) {
        colorized = _colorizedCache[colorKey]!;
      } else {
        colorized = _colorize(svgRaw, useFront);
        _colorizedCache[colorKey] = colorized;
      }

      if (mounted) setState(() => _svgString = colorized);
    } catch (e) {
      debugPrint('BodyPartIcon: Error loading SVG: $e');
    }
  }

  /// Some body parts look better from front, some from back
  bool _shouldUseFront() {
    const backParts = ['back', 'lats', 'traps', 'lower_back', 'hamstrings', 'rear_delts', 'glutes'];
    if (backParts.contains(widget.bodyPart.toLowerCase())) return false;
    return widget.showFront;
  }

  /// Colorize the SVG:
  /// Step 1: Nuclear dim — replace ALL colors with near-black
  /// Step 2: Re-color ONLY the target muscle IDs with highlightColor
  String _colorize(String svg, bool isFront) {
    final targetMuscleIds = _getTargetMuscleIds(isFront);
    final highlightHex = _colorToHex(widget.highlightColor);

    // ═══════════════════════════════════════════════════════════════════
    // STEP 1: DIM ENTIRE SVG
    // Replace ALL color values with dim grey - this catches everything:
    // skin, outlines, muscles, gradients, strokes, EVERYTHING
    // ═══════════════════════════════════════════════════════════════════

    String result = svg;

    // Dim color for body silhouette (very subtle, barely visible)
    const dimFill = '#1A1A1A';      // Near-black fill for body shape
    const dimStroke = '#222222';     // Very dark stroke for outlines

    // Replace ALL hex colors in fill attributes
    result = result.replaceAll(RegExp(r'fill="#[0-9A-Fa-f]{3,8}"'), 'fill="$dimFill"');

    // Replace ALL rgb/rgba fills
    result = result.replaceAll(RegExp(r'fill="rgb\([^)]+\)"'), 'fill="$dimFill"');
    result = result.replaceAll(RegExp(r'fill="rgba\([^)]+\)"'), 'fill="$dimFill"');

    // Replace gradient stop colors
    result = result.replaceAll(RegExp(r'stop-color:#[0-9A-Fa-f]{3,8}'), 'stop-color:$dimFill');
    result = result.replaceAll(RegExp(r'stop-color="#[0-9A-Fa-f]{3,8}"'), 'stop-color="$dimFill"');

    // Replace stroke colors
    result = result.replaceAll(RegExp(r'stroke="#[0-9A-Fa-f]{3,8}"'), 'stroke="$dimStroke"');
    result = result.replaceAll(RegExp(r'stroke="rgb\([^)]+\)"'), 'stroke="$dimStroke"');

    // Also handle style="fill:#XXXXX" inline styles
    result = result.replaceAll(RegExp(r'fill:\s*#[0-9A-Fa-f]{3,8}'), 'fill:$dimFill');
    result = result.replaceAll(RegExp(r'stroke:\s*#[0-9A-Fa-f]{3,8}'), 'stroke:$dimStroke');

    // Handle url() gradient references — replace with dim
    result = result.replaceAll(RegExp(r'fill="url\(#[^)]+\)"'), 'fill="$dimFill"');

    // ═══════════════════════════════════════════════════════════════════
    // STEP 2: HIGHLIGHT ONLY TARGET MUSCLE IDS
    // Now go through ONLY the specific muscle path IDs and color them
    // ═══════════════════════════════════════════════════════════════════

    for (final muscleId in targetMuscleIds) {
      // Handle: <path id="muscle-X" ... fill="..." ...>
      result = result.replaceAllMapped(
        RegExp('(<[^>]*id="$muscleId"[^>]*?)fill="[^"]*"'),
        (match) => '${match.group(1)}fill="$highlightHex"',
      );

      // Handle: <path fill="..." ... id="muscle-X" ...> (fill comes before id)
      result = result.replaceAllMapped(
        RegExp('(<[^>]*?)fill="[^"]*"([^>]*id="$muscleId")'),
        (match) => '${match.group(1)}fill="$highlightHex"${match.group(2)}',
      );

      // Handle inline style: style="fill:#XXXXX" on muscle elements
      result = result.replaceAllMapped(
        RegExp('(<[^>]*id="$muscleId"[^>]*?)style="([^"]*?)fill:[^;"]*'),
        (match) => '${match.group(1)}style="${match.group(2)}fill:$highlightHex',
      );
    }

    return result;
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2, 8).toUpperCase()}';
  }

  List<String> _getTargetMuscleIds(bool isFront) {
    final bp = widget.bodyPart.toLowerCase();

    if (bp == 'full_body' || bp == 'fullbody' || bp == 'full') {
      return _getAllMuscleIds(isFront);
    }

    if (isFront) {
      return _frontMuscleMap[bp] ?? [];
    } else {
      return _backMuscleMap[bp] ?? [];
    }
  }

  List<String> _getAllMuscleIds(bool isFront) {
    if (isFront) {
      return _frontMuscleMap.values.expand((ids) => ids).toList();
    } else {
      return _backMuscleMap.values.expand((ids) => ids).toList();
    }
  }

  // Muscle ID maps — same IDs as MuscleBodyWidget._getMuscleMap()
  static const _frontMuscleMap = {
    'chest': ['muscle-0', 'muscle-19', 'muscle-1', 'muscle-2', 'muscle-35', 'muscle-36'],
    'shoulders': ['muscle-3', 'muscle-17', 'muscle-18', 'muscle-4', 'muscle-5', 'muscle-6', 'muscle-37', 'muscle-38'],
    'biceps': ['muscle-7', 'muscle-8', 'muscle-9', 'muscle-39', 'muscle-40'],
    'arms': ['muscle-7', 'muscle-8', 'muscle-9', 'muscle-39', 'muscle-40', 'muscle-10', 'muscle-11', 'muscle-12', 'muscle-24', 'muscle-41', 'muscle-42'],
    'forearms': ['muscle-10', 'muscle-11', 'muscle-12', 'muscle-24', 'muscle-41', 'muscle-42'],
    'abs': ['muscle-20', 'muscle-21', 'muscle-27', 'muscle-28', 'muscle-43', 'muscle-44', 'muscle-45'],
    'core': ['muscle-20', 'muscle-21', 'muscle-27', 'muscle-28', 'muscle-43', 'muscle-44', 'muscle-45'],
    'quadriceps': ['muscle-13', 'muscle-14', 'muscle-15', 'muscle-16', 'muscle-29', 'muscle-30', 'muscle-31', 'muscle-32'],
    'legs': ['muscle-13', 'muscle-14', 'muscle-15', 'muscle-16', 'muscle-29', 'muscle-30', 'muscle-31', 'muscle-32', 'muscle-25', 'muscle-26', 'muscle-33', 'muscle-34'],
    'calves': ['muscle-25', 'muscle-26', 'muscle-33', 'muscle-34'],
    'neck': ['muscle-22', 'muscle-23'],
  };

  static const _backMuscleMap = {
    'traps': ['bMuscle-0', 'bMuscle-18', 'bMuscle-1', 'bMuscle-2'],
    'back': [
      'bMuscle-0', 'bMuscle-18', 'bMuscle-1', 'bMuscle-2',           // traps
      'bMuscle-3', 'bMuscle-4', 'bMuscle-19', 'bMuscle-30', 'bMuscle-31', // lats
      'bMuscle-10', 'bMuscle-11', 'bMuscle-12', 'bMuscle-36', 'bMuscle-37', // lower back
    ],
    'lats': ['bMuscle-3', 'bMuscle-4', 'bMuscle-19', 'bMuscle-30', 'bMuscle-31'],
    'shoulders': ['bMuscle-5', 'bMuscle-6', 'bMuscle-20', 'bMuscle-32', 'bMuscle-33'],
    'rear_delts': ['bMuscle-5', 'bMuscle-6', 'bMuscle-20', 'bMuscle-32', 'bMuscle-33'],
    'triceps': ['bMuscle-7', 'bMuscle-8', 'bMuscle-21', 'bMuscle-22', 'bMuscle-34', 'bMuscle-35'],
    'arms': ['bMuscle-7', 'bMuscle-8', 'bMuscle-21', 'bMuscle-22', 'bMuscle-34', 'bMuscle-35', 'bMuscle-28', 'bMuscle-29'],
    'lower_back': ['bMuscle-10', 'bMuscle-11', 'bMuscle-12', 'bMuscle-36', 'bMuscle-37'],
    'glutes': ['bMuscle-13', 'bMuscle-14', 'bMuscle-38'],
    'hamstrings': ['bMuscle-15', 'bMuscle-16', 'bMuscle-17', 'bMuscle-23', 'bMuscle-24'],
    'legs': ['bMuscle-15', 'bMuscle-16', 'bMuscle-17', 'bMuscle-23', 'bMuscle-24', 'bMuscle-9', 'bMuscle-25', 'bMuscle-26', 'bMuscle-27'],
    'calves': ['bMuscle-9', 'bMuscle-25', 'bMuscle-26', 'bMuscle-27'],
    'forearms': ['bMuscle-28', 'bMuscle-29'],
  };

  @override
  Widget build(BuildContext context) {
    if (_svgString == null) {
      return Container(
        width: widget.size,
        height: widget.size * 1.25,
        decoration: BoxDecoration(
          color: AppColors.white5,
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    return RepaintBoundary(
      child: SizedBox(
        width: widget.size,
        height: widget.size * 1.25,
        child: SvgPicture.string(
          _svgString!,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
