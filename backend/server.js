const express = require('express');
const multer = require('multer');
const FormData = require('form-data');
const axios = require('axios');
const fs = require('fs');
const path = require('path');
require('dotenv').config();

const app = express();
const upload = multer({ dest: 'uploads/' });

// Middleware
app.use(express.json());

// CORS - Allow your app to talk to this server
app.use((req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
  next();
});

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok', message: 'Skelatal-PT Backend is running! 🔥' });
});

// POST /api/transcribe - Send audio to Whisper
app.post('/api/transcribe', upload.single('audio'), async (req, res) => {
  try {
    const { isPremium } = req.body;
    const audioFile = req.file;

    if (!audioFile) {
      return res.status(400).json({ error: 'No audio file provided' });
    }

    console.log('📤 Transcribing audio for user (premium:', isPremium, ')');

    // Create form data for OpenAI
    const formData = new FormData();
    formData.append('file', fs.createReadStream(audioFile.path));
    formData.append('model', 'whisper-1');
    formData.append('language', 'en');
    formData.append('response_format', 'text');
    formData.append('prompt', 'Weight in pounds: 135, 45, 225, 315, body weight');

    // Send to OpenAI Whisper API
    const response = await axios.post(
      'https://api.openai.com/v1/audio/transcriptions',
      formData,
      {
        headers: {
          'Authorization': `Bearer ${process.env.OPENAI_API_KEY}`,
          ...formData.getHeaders(),
        },
      }
    );

    const transcription = response.data;
    console.log('✅ Transcription:', transcription);

    // Clean up uploaded file
    fs.unlinkSync(audioFile.path);

    // Extract weight from transcription
    const weight = extractWeight(transcription);

    res.json({
      success: true,
      transcription: transcription.trim(),
      weight: weight,
    });

  } catch (error) {
    console.error('❌ Transcription error:', error.message);
    
    // Clean up file if it exists
    if (req.file) {
      try {
        fs.unlinkSync(req.file.path);
      } catch (e) {}
    }

    res.status(500).json({
      success: false,
      error: 'Failed to transcribe audio',
      details: error.response?.data || error.message,
    });
  }
});

// Helper function to extract weight from text
function extractWeight(text) {
  text = text.toLowerCase().trim();

  // Handle body weight
  if (text.includes('body') || text.includes('bodyweight')) {
    return 0;
  }

  // Extract number
  const numberPattern = /(\d+\.?\d*)/;
  const match = text.match(numberPattern);
  
  if (match) {
    return parseFloat(match[1]);
  }

  return null;
}

// Rate limiting (optional but recommended)
const rateLimitMap = new Map();

function rateLimit(req, res, next) {
  const userId = req.headers['x-user-id'] || req.ip;
  const now = Date.now();
  const userRequests = rateLimitMap.get(userId) || [];
  
  // Filter requests from last minute
  const recentRequests = userRequests.filter(time => now - time < 60000);
  
  // Limit to 10 requests per minute
  if (recentRequests.length >= 10) {
    return res.status(429).json({ error: 'Too many requests. Try again later.' });
  }
  
  recentRequests.push(now);
  rateLimitMap.set(userId, recentRequests);
  next();
}

// Apply rate limiting to transcribe endpoint
app.post('/api/transcribe', rateLimit);

// Start server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log('🚀 Skelatal-PT Backend running on port', PORT);
  console.log('🔑 OpenAI API Key:', process.env.OPENAI_API_KEY ? 'Loaded ✅' : 'MISSING ❌');
});

