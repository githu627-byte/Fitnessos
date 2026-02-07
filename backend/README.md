# Skelatal-PT Backend 🔥

Simple Node.js backend for voice recognition with OpenAI Whisper.

## Why Backend?

✅ **API keys stay safe** on server (not in app)  
✅ **Control costs** with rate limiting  
✅ **Track usage** per user  
✅ **Easy to scale** when you grow  

## Quick Start (5 Minutes)

### 1. Install Node.js
Download from: https://nodejs.org/ (v18 or higher)

### 2. Setup Backend
```bash
cd backend
npm install
```

### 3. Add Your OpenAI API Key
```bash
cp env.example .env
# Edit .env and add your OpenAI key
```

Your `.env` file should look like:
```
OPENAI_API_KEY=sk-proj-...YOUR_KEY_HERE
PORT=3000
```

### 4. Run Backend
```bash
npm start
```

You should see:
```
🚀 Skelatal-PT Backend running on port 3000
🔑 OpenAI API Key: Loaded ✅
```

### 5. Test It
Open http://localhost:3000/health

You should see:
```json
{"status":"ok","message":"Skelatal-PT Backend is running! 🔥"}
```

## API Endpoints

### POST /api/transcribe
Transcribe audio to text using Whisper.

**Request:**
```bash
curl -X POST http://localhost:3000/api/transcribe \
  -F "audio=@audio.m4a" \
  -F "isPremium=false"
```

**Response:**
```json
{
  "success": true,
  "transcription": "135 pounds",
  "weight": 135
}
```

## Deploy to Production

### Option 1: Railway (FREE $5/month credit)
1. Go to https://railway.app/
2. Sign up with GitHub
3. Click "New Project" → "Deploy from GitHub"
4. Select your repo
5. Add environment variable: `OPENAI_API_KEY`
6. Deploy! 🚀

Railway gives you: `https://your-app.railway.app`

### Option 2: Render (FREE tier)
1. Go to https://render.com/
2. Sign up with GitHub
3. New → Web Service
4. Connect your repo, select `backend` folder
5. Add environment variable: `OPENAI_API_KEY`
6. Deploy! 🚀

### Option 3: Heroku ($7/month)
1. Go to https://heroku.com/
2. Create new app
3. Connect GitHub repo
4. Set `OPENAI_API_KEY` in config vars
5. Deploy! 🚀

## Update Flutter App

Change the Whisper service to use your backend:

```dart
// lib/services/whisper_service.dart
class WhisperService {
  // Your deployed backend URL
  static const String _backendUrl = 'https://your-app.railway.app';
  
  Future<String?> transcribeAudio(String audioFilePath, {bool isPremium = false}) async {
    final file = File(audioFilePath);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$_backendUrl/api/transcribe'),
    );
    
    request.files.add(await http.MultipartFile.fromPath('audio', audioFilePath));
    request.fields['isPremium'] = isPremium.toString();
    
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final data = jsonDecode(responseBody);
    
    if (data['success']) {
      return data['transcription'];
    }
    return null;
  }
}
```

## Security Features

✅ **Rate Limiting**: 10 requests per minute per user  
✅ **CORS**: Configured for your app  
✅ **No API Key Exposure**: Keys never leave server  
✅ **File Cleanup**: Temp files auto-deleted  

## Cost Estimation

**Whisper API:** $0.006 per minute  
**Average request:** 3 seconds = $0.0003  
**1000 users × 10 workouts/month:** ~$5/month  

**Hosting:**
- Railway: FREE ($5 credit/month)
- Render: FREE (500 hours/month)
- Heroku: $7/month (basic tier)

**Total: $0-7/month** for MVP! 🎉

## Monitoring

Check your costs at:
- OpenAI: https://platform.openai.com/usage
- Railway: https://railway.app/dashboard

Set up billing alerts to avoid surprises!

## Troubleshooting

### "OpenAI API Key: MISSING"
- Make sure `.env` file exists
- Check the API key is correct
- Restart the server

### "Port 3000 already in use"
- Change PORT in `.env` to 3001
- Or kill the process: `lsof -ti:3000 | xargs kill`

### "Cannot connect from app"
- Make sure backend is running
- Check the URL in Flutter app matches deployed URL
- Test with curl first

## Development

Run with auto-restart:
```bash
npm run dev
```

## Production Checklist

- [ ] Get OpenAI API key
- [ ] Deploy backend to Railway/Render
- [ ] Test `/health` endpoint
- [ ] Test `/api/transcribe` with sample audio
- [ ] Update Flutter app with backend URL
- [ ] Set up billing alerts on OpenAI
- [ ] Monitor usage in Railway/Render

## Support

Questions? Check:
- OpenAI Docs: https://platform.openai.com/docs
- Railway Docs: https://docs.railway.app/
- Render Docs: https://render.com/docs

---

**Your API keys are now SAFE! 🔒**

