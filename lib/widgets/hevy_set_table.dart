import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../models/workout_set_model.dart';

/// Set logging table with weight/reps inputs and completion checkmarks
class HevySetTable extends StatefulWidget {
  final List<WorkoutSet> sets;
  final List<WorkoutSet>? previousSets;
  final Function(int setIndex) onCompleteSet;
  final Function(int setIndex, double? weight) onUpdateWeight;
  final Function(int setIndex, int? reps) onUpdateReps;

  const HevySetTable({
    super.key,
    required this.sets,
    this.previousSets,
    required this.onCompleteSet,
    required this.onUpdateWeight,
    required this.onUpdateReps,
  });

  @override
  State<HevySetTable> createState() => _HevySetTableState();
}

class _HevySetTableState extends State<HevySetTable> {
  final Map<int, TextEditingController> _weightControllers = {};
  final Map<int, TextEditingController> _repsControllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  @override
  void didUpdateWidget(HevySetTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sets.length != widget.sets.length) {
      _initializeControllers();
    }
  }

  @override
  void dispose() {
    for (var controller in _weightControllers.values) {
      controller.dispose();
    }
    for (var controller in _repsControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _initializeControllers() {
    // Dispose old controllers
    for (var controller in _weightControllers.values) {
      controller.dispose();
    }
    for (var controller in _repsControllers.values) {
      controller.dispose();
    }
    
    _weightControllers.clear();
    _repsControllers.clear();

    // Create new controllers
    for (int i = 0; i < widget.sets.length; i++) {
      final set = widget.sets[i];
      _weightControllers[i] = TextEditingController(
        text: set.weight != null ? set.weight!.toStringAsFixed(1) : '',
      );
      _repsControllers[i] = TextEditingController(
        text: set.reps != null ? set.reps.toString() : '',
      );
    }
  }

  int _getFirstIncompleteIndex() {
    for (int i = 0; i < widget.sets.length; i++) {
      if (!widget.sets[i].isCompleted) {
        return i;
      }
    }
    return widget.sets.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Table header
        _buildTableHeader(),
        
        const SizedBox(height: 8),
        
        // Set rows
        ...List.generate(
          widget.sets.length,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _buildSetRow(index),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              'SET',
              style: _headerStyle,
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              'PREVIOUS',
              style: _headerStyle,
            ),
          ),
          Expanded(
            child: Text(
              'WEIGHT',
              style: _headerStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'REPS',
              style: _headerStyle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              '✓',
              style: _headerStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetRow(int index) {
    final set = widget.sets[index];
    final previousSet = widget.previousSets != null && index < widget.previousSets!.length
        ? widget.previousSets![index]
        : null;
    
    final isCompleted = set.isCompleted;
    final isActive = !isCompleted && index == _getFirstIncompleteIndex();
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.cyberLime.withOpacity(0.1) : null,
        border: isActive ? Border.all(color: AppColors.cyberLime, width: 2) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Set number
          SizedBox(
            width: 40,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: isCompleted ? AppColors.cyberLime : Colors.white,
              ),
            ),
          ),
          
          // Previous performance
          SizedBox(
            width: 80,
            child: Text(
              previousSet != null && previousSet.weight != null && previousSet.reps != null
                  ? '${previousSet.weight!.toInt()}×${previousSet.reps}'
                  : '-',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.white50,
              ),
            ),
          ),
          
          // Weight input
          Expanded(
            child: _buildWeightInput(set, index, isActive, isCompleted),
          ),
          
          // Reps input
          Expanded(
            child: _buildRepsInput(set, index, isActive, isCompleted),
          ),
          
          // Complete button
          SizedBox(
            width: 40,
            child: _buildCompleteButton(set, index),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightInput(WorkoutSet set, int index, bool isActive, bool isCompleted) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.white5 : AppColors.white10,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? AppColors.cyberLime : AppColors.white20,
          width: isActive ? 2 : 1,
        ),
      ),
      child: TextField(
        enabled: !isCompleted,
        controller: _weightControllers[index],
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: isCompleted ? AppColors.white50 : Colors.white,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '-',
          hintStyle: TextStyle(color: AppColors.white30),
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
        ],
        onChanged: (value) {
          final weight = double.tryParse(value);
          widget.onUpdateWeight(index, weight);
        },
      ),
    );
  }

  Widget _buildRepsInput(WorkoutSet set, int index, bool isActive, bool isCompleted) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isCompleted ? AppColors.white5 : AppColors.white10,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isActive ? AppColors.cyberLime : AppColors.white20,
          width: isActive ? 2 : 1,
        ),
      ),
      child: TextField(
        enabled: !isCompleted,
        controller: _repsControllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: isCompleted ? AppColors.white50 : Colors.white,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '-',
          hintStyle: TextStyle(color: AppColors.white30),
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          final reps = int.tryParse(value);
          widget.onUpdateReps(index, reps);
        },
      ),
    );
  }

  Widget _buildCompleteButton(WorkoutSet set, int index) {
    if (set.isCompleted) {
      return const Icon(
        Icons.check_circle,
        color: AppColors.cyberLime,
        size: 24,
      );
    }
    
    final canComplete = set.weight != null && set.reps != null;
    
    return GestureDetector(
      onTap: canComplete ? () => widget.onCompleteSet(index) : null,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: canComplete ? AppColors.cyberLime : AppColors.white30,
            width: 2,
          ),
        ),
        child: canComplete
            ? Container(
                margin: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.cyberLime.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }

  final _headerStyle = const TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.white50,
    letterSpacing: 1,
  );
}

