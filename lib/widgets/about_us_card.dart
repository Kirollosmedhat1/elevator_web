import 'package:flutter/material.dart';

class AboutUsCard extends StatefulWidget {
  final BuildContext context;
  final String image;
  final String title;
  final String description;
  final dynamic controller;
  final int cardIndex;

  const AboutUsCard({
    super.key,
    required this.context,
    required this.image,
    required this.title,
    required this.description,
    required this.controller,
    required this.cardIndex,
  });

  @override
  State<AboutUsCard> createState() => _AboutUsCardState();
}

class _AboutUsCardState extends State<AboutUsCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.width < 1000
              ? MediaQuery.of(context).size.height *
                  0.25 // Mobile/Tablet: much smaller
              : MediaQuery.of(context).size.height *
                  0.55, // Desktop: original height
      width: MediaQuery.of(context).size.height * 0.365,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              height:
                  MediaQuery.of(context).size.width < 1000
                      ? MediaQuery.of(context).size.height *
                          0.18 // Mobile/Tablet: increased image height
                      : MediaQuery.of(context).size.height *
                          0.25, // Desktop: original image
              width: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 3),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  AnimatedScale(
                    duration: Duration(milliseconds: 300),
                    scale: isHovered ? 1.1 : 1.0,
                    child: _buildImage(context),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: isHovered ? 0.2 : 0.0,
                    child: Container(
                      height:
                          MediaQuery.of(context).size.width < 1000
                              ? MediaQuery.of(context).size.height * 0.18
                              : MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.height * 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width > 768 ? 11 : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width < 1000 ? 4 : 8,
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    height: 1.5,
                  ),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    final imageHeight =
        MediaQuery.of(context).size.width < 1000
            ? MediaQuery.of(context).size.height * 0.18
            : MediaQuery.of(context).size.height * 0.25;
    final imageWidth = MediaQuery.of(context).size.height * 1;

    // Check if image is a network URL or local asset
    if (widget.image.startsWith('http') ||
        widget.image.startsWith('https') ||
        widget.image.startsWith('/')) {
      // Network image
      return Image.network(
        widget.image,
        fit: BoxFit.cover,
        height: imageHeight,
        width: imageWidth,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: imageHeight,
            width: imageWidth,
            color: Colors.grey[300],
            child: Center(
              child: Icon(Icons.broken_image, color: Colors.grey),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: imageHeight,
            width: imageWidth,
            color: Colors.grey[200],
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      );
    } else {
      // Local asset
      return Image.asset(
        widget.image,
        fit: BoxFit.cover,
        height: imageHeight,
        width: imageWidth,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: imageHeight,
            width: imageWidth,
            color: Colors.grey[300],
            child: Center(
              child: Icon(Icons.broken_image, color: Colors.grey),
            ),
          );
        },
      );
    }
  }
}
