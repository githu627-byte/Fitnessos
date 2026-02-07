import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:porcupine_flutter/porcupine_manager.dart';
import 'package:porcupine_flutter/porcupine_error.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'whisper_service.dart';

/// Service for voice recognition with wake word detection
/// 
/// Features:
/// - On-device wake word detection ("skelatal") using Porcupine
/// - Speech-to-text using OpenAI Whisper
/// - Weight value extraction from speech
/// - Free tier: Standard Whisper model
/// - Premium tier: Enhanced accuracy and speed
/// 
/// Flow:
/// 1. Start listening for wake word "skelatal"
/// 2. When detected, start recording audio
/// 3. Record for 5 seconds or until silence
/// 4. Send audio to Whisper for transcription
/// 5. Extract weight from transcription
class VoiceRecognitionService {
  PorcupineManager? _porcupineManager;
  final AudioRecorder _audioRecorder = AudioRecorder();
  final WhisperService _whisperService = WhisperService();
  
  bool _isListening = false;
  bool _isRecording = false;
  StreamController<VoiceRecognitionState>? _stateController;
  
  // Porcupine Access Key from Picovoice Console
  static const String _accessKey = 'bbKH6Nhkdaipq7VvKKb+Fexv/0qHXLvAaks+jQGf+4QutHyVmMEfVQ==';
  
  /// Current state stream
  Stream<VoiceRecognitionState> get stateStream {
    _stateController ??= StreamController<VoiceRecognitionState>.broadcast();
    return _stateController!.stream;
  }

  /// Initialize the wake word detector
  /// Must be called before startListening
  Future<bool> initialize() async {
    try {
      // Request microphone permission
      final status = await Permission.microphone.request();
      if (!status.isGranted) {
        _emitState(VoiceRecognitionState.error('Microphone permission denied'));
        return false;
      }
      
      // Determine platform-specific asset path
      String assetPath;
      if (defaultTargetPlatform == TargetPlatform.android) {
        assetPath = 'assets/wake_word/skeletal_android.ppn';
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        assetPath = 'assets/wake_word/skeletal_ios.ppn';
      } else {
        _emitState(VoiceRecognitionState.error('Unsupported platform'));
        return false;
      }
      
      // ========== FIX: Extract asset to real file ==========
      // Porcupine needs a file system path, not a Flutter asset path
      final keywordPath = await _extractAssetToFile(assetPath);
      if (keywordPath == null) {
        _emitState(VoiceRecognitionState.error('Failed to load wake word model'));
        return false;
      }
      // =====================================================
      
      debugPrint('🔑 Using keyword path: $keywordPath');
      debugPrint('🔑 Using access key: $_accessKey');
      
      // Initialize Porcupine with custom wake word
      _porcupineManager = await PorcupineManager.fromKeywordPaths(
        _accessKey,
        [keywordPath],
        _onWakeWordDetected,
        errorCallback: _onPorcupineError,
      );
      
      debugPrint('✅ VoiceRecognitionService: Porcupine initialized successfully');
      debugPrint('🎤 Ready to listen for "skeletal"');
      return true;
    } on PorcupineException catch (e) {
      debugPrint('❌ VoiceRecognitionService: Porcupine init failed: $e');
      debugPrint('❌ Error message: ${e.message}');
      _emitState(VoiceRecognitionState.error('Failed to initialize wake word: ${e.message}'));
      return false;
    } catch (e) {
      debugPrint('❌ VoiceRecognitionService: Unexpected error: $e');
      _emitState(VoiceRecognitionState.error('Unexpected error: $e'));
      return false;
    }
  }

  /// Extract a Flutter asset to a real file and return the path
  /// Porcupine can't read Flutter assets directly - they need to be on the file system
  Future<String?> _extractAssetToFile(String assetPath) async {
    try {
      debugPrint('📦 Extracting asset: $assetPath');
      
      // Load asset bytes
      final byteData = await rootBundle.load(assetPath);
      
      // Get temp directory
      final tempDir = await getTemporaryDirectory();
      final fileName = assetPath.split('/').last;
      final file = File('${tempDir.path}/$fileName');
      
      // Write to file
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
      
      debugPrint('✅ Extracted wake word model to: ${file.path}');
      return file.path;
    } catch (e) {
      debugPrint('❌ Failed to extract asset: $e');
      return null;
    }
  }

  /// Start listening for wake word "skelatal"
  Future<void> startListening({required bool isPremium}) async {
    debugPrint('🎤 startListening called');
    
    if (_isListening) {
      debugPrint('⚠️ Already listening');
      return;
    }
    
    if (_porcupineManager == null) {
      debugPrint('⚠️ Porcupine manager is null, initializing...');
      final initialized = await initialize();
      if (!initialized) {
        debugPrint('❌ Initialization failed');
        return;
      }
    }
    
    try {
      debugPrint('▶️ Starting Porcupine manager...');
      await _porcupineManager!.start();
      _isListening = true;
      _emitState(VoiceRecognitionState.listening);
      
      debugPrint('✅ VoiceRecognitionService: Listening for "skelatal"...');
      debugPrint('🔊 Say "skelatal" to trigger wake word detection');
    } catch (e) {
      debugPrint('❌ Failed to start listening: $e');
      _emitState(VoiceRecognitionState.error('Failed to start: $e'));
    }
  }

  /// Callback when wake word is detected
  void _onWakeWordDetected(int keywordIndex) async {
    debugPrint('🔥 Wake word "skelatal" detected!');
    _emitState(VoiceRecognitionState.wakeWordDetected);
    
    // Start recording audio for Whisper transcription
    await _recordAndTranscribe();
  }

  /// Record audio and send to Whisper
  Future<void> _recordAndTranscribe() async {
    if (_isRecording) return;
    
    try {
      _isRecording = true;
      
      // Get temp directory for audio file
      final tempDir = await getTemporaryDirectory();
      final audioPath = '${tempDir.path}/weight_audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      
      // Check if we have permission
      if (await _audioRecorder.hasPermission()) {
        debugPrint('🎙️ Recording audio...');
        
        // Start recording
        await _audioRecorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc, // AAC format
            bitRate: 128000,
            sampleRate: 16000, // 16kHz is good for speech
          ),
          path: audioPath,
        );
        
        // Record for 5 seconds (enough time to say weight)
        await Future.delayed(const Duration(seconds: 5));
        
        // Stop recording
        final recordedPath = await _audioRecorder.stop();
        debugPrint('✅ Recording saved: $recordedPath');
        
        if (recordedPath != null) {
          // Send to Whisper for transcription
          debugPrint('📤 Sending to Whisper...');
          final transcription = await _whisperService.transcribeAudio(recordedPath);
          
          if (transcription != null && transcription.isNotEmpty) {
            debugPrint('🎯 Transcribed: "$transcription"');
            
            // Extract weight from transcription
            final weight = extractWeightFromText(transcription);
            if (weight != null) {
              _emitState(VoiceRecognitionState.weightDetected(weight));
            } else {
              _emitState(VoiceRecognitionState.error('Could not understand weight. Try again.'));
            }
          } else {
            _emitState(VoiceRecognitionState.error('No speech detected. Please try again.'));
          }
          
          // Clean up audio file
          try {
            await File(recordedPath).delete();
          } catch (e) {
            debugPrint('⚠️ Could not delete temp audio file: $e');
          }
        }
      } else {
        _emitState(VoiceRecognitionState.error('Microphone permission denied'));
      }
    } catch (e) {
      debugPrint('❌ Recording/transcription error: $e');
      _emitState(VoiceRecognitionState.error('Failed to process audio: $e'));
    } finally {
      _isRecording = false;
    }
  }

  /// Callback for Porcupine errors
  void _onPorcupineError(PorcupineException error) {
    debugPrint('❌ Porcupine error: ${error.message}');
    _emitState(VoiceRecognitionState.error(error.message ?? 'Unknown error'));
  }

  /// Stop listening
  Future<void> stopListening() async {
    if (!_isListening) return;
    
    try {
      await _porcupineManager?.stop();
      await _audioRecorder.stop();
      _isListening = false;
      _isRecording = false;
      _emitState(VoiceRecognitionState.idle);
      
      debugPrint('⏹️ VoiceRecognitionService: Stopped listening');
    } catch (e) {
      debugPrint('❌ Error stopping: $e');
    }
  }

  /// Extract weight value from transcribed text
  /// Examples: "135 pounds", "135", "one thirty five", "135 lbs", "body weight"
  double? extractWeightFromText(String text) {
    text = text.toLowerCase().trim();
    
    // Handle body weight
    if (text.contains('body') || text.contains('bodyweight')) {
      return 0.0; // Special value for body weight
    }
    
    // Try to extract number directly
    final numberPattern = RegExp(r'(\d+\.?\d*)');
    final match = numberPattern.firstMatch(text);
    if (match != null) {
      return double.tryParse(match.group(1)!);
    }
    
    // TODO: Handle written numbers like "one thirty five", "forty five"
    // This would require a number-to-text parser
    
    return null;
  }

  void _emitState(VoiceRecognitionState state) {
    _stateController?.add(state);
  }

  Future<void> dispose() async {
    await stopListening();
    await _porcupineManager?.delete();
    _porcupineManager = null;
    await _audioRecorder.dispose();
    await _stateController?.close();
    _stateController = null;
  }
}

/// Voice recognition state
class VoiceRecognitionState {
  final VoiceRecognitionStatus status;
  final double? detectedWeight;
  final String? errorMessage;

  const VoiceRecognitionState._({
    required this.status,
    this.detectedWeight,
    this.errorMessage,
  });

  static const VoiceRecognitionState idle = VoiceRecognitionState._(status: VoiceRecognitionStatus.idle);
  static const VoiceRecognitionState listening = VoiceRecognitionState._(status: VoiceRecognitionStatus.listening);
  static const VoiceRecognitionState wakeWordDetected = VoiceRecognitionState._(status: VoiceRecognitionStatus.wakeWordDetected);
  
  static VoiceRecognitionState weightDetected(double weight) => VoiceRecognitionState._(
    status: VoiceRecognitionStatus.weightDetected,
    detectedWeight: weight,
  );
  
  static VoiceRecognitionState error(String message) => VoiceRecognitionState._(
    status: VoiceRecognitionStatus.error,
    errorMessage: message,
  );
}

enum VoiceRecognitionStatus {
  idle,
  listening,
  wakeWordDetected,
  weightDetected,
  error,
}

