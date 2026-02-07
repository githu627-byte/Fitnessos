import '../data/exercise_gif_mapping.dart';
import '../data/exercise_id_overrides.dart';

/// Quality/resolution options for exercise GIFs
enum GifQuality {
  /// 180p - Low quality, small file size (for thumbnails)
  low,
  
  /// 360p - Medium quality, balanced (default)
  medium,
  
  /// 720p - High quality, larger files
  high,
  
  /// 1080p - Ultra quality, largest files (tablets/large screens)
  ultra,
}

/// Service for managing exercise GIF paths and loading
class ExerciseGifService {
  /// Get the asset path for an exercise GIF
  /// 
  /// Returns the full asset path to the GIF file, or null if not found.
  /// The quality parameter determines which resolution variant to use.
  /// 
  /// Example:
  /// ```dart
  /// final path = ExerciseGifService.getGifPath('bench_press', quality: GifQuality.medium);
  /// // Returns: 'assets/exercise_gifs/00251301/00251301-Barbell-Bench-Press_Chest-FIX_360.gif'
  /// ```
  static String? getGifPath(String exerciseId, {GifQuality quality = GifQuality.medium}) {
    // First check for manual overrides
    final overriddenId = ExerciseIdOverrides.getOverriddenId(exerciseId);
    
    // Normalize exercise ID
    final normalizedId = _normalizeExerciseId(overriddenId);
    
    // Look up GIF info
    var gifInfo = ExerciseGifMapping.getGifInfo(normalizedId);
    
    // Try alternative normalizations if not found
    if (gifInfo == null) {
      final alternateId = _tryAlternateNormalizations(overriddenId);
      if (alternateId != null) {
        gifInfo = ExerciseGifMapping.getGifInfo(alternateId);
      }
    }
    
    if (gifInfo == null) return null;
    
    // Get the appropriate resolution GIF filename
    final gifFilename = _getGifFilename(gifInfo, quality);
    if (gifFilename.isEmpty) return null;
    
    // Build full asset path
    return 'assets/exercise_gifs/${gifInfo.folderName}/$gifFilename';
  }
  
  /// Get the GIF filename for the specified quality
  static String _getGifFilename(ExerciseGifInfo gifInfo, GifQuality quality) {
    switch (quality) {
      case GifQuality.low:
        return gifInfo.gif180;
      case GifQuality.medium:
        return gifInfo.gif360;
      case GifQuality.high:
        return gifInfo.gif720;
      case GifQuality.ultra:
        return gifInfo.gif1080;
    }
  }
  
  /// Normalize exercise ID for consistent lookup
  static String _normalizeExerciseId(String id) {
    return id.toLowerCase()
        .replaceAll('-', '_')
        .replaceAll(' ', '_')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(',', '')
        .trim();
  }
  
  /// Try alternate normalizations for edge cases
  static String? _tryAlternateNormalizations(String id) {
    final normalized = _normalizeExerciseId(id);
    
    // Try removing "barbell_" prefix
    if (normalized.startsWith('barbell_')) {
      final withoutBarbell = normalized.substring(8);
      if (ExerciseGifMapping.getGifInfo(withoutBarbell) != null) {
        return withoutBarbell;
      }
    }
    
    // Try adding "barbell_" prefix
    final withBarbell = 'barbell_$normalized';
    if (ExerciseGifMapping.getGifInfo(withBarbell) != null) {
      return withBarbell;
    }
    
    // Try plural/singular variations
    if (normalized.endsWith('s')) {
      final singular = normalized.substring(0, normalized.length - 1);
      if (ExerciseGifMapping.getGifInfo(singular) != null) {
        return singular;
      }
    } else {
      final plural = '${normalized}s';
      if (ExerciseGifMapping.getGifInfo(plural) != null) {
        return plural;
      }
    }
    
    return null;
  }
  
  /// Get all asset paths for all resolution variants
  static List<String> getAllGifVariants(String exerciseId) {
    final normalizedId = _normalizeExerciseId(exerciseId);
    final gifInfo = ExerciseGifMapping.getGifInfo(normalizedId);
    
    if (gifInfo == null) return [];
    
    return [
      'assets/exercise_gifs/${gifInfo.folderName}/${gifInfo.gif180}',
      'assets/exercise_gifs/${gifInfo.folderName}/${gifInfo.gif360}',
      'assets/exercise_gifs/${gifInfo.folderName}/${gifInfo.gif720}',
      'assets/exercise_gifs/${gifInfo.folderName}/${gifInfo.gif1080}',
    ];
  }
  
  /// Check if a GIF exists for the given exercise ID
  static bool hasGif(String exerciseId) {
    return getGifPath(exerciseId) != null;
  }
  
  /// Get adaptive quality based on screen size
  static GifQuality getAdaptiveQuality(double screenWidth) {
    if (screenWidth < 400) {
      return GifQuality.low; // Small phones - use 180p
    } else if (screenWidth < 600) {
      return GifQuality.medium; // Regular phones - use 360p
    } else if (screenWidth < 900) {
      return GifQuality.high; // Large phones/small tablets - use 720p
    } else {
      return GifQuality.ultra; // Tablets/desktops - use 1080p
    }
  }
}

