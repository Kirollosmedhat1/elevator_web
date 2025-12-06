import 'package:flutter/foundation.dart';

/// Helper class for handling video URLs and CORS issues on web
class VideoHelper {
  /// Ensures video URL is properly formatted for web playback
  /// Adds CORS proxy if needed for cross-origin videos
  static String getWebFriendlyUrl(String videoUrl) {
    // If it's already a local asset or data URL, return as-is
    if (videoUrl.startsWith('asset://') || 
        videoUrl.startsWith('data:') ||
        videoUrl.startsWith('blob:')) {
      return videoUrl;
    }

    // For web platform, ensure the URL is accessible
    // Some CORS issues can be mitigated by ensuring the URL is complete
    if (!videoUrl.startsWith('http://') && !videoUrl.startsWith('https://')) {
      return 'https://$videoUrl';
    }

    return videoUrl;
  }

  /// Check if video URL is likely to have CORS issues
  static bool likelyHasCorsIssues(String videoUrl) {
    // Supabase storage URLs typically support CORS
    if (videoUrl.contains('supabase.co')) return false;
    
    // YouTube videos require specific handling
    if (videoUrl.contains('youtube.com') || videoUrl.contains('youtu.be')) {
      return true; // YouTube blocks direct video_player access
    }

    // Assume other origins might have CORS issues on web
    if (kIsWeb) {
      return !videoUrl.contains('supabase.co') && 
             !videoUrl.contains('localhost');
    }

    return false;
  }

  /// Get alternative video sources for fallback scenarios
  static List<String> getVideoSources(String primaryUrl) {
    // Add any mirror URLs or alternative sources here
    return [primaryUrl];
  }

  /// Validates if a URL is in a format that video_player can handle
  static bool isValidVideoUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return false;

    // Check if it's a valid web URL or asset
    if (url.startsWith('asset://')) return true;
    if (url.startsWith('data:')) return true;
    if (url.startsWith('blob:')) return true;
    
    return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
  }
}
