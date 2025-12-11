# Supabase Setup Guide

This guide will help you set up Supabase for your Elevator Web Application.

## Step 1: Create a Supabase Project

1. Go to [https://supabase.com](https://supabase.com)
2. Sign up or log in
3. Click "New Project"
4. Fill in your project details:
   - Name: Your project name
   - Database Password: Choose a strong password (save it!)
   - Region: Choose the closest region to your users
5. Wait for the project to be created (takes a few minutes)

## Step 2: Get Your Supabase Credentials

1. In your Supabase project dashboard, go to **Settings** → **API**
2. Copy the following:
   - **Project URL** (this is your `supabaseUrl`)
   - **anon/public key** (this is your `supabaseAnonKey`)

## Step 3: Update Configuration

1. Open `lib/config/supabase_config.dart`
2. Replace the placeholder values:
   ```dart
   static const String supabaseUrl = 'YOUR_SUPABASE_URL';
   static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
   ```
   With your actual values:
   ```dart
   static const String supabaseUrl = 'https://xxxxxxxxxxxxx.supabase.co';
   static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
   ```

## Step 4: Create Database Tables

1. In your Supabase dashboard, go to **SQL Editor**
2. Click "New Query"
3. Copy and paste the contents of `supabase_schema.sql`
4. Click "Run" to execute the SQL
5. Verify the tables were created by going to **Table Editor**

## Step 5: Set Up Storage Bucket for CV Files

1. In your Supabase dashboard, go to **Storage**
2. Click "Create a new bucket"
3. Configure the bucket:
   - **Name**: `cv_files`
   - **Public bucket**: Unchecked (private)
   - **File size limit**: 10 MB (or your preferred limit)
   - **Allowed MIME types**: 
     - `application/pdf`
     - `application/msword`
     - `application/vnd.openxmlformats-officedocument.wordprocessingml.document`
4. Click "Create bucket"

### Set Storage Policies

1. Go to **Storage** → **Policies**
2. Click on the `cv_files` bucket
3. Click "New Policy" → "Create policy from scratch"
4. Configure:
   - **Policy name**: Allow public uploads to cv_files
   - **Allowed operation**: INSERT
   - **Target roles**: anon
   - **Policy definition**: 
     ```sql
     (bucket_id = 'cv_files')
     ```
5. Save the policy

## Step 6: Install Dependencies

Run the following command in your project root:

```bash
flutter pub get
```

## Step 7: Test the Integration

1. Run your Flutter app
2. Try submitting the contact form
3. Try submitting a career application
4. Check your Supabase dashboard:
   - **Table Editor** → `contact_submissions` - should see your test submission
   - **Table Editor** → `career_applications` - should see your test application
   - **Storage** → `cv_files` - should see uploaded CV files

## Troubleshooting

### Error: "Supabase not initialized"
- Make sure you've updated `supabase_config.dart` with your actual credentials
- Check that `main()` is properly calling `SupabaseService.initialize()`

### Error: "Failed to submit form"
- Check your Supabase project is active
- Verify the table names match exactly (case-sensitive)
- Check Row Level Security policies are set correctly
- Check browser console for detailed error messages

### CV Files Not Uploading
- Verify the storage bucket `cv_files` exists
- Check storage policies allow INSERT for anon role
- Verify file size is within limits
- Check MIME type restrictions

## Security Notes

- The `anon` key is safe to use in client-side code, but it's limited by RLS policies
- Never commit your actual Supabase credentials to version control
- Consider using environment variables for production
- Regularly review and update your RLS policies

## Next Steps

- Set up email notifications for new submissions (using Supabase Edge Functions)
- Add authentication if you want admin access to view submissions
- Create admin dashboard to view and manage submissions
- Set up automated backups











