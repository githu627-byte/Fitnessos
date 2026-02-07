# 🔥 Supabase Setup for FitnessOS Analytics

## Step 1: Run SQL Migration

1. Go to your Supabase project dashboard
2. Click **SQL Editor** in the left sidebar
3. Click **New Query**
4. Copy the entire contents of `supabase/migrations/create_analytics_tables.sql`
5. Paste into the SQL editor
6. Click **Run** (or press Ctrl/Cmd + Enter)

**This will create**:
- ✅ 6 tables (workout_sessions, exercise_sets, personal_records, body_measurements, progress_photos, workout_recordings)
- ✅ All indexes for fast queries
- ✅ Row Level Security (RLS) policies (users can only see their own data)
- ✅ 2 storage buckets (progress-photos, workout-videos)
- ✅ Storage policies (users can only access their own files)

## Step 2: Verify Setup

Run these queries in SQL Editor to verify:

```sql
-- Check all tables were created
SELECT tablename FROM pg_tables WHERE schemaname = 'public' ORDER BY tablename;

-- Check storage buckets
SELECT * FROM storage.buckets;

-- Check RLS is enabled
SELECT schemaname, tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
AND rowsecurity = true;
```

**You should see**:
- 6 tables with RLS enabled ✅
- 2 storage buckets ✅

## Step 3: Test Sync (Optional)

After setting up tables, complete a workout in the app:

1. Login to the app
2. Complete any workout (Auto Mode, Visual Guide, or Pro Logger)
3. Check Supabase **Table Editor**:
   - Should see new row in `workout_sessions` ✅
   - Should see sets in `exercise_sets` ✅
   - Should see PR in `personal_records` if applicable ✅

## What Each Table Does

| Table | Purpose |
|-------|---------|
| `workout_sessions` | Main workout data (name, date, duration, calories, mode) |
| `exercise_sets` | Detailed set data (exercise, weight, reps, form scores) |
| `personal_records` | Auto-tracked PRs with e1RM calculations |
| `body_measurements` | Body weight and measurements |
| `progress_photos` | Progress photo metadata (files in storage) |
| `workout_recordings` | Video recording metadata (files in storage) |

## Security Features

### Row Level Security (RLS)
- ✅ Users can ONLY see/edit their own data
- ✅ Enforced at database level (not app level)
- ✅ Even if someone hacks the API, they can't access other users' data

### Storage Policies
- ✅ Photos/videos stored per user: `progress-photos/{user_id}/photo.jpg`
- ✅ Users can ONLY access files in their own folder
- ✅ Private by default (not publicly accessible)

## Sync Behavior

**When user completes workout**:
1. ✅ Saves to local SQLite (instant)
2. ☁️ Syncs to Supabase in background (2-5 seconds)
3. 🔄 If offline, queues for later sync

**When user opens app**:
1. 📥 Checks for cloud updates
2. 🔄 Pulls missing workouts (if on new device)
3. ✅ Merges with local data

## Troubleshooting

### "relation does not exist" error
- Run the SQL migration again
- Check table names match exactly (lowercase, underscores)

### Sync not working
- Check user is logged in: `Supabase.instance.client.auth.currentUser`
- Check Supabase URL and anon key in env
- Check RLS policies were created

### Storage upload fails
- Check buckets were created
- Check storage policies were created
- Check file path format: `{user_id}/filename.jpg`

## Next Steps

1. ✅ Run SQL migration
2. ✅ Verify tables created
3. ✅ Test by completing a workout
4. ✅ Check data appears in Supabase Table Editor

**Done! Your app now has cloud backup for all analytics data!** 🎉
