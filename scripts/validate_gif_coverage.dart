import 'dart:io';
import 'package:fitnessos/models/workout_data.dart';
import 'package:fitnessos/services/exercise_gif_service.dart';

/// Validation script to check which exercises have GIFs
void main() {
  print('🔍 Validating exercise GIF coverage...\n');
  
  int totalExercises = 0;
  int foundGifs = 0;
  int missingGifs = 0;
  final List<String> missing = [];
  final List<String> found = [];
  
  // Check all exercises in muscle splits
  WorkoutData.muscleSplits.forEach((category, exercises) {
    for (final exercise in exercises) {
      totalExercises++;
      final hasGif = ExerciseGifService.hasGif(exercise.id);
      
      if (hasGif) {
        foundGifs++;
        found.add('✓ ${exercise.id} (${exercise.name})');
      } else {
        missingGifs++;
        missing.add('✗ ${exercise.id} (${exercise.name})');
      }
    }
  });
  
  // Check cardio exercises
  for (final exercise in WorkoutData.cardioExercises) {
    totalExercises++;
    final hasGif = ExerciseGifService.hasGif(exercise.id);
    
    if (hasGif) {
      foundGifs++;
      found.add('✓ ${exercise.id} (${exercise.name})');
    } else {
      missingGifs++;
      missing.add('✗ ${exercise.id} (${exercise.name})');
    }
  }
  
  print('📊 Summary:');
  print('  Total exercises: $totalExercises');
  print('  Found GIFs: $foundGifs (${(foundGifs / totalExercises * 100).toStringAsFixed(1)}%)');
  print('  Missing GIFs: $missingGifs (${(missingGifs / totalExercises * 100).toStringAsFixed(1)}%)');
  print('');
  
  if (missingGifs > 0) {
    print('⚠️  Missing GIFs (${missingGifs}):');
    for (final item in missing) {
      print('  $item');
    }
  }
  
  print('\n✅ Validation complete!');
  
  // Test a few sample exercises
  print('\n🧪 Sample GIF Paths:');
  final samples = ['bench_press', 'squat', 'deadlift', 'pushups', 'pullups'];
  for (final id in samples) {
    final path = ExerciseGifService.getGifPath(id);
    print('  $id: ${path ?? "NOT FOUND"}');
  }
}

