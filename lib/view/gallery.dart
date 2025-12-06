import 'package:flutter/material.dart';
import 'package:elevatorweb/widgets/footer.dart';
import 'package:elevatorweb/services/supabase_service.dart';
import 'package:elevatorweb/services/video_helper.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  List<Map<String, dynamic>> _galleryItems = [];
  bool _isLoading = true;
  String? _errorMessage;
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _loadGalleryItems();
  }

  Future<void> _loadGalleryItems() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      print('🔄 Loading gallery items...');
      final items = await SupabaseService().getGalleryItems();
      print('✅ Gallery items fetched: ${items.length}');
      print('✅ Gallery items data: $items');

      // Debug: Print each item's structure
      for (var i = 0; i < items.length; i++) {
        print('📸 Item $i: ${items[i]}');
        print('   - Has url: ${items[i].containsKey('url')}');
        print('   - URL value: ${items[i]['url']}');
        print('   - Has type: ${items[i].containsKey('type')}');
        print('   - Type value: ${items[i]['type']}');
      }

      setState(() {
        _galleryItems = items;
        _isLoading = false;
      });
    } catch (e, stackTrace) {
      print('❌ Error loading gallery: $e');
      print('❌ Stack trace: $stackTrace');
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  List<String> get _availableTypes {
    final types =
        _galleryItems
            .map((item) => item['type'] as String?)
            .whereType<String>()
            .where((type) => type.isNotEmpty)
            .toSet()
            .toList();
    types.sort();
    return types;
  }

  List<Map<String, dynamic>> get _filteredItems {
    if (_selectedType == null) {
      return _galleryItems;
    }
    return _galleryItems
        .where((item) => item['type'] == _selectedType)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gallery',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Type Filter
                  if (_availableTypes.isNotEmpty) ...[
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildFilterChip('All', null),
                        ..._availableTypes.map(
                          (type) => _buildFilterChip(type, type),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                  ],
                ],
              ),
            ),

            // Gallery Content
            if (_isLoading)
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_errorMessage != null)
              Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(Icons.error_outline, size: 48, color: Colors.red),
                    SizedBox(height: 16),
                    Text(
                      'Error loading gallery',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _errorMessage!,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _loadGalleryItems,
                      child: Text('Retry'),
                    ),
                  ],
                ),
              )
            else if (_filteredItems.isEmpty)
              Container(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_outlined, size: 64, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'No images found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Total items in database: ${_galleryItems.length}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      if (_selectedType != null)
                        Text(
                          'Filtered by: $_selectedType',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadGalleryItems,
                        child: Text('Refresh'),
                      ),
                    ],
                  ),
                ),
              )
            else
              _buildGalleryGrid(),

            SizedBox(height: 40),
            Footer(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String? type) {
    final isSelected = _selectedType == type;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedType = selected ? type : null;
        });
      },
      selectedColor: Color(0xFFbdd7ee),
      checkmarkColor: Color(0xff0B415A),
      labelStyle: TextStyle(
        color: isSelected ? Color(0xff0B415A) : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildGalleryGrid() {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final crossAxisCount = isMobile ? 3 : 5;
    final spacing = isMobile ? 8.0 : 16.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: 0.6,
        ),
        itemCount: _filteredItems.length,
        itemBuilder: (context, index) {
          final item = _filteredItems[index];
          final mediaUrl = item['url'] as String?;
          final type = item['type'] as String?;
          final isVideo = type?.toLowerCase() == 'video';

          if (mediaUrl == null || mediaUrl.isEmpty) {
            return _buildPlaceholder('No Media');
          }

          return GestureDetector(
            onTap:
                () =>
                    isVideo
                        ? _showVideoDialog(context, mediaUrl, type)
                        : _showImageDialog(context, mediaUrl, type),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (isVideo)
                    // Video thumbnail
                    _buildVideoThumbnail(mediaUrl)
                  else
                    // Image
                    Image.network(
                      mediaUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value:
                                  loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder('Error loading image');
                      },
                    ),
                  // Overlay with type label
                  if (type != null && type.isNotEmpty)
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: Container(
                    //     padding: EdgeInsets.all(8),
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         begin: Alignment.topCenter,
                    //         end: Alignment.bottomCenter,
                    //         colors: [
                    //           Colors.transparent,
                    //           Colors.black.withOpacity(0.7),
                    //         ],
                    //       ),
                    //     ),
                    //     child: Text(
                    //       type,
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // ),
                    // Play icon for videos
                    if (isVideo)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                          child: Center(
                            child: Icon(
                              Icons.play_circle_filled,
                              color: Colors.white,
                              size: 64,
                            ),
                          ),
                        ),
                      ),
                  // Hover effect for images
                  if (!isVideo)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0),
                        ),
                        child: Icon(
                          Icons.zoom_in,
                          color: Colors.white.withOpacity(0),
                          size: 32,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlaceholder(String text) {
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image, size: 32, color: Colors.grey),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoThumbnail(String videoUrl) {
    // For videos, we'll show a placeholder with play icon
    // In a real app, you might want to extract a thumbnail from the video
    return Container(
      color: Colors.grey[900],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.videocam, size: 48, color: Colors.white70),
            SizedBox(height: 8),
            Text(
              'Video',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl, String? type) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Center(
                  child: InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 300,
                            height: 300,
                            color: Colors.grey[800],
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 48,
                                    color: Colors.white,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Error loading image',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.black54,
                    ),
                  ),
                ),
                if (type != null && type.isNotEmpty)
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
    );
  }

  void _showVideoDialog(BuildContext context, String videoUrl, String? type) {
    showDialog(
      context: context,
      builder: (context) => _VideoPlayerDialog(videoUrl: videoUrl, type: type),
    );
  }
}

class _VideoPlayerDialog extends StatefulWidget {
  const _VideoPlayerDialog({required this.videoUrl, this.type});

  final String videoUrl;
  final String? type;

  @override
  State<_VideoPlayerDialog> createState() => _VideoPlayerDialogState();
}

class _VideoPlayerDialogState extends State<_VideoPlayerDialog> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  String? _error;
  int _retryCount = 0;
  static const int _maxRetries = 3;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() {
    // Validate and prepare the video URL
    final videoUrl = widget.videoUrl.trim();
    
    if (!VideoHelper.isValidVideoUrl(videoUrl)) {
      if (mounted) {
        setState(() {
          _error = 'Invalid video URL format: $videoUrl';
        });
      }
      return;
    }

    final webFriendlyUrl = VideoHelper.getWebFriendlyUrl(videoUrl);
    
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(webFriendlyUrl),
      httpHeaders: {
        'Connection': 'keep-alive',
        'Accept-Ranges': 'bytes',
        'User-Agent': 'flutter-video-player/1.0',
      },
    )..setLooping(true);
    
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      // Add timeout to prevent indefinite hanging
      await _controller.initialize().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('Video loading timeout');
        },
      );

      if (mounted) {
        await _controller.play();
        setState(() {
          _isInitialized = true;
          _error = null;
        });
      }
    } on TimeoutException catch (e) {
      if (mounted) {
        setState(() {
          _error =
              'Video took too long to load. Please check your internet connection.';
        });
      }
      print('Video timeout error: $e');
    } catch (e) {
      print('Video initialization error: $e');
      if (mounted) {
        setState(() {
          _error = 'Unable to load video. Please try again.';
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (!_controller.value.isInitialized) return;
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(16),
      child: Stack(
        children: [
          Center(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9,
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.black,
                  child:
                      _error != null
                          ? _buildErrorState()
                          : _isInitialized
                          ? _buildVideoPlayer()
                          : _buildLoadingState(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
              style: IconButton.styleFrom(backgroundColor: Colors.black54),
            ),
          ),
          if (widget.type != null && widget.type!.isNotEmpty)
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.type!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(child: CircularProgressIndicator(color: Colors.white));
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.white),
          SizedBox(height: 12),
          Text(
            _error ?? 'Unable to load video',
            style: TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          if (_retryCount < _maxRetries)
            TextButton.icon(
              onPressed: () {
                _controller.dispose();
                setState(() {
                  _error = null;
                  _isInitialized = false;
                  _retryCount++;
                });
                Future.delayed(Duration(milliseconds: 500), () {
                  _initializeController();
                });
              },
              icon: Icon(Icons.replay, color: Colors.white),
              label: Text(
                'Retry (${_retryCount + 1}/$_maxRetries)',
                style: TextStyle(color: Colors.white),
              ),
            )
          else
            Column(
              children: [
                Text(
                  'Max retries reached',
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
                SizedBox(height: 12),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Close', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio:
              _controller.value.aspectRatio == 0
                  ? 16 / 9
                  : _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
        Positioned(
          bottom: 12,
          left: 12,
          right: 12,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: _togglePlayPause,
              ),
              Expanded(
                child: VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Color(0xFFbdd7ee),
                    bufferedColor: Colors.white24,
                    backgroundColor: Colors.white24,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                _formatDuration(_controller.value.position) +
                    ' / ' +
                    _formatDuration(_controller.value.duration),
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
