import '../data/exercise_gif_mapping.dart';
import '../data/exercise_id_overrides_fixed.dart';

/// Quality/resolution options for exercise videos
enum VideoQuality {
  /// 180p - Low quality, small file size (for thumbnails)
  low,
  
  /// 360p - Medium quality, balanced
  medium,
  
  /// 720p - High quality, default for all devices
  high,
}

/// Service for managing exercise video paths and loading
class ExerciseVideoService {
  /// Get the asset path for an exercise video (MP4)
  /// 
  /// Returns the full asset path to the MP4 file, or null if not found.
  /// The quality parameter determines which resolution variant to use.
  /// 
  /// Example:
  /// ```dart
  /// final path = ExerciseVideoService.getVideoPath('bench_press', quality: VideoQuality.high);
  /// // Returns: 'assets/exercise_videos/00251301-Barbell-Bench-Press_Chest-FIX_720.mp4'
  /// ```
  static String? getVideoPath(String exerciseId, {VideoQuality quality = VideoQuality.high}) {
    // First check for manual overrides (using fixed version)
    final overriddenId = ExerciseIdOverridesFix.getOverriddenId(exerciseId);
    
    // Normalize exercise ID
    final normalizedId = _normalizeExerciseId(overriddenId);
    
    // Look up video info
    var videoInfo = ExerciseGifMapping.getGifInfo(normalizedId);
    
    // Try alternative normalizations if not found
    if (videoInfo == null) {
      final alternateId = _tryAlternateNormalizations(overriddenId);
      if (alternateId != null) {
        videoInfo = ExerciseGifMapping.getGifInfo(alternateId);
      }
    }
    
    if (videoInfo == null) return null;
    
    // Get the appropriate resolution video filename (convert .gif to .mp4)
    final videoFilename = _getVideoFilename(videoInfo, quality);
    if (videoFilename.isEmpty) return null;
    
    // Build full asset path (flattened structure - no subfolders)
    return 'assets/exercise_videos/$videoFilename';
  }
  
  /// Get the video filename for the specified quality
  static String _getVideoFilename(ExerciseGifInfo videoInfo, VideoQuality quality) {
    String gifFilename;
    switch (quality) {
      case VideoQuality.low:
        gifFilename = videoInfo.gif180;
        break;
      case VideoQuality.medium:
        gifFilename = videoInfo.gif360;
        break;
      case VideoQuality.high:
        // Use 720p for high quality
        gifFilename = videoInfo.gif720;
        break;
    }
    
    // Convert .gif extension to .mp4
    return gifFilename.replaceAll('.gif', '.mp4');
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
  
  /// Get the static thumbnail path for an exercise (WebP image)
  /// Returns null if no thumbnail exists
  static String? getThumbnailPath(String exerciseId) {
    // Use same override + mapping logic as getVideoPath
    final overriddenId = ExerciseIdOverridesFix.getOverriddenId(exerciseId);
    final normalizedId = _normalizeExerciseId(overriddenId);

    var videoInfo = ExerciseGifMapping.getGifInfo(normalizedId);
    if (videoInfo == null) {
      final alternateId = _tryAlternateNormalizations(overriddenId);
      if (alternateId != null) {
        videoInfo = ExerciseGifMapping.getGifInfo(alternateId);
      }
    }

    if (videoInfo == null) return null;

    // Get the 720p filename and change extension to .webp
    final videoFilename = videoInfo.gif720;
    if (videoFilename.isEmpty) return null;

    final thumbFilename = videoFilename.replaceAll('.gif', '.mp4').replaceAll('.mp4', '.webp');
    return 'assets/exercise_thumbnails/$thumbFilename';
  }

  /// Check if a video exists for the given exercise ID
  static bool hasVideo(String exerciseId) {
    return getVideoPath(exerciseId) != null;
  }
  
  /// Get adaptive quality based on screen size
  static VideoQuality getAdaptiveQuality(double screenWidth) {
    // We only have 720p videos available
    return VideoQuality.high; // Always use 720p
  }
  
  // LEGACY COMPATIBILITY: Keep old GIF methods for backwards compatibility
  static String? getGifPath(String exerciseId, {VideoQuality? quality}) {
    return getVideoPath(exerciseId, quality: quality ?? VideoQuality.high); // Use 720p
  }
  
  static bool hasGif(String exerciseId) {
    return hasVideo(exerciseId);
  }
}

