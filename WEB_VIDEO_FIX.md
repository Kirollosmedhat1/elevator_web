<!-- Web video playback optimization for Flutter -->
<!-- Add this before the </head> tag in web/index.html -->

<!-- Video streaming meta tags and headers -->
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta http-equiv="Cache-Control" content="public, max-age=3600">

<!-- Enable video playback features -->
<script>
  // Log video player events for debugging
  window.addEventListener('DOMContentLoaded', function() {
    console.log('Flutter video player loaded');
    
    // Monitor video playback issues
    if (document.querySelector('video')) {
      const videos = document.querySelectorAll('video');
      videos.forEach(video => {
        video.addEventListener('error', (e) => {
          console.error('Video error:', e.target.error);
        });
        video.addEventListener('stalled', () => {
          console.warn('Video stalled');
        });
        video.addEventListener('waiting', () => {
          console.log('Video waiting for data');
        });
      });
    }
  });
</script>

<!-- CORS policy for video resources -->
<meta http-equiv="Permissions-Policy" content="camera=(), microphone=(), geolocation=()">
