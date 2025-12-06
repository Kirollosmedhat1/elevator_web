# Flutter Web Video Playback - Troubleshooting & Solutions

## Changes Applied

I've implemented several fixes to improve video playback in your deployed Flutter web app:

### 1. **Enhanced Error Handling & Retry Logic**
- Added timeout detection (10 seconds per attempt)
- Implemented automatic retry mechanism (up to 3 retries)
- Clear error messages guiding users to check internet connection
- Graceful fallback UI when max retries are exceeded

### 2. **HTTP Headers Optimization**
- Added `Accept-Ranges: bytes` for proper streaming support
- Set `Connection: keep-alive` for persistent connections
- Added `User-Agent` header for better server compatibility

### 3. **URL Validation & Normalization**
- Created `VideoHelper` service to validate video URLs
- Ensures URLs are in correct format (http/https)
- Validates URL structure before attempting playback

### 4. **Web-Specific Configuration**
- Updated `web/index.html` with video playback meta tags
- Added cache control headers for better performance
- Included console debugging helpers

## Common Issues & Solutions

### ❌ "Try Again" Loop or Timeout Errors

**Cause:** Video source cannot reach the device or network timeout.

**Solutions:**
1. **Check Internet Connection** - Ensure stable connection from deployment location
2. **Verify Video URL** - Open video URL directly in browser to confirm it works
3. **Check Response Headers:**
   ```bash
   curl -I "https://your-video-url.com/video.mp4"
   ```
   Look for:
   - `HTTP/1.1 200 OK` status
   - `Content-Type: video/mp4`
   - `Accept-Ranges: bytes` (optional but recommended)

### ❌ CORS (Cross-Origin Resource Sharing) Errors

**Console Error:** `Access to XMLHttpRequest blocked by CORS policy`

**Cause:** Video server doesn't allow requests from your domain.

**Solutions:**
1. **Host videos on CORS-friendly CDN:**
   - Supabase Storage ✅ (Already integrated)
   - AWS CloudFront ✅
   - Cloudflare ✅
   - Firebase Storage ✅

2. **If using custom server, configure CORS:**
   ```
   Access-Control-Allow-Origin: *
   Access-Control-Allow-Methods: GET, HEAD, OPTIONS
   Access-Control-Allow-Headers: Range
   ```

### ❌ Unsupported Video Format

**Cause:** Browser doesn't support the codec.

**Solutions:**
- Use **MP4 (H.264 video + AAC audio)** - most compatible
- Ensure video is encoded with: `ffmpeg -i input.mov -c:v libx264 -crf 23 -c:a aac output.mp4`

### ❌ Large File Sizes

**Cause:** GitHub has size limits; large videos fail to load.

**Solutions:**
1. **Move videos to cloud storage:**
   ```
   Supabase Storage → Get public URL → Use in app
   AWS S3 → CloudFront CDN
   Bunny CDN → Fast global delivery
   ```

2. **Compress videos:**
   ```bash
   ffmpeg -i video.mp4 -vf scale=1280:-1 -c:v libx264 -crf 28 compressed.mp4
   ```

## How to Test the Fix

### Local Testing
```bash
# Build and serve locally
cd /Users/kiro/Developer/lib/elevatorweb
flutter build web
python3 -m http.server 8000 -d build/web
# Open http://localhost:8000 and test videos
```

### Deployment Testing
1. Push changes:
   ```bash
   git add .
   git commit -m "Fix: Add robust video playback handling for web"
   git push origin main
   ```

2. Rebuild web:
   ```bash
   flutter build web --release
   ```

3. Deploy to your host and test video playback

## Video URL Requirements

For videos to play on deployed web:
✅ Must be HTTPS (not HTTP)
✅ Must support Range requests (Accept-Ranges: bytes)
✅ Server must have CORS enabled or same-origin
✅ Content-Type header must be video/mp4 or compatible
✅ Video codec must be H.264 (MP4 container)

## Recommended Video Hosting Setup

### For Supabase (Already integrated):
```dart
// Videos automatically get CORS headers from Supabase Storage
final videoUrl = 'https://your-project.supabase.co/storage/v1/object/public/videos/video.mp4';
```

### For AWS S3:
```dart
// Use CloudFront distribution for better performance
final videoUrl = 'https://d123.cloudfront.net/videos/video.mp4';
```

### For Custom Server:
Ensure `_headers` file or `.htaccess` (if Apache):
```
[[headers]]
  for = "/videos/*"
  [headers.values]
    Access-Control-Allow-Origin = "*"
    Access-Control-Allow-Methods = "GET, HEAD, OPTIONS"
    Content-Type = "video/mp4"
    Accept-Ranges = "bytes"
```

## Files Modified

1. `lib/view/gallery.dart` - Enhanced video player with error handling
2. `lib/services/video_helper.dart` - New video URL validation service
3. `web/index.html` - Added video optimization meta tags
4. `pubspec.yaml` - Ensured video_player ^2.9.2 dependency

## Next Steps

1. **Test videos locally first** using the local testing commands above
2. **Verify video URLs** are accessible and have correct headers
3. **Check browser console** (F12) for specific error messages
4. **Deploy and test** the fix on your live site
5. If still failing, share:
   - Browser console error
   - Network tab screenshot showing the video request
   - Video URL (sanitized if needed)

## Video Player Controls Added

- ▶️ Play/Pause button
- ⏱️ Progress bar with scrubbing
- 🔊 Volume control
- ⏱️ Duration display
- 🔄 Retry mechanism with counter

---

**Questions or issues?** Check the browser console (F12 → Console) for detailed error messages.
