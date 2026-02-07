import 'dart:io';

/// Script to scan exercise GIF folders and generate mapping file
void main() async {
  print('🔍 Scanning exercise GIF folders...\n');
  
  final videosDir = Directory('assets/exercise_videos');
  if (!await videosDir.exists()) {
    print('❌ ERROR: assets/exercise_videos directory not found!');
    exit(1);
  }

  final Map<String, ExerciseGifInfo> exerciseMap = {};
  final List<String> errors = [];
  
  // Scan all subdirectories
  await for (final entity in videosDir.list()) {
    if (entity is Directory) {
      final folderName = entity.path.split('/').last;
      
      // Find MP4 files in this folder
      final mp4Files = <String>[];
      await for (final file in entity.list()) {
        if (file is File && file.path.endsWith('.mp4')) {
          mp4Files.add(file.path.split('/').last);
        }
      }
      
      if (mp4Files.isEmpty) {
        errors.add('No MP4s found in $folderName');
        continue;
      }
      
      // Extract exercise name from first MP4 filename
      final firstMp4 = mp4Files.first;
      final exerciseName = extractExerciseName(firstMp4);
      final normalizedId = normalizeExerciseName(exerciseName);
      
      exerciseMap[normalizedId] = ExerciseGifInfo(
        id: normalizedId,
        folderName: folderName,
        exerciseName: exerciseName,
        gifFiles: mp4Files,
        gif180: mp4Files.firstWhere((f) => f.contains('_180.mp4'), orElse: () => ''),
        gif360: mp4Files.firstWhere((f) => f.contains('_360.mp4'), orElse: () => ''),
        gif720: mp4Files.firstWhere((f) => f.contains('_720.mp4'), orElse: () => ''),
        gif1080: mp4Files.firstWhere((f) => f.contains('_1080.mp4'), orElse: () => ''),
      );
      
      print('✓ $normalizedId → $folderName ($exerciseName)');
    }
  }
  
  print('\n📊 Summary:');
  print('  - Total exercise folders: ${exerciseMap.length}');
  print('  - Errors: ${errors.length}');
  
  if (errors.isNotEmpty) {
    print('\n⚠️  Errors:');
    errors.forEach((e) => print('  - $e'));
  }
  
  // Generate Dart mapping file
  print('\n📝 Generating mapping file...');
  await generateMappingFile(exerciseMap);
  
  print('\n✅ Done! Mapping file created at lib/data/exercise_gif_mapping.dart');
}

String extractExerciseName(String gifFilename) {
  // Format: 00251301-Barbell-Bench-Press_Chest-FIX_1080.gif
  // Extract the part between first dash and first underscore
  final parts = gifFilename.split('-');
  if (parts.length < 2) return gifFilename;
  
  // Join all parts except the ID, then split by underscore to remove muscle group
  final namePart = parts.sublist(1).join('-').split('_').first;
  return namePart;
}

String normalizeExerciseName(String name) {
  // Convert "Barbell-Bench-Press" to "barbell_bench_press"
  return name.toLowerCase()
      .replaceAll('-', '_')
      .replaceAll(' ', '_')
      .replaceAll('(', '')
      .replaceAll(')', '')
      .replaceAll(',', '');
}

Future<void> generateMappingFile(Map<String, ExerciseGifInfo> exerciseMap) async {
  final buffer = StringBuffer();
  
  buffer.writeln('/// Auto-generated exercise GIF mapping');
  buffer.writeln('/// Generated: ${DateTime.now()}');
  buffer.writeln('/// Total exercises: ${exerciseMap.length}');
  buffer.writeln();
  buffer.writeln('class ExerciseGifInfo {');
  buffer.writeln('  final String folderName;');
  buffer.writeln('  final String gif180;');
  buffer.writeln('  final String gif360;');
  buffer.writeln('  final String gif720;');
  buffer.writeln('  final String gif1080;');
  buffer.writeln();
  buffer.writeln('  const ExerciseGifInfo({');
  buffer.writeln('    required this.folderName,');
  buffer.writeln('    required this.gif180,');
  buffer.writeln('    required this.gif360,');
  buffer.writeln('    required this.gif720,');
  buffer.writeln('    required this.gif1080,');
  buffer.writeln('  });');
  buffer.writeln('}');
  buffer.writeln();
  buffer.writeln('class ExerciseGifMapping {');
  buffer.writeln('  /// Map of exercise IDs to their GIF info');
  buffer.writeln('  static const Map<String, ExerciseGifInfo> exerciseGifs = {');
  
  // Sort by key for readability
  final sortedKeys = exerciseMap.keys.toList()..sort();
  
  for (final key in sortedKeys) {
    final info = exerciseMap[key]!;
    buffer.writeln('    \'$key\': ExerciseGifInfo(');
    buffer.writeln('      folderName: \'${info.folderName}\',');
    buffer.writeln('      gif180: \'${info.gif180}\',');
    buffer.writeln('      gif360: \'${info.gif360}\',');
    buffer.writeln('      gif720: \'${info.gif720}\',');
    buffer.writeln('      gif1080: \'${info.gif1080}\',');
    buffer.writeln('    ), // ${info.exerciseName}');
  }
  
  buffer.writeln('  };');
  buffer.writeln();
  buffer.writeln('  /// Get the GIF info for an exercise ID');
  buffer.writeln('  static ExerciseGifInfo? getGifInfo(String exerciseId) {');
  buffer.writeln('    return exerciseGifs[exerciseId];');
  buffer.writeln('  }');
  buffer.writeln('}');
  
  final outputFile = File('lib/data/exercise_gif_mapping.dart');
  await outputFile.parent.create(recursive: true);
  await outputFile.writeAsString(buffer.toString());
}

class ExerciseGifInfo {
  final String id;
  final String folderName;
  final String exerciseName;
  final List<String> gifFiles;
  final String gif180;
  final String gif360;
  final String gif720;
  final String gif1080;
  
  ExerciseGifInfo({
    required this.id,
    required this.folderName,
    required this.exerciseName,
    required this.gifFiles,
    required this.gif180,
    required this.gif360,
    required this.gif720,
    required this.gif1080,
  });
}

