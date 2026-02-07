import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_styles.dart';

class PersonalInfoScreen extends StatefulWidget {
  final VoidCallback onNext;
  final Function(String, int, DateTime?, String, double, double, double) onSave;

  const PersonalInfoScreen({
    super.key,
    required this.onNext,
    required this.onSave,
  });

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightFeetController = TextEditingController();
  final _heightInchesController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetWeightController = TextEditingController();
  
  DateTime? _selectedDate;
  String _selectedGender = 'male';

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightFeetController.dispose();
    _heightInchesController.dispose();
    _weightController.dispose();
    _targetWeightController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)),
      firstDate: DateTime(1924),
      lastDate: DateTime.now().subtract(const Duration(days: 365 * 13)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.cyberLime,
              onPrimary: Colors.black,
              surface: Color(0xFF1a1a1a),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // Auto-calculate age
        final age = DateTime.now().year - picked.year;
        _ageController.text = age.toString();
      });
    }
  }

  void _handleNext() {
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _heightFeetController.text.isEmpty ||
        _heightInchesController.text.isEmpty ||
        _weightController.text.isEmpty ||
        _targetWeightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: AppColors.neonCrimson,
        ),
      );
      return;
    }

    // Calculate total height in inches
    final feet = int.tryParse(_heightFeetController.text) ?? 0;
    final inches = int.tryParse(_heightInchesController.text) ?? 0;
    final totalHeight = (feet * 12) + inches.toDouble();

    widget.onSave(
      _nameController.text,
      int.parse(_ageController.text),
      _selectedDate,
      _selectedGender,
      totalHeight,
      double.parse(_weightController.text),
      double.parse(_targetWeightController.text),
    );
    widget.onNext();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.blackGradient,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Let\'s get to know you',
                style: AppTextStyles.h1,
              ),
              const SizedBox(height: 8),
              Text(
                'This helps us personalize your experience',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white60,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('Your name'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nameController,
                        style: AppTextStyles.bodyLarge,
                        decoration: const InputDecoration(
                          hintText: 'e.g., Alex',
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Date of Birth
                      _buildLabel('Date of Birth'),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                          decoration: BoxDecoration(
                            color: AppColors.white10,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _selectedDate != null 
                                  ? AppColors.cyberLime.withOpacity(0.3) 
                                  : AppColors.white20,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _selectedDate != null
                                    ? '${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}'
                                    : 'Select your birthday',
                                style: AppTextStyles.bodyLarge.copyWith(
                                  color: _selectedDate != null 
                                      ? Colors.white 
                                      : AppColors.white40,
                                ),
                              ),
                              Icon(
                                Icons.calendar_today,
                                color: _selectedDate != null 
                                    ? AppColors.cyberLime 
                                    : AppColors.white40,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      _buildLabel('Age'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        style: AppTextStyles.bodyLarge,
                        decoration: InputDecoration(
                          hintText: _selectedDate != null ? 'Auto-calculated' : 'e.g., 28',
                          enabled: _selectedDate == null,
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Gender
                      _buildLabel('Gender'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildGenderOption('Male', 'male'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildGenderOption('Female', 'female'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildGenderOption('Other', 'other'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Height
                      _buildLabel('Height'),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _heightFeetController,
                              keyboardType: TextInputType.number,
                              style: AppTextStyles.bodyLarge,
                              decoration: const InputDecoration(
                                hintText: 'Feet',
                                suffixText: 'ft',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _heightInchesController,
                              keyboardType: TextInputType.number,
                              style: AppTextStyles.bodyLarge,
                              decoration: const InputDecoration(
                                hintText: 'Inches',
                                suffixText: 'in',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      _buildLabel('Current weight (lbs)'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _weightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: AppTextStyles.bodyLarge,
                        decoration: const InputDecoration(
                          hintText: 'e.g., 185',
                          suffixText: 'lbs',
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      _buildLabel('Target weight (lbs)'),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _targetWeightController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: AppTextStyles.bodyLarge,
                        decoration: const InputDecoration(
                          hintText: 'e.g., 175',
                          suffixText: 'lbs',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleNext,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('CONTINUE'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String label, String value) {
    final isSelected = _selectedGender == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cyberLime.withOpacity(0.2) : AppColors.white10,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.cyberLime : AppColors.white20,
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isSelected ? AppColors.cyberLime : AppColors.white70,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.labelMedium.copyWith(
        color: AppColors.white70,
        fontSize: 14,
      ),
    );
  }
}

