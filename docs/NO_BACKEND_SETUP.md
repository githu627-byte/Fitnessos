# No Backend Needed! Setup Guide 🚀

## TL;DR - What You Need:

1. **Porcupine** (Wake Word) → FREE ✅
2. **OpenAI Whisper** (Speech-to-Text) → ~$0.0005 per use 💰

**Total monthly cost for 1000 users:** ~$30-50 (super cheap!)

---

## Setup Steps (15 Minutes Total)

### Step 1: Porcupine Wake Word (FREE Forever)

1. Go to https://console.picovoice.ai/
2. Sign up (FREE - no credit card!)
3. Copy your **Access Key**
4. Train custom wake word "skelatal":
   - Click "Porcupine" → "Train Custom Wake Word"
   - Enter: `skelatal`
   - Select: Android + iOS
   - Train (2 min) → Download `.ppn` files
5. Add files to project:
   ```
   assets/wake_word/
   ├── skelatal_android.ppn
   └── skelatal_ios.ppn
   ```
6. Add key to `lib/services/voice_recognition_service.dart`:
   ```dart
   static const String _accessKey = 'YOUR_KEY_HERE';
   ```

**Cost:** FREE forever! ✅

---

### Step 2: OpenAI Whisper API (Pay as you go)

1. Go to https://platform.openai.com/
2. Sign up and add payment method ($5 minimum)
3. Get API key: https://platform.openai.com/api-keys
4. Add key to `lib/services/whisper_service.dart`:
   ```dart
   static const String _openAiApiKey = 'sk-...YOUR_KEY';
   ```

**Cost:** $0.006 per minute of audio
- Average weight input: 3 seconds = $0.0003
- 1000 uses = $0.30
- Super cheap! 💸

---

## ⚠️ Security: Don't Hardcode API Keys!

### Option 1: Environment Variables (Quick)

1. Add to pubspec.yaml:
   ```yaml
   dependencies:
     flutter_dotenv: ^5.1.0
   ```

2. Create `.env` file (add to .gitignore!):
   ```
   OPENAI_API_KEY=sk-...your-key
   PORCUPINE_ACCESS_KEY=...your-key
   ```

3. Load in app:
   ```dart
   import 'package:flutter_dotenv/flutter_dotenv.dart';
   
   await dotenv.load();
   final openAiKey = dotenv.env['OPENAI_API_KEY']!;
   ```

### Option 2: Backend (More Secure for Production)

If you scale big, move API keys to backend:
- User → App → Your Backend → OpenAI
- Backend keeps keys safe
- Backend can rate-limit users
- Backend can track usage per user

But for now? **Option 1 is fine!** 👍

---

## Do You Need a Backend? 🤔

### NO Backend Needed If:
- ✅ Just starting out
- ✅ < 10,000 users
- ✅ Trust your users
- ✅ Want to ship fast

### YES Backend Recommended If:
- ❌ > 50,000 users (API key could leak)
- ❌ Need to track usage per user
- ❌ Want to rate-limit free users
- ❌ Need analytics on voice usage

**For Skelatal-PT MVP:** No backend needed! 🚀

---

## Full Architecture (No Backend)

```
User finishes set
    ↓
Weight dialog appears
    ↓
User taps mic button
    ↓
Porcupine listening (on-device, FREE)
    ↓
User says "skelatal" → Detected instantly!
    ↓
Start recording audio (5 seconds)
    ↓
Send audio directly to OpenAI Whisper API
    ↓
Get transcription: "135 pounds"
    ↓
Extract weight: 135
    ↓
Auto-fill in dialog → CONFIRM
```

**All happens in the app - no backend! 🎉**

---

## Cost Breakdown (1000 Users)

### Scenario: 1000 users, 10 workouts/month each

**Porcupine (Wake Word):**
- Cost: $0 (FREE) ✅

**Whisper (Speech-to-Text):**
- Assume 50% use voice input
- 500 users × 10 workouts × 3 sets avg = 15,000 voice inputs
- 15,000 × $0.0003 = **$4.50/month** 💰

**Total: ~$5/month** for 1000 users! 

---

## When to Add Backend?

Add backend when you reach **50,000+ users** or need:
1. User-specific rate limits
2. Premium vs Free tier enforcement
3. Usage analytics
4. API key rotation
5. Cost optimization (caching common weights)

Until then? **Direct API calls are perfect!** 🔥

---

## Alternative: Free Speech Recognition?

Want to avoid OpenAI costs? Use device speech recognition:

```dart
import 'package:speech_to_text/speech_to_text.dart';

final speech = SpeechToText();
await speech.initialize();
speech.listen(onResult: (result) {
  final text = result.recognizedWords; // "135 pounds"
  // Extract weight
});
```

**Pros:** FREE, offline, fast
**Cons:** Less accurate than Whisper (especially in noisy gyms)

**Recommendation:** Start with Whisper (super cheap), switch to device if costs scale 📊

---

## Setup Checklist

- [ ] Get Porcupine key (FREE at console.picovoice.ai)
- [ ] Train "skelatal" wake word
- [ ] Download .ppn files to assets/wake_word/
- [ ] Get OpenAI API key (platform.openai.com)
- [ ] Add both keys to code (use .env for security)
- [ ] Test in quiet environment
- [ ] Test in gym (noisy)
- [ ] Set up billing alerts on OpenAI ($5 threshold)

---

## You're Ready! 🚀

No backend needed for now. Just:
1. Add API keys
2. Test wake word
3. Test voice transcription
4. Ship it! 🔥

Backend can come later when you scale! 💪

