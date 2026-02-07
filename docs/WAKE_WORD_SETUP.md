# Wake Word "skelatal" Setup Guide

## Quick Start

The wake word **"skelatal"** runs **100% on-device** using Porcupine by Picovoice. No internet needed, instant response!

## Step 1: Get Porcupine Access Key (FREE)

1. Go to https://console.picovoice.ai/
2. Sign up for free account
3. Copy your **Access Key**
4. Replace in `lib/services/voice_recognition_service.dart`:
   ```dart
   static const String _accessKey = 'YOUR_KEY_HERE';
   ```

## Step 2: Train Custom Wake Word "skelatal"

1. In Picovoice Console, go to **Porcupine** section
2. Click **"Train Custom Wake Word"**
3. Enter wake word: `skelatal`
4. Select platforms: **Android** + **iOS**
5. Train model (takes ~2 minutes)
6. Download the `.ppn` files:
   - `skelatal_android.ppn`
   - `skelatal_ios.ppn`

## Step 3: Add Wake Word Files to Project

1. Create directory: `assets/wake_word/`
2. Copy downloaded files:
   ```
   assets/wake_word/
   ├── skelatal_android.ppn
   └── skelatal_ios.ppn
   ```

3. Add to `pubspec.yaml`:
   ```yaml
   flutter:
     assets:
       - assets/wake_word/skelatal_android.ppn
       - assets/wake_word/skelatal_ios.ppn
   ```

## Step 4: Configure Permissions

### Android (`android/app/src/main/AndroidManifest.xml`)
Already added, but verify:
```xml
<uses-permission android:name="android.permission.RECORD_AUDIO"/>
```

### iOS (`ios/Runner/Info.plist`)
Add if not present:
```xml
<key>NSMicrophoneUsageDescription</key>
<string>Skelatal-PT needs microphone access to detect wake word for hands-free weight tracking</string>
```

## Step 5: Test Wake Word

```dart
// In your widget
final voiceService = VoiceRecognitionService();

// Initialize once
await voiceService.initialize();

// Start listening
await voiceService.startListening(isPremium: false);

// Listen for state changes
voiceService.stateStream.listen((state) {
  if (state.status == VoiceRecognitionStatus.wakeWordDetected) {
    print('🔥 "skelatal" detected!');
    // Now record audio for Whisper
  }
});

// Stop when done
await voiceService.stopListening();
```

## How It Works

```
User says "skelatal"
    ↓
Porcupine detects on-device (instant, no internet)
    ↓
Callback triggered → Start recording
    ↓
User says weight: "135 pounds"
    ↓
Send audio to Whisper API
    ↓
Extract weight: 135
    ↓
Auto-fill weight input
```

## Pricing

### Porcupine (Wake Word)
- **Free Tier**: 
  - Unlimited wake word detections
  - On-device processing (no API calls)
  - 3 custom wake words
- **Perfect for Skelatal-PT!**

### Whisper (Speech to Text)
- Only called AFTER wake word detected
- ~$0.0005 per weight input
- See `docs/WHISPER_INTEGRATION.md`

## Alternative Wake Words (Optional)

You can train additional wake words:
- "hey skelatal"
- "yo skelatal"
- "skeletal" (without 'a')

Just train in Picovoice Console and add to keyword paths array:
```dart
await PorcupineManager.fromKeywordPaths(
  accessKey,
  [
    'assets/wake_word/skelatal_android.ppn',
    'assets/wake_word/hey_skelatal_android.ppn',
  ],
  _onWakeWordDetected,
);
```

## Troubleshooting

### "Access key not valid"
- Make sure you copied the key correctly
- Check it's not expired (free keys last forever)
- Verify account is verified

### Wake word not detecting
- Test in quiet environment first
- Say it clearly: "ske-LA-tal"
- Check microphone permission granted
- Verify `.ppn` files are in assets folder
- Check `flutter pub get` ran after adding to pubspec

### "Failed to initialize"
- Check platform (Android/iOS only, no web)
- Verify `.ppn` file matches platform
- Check assets are properly declared in pubspec.yaml

## Testing Tips

1. **Quiet Environment First**: Test in quiet room
2. **Clear Pronunciation**: "SKEL-uh-tal"
3. **Consistent Distance**: ~1-2 feet from phone
4. **Multiple Attempts**: Train your voice by repeating
5. **Check Logs**: Look for "🔥 Wake word detected!" in console

## Performance

- **Latency**: < 100ms detection time
- **CPU Usage**: Minimal (~1-2%)
- **Battery**: Negligible impact
- **Accuracy**: 95%+ in quiet environments

## Next Steps

Once wake word is working:
1. Integrate Whisper API for speech-to-text (see `WHISPER_INTEGRATION.md`)
2. Test in gym environment (background music, noise)
3. Add fallback: if wake word fails, user can tap mic button
4. Premium feature: Multi-word commands like "skelatal 135 on bench press"

