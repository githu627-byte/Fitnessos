import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import '../widgets/glow_button.dart';
import '../models/workout_data.dart';
import '../widgets/exercise_animation_widget.dart';
// ExerciseSettings lives in custom_workouts_screen.dart - import from there
import 'custom_workouts_screen.dart' show ExerciseSettings;

/// ═══════════════════════════════════════════════════════════════════════════
/// WORKOUT REVIEW SCREEN - Full Screen Exercise Review & Config
/// ═══════════════════════════════════════════════════════════════════════════
/// Replaces the old DraggableScrollableSheet popup.
/// Opens full screen when user taps the FAB from custom_workouts_screen.
/// Shows selected exercises with preset buttons and clean set/rep/rest inputs.
/// ═══════════════════════════════════════════════════════════════════════════

class WorkoutReviewScreen extends StatefulWidget {
  final List<Exercise> selectedExercises;
  final Map<String, ExerciseSettings> exerciseSettings;
  final String workoutName;
  final String workoutEmoji;
  final String workoutMode;

  const WorkoutReviewScreen({
    super.key,
    required this.selectedExercises,
    required this.exerciseSettings,
    required this.workoutName,
    required this.workoutEmoji,
    required this.workoutMode,
  });

  @override
  State<WorkoutReviewScreen> createState() => _WorkoutReviewScreenState();
}

class _WorkoutReviewScreenState extends State<WorkoutReviewScreen> {
  late List<Exercise> _exercises;
  late Map<String, ExerciseSettings> _settings;
  String? _activePreset;

  @override
  void initState() {
    super.initState();
    _exercises = List.from(widget.selectedExercises);
    _settings = {};
    for (final entry in widget.exerciseSettings.entries) {
      _settings[entry.key] = entry.value.copyWith();
    }
  }

  void _applyPreset(String preset) {
    HapticFeedback.mediumImpact();
    setState(() {
      _activePreset = preset;
      for (final exercise in _exercises) {
        switch (preset) {
          case 'strength':
            _settings[exercise.id] = ExerciseSettings(sets: 4, reps: 3, restSeconds: 240);
            break;
          case 'hypertrophy':
            _settings[exercise.id] = ExerciseSettings(sets: 4, reps: 10, restSeconds: 120);
            break;
          case 'endurance':
            _settings[exercise.id] = ExerciseSettings(sets: 3, reps: 15, restSeconds: 60);
            break;
          case 'hiit':
            _settings[exercise.id] = ExerciseSettings(sets: 1, reps: 999, restSeconds: 20, timeSeconds: 40);
            break;
          case 'tabata':
            _settings[exercise.id] = ExerciseSettings(sets: 1, reps: 999, restSeconds: 10, timeSeconds: 20);
            break;
        }
      }
    });
  }

  void _removeExercise(Exercise exercise) {
    HapticFeedback.lightImpact();
    setState(() {
      _exercises.removeWhere((e) => e.id == exercise.id);
      _settings.remove(exercise.id);
    });
    if (_exercises.isEmpty) {
      Navigator.pop(context, {'exercises': <Exercise>[], 'settings': <String, ExerciseSettings>{}});
    }
  }

  void _commitWorkout() {
    HapticFeedback.heavyImpact();
    Navigator.pop(context, {'exercises': _exercises, 'settings': _settings, 'commit': true});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildPresetBar(),
            Expanded(
              child: _exercises.isEmpty
                  ? const Center(child: Text('No exercises added', style: TextStyle(color: AppColors.white50, fontSize: 16)))
                  : ReorderableListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                      itemCount: _exercises.length,
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) newIndex--;
                          final item = _exercises.removeAt(oldIndex);
                          _exercises.insert(newIndex, item);
                        });
                        HapticFeedback.selectionClick();
                      },
                      proxyDecorator: (child, index, animation) {
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (context, child) {
                            return Material(
                              color: Colors.transparent,
                              elevation: 8,
                              shadowColor: AppColors.cyberLime.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(16),
                              child: child,
                            );
                          },
                          child: child,
                        );
                      },
                      itemBuilder: (context, index) {
                        final exercise = _exercises[index];
                        final settings = _settings[exercise.id] ?? ExerciseSettings(sets: 3, reps: 10, restSeconds: 60);
                        return _buildExerciseItem(key: ValueKey(exercise.id), exercise: exercise, settings: settings, index: index);
                      },
                    ),
            ),
            _buildCommitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.white10))),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              Navigator.pop(context, {'exercises': _exercises, 'settings': _settings});
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: AppColors.white10, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.workoutName.isEmpty ? 'MY WORKOUT' : widget.workoutName.toUpperCase(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 0.5),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '${_exercises.length} exercise${_exercises.length == 1 ? '' : 's'} · ${widget.workoutMode == 'ai' ? 'AI Mode' : 'Manual Mode'}',
                  style: const TextStyle(fontSize: 12, color: AppColors.white50, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              setState(() { _exercises.clear(); _settings.clear(); });
              Navigator.pop(context, {'exercises': <Exercise>[], 'settings': <String, ExerciseSettings>{}});
            },
            child: const Text('CLEAR', style: TextStyle(color: AppColors.neonCrimson, fontSize: 12, fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildPresetChip('strength', '', 'STRENGTH', '3 reps · 4 sets · 4min'),
            const SizedBox(width: 8),
            _buildPresetChip('hypertrophy', '🔥', 'HYPERTROPHY', '10 reps · 4 sets · 2min'),
            const SizedBox(width: 8),
            _buildPresetChip('endurance', '⚡', 'ENDURANCE', '15 reps · 3 sets · 1min'),
            const SizedBox(width: 8),
            _buildPresetChip('hiit', '🏃', 'HIIT', '40s work · 20s rest'),
            const SizedBox(width: 8),
            _buildPresetChip('tabata', '💥', 'TABATA', '20s work · 10s rest'),
          ],
        ),
      ),
    );
  }

  Widget _buildPresetChip(String id, String emoji, String label, String subtitle) {
    final isActive = _activePreset == id;
    return GestureDetector(
      onTap: () => _applyPreset(id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.cyberLime.withOpacity(0.15) : AppColors.white5,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isActive ? AppColors.cyberLime : AppColors.white10, width: isActive ? 2 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: isActive ? AppColors.cyberLime : Colors.white, letterSpacing: 0.5)),
              ],
            ),
            const SizedBox(height: 2),
            Text(subtitle, style: TextStyle(fontSize: 9, color: isActive ? AppColors.cyberLime.withOpacity(0.7) : AppColors.white40, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseItem({required Key key, required Exercise exercise, required ExerciseSettings settings, required int index}) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: AppColors.white5, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.white10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 14, 8, 8),
            child: Row(
              children: [
                const Icon(Icons.drag_handle, color: AppColors.white30, size: 20),
                const SizedBox(width: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 48, height: 48, color: AppColors.white10,
                    child: ExerciseAnimationWidget(exerciseId: exercise.id, size: 48, showWatermark: false),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${index + 1}. ${exercise.name}', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Row(children: [
                        _buildSmallBadge(exercise.equipment, AppColors.cyberLime),
                        const SizedBox(width: 6),
                        _buildSmallBadge(exercise.difficulty, AppColors.white40),
                      ]),
                    ],
                  ),
                ),
                IconButton(icon: const Icon(Icons.close, color: AppColors.neonCrimson, size: 20), onPressed: () => _removeExercise(exercise), padding: EdgeInsets.zero, constraints: const BoxConstraints(minWidth: 36, minHeight: 36)),
              ],
            ),
          ),
          const Divider(color: AppColors.white10, height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
            child: settings.timeSeconds != null ? _buildTimeBasedRow(exercise.id, settings) : _buildRepBasedRow(exercise.id, settings),
          ),
        ],
      ),
    );
  }

  Widget _buildRepBasedRow(String exerciseId, ExerciseSettings settings) {
    return Row(children: [
      Expanded(child: _buildEditableField(label: 'SETS', value: settings.sets, color: AppColors.cyberLime, onChanged: (val) => setState(() { _settings[exerciseId] = settings.copyWith(sets: val.clamp(1, 20)); }))),
      const SizedBox(width: 10),
      Expanded(child: _buildEditableField(label: 'REPS', value: settings.reps, color: AppColors.cyberLime, onChanged: (val) => setState(() { _settings[exerciseId] = settings.copyWith(reps: val.clamp(1, 100)); }))),
      const SizedBox(width: 10),
      Expanded(child: _buildEditableField(label: 'REST', value: settings.restSeconds, suffix: 's', color: AppColors.white50, step: 15, onChanged: (val) => setState(() { _settings[exerciseId] = settings.copyWith(restSeconds: val.clamp(0, 600)); }))),
    ]);
  }

  Widget _buildTimeBasedRow(String exerciseId, ExerciseSettings settings) {
    return Row(children: [
      Expanded(child: _buildEditableField(label: 'WORK', value: settings.timeSeconds ?? 40, suffix: 's', color: AppColors.neonOrange, step: 5, onChanged: (val) => setState(() { _settings[exerciseId] = settings.copyWith(timeSeconds: val.clamp(5, 120)); }))),
      const SizedBox(width: 10),
      Expanded(child: _buildEditableField(label: 'REST', value: settings.restSeconds, suffix: 's', color: AppColors.white50, step: 5, onChanged: (val) => setState(() { _settings[exerciseId] = settings.copyWith(restSeconds: val.clamp(0, 120)); }))),
    ]);
  }

  Widget _buildEditableField({required String label, required int value, required Color color, required ValueChanged<int> onChanged, String suffix = '', int step = 1}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.white10)),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: color, letterSpacing: 1)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () { HapticFeedback.selectionClick(); onChanged(value - step); },
                child: Container(width: 28, height: 28, decoration: BoxDecoration(color: AppColors.white10, borderRadius: BorderRadius.circular(7)), child: const Icon(Icons.remove, color: Colors.white70, size: 16)),
              ),
              GestureDetector(
                onTap: () => _showNumberInput(label, value, suffix, step, onChanged),
                child: Container(width: 48, alignment: Alignment.center, child: Text('$value$suffix', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white))),
              ),
              GestureDetector(
                onTap: () { HapticFeedback.selectionClick(); onChanged(value + step); },
                child: Container(width: 28, height: 28, decoration: BoxDecoration(color: AppColors.white10, borderRadius: BorderRadius.circular(7)), child: const Icon(Icons.add, color: Colors.white70, size: 16)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showNumberInput(String label, int currentValue, String suffix, int step, ValueChanged<int> onChanged) {
    final controller = TextEditingController(text: '$currentValue');
    controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1)),
        content: TextField(
          controller: controller, autofocus: true, keyboardType: TextInputType.number, textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900),
          decoration: InputDecoration(
            suffixText: suffix,
            suffixStyle: const TextStyle(color: AppColors.white50, fontSize: 20, fontWeight: FontWeight.w700),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.cyberLime.withOpacity(0.5))),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.cyberLime, width: 2)),
          ),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onSubmitted: (val) { final p = int.tryParse(val); if (p != null) onChanged(p); Navigator.pop(ctx); },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCEL', style: TextStyle(color: AppColors.white50))),
          TextButton(onPressed: () { final p = int.tryParse(controller.text); if (p != null) onChanged(p); Navigator.pop(ctx); }, child: const Text('SET', style: TextStyle(color: AppColors.cyberLime, fontWeight: FontWeight.w900))),
        ],
      ),
    );
  }

  Widget _buildCommitButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(color: Colors.black, border: Border(top: BorderSide(color: AppColors.white10))),
      child: SafeArea(top: false, child: GlowButton(text: '✅ COMMIT WORKOUT', onPressed: _commitWorkout, padding: const EdgeInsets.symmetric(vertical: 18))),
    );
  }

  Widget _buildSmallBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(4)),
      child: Text(text.toUpperCase(), style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w700)),
    );
  }
}
