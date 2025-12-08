-- Row Level Security Policy for Gallery Table
-- Run this SQL in your Supabase SQL Editor to allow public reads

-- Enable Row Level Security (if not already enabled)
ALTER TABLE gallery ENABLE ROW LEVEL SECURITY;

-- Create policy to allow public read access
CREATE POLICY "Allow public read on gallery"
  ON gallery
  FOR SELECT
  TO anon
  USING (true);

-- Also allow authenticated users to read
CREATE POLICY "Allow authenticated read on gallery"
  ON gallery
  FOR SELECT
  TO authenticated
  USING (true);








