import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// ═══════════════════════════════════════════════════════════════════════════
/// FIREBASE ANALYTICS SERVICE - FitnessOS Event Tracking
/// ═══════════════════════════════════════════════════════════════════════════
/// Singleton service for logging all user events to Firebase Analytics.
/// Organized by: User Properties, App Lifecycle, Onboarding, Auth, Paywall,
/// Navigation, Workouts, AI Camera, Recording, Profile, Errors.
///
/// Gracefully degrades to no-op when Firebase is not configured.
/// ═══════════════════════════════════════════════════════════════════════════

class FirebaseAnalyticsService {
  FirebaseAnalyticsService._();
  static final FirebaseAnalyticsService _instance = FirebaseAnalyticsService._();
  factory FirebaseAnalyticsService() => _instance;

  static bool _firebaseAvailable = false;
  FirebaseAnalytics? _analytics;

  /// Call once during app startup. Safe to call even if Firebase isn't configured.
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      _instance._analytics = FirebaseAnalytics.instance;
      _firebaseAvailable = true;
      debugPrint('Firebase Analytics initialized');
    } catch (e) {
      _firebaseAvailable = false;
      debugPrint('Firebase not configured — analytics disabled: $e');
    }
  }

  /// Navigator observer for automatic route tracking.
  /// Returns a no-op observer when Firebase is not available.
  NavigatorObserver get observer {
    if (_firebaseAvailable && _analytics != null) {
      return FirebaseAnalyticsObserver(analytics: _analytics!);
    }
    return NavigatorObserver();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CORE HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setUserId(String? userId) async {
    if (!_firebaseAvailable) return;
    try {
      await _analytics!.setUserId(id: userId);
    } catch (e) {
      debugPrint('Analytics setUserId error: $e');
    }
  }

  Future<void> _logEvent(String name, [Map<String, Object>? params]) async {
    if (!_firebaseAvailable) return;
    try {
      await _analytics!.logEvent(name: name, parameters: params);
    } catch (e) {
      debugPrint('Analytics error ($name): $e');
    }
  }

  Future<void> _setUserProperty(String name, String? value) async {
    if (!_firebaseAvailable) return;
    try {
      await _analytics!.setUserProperty(name: name, value: value);
    } catch (e) {
      debugPrint('Analytics user property error ($name): $e');
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // USER PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> setSubscriptionStatus(String status) =>
      _setUserProperty('subscription_status', status);

  Future<void> setSignInMethod(String method) =>
      _setUserProperty('sign_in_method', method);

  Future<void> setTrainingPreference(String pref) =>
      _setUserProperty('training_preference', pref);

  Future<void> setWorkoutLocation(String loc) =>
      _setUserProperty('workout_location', loc);

  Future<void> setFitnessGoal(String goal) =>
      _setUserProperty('fitness_goal', goal);

  Future<void> setExperienceLevel(String level) =>
      _setUserProperty('experience_level', level);

  Future<void> setWorkoutsCompleted(int count) =>
      _setUserProperty('workouts_completed', count.toString());

  Future<void> setDaysActive(int count) =>
      _setUserProperty('days_active', count.toString());

  Future<void> setOnboardingCompleted(bool completed) =>
      _setUserProperty('onboarding_completed', completed.toString());

  // ═══════════════════════════════════════════════════════════════════════════
  // APP LIFECYCLE
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logAppOpened({
    required bool isSubscribed,
    required int daysSinceInstall,
  }) =>
      _logEvent('app_opened', {
        'is_subscribed': isSubscribed,
        'days_since_install': daysSinceInstall,
      });

  // ═══════════════════════════════════════════════════════════════════════════
  // ONBOARDING
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logOnboardingStarted() => _logEvent('onboarding_started');

  Future<void> logOnboardingStepCompleted({
    required String stepName,
    required int stepNumber,
  }) =>
      _logEvent('onboarding_step_completed', {
        'step_name': stepName,
        'step_number': stepNumber,
      });

  Future<void> logOnboardingCompleted({required int totalTimeSeconds}) =>
      _logEvent('onboarding_completed', {
        'total_time_seconds': totalTimeSeconds,
      });

  Future<void> logOnboardingDroppedOff({
    required String lastStep,
    required int stepNumber,
  }) =>
      _logEvent('onboarding_dropped_off', {
        'last_step': lastStep,
        'step_number': stepNumber,
      });

  // ═══════════════════════════════════════════════════════════════════════════
  // AUTH
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logSignUpCompleted({required String method}) =>
      _logEvent('sign_up_completed', {'method': method});

  Future<void> logSignInCompleted({required String method}) =>
      _logEvent('sign_in_completed', {'method': method});

  // ═══════════════════════════════════════════════════════════════════════════
  // PAYWALL
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logPaywallViewed({required String source}) =>
      _logEvent('paywall_viewed', {'source': source});

  Future<void> logPaywallDismissed({
    required String source,
    required int timeOnScreenSeconds,
  }) =>
      _logEvent('paywall_dismissed', {
        'source': source,
        'time_on_screen_seconds': timeOnScreenSeconds,
      });

  Future<void> logSubscriptionStarted({
    required String productId,
    required String price,
    required bool isTrial,
  }) =>
      _logEvent('subscription_started', {
        'product_id': productId,
        'price': price,
        'is_trial': isTrial,
      });

  Future<void> logSubscriptionRestored({required String productId}) =>
      _logEvent('subscription_restored', {'product_id': productId});

  // ═══════════════════════════════════════════════════════════════════════════
  // NAVIGATION
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    if (!_firebaseAvailable) return;
    try {
      await _analytics!.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      );
    } catch (e) {
      debugPrint('Analytics error (screen_view): $e');
    }
  }

  Future<void> logTabSelected({required String tabName}) =>
      _logEvent('tab_selected', {'tab_name': tabName});

  Future<void> logProfileSubTabViewed({required String subTab}) =>
      _logEvent('profile_tab_viewed', {'sub_tab': subTab});

  // ═══════════════════════════════════════════════════════════════════════════
  // WORKOUT PRESETS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logPresetWorkoutSelected({
    required String presetId,
    required String presetName,
    required String category,
    required String difficulty,
  }) =>
      _logEvent('preset_workout_selected', {
        'preset_id': presetId,
        'preset_name': presetName,
        'category': category,
        'difficulty': difficulty,
      });

  Future<void> logDifficultyChanged({
    required String presetId,
    required String oldDifficulty,
    required String newDifficulty,
  }) =>
      _logEvent('difficulty_changed', {
        'preset_id': presetId,
        'old_difficulty': oldDifficulty,
        'new_difficulty': newDifficulty,
      });

  // ═══════════════════════════════════════════════════════════════════════════
  // CUSTOM WORKOUT BUILDER
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logCustomWorkoutStarted({required String mode}) =>
      _logEvent('custom_workout_started', {'mode': mode});

  Future<void> logCustomWorkoutSaved({
    required int exerciseCount,
    required String mode,
    required String name,
  }) =>
      _logEvent('custom_workout_saved', {
        'exercise_count': exerciseCount,
        'mode': mode,
        'name': name,
      });

  Future<void> logExerciseAddedToCustom({
    required String exerciseId,
    required String mode,
  }) =>
      _logEvent('exercise_added_to_custom', {
        'exercise_id': exerciseId,
        'mode': mode,
      });

  Future<void> logExerciseRemovedFromCustom({required String exerciseId}) =>
      _logEvent('exercise_removed_from_custom', {'exercise_id': exerciseId});

  Future<void> logExerciseSearched({
    required String query,
    required int resultsCount,
    required String mode,
  }) =>
      _logEvent('exercise_searched', {
        'query': query,
        'results_count': resultsCount,
        'mode': mode,
      });

  Future<void> logEquipmentFilterUsed({
    required String equipmentType,
    required String mode,
  }) =>
      _logEvent('equipment_filter_used', {
        'equipment_type': equipmentType,
        'mode': mode,
      });

  // ═══════════════════════════════════════════════════════════════════════════
  // WORKOUT EXECUTION
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logWorkoutStarted({
    required String mode,
    required String workoutName,
    required int exerciseCount,
    required bool isPreset,
    required bool isCustom,
  }) =>
      _logEvent('workout_started', {
        'mode': mode,
        'workout_name': workoutName,
        'exercise_count': exerciseCount,
        'is_preset': isPreset,
        'is_custom': isCustom,
      });

  Future<void> logWorkoutCompleted({
    required String mode,
    required int durationSeconds,
    required int totalReps,
    required int totalSets,
    required int exercisesCompleted,
    required String workoutName,
  }) =>
      _logEvent('workout_completed', {
        'mode': mode,
        'duration_seconds': durationSeconds,
        'total_reps': totalReps,
        'total_sets': totalSets,
        'exercises_completed': exercisesCompleted,
        'workout_name': workoutName,
      });

  Future<void> logWorkoutAbandoned({
    required String mode,
    required int durationSeconds,
    required int exercisesCompleted,
  }) =>
      _logEvent('workout_abandoned', {
        'mode': mode,
        'duration_seconds': durationSeconds,
        'exercises_completed': exercisesCompleted,
      });

  Future<void> logTrainingModeSelected({required String mode}) =>
      _logEvent('training_mode_selected', {'mode': mode});

  // ═══════════════════════════════════════════════════════════════════════════
  // AI CAMERA
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logCameraInitialized({required bool success}) =>
      _logEvent('camera_initialized', {'success': success});

  Future<void> logBodyDetected({required double timeToDetectSeconds}) =>
      _logEvent('body_detected', {
        'time_to_detect_seconds': timeToDetectSeconds,
      });

  Future<void> logRepCounted({
    required String exerciseId,
    required int setNumber,
    required int repNumber,
  }) =>
      _logEvent('rep_counted', {
        'exercise_id': exerciseId,
        'set_number': setNumber,
        'rep_number': repNumber,
      });

  Future<void> logSetCompleted({
    required String exerciseId,
    required int setNumber,
    required int reps,
    required int durationSeconds,
  }) =>
      _logEvent('set_completed', {
        'exercise_id': exerciseId,
        'set_number': setNumber,
        'reps': reps,
        'duration_seconds': durationSeconds,
      });

  Future<void> logExerciseCompleted({
    required String exerciseId,
    required int totalSets,
    required int totalReps,
  }) =>
      _logEvent('exercise_completed', {
        'exercise_id': exerciseId,
        'total_sets': totalSets,
        'total_reps': totalReps,
      });

  Future<void> logExerciseSwapped({
    required String oldExerciseId,
    required String newExerciseId,
  }) =>
      _logEvent('exercise_swapped', {
        'old_exercise_id': oldExerciseId,
        'new_exercise_id': newExerciseId,
      });

  Future<void> logRestTimerSkipped({required int secondsRemaining}) =>
      _logEvent('rest_timer_skipped', {
        'seconds_remaining': secondsRemaining,
      });

  // ═══════════════════════════════════════════════════════════════════════════
  // RECORDING & SHARING
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logWorkoutRecorded({required int durationSeconds}) =>
      _logEvent('workout_recorded', {
        'duration_seconds': durationSeconds,
      });

  Future<void> logWorkoutRecordingShared() =>
      _logEvent('workout_recording_shared');

  // ═══════════════════════════════════════════════════════════════════════════
  // PROFILE & ANALYTICS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logAnalyticsPeriodChanged({required String period}) =>
      _logEvent('analytics_period_changed', {'period': period});

  Future<void> logMeasurementLogged({required String type}) =>
      _logEvent('measurement_logged', {'type': type});

  Future<void> logVideoViewed() => _logEvent('video_viewed');

  Future<void> logVideoShared() => _logEvent('video_shared');

  Future<void> logVideoDeleted() => _logEvent('video_deleted');

  Future<void> logExerciseExplanationViewed({required String exerciseId}) =>
      _logEvent('exercise_explanation_viewed', {
        'exercise_id': exerciseId,
      });

  Future<void> logSettingsOpened() => _logEvent('settings_opened');

  Future<void> logRecoveryCardViewed() => _logEvent('recovery_card_viewed');

  Future<void> logFormCheckCardTapped() => _logEvent('form_check_card_tapped');

  Future<void> logHeatmapViewed() => _logEvent('heatmap_viewed');

  Future<void> logMeasurementsOpened() => _logEvent('measurements_opened');

  // ═══════════════════════════════════════════════════════════════════════════
  // ERRORS
  // ═══════════════════════════════════════════════════════════════════════════

  Future<void> logError({
    required String errorType,
    required String errorMessage,
    String? context,
  }) =>
      _logEvent('app_error', {
        'error_type': errorType,
        'error_message': errorMessage.length > 100
            ? errorMessage.substring(0, 100)
            : errorMessage,
        if (context != null) 'context': context,
      });

  Future<void> logCameraError({required String errorMessage}) =>
      _logEvent('camera_error', {
        'error_message': errorMessage.length > 100
            ? errorMessage.substring(0, 100)
            : errorMessage,
      });

  Future<void> logPoseDetectionFailure({
    required int frameCount,
    required String exerciseId,
  }) =>
      _logEvent('pose_detection_failure', {
        'frame_count': frameCount,
        'exercise_id': exerciseId,
      });

  Future<void> logWorkoutSaveError({required String errorMessage}) =>
      _logEvent('workout_save_error', {
        'error_message': errorMessage.length > 100
            ? errorMessage.substring(0, 100)
            : errorMessage,
      });

  Future<void> logGifLoadFailure({
    required String exerciseId,
  }) =>
      _logEvent('gif_load_failure', {
        'exercise_id': exerciseId,
      });
}
