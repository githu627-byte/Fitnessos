import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Service for transcribing audio using OpenAI Whisper API via backend
/// API keys stay safe on server - app never sees them!
class WhisperService {
  // Backend deployed on Railway
  // For local testing: http://localhost:3000
  // For production: https://fitnessos-production.up.railway.app
  static const String _backendUrl = 'https://fitnessos-production.up.railway.app';
  
  /// Transcribe audio file to text using Whisper via backend
  /// 
  /// [audioFilePath] - Path to recorded audio file (m4a, mp3, wav, etc.)
  /// [isPremium] - Premium users get priority (future feature)
  /// 
  /// Returns transcribed text or null if failed
  Future<String?> transcribeAudio(
    String audioFilePath, {
    bool isPremium = false,
  }) async {
    try {
      final file = File(audioFilePath);
      if (!await file.exists()) {
        debugPrint('❌ Audio file does not exist: $audioFilePath');
        return null;
      }

      debugPrint('🎤 Sending audio to backend...');
      
      // Create multipart request to YOUR backend
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$_backendUrl/api/transcribe'),
      );
      
      // Add audio file
      request.files.add(await http.MultipartFile.fromPath(
        'audio',
        audioFilePath,
        filename: 'audio.m4a',
      ));
      
      // Add metadata
      request.fields['isPremium'] = isPremium.toString();
      
      // Send request
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      
      if (response.statusCode == 200) {
        final data = jsonDecode(responseBody);
        
        if (data['success'] == true) {
          final transcription = data['transcription'] as String?;
          debugPrint('✅ Backend transcription: "$transcription"');
          return transcription?.trim();
        } else {
          debugPrint('❌ Backend error: ${data['error']}');
          return null;
        }
      } else {
        debugPrint('❌ Backend returned ${response.statusCode}: $responseBody');
        return null;
      }
    } catch (e) {
      debugPrint('❌ Whisper transcription failed: $e');
      return null;
    }
  }
  
  /// Estimate cost for a transcription
  /// Whisper charges $0.006 per minute of audio
  double estimateCost(int audioLengthSeconds) {
    final minutes = audioLengthSeconds / 60.0;
    return minutes * 0.006;
  }
}

