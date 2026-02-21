import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/glow_button.dart';
import '../models/analytics_data.dart';
import '../services/analytics_service.dart';
import '../../../services/firebase_analytics_service.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// MEASUREMENTS INPUT SCREEN - Beautiful Bottom Sheet
/// ═══════════════════════════════════════════════════════════════════════════
/// A stunning bottom sheet for entering body measurements.
/// Includes progress photos, animated inputs, and save functionality.
/// ═══════════════════════════════════════════════════════════════════════════

class MeasurementsInputScreen extends StatefulWidget {
  final BodyMeasurement? existingMeasurement;
  final VoidCallback? onSaved;

  const MeasurementsInputScreen({
    super.key,
    this.existingMeasurement,
    this.onSaved,
  });

  static Future<bool?> show(BuildContext context, {BodyMeasurement? measurement}) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MeasurementsInputScreen(
        existingMeasurement: measurement,
      ),
    );
  }

  @override
  State<MeasurementsInputScreen> createState() => _MeasurementsInputScreenState();
}

class _MeasurementsInputScreenState extends State<MeasurementsInputScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animController;
  
  // Controllers
  final _weightController = TextEditingController();
  final _bodyFatController = TextEditingController();
  final _chestController = TextEditingController();
  final _armsController = TextEditingController();
  final _forearmsController = TextEditingController();
  final _waistController = TextEditingController();
  final _hipsController = TextEditingController();
  final _thighsController = TextEditingController();
  final _calvesController = TextEditingController();
  final _shouldersController = TextEditingController();
  final _neckController = TextEditingController();
  final _notesController = TextEditingController();
  
  List<XFile> _selectedPhotos = [];
  bool _isSaving = false;
  int _currentPhotoTypeIndex = 0;
  
  final _photoTypes = ['Front', 'Side', 'Back', 'Flexed'];

  @override
  void initState() {
    super.initState();
    FirebaseAnalyticsService().logMeasurementsOpened();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    )..forward();
    
    if (widget.existingMeasurement != null) {
      _loadExistingData();
    }
  }

  void _loadExistingData() {
    final m = widget.existingMeasurement!;
    _weightController.text = m.weight?.toString() ?? '';
    _bodyFatController.text = m.bodyFat?.toString() ?? '';
    _chestController.text = m.chest?.toString() ?? '';
    _armsController.text = m.arms?.toString() ?? '';
    _forearmsController.text = m.forearms?.toString() ?? '';
    _waistController.text = m.waist?.toString() ?? '';
    _hipsController.text = m.hips?.toString() ?? '';
    _thighsController.text = m.thighs?.toString() ?? '';
    _calvesController.text = m.calves?.toString() ?? '';
    _shouldersController.text = m.shoulders?.toString() ?? '';
    _neckController.text = m.neck?.toString() ?? '';
    _notesController.text = m.notes ?? '';
  }

  Future<void> _pickPhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
    );
    
    if (image != null) {
      setState(() {
        _selectedPhotos.add(image);
        if (_currentPhotoTypeIndex < _photoTypes.length - 1) {
          _currentPhotoTypeIndex++;
        }
      });
      HapticFeedback.mediumImpact();
    }
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();
    
    if (images.isNotEmpty) {
      setState(() {
        _selectedPhotos.addAll(images.take(4 - _selectedPhotos.length));
      });
      HapticFeedback.mediumImpact();
    }
  }

  Future<void> _saveData() async {
    setState(() => _isSaving = true);
    
    try {
      final measurement = BodyMeasurement(
        id: widget.existingMeasurement?.id ?? 
            DateTime.now().millisecondsSinceEpoch.toString(),
        date: DateTime.now(),
        weight: double.tryParse(_weightController.text),
        bodyFat: double.tryParse(_bodyFatController.text),
        chest: double.tryParse(_chestController.text),
        arms: double.tryParse(_armsController.text),
        forearms: double.tryParse(_forearmsController.text),
        waist: double.tryParse(_waistController.text),
        hips: double.tryParse(_hipsController.text),
        thighs: double.tryParse(_thighsController.text),
        calves: double.tryParse(_calvesController.text),
        shoulders: double.tryParse(_shouldersController.text),
        neck: double.tryParse(_neckController.text),
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );
      
      await AnalyticsService.saveMeasurement(measurement);
      FirebaseAnalyticsService().logMeasurementLogged(type: 'body_measurements');

      // Save photos
      for (int i = 0; i < _selectedPhotos.length; i++) {
        final photo = ProgressPhoto(
          id: '${measurement.id}_photo_$i',
          date: DateTime.now(),
          imagePath: _selectedPhotos[i].path,
          type: _photoTypes[i % _photoTypes.length].toLowerCase(),
          associatedMeasurementId: measurement.id,
        );
        await AnalyticsService.saveProgressPhoto(photo);
      }
      
      if (mounted) {
        HapticFeedback.heavyImpact();
        widget.onSaved?.call();
        Navigator.pop(context, true);
      }
    } catch (e) {
      debugPrint('Error saving measurement: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving: $e'),
            backgroundColor: AppColors.neonCrimson,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - _animController.value)),
          child: Opacity(
            opacity: _animController.value,
            child: child,
          ),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.92,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1A1A2E),
              Colors.black,
            ],
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.existingMeasurement == null 
                            ? 'NEW MEASUREMENT' 
                            : 'EDIT MEASUREMENT',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(DateTime.now()),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            
            // Form
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: bottomPadding + 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Photos section
                      _buildPhotosSection(),
                      
                      const SizedBox(height: 24),
                      
                      // Weight (highlighted)
                      _buildMeasurementField(
                        controller: _weightController,
                        label: 'BODY WEIGHT',
                        unit: 'kg',
                        icon: Icons.monitor_weight_rounded,
                        isHighlighted: true,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Body fat
                      _buildMeasurementField(
                        controller: _bodyFatController,
                        label: 'BODY FAT',
                        unit: '%',
                        icon: Icons.percent,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Section header
                      _buildSectionHeader('UPPER BODY'),
                      
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildMeasurementField(
                              controller: _chestController,
                              label: 'CHEST',
                              unit: 'cm',
                              icon: Icons.straighten,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildMeasurementField(
                              controller: _shouldersController,
                              label: 'SHOULDERS',
                              unit: 'cm',
                              icon: Icons.straighten,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildMeasurementField(
                              controller: _armsController,
                              label: 'ARMS',
                              unit: 'cm',
                              icon: Icons.fitness_center,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildMeasurementField(
                              controller: _forearmsController,
                              label: 'FOREARMS',
                              unit: 'cm',
                              icon: Icons.fitness_center,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      _buildMeasurementField(
                        controller: _neckController,
                        label: 'NECK',
                        unit: 'cm',
                        icon: Icons.straighten,
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Section header
                      _buildSectionHeader('CORE'),
                      
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildMeasurementField(
                              controller: _waistController,
                              label: 'WAIST',
                              unit: 'cm',
                              icon: Icons.straighten,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildMeasurementField(
                              controller: _hipsController,
                              label: 'HIPS',
                              unit: 'cm',
                              icon: Icons.straighten,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Section header
                      _buildSectionHeader('LOWER BODY'),
                      
                      const SizedBox(height: 12),
                      
                      Row(
                        children: [
                          Expanded(
                            child: _buildMeasurementField(
                              controller: _thighsController,
                              label: 'THIGHS',
                              unit: 'cm',
                              icon: Icons.straighten,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildMeasurementField(
                              controller: _calvesController,
                              label: 'CALVES',
                              unit: 'cm',
                              icon: Icons.straighten,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Notes
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: TextField(
                          controller: _notesController,
                          maxLines: 3,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Notes (optional)',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(16),
                            prefixIcon: Icon(
                              Icons.note,
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Save button
                      GlowButton(
                        text: _isSaving ? 'SAVING...' : 'SAVE MEASUREMENT',
                        onPressed: _isSaving ? () {} : _saveData,
                        glowColor: AppColors.cyberLime,
                        textColor: Colors.black,
                        backgroundColor: AppColors.cyberLime,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhotosSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.cyberLime.withOpacity(0.1),
            AppColors.neonPurple.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cyberLime.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.cyberLime.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.photo_camera,
                      color: AppColors.cyberLime,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'PROGRESS PHOTOS',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickPhoto,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cyberLime.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            size: 16,
                            color: AppColors.cyberLime,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Camera',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.cyberLime,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _pickFromGallery,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.photo_library,
                            size: 16,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Gallery',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          if (_selectedPhotos.isEmpty)
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white.withOpacity(0.3),
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add up to 4 progress photos',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedPhotos.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.cyberLime,
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(_selectedPhotos[index].path),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              _photoTypes[index % _photoTypes.length],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPhotos.removeAt(index);
                              });
                              HapticFeedback.lightImpact();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.cyberLime,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildMeasurementField({
    required TextEditingController controller,
    required String label,
    required String unit,
    required IconData icon,
    bool isHighlighted = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isHighlighted 
            ? AppColors.cyberLime.withOpacity(0.1) 
            : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isHighlighted 
              ? AppColors.cyberLime.withOpacity(0.4) 
              : Colors.white.withOpacity(0.1),
          width: isHighlighted ? 2 : 1,
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: isHighlighted ? AppColors.cyberLime : Colors.white.withOpacity(0.5),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                  color: isHighlighted ? AppColors.cyberLime : Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(
                    fontSize: isHighlighted ? 28 : 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '-',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                ),
              ),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  void dispose() {
    _animController.dispose();
    _weightController.dispose();
    _bodyFatController.dispose();
    _chestController.dispose();
    _armsController.dispose();
    _forearmsController.dispose();
    _waistController.dispose();
    _hipsController.dispose();
    _thighsController.dispose();
    _calvesController.dispose();
    _shouldersController.dispose();
    _neckController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
