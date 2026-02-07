import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../../utils/app_colors.dart';
import 'form_checker.dart';
import 'premium_skeleton_painter.dart';

class FormReportCardScreen extends StatefulWidget {
  final File capturedImage;
  final FormCheckResult result;
  final Map<PoseLandmarkType, PoseLandmark> landmarks;
  final Size imageSize;
  final String exerciseName;
  const FormReportCardScreen({super.key, required this.capturedImage, required this.result, required this.landmarks, required this.imageSize, required this.exerciseName});
  @override
  State<FormReportCardScreen> createState() => _FormReportCardScreenState();
}

class _FormReportCardScreenState extends State<FormReportCardScreen> with SingleTickerProviderStateMixin {
  final GlobalKey _reportKey = GlobalKey();
  late AnimationController _animController;
  late Animation<double> _slideAnimation, _fadeAnimation;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _slideAnimation = Tween<double>(begin: 100, end: 0).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() { _animController.dispose(); super.dispose(); }

  Color get _scoreColor => widget.result.formScore >= 90 ? const Color(0xFF00F0FF) : widget.result.formScore >= 70 ? AppColors.cyberLime : widget.result.formScore >= 50 ? const Color(0xFFFFB800) : const Color(0xFFFF003C);
  String get _grade => widget.result.formScore >= 95 ? 'S' : widget.result.formScore >= 90 ? 'A+' : widget.result.formScore >= 85 ? 'A' : widget.result.formScore >= 80 ? 'B+' : widget.result.formScore >= 70 ? 'B' : widget.result.formScore >= 60 ? 'C' : widget.result.formScore >= 50 ? 'D' : 'F';
  String get _verdict => widget.result.formScore >= 90 ? 'PERFECT FORM' : widget.result.formScore >= 70 ? 'GOOD FORM' : widget.result.formScore >= 50 ? 'NEEDS WORK' : 'FIX YOUR FORM';

  Future<void> _share() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    HapticFeedback.mediumImpact();
    try {
      await Future.delayed(const Duration(milliseconds: 100));
      final boundary = _reportKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) { setState(() => _isSharing = false); return; }
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) { setState(() => _isSharing = false); return; }
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/form_report_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      await Share.shareXFiles([XFile(file.path)], text: '${widget.exerciseName.toUpperCase()} FORM CHECK\n${widget.result.formScore}% - $_verdict\n\n💀 Analyzed by FitnessOS\n#FormCheck #FitnessOS #SkeletonMode');
    } catch (e) { debugPrint('Share error: $e'); }
    setState(() => _isSharing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050810),
      body: AnimatedBuilder(
        animation: _animController,
        builder: (context, child) => Stack(
          children: [
            Container(decoration: BoxDecoration(gradient: RadialGradient(center: Alignment.topCenter, radius: 1.5, colors: [_scoreColor.withOpacity(0.15), const Color(0xFF050810)]))),
            SafeArea(
              child: Column(
                children: [
                  Padding(padding: const EdgeInsets.all(16), child: Row(children: [GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.close, color: Colors.white, size: 22))), const Expanded(child: Text('FORM REPORT', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 2))), const SizedBox(width: 42)])),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Transform.translate(
                        offset: Offset(0, _slideAnimation.value),
                        child: Opacity(
                          opacity: _fadeAnimation.value,
                          child: RepaintBoundary(
                            key: _reportKey,
                            child: Container(
                              decoration: BoxDecoration(color: const Color(0xFF0A0E1A), borderRadius: BorderRadius.circular(28), border: Border.all(color: _scoreColor.withOpacity(0.4), width: 2), boxShadow: [BoxShadow(color: _scoreColor.withOpacity(0.25), blurRadius: 40)]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
                                    child: AspectRatio(
                                      aspectRatio: 3 / 4,
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.file(widget.capturedImage, fit: BoxFit.cover),
                                          Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.4)], stops: const [0.5, 1.0]))),
                                          CustomPaint(painter: PremiumSkeletonPainter(landmarks: widget.landmarks, imageSize: widget.imageSize, isFrontCamera: true, formScore: widget.result.formScore, faults: widget.result.faults, showAngles: true)),
                                          Positioned(top: 16, left: 16, child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(24), border: Border.all(color: _scoreColor.withOpacity(0.5))), child: Row(mainAxisSize: MainAxisSize.min, children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: _scoreColor, shape: BoxShape.circle, boxShadow: [BoxShadow(color: _scoreColor, blurRadius: 6)])), const SizedBox(width: 8), Text(widget.exerciseName.toUpperCase(), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.white, letterSpacing: 1))]))),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(24),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('${widget.result.formScore}', style: TextStyle(fontSize: 72, fontWeight: FontWeight.w900, color: _scoreColor, height: 1, shadows: [Shadow(color: _scoreColor.withOpacity(0.5), blurRadius: 20)])), Padding(padding: const EdgeInsets.only(bottom: 12, left: 4), child: Text('%', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: _scoreColor.withOpacity(0.7))))]),
                                              const SizedBox(height: 8),
                                              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: _scoreColor.withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: _scoreColor.withOpacity(0.3))), child: Text(_verdict, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: _scoreColor, letterSpacing: 1))),
                                            ],
                                          ),
                                        ),
                                        Container(width: 90, height: 90, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: _scoreColor, width: 4), boxShadow: [BoxShadow(color: _scoreColor.withOpacity(0.4), blurRadius: 24)]), child: Center(child: Text(_grade, style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: _scoreColor)))),
                                      ],
                                    ),
                                  ),
                                  if (widget.result.faults.isNotEmpty) Padding(
                                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(margin: const EdgeInsets.only(bottom: 16), height: 1, color: Colors.white.withOpacity(0.1)),
                                        Text('AREAS TO IMPROVE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(0.5), letterSpacing: 2)),
                                        const SizedBox(height: 12),
                                        ...widget.result.faults.take(3).map((f) {
                                          final col = f.severity == FaultSeverity.critical ? const Color(0xFFFF003C) : f.severity == FaultSeverity.high ? const Color(0xFFFFB800) : AppColors.cyberLime;
                                          return Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [Container(width: 4, height: 40, decoration: BoxDecoration(color: col, borderRadius: BorderRadius.circular(2))), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(f.message, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)), if (f.correction != null) Text(f.correction!, style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.6)))]))]));
                                        }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.white.withOpacity(0.1)))),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.auto_awesome, color: _scoreColor.withOpacity(0.6), size: 16), const SizedBox(width: 8), Text('ANALYZED BY ', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white.withOpacity(0.4), letterSpacing: 1)), ShaderMask(shaderCallback: (bounds) => LinearGradient(colors: [AppColors.cyberLime, const Color(0xFF00F0FF)]).createShader(bounds), child: const Text('FITNESSOS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 2)))]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _share,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            decoration: BoxDecoration(gradient: LinearGradient(colors: [_scoreColor, _scoreColor.withOpacity(0.7)]), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: _scoreColor.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))]),
                            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: _isSharing ? [const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.black)))] : [const Icon(Icons.share, color: Colors.black, size: 22), const SizedBox(width: 10), const Text('SHARE REPORT', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black, letterSpacing: 1))]),
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(onTap: () => Navigator.pop(context), child: Container(padding: const EdgeInsets.symmetric(vertical: 14), decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white.withOpacity(0.2))), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.refresh, color: Colors.white70, size: 18), SizedBox(width: 8), Text('RETAKE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white70))]))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

