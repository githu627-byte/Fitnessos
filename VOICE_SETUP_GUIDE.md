# 🎤 VOICE RECOGNITION SETUP GUIDE

## ✅ What's Been Added

1. **Weight Logging Dialog** - Appears after every set (GYM workouts only)
2. **Porcupine Wake Word** - On-device detection for "skelatal"  
3. **Whisper Speech-to-Text** - Backend API for transcription
4. **Manual Input** - Tap to type weight if voice fails

---

## 🔧 Setup Steps (Do These In Order!)

### **Step 1: Get Porcupine Wake Word Key (FREE)**

1. Go to https://console.picovoice.ai/
2. Sign up (free account)
3. Click **"Porcupine"** → **"Train Custom Wake Word"**
4. Enter wake word: `skelatal`
5. Select platforms: **Android** + **iOS**
6. Click **"Train"** (takes 2 min)
7. Download:
   - `skelatal_android.ppn`
   - `skelatal_ios.ppn`
8. Create folder: `assets/wake_word/`
9. Put both `.ppn` files in that folder
10. Add to `pubspec.yaml`:
    ```yaml
    flutter:
      assets:
        - assets/wake_word/
    ```
11. Copy your **Access Key** from Picovoice Console
12. Open `lib/services/voice_recognition_service.dart`
13. Replace line 37:
    ```dart
    static const String _accessKey = 'YOUR_ACTUAL_KEY_HERE';
    ```

---

### **Step 2: Get OpenAI Whisper API Key**

1. Go to https://platform.openai.com/api-keys
2. Click **"Create new secret key"**
3. Copy it (starts with `sk-...`)
4. **KEEP IT SECRET!** ⚠️

---

### **Step 3: Deploy Backend to Railway (5 MINUTES)**

#### A. Create Railway Account
1. Go to https://railway.app/
2. Sign up with GitHub

#### B. Deploy Backend
1. Click **"Start a New Project"**
2. Click **"Deploy from GitHub repo"**
3. Select **`stossthegreat/fitnessos`** (or your repo)
4. Railway auto-detects the `backend/` folder

#### C. Configure Railway
1. Click **"Settings"** (⚙️)
2. Set **"Root Directory"** to: `backend`
3. Click **"Variables"** tab
4. Click **"+ New Variable"**
5. Add:
   - **Variable:** `OPENAI_API_KEY`
   - **Value:** `sk-...` (your Whisper key from Step 2)
6. Add another:
   - **Variable:** `PORT`
   - **Value:** `3000`
7. Click **"Deploy"**

#### D. Get Your Backend URL
Wait 1-2 minutes, then Railway gives you a URL like:
```
https://fitnessos-backend-production.up.railway.app
```

---

### **Step 4: Update Flutter App**

1. Open `lib/services/whisper_service.dart`
2. Find line 12:
   ```dart
   static const String _backendUrl = 'YOUR_BACKEND_URL_HERE';
   ```
3. Replace with your Railway URL:
   ```dart
   static const String _backendUrl = 'https://YOUR-APP.railway.app';
   ```

---

### **Step 5: Build & Test!**

```bash
flutter pub get
flutter build apk --release
```

Install APK on your phone and test:
1. Start a GYM workout (e.g., "Chest Day")
2. Complete a set
3. Weight dialog appears! 💪
4. Tap the **MIC button**
5. Say: **"skelatal 135 pounds"**
6. Watch it auto-fill! ✨

---

## 🎯 How Voice Recognition Works

```
User taps MIC
    ↓
Porcupine listens (on-device, no internet)
    ↓
User says: "SKELATAL"
    ↓
Wake word detected! (< 100ms) ⚡
    ↓
Start recording audio (5 seconds)
    ↓
User says: "135 pounds"
    ↓
Send audio → YOUR Railway backend
    ↓
Backend → OpenAI Whisper API
    ↓
Returns: "135 pounds"
    ↓
Extract: 135
    ↓
Auto-fill weight field! ✅
```

---

## 🔒 Security (API Key is SAFE!)

- ✅ **Porcupine key**: In Flutter code (safe - it's just for wake word)
- ✅ **OpenAI key**: On Railway server (NEVER in your app!)
- ✅ **Users can't see**: Your OpenAI key
- ✅ **Rate limiting**: 10 requests/min per IP

---

## 🐛 Troubleshooting

### "Microphone permission denied"
- Go to phone Settings → Apps → Skelatal-PT → Permissions → Enable Microphone

### "Wake word not detecting"
- Make sure `.ppn` files are in `assets/wake_word/`
- Check `pubspec.yaml` has `assets/wake_word/` listed
- Verify your Porcupine access key is correct

### "Voice transcription failed"
- Check Railway backend is deployed (green status)
- Verify `OPENAI_API_KEY` is set in Railway Variables
- Check `_backendUrl` in `whisper_service.dart` matches Railway URL
- Test backend directly: `curl https://YOUR-APP.railway.app/health`

### "Weight dialog not appearing"
- Only shows for **GYM** workouts (not home/bodyweight)
- Check workout category in Workouts tab
- Dialog shows during REST screen (after completing a set)

---

## 💰 Costs

| Service | Cost | What You Get |
|---------|------|--------------|
| **Porcupine** | FREE | 3 wake words, unlimited detections |
| **Railway** | FREE | 500 hours/month, $5 credit |
| **OpenAI Whisper** | $0.006/min | ~$0.01 per weight input (5 sec audio) |

**Example:** 
- 100 workouts/month × 30 sets × $0.01 = **$30/month**
- Railway FREE tier covers hosting
- Porcupine is always FREE

---

## 📝 What's Next?

Once this is working, you can add:
- [ ] Spoken number conversion ("fifty" → 50)
- [ ] Weight summary at end of workout
- [ ] Voice commands ("next set", "skip rest")
- [ ] Premium tier for faster transcription
- [ ] Shareable workout reports with weight stats

---

**Wake word: "skelatal" 💀🎤**

