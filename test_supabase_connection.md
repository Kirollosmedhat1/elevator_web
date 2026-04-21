# Testing Supabase Gallery Connection

## Step 1: Check Browser Console

1. Open your Flutter web app in the browser
2. Open Developer Tools (F12 or Right-click → Inspect)
3. Go to the Console tab
4. Navigate to the Gallery page
5. Look for these debug messages:
   - `🔄 Loading gallery items...`
   - `🔍 Attempting to fetch gallery items...`
   - `✅ Raw response received: ...`
   - `✅ Gallery items fetched: X`

## Step 2: Verify RLS Policy

Run this SQL in Supabase SQL Editor:

```sql
-- Check if RLS is enabled
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' AND tablename = 'gallery';

-- Check existing policies
SELECT * FROM pg_policies WHERE tablename = 'gallery';

-- If no policy exists, create one:
ALTER TABLE gallery ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow public read on gallery"
  ON gallery
  FOR SELECT
  TO anon
  USING (true);
```

## Step 3: Test Direct Query

Run this in Supabase SQL Editor to verify data exists:

```sql
SELECT * FROM gallery;
```

You should see your 4 rows.

## Step 4: Check Table Structure

Verify your table has these columns:
- `id` (text or uuid)
- `url` (text)
- `type` (text)

## Step 5: Common Issues

1. **RLS Policy Missing**: Most common issue - run the policy SQL above
2. **Column Names**: Make sure columns are lowercase: `id`, `url`, `type`
3. **Data Type**: The `id` column in your SQL shows strings ('1', '2') which is fine
4. **URL Format**: Your URLs look correct (Supabase signed URLs)

## Step 6: Manual Test

Try this in Supabase SQL Editor to test the exact query:

```sql
SELECT id, url, type FROM gallery;
```

If this works, the issue is likely RLS or the Flutter code.















