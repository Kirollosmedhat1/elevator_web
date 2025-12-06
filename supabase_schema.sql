-- Supabase Database Schema for Elevator Web Application
-- Run this SQL in your Supabase SQL Editor to create the necessary tables

-- Contact Submissions Table
CREATE TABLE IF NOT EXISTS contact_submissions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT NOT NULL,
  governorate TEXT,
  city TEXT NOT NULL,
  contact_time TEXT,
  message TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Career Applications Table
CREATE TABLE IF NOT EXISTS career_applications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT NOT NULL,
  career TEXT NOT NULL,
  governorate TEXT NOT NULL,
  message TEXT,
  cv_file_name TEXT,
  cv_file_url TEXT,
  cv_mime_type TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Products Table (optional - if you want to manage products from Supabase)
CREATE TABLE IF NOT EXISTS products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  image TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Row Level Security (RLS)
ALTER TABLE contact_submissions ENABLE ROW LEVEL SECURITY;
ALTER TABLE career_applications ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- Create policies to allow inserts (public can submit forms)
-- Contact Submissions: Allow anyone to insert
CREATE POLICY "Allow public insert on contact_submissions"
  ON contact_submissions
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Career Applications: Allow anyone to insert
CREATE POLICY "Allow public insert on career_applications"
  ON career_applications
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Products: Allow anyone to read, but only authenticated users can modify
CREATE POLICY "Allow public read on products"
  ON products
  FOR SELECT
  TO anon
  USING (true);

-- Create Storage Bucket for CV Files
-- Note: You need to create this bucket in Supabase Dashboard > Storage
-- Bucket name: cv_files
-- Public: false (private bucket)
-- Allowed MIME types: application/pdf, application/msword, application/vnd.openxmlformats-officedocument.wordprocessingml.document

-- Storage Policy for CV Files (allow uploads from anonymous users)
-- This will be created automatically when you set up the bucket, but you can customize it:
-- CREATE POLICY "Allow public uploads to cv_files"
--   ON storage.objects
--   FOR INSERT
--   TO anon
--   WITH CHECK (bucket_id = 'cv_files');

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_contact_submissions_created_at ON contact_submissions(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_career_applications_created_at ON career_applications(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_career_applications_career ON career_applications(career);








