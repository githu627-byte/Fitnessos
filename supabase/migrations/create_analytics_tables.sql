-- ═══════════════════════════════════════════════════════════════════════════
-- FitnessOS Analytics Tables - Supabase Migration
-- Run this in Supabase SQL Editor
-- ═══════════════════════════════════════════════════════════════════════════

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ═══════════════════════════════════════════════════════════════════════════
-- WORKOUT SESSIONS TABLE
-- ═══════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS workout_sessions (
  id TEXT PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  name TEXT NOT NULL,
  date TIMESTAMPTZ NOT NULL,
  start_time TIMESTAMPTZ,
  end_time TIMESTAMPTZ,
  duration_minutes INTEGER,
  status TEXT NOT NULL DEFAULT 'complete',
  total_reps INTEGER DEFAULT 0,
  total_volume REAL DEFAULT 0,
  avg_form_score REAL DEFAULT 0.0,
  perfect_reps INTEGER DEFAULT 0,
  calories_burned INTEGER DEFAULT 0,
  workout_mode TEXT,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_workout_sessions_user_id ON workout_sessions(user_id);
CREATE INDEX IF NOT EXISTS idx_workout_sessions_date ON workout_sessions(user_id, date DESC);
CREATE INDEX IF NOT EXISTS idx_workout_sessions_status ON workout_sessions(user_id, status);

-- Row Level Security
ALTER TABLE workout_sessions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own workout sessions"
  ON workout_sessions FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own workout sessions"
  ON workout_sessions FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own workout sessions"
  ON workout_sessions FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own workout sessions"
  ON workout_sessions FOR DELETE
  USING (auth.uid() = user_id);

-- ═══════════════════════════════════════════════════════════════════════════
-- EXERCISE SETS TABLE
-- ═══════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS exercise_sets (
  id BIGSERIAL PRIMARY KEY,
  session_id TEXT REFERENCES workout_sessions(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  exercise_name TEXT NOT NULL,
  set_number INTEGER NOT NULL,
  weight REAL DEFAULT 0,
  reps_completed INTEGER NOT NULL,
  reps_target INTEGER NOT NULL,
  form_score REAL DEFAULT 0.0,
  perfect_reps INTEGER DEFAULT 0,
  good_reps INTEGER DEFAULT 0,
  missed_reps INTEGER DEFAULT 0,
  max_combo INTEGER DEFAULT 0,
  duration_seconds INTEGER DEFAULT 0,
  rest_time_seconds INTEGER DEFAULT 0,
  timestamp TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_exercise_sets_user_id ON exercise_sets(user_id);
CREATE INDEX IF NOT EXISTS idx_exercise_sets_session_id ON exercise_sets(session_id);
CREATE INDEX IF NOT EXISTS idx_exercise_sets_exercise_name ON exercise_sets(user_id, exercise_name);
CREATE INDEX IF NOT EXISTS idx_exercise_sets_timestamp ON exercise_sets(user_id, timestamp DESC);

-- Row Level Security
ALTER TABLE exercise_sets ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own exercise sets"
  ON exercise_sets FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own exercise sets"
  ON exercise_sets FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own exercise sets"
  ON exercise_sets FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own exercise sets"
  ON exercise_sets FOR DELETE
  USING (auth.uid() = user_id);

-- ═══════════════════════════════════════════════════════════════════════════
-- PERSONAL RECORDS TABLE
-- ═══════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS personal_records (
  id BIGSERIAL PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  exercise_name TEXT NOT NULL,
  weight REAL NOT NULL,
  reps INTEGER NOT NULL,
  e1rm REAL,
  date TIMESTAMPTZ NOT NULL,
  session_id TEXT REFERENCES workout_sessions(id) ON DELETE SET NULL,
  is_current BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, exercise_name, is_current)
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_personal_records_user_id ON personal_records(user_id);
CREATE INDEX IF NOT EXISTS idx_personal_records_exercise ON personal_records(user_id, exercise_name);
CREATE INDEX IF NOT EXISTS idx_personal_records_current ON personal_records(user_id, is_current) WHERE is_current = TRUE;

-- Row Level Security
ALTER TABLE personal_records ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own personal records"
  ON personal_records FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own personal records"
  ON personal_records FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own personal records"
  ON personal_records FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own personal records"
  ON personal_records FOR DELETE
  USING (auth.uid() = user_id);

-- ═══════════════════════════════════════════════════════════════════════════
-- BODY MEASUREMENTS TABLE
-- ═══════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS body_measurements (
  id TEXT PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  date TIMESTAMPTZ NOT NULL,
  weight REAL,
  body_fat REAL,
  chest REAL,
  arms REAL,
  forearms REAL,
  waist REAL,
  hips REAL,
  thighs REAL,
  calves REAL,
  shoulders REAL,
  neck REAL,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_body_measurements_user_id ON body_measurements(user_id);
CREATE INDEX IF NOT EXISTS idx_body_measurements_date ON body_measurements(user_id, date DESC);

-- Row Level Security
ALTER TABLE body_measurements ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own body measurements"
  ON body_measurements FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own body measurements"
  ON body_measurements FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own body measurements"
  ON body_measurements FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own body measurements"
  ON body_measurements FOR DELETE
  USING (auth.uid() = user_id);

-- ═══════════════════════════════════════════════════════════════════════════
-- PROGRESS PHOTOS TABLE
-- ═══════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS progress_photos (
  id TEXT PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  date TIMESTAMPTZ NOT NULL,
  image_url TEXT NOT NULL,
  type TEXT NOT NULL,
  measurement_id TEXT REFERENCES body_measurements(id) ON DELETE SET NULL,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_progress_photos_user_id ON progress_photos(user_id);
CREATE INDEX IF NOT EXISTS idx_progress_photos_date ON progress_photos(user_id, date DESC);
CREATE INDEX IF NOT EXISTS idx_progress_photos_measurement ON progress_photos(measurement_id);

-- Row Level Security
ALTER TABLE progress_photos ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own progress photos"
  ON progress_photos FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own progress photos"
  ON progress_photos FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own progress photos"
  ON progress_photos FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own progress photos"
  ON progress_photos FOR DELETE
  USING (auth.uid() = user_id);

-- ═══════════════════════════════════════════════════════════════════════════
-- WORKOUT RECORDINGS TABLE (for video links)
-- ═══════════════════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS workout_recordings (
  id TEXT PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
  workout_name TEXT NOT NULL,
  video_url TEXT NOT NULL,
  thumbnail_url TEXT,
  duration_seconds INTEGER,
  recorded_at TIMESTAMPTZ NOT NULL,
  session_id TEXT REFERENCES workout_sessions(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_workout_recordings_user_id ON workout_recordings(user_id);
CREATE INDEX IF NOT EXISTS idx_workout_recordings_date ON workout_recordings(user_id, recorded_at DESC);
CREATE INDEX IF NOT EXISTS idx_workout_recordings_session ON workout_recordings(session_id);

-- Row Level Security
ALTER TABLE workout_recordings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own workout recordings"
  ON workout_recordings FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own workout recordings"
  ON workout_recordings FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update their own workout recordings"
  ON workout_recordings FOR UPDATE
  USING (auth.uid() = user_id);

CREATE POLICY "Users can delete their own workout recordings"
  ON workout_recordings FOR DELETE
  USING (auth.uid() = user_id);

-- ═══════════════════════════════════════════════════════════════════════════
-- STORAGE BUCKETS (for images/videos)
-- ═══════════════════════════════════════════════════════════════════════════
-- Run these in Supabase Storage UI or via SQL:

-- Create progress-photos bucket
INSERT INTO storage.buckets (id, name, public) 
VALUES ('progress-photos', 'progress-photos', false)
ON CONFLICT (id) DO NOTHING;

-- Create workout-videos bucket
INSERT INTO storage.buckets (id, name, public) 
VALUES ('workout-videos', 'workout-videos', false)
ON CONFLICT (id) DO NOTHING;

-- Storage policies for progress-photos
CREATE POLICY "Users can upload their own progress photos"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'progress-photos' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can view their own progress photos"
  ON storage.objects FOR SELECT
  USING (
    bucket_id = 'progress-photos' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can delete their own progress photos"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'progress-photos' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

-- Storage policies for workout-videos
CREATE POLICY "Users can upload their own workout videos"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'workout-videos' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can view their own workout videos"
  ON storage.objects FOR SELECT
  USING (
    bucket_id = 'workout-videos' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can delete their own workout videos"
  ON storage.objects FOR DELETE
  USING (
    bucket_id = 'workout-videos' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

-- ═══════════════════════════════════════════════════════════════════════════
-- HELPER FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════

-- Function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger for workout_sessions
CREATE TRIGGER update_workout_sessions_updated_at
  BEFORE UPDATE ON workout_sessions
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ═══════════════════════════════════════════════════════════════════════════
-- VERIFICATION QUERIES
-- ═══════════════════════════════════════════════════════════════════════════

-- Run these to verify everything was created:
-- SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename;
-- SELECT * FROM storage.buckets;

-- ═══════════════════════════════════════════════════════════════════════════
-- ✅ SETUP COMPLETE!
-- ═══════════════════════════════════════════════════════════════════════════
