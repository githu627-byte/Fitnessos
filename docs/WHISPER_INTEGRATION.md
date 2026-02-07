# OpenAI Whisper Integration Guide

## Overview
This document outlines how to integrate OpenAI Whisper API for voice-based weight tracking in Skelatal-PT.

## Features
- **Wake Word Detection**: "skelatal" triggers voice recognition
- **Weight Extraction**: Automatically extracts weight values from speech
- **Free vs Premium**: 
  - Free users: Standard Whisper model
  - Premium users: Faster processing, better accuracy

## Implementation Steps

### 1. Add Required Packages

Add to `pubspec.yaml`:
```yaml
dependencies:
  http: ^1.1.0
  record: ^5.0.0  # For audio recording
  permission_handler: ^11.0.0  # For microphone permission
```

### 2. Get OpenAI API Key

1. Sign up at https://platform.openai.com/
2. Generate API key
3. Store securely (use flutter_dotenv or similar)

```dart
// .env file (don't commit!)
OPENAI_API_KEY=sk-...your-key-here
```

### 3. Wake Word Detection (Optional)

For better UX, implement local wake word detection before calling Whisper:

**Option A: Use Porcupine (Picovoice)**
```yaml
dependencies:
  porcupine_flutter: ^3.0.0
```

**Option B: Use Snowboy (offline)**
- Lightweight, runs on device
- Custom wake word "skelatal"

**Option C: Skip wake word, just use button**
- Simpler implementation
- User taps mic button, says weight directly

### 4. Implement Whisper API Call

```dart
Future<String> transcribeAudio(String audioFilePath, {required bool isPremium}) async {
  final file = File(audioFilePath);
  final bytes = await file.readAsBytes();
  
  final request = http.MultipartRequest(
    'POST',
    Uri.parse('https://api.openai.com/v1/audio/transcriptions'),
  );
  
  request.headers['Authorization'] = 'Bearer $OPENAI_API_KEY';
  request.fields['model'] = isPremium ? 'whisper-1' : 'whisper-1'; // Same model, adjust on backend
  request.fields['language'] = 'en';
  request.fields['response_format'] = 'text';
  
  request.files.add(http.MultipartFile.fromBytes(
    'file',
    bytes,
    filename: 'audio.m4a',
  ));
  
  final response = await request.send();
  final responseBody = await response.stream.bytesToString();
  
  if (response.statusCode == 200) {
    return responseBody; // Transcribed text
  } else {
    throw Exception('Whisper API error: $responseBody');
  }
}
```

### 5. Extract Weight from Transcription

Already implemented in `VoiceRecognitionService.extractWeightFromText()`:
- Handles: "135", "135 pounds", "135 lbs", "one thirty five"
- Can be extended for kilograms, written numbers, etc.

### 6. Update WeightInputDialog

Replace the placeholder in `weight_input_dialog.dart`:

```dart
void _startVoiceInput() async {
  setState(() => _isListening = true);
  HapticFeedback.mediumImpact();
  
  // Request microphone permission
  final permission = await Permission.microphone.request();
  if (!permission.isGranted) {
    // Show error
    return;
  }
  
  // Start recording
  final recorder = AudioRecorder();
  await recorder.start();
  
  // Record for X seconds or until user stops
  await Future.delayed(const Duration(seconds: 5));
  
  final path = await recorder.stop();
  if (path != null) {
    // Transcribe with Whisper
    final text = await transcribeAudio(path, isPremium: _isPremium);
    
    // Extract weight
    final weight = extractWeightFromText(text);
    if (weight != null) {
      _weightController.text = weight.toString();
      _submitWeight();
    }
  }
  
  setState(() => _isListening = false);
}
```

## Cost Considerations

### Whisper API Pricing (as of 2024)
- $0.006 per minute of audio
- Average weight input: ~2-5 seconds = ~$0.0005 per use
- For 1000 users doing 10 workouts/month = ~$50/month

### Recommendations
1. **Free Tier**: Limit to 5 voice inputs per workout
2. **Premium Tier**: Unlimited voice inputs
3. **Cache Common Weights**: "45", "135", "225" etc can be pre-stored
4. **Optimize Audio**: Send only 3-5 second clips, reduce sample rate

## Alternative: On-Device Speech Recognition

For cost savings, use device's native speech recognition:

```dart
import 'package:speech_to_text/speech_to_text.dart';

final speech = SpeechToText();
await speech.initialize();

speech.listen(onResult: (result) {
  final text = result.recognizedWords;
  final weight = extractWeightFromText(text);
  // Use weight
});
```

**Pros**: Free, works offline, fast
**Cons**: Less accurate than Whisper, language support varies

## Security Notes
- Never commit API keys
- Validate extracted weights (0-1000 lbs range)
- Rate limit voice requests
- Add user consent for microphone access

## Testing
1. Test with various accents
2. Test background noise scenarios
3. Test with written numbers: "one thirty five"
4. Test with units: "pounds", "lbs", "kilos"
5. Test wake word false positives

## Future Enhancements
- Multi-language support
- Metric/Imperial unit detection
- Voice commands: "same weight as last time"
- Exercise name recognition: "skelatal, 135 pounds on bench press"

