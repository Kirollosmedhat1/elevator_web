import 'package:flutter/material.dart';

class AboutusContainer extends StatefulWidget {
  const AboutusContainer({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image;
  final String title;
  final String description;

  @override
  State<AboutusContainer> createState() => _AboutusContainerState();
}

class _AboutusContainerState extends State<AboutusContainer> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      width: MediaQuery.of(context).size.height * 0.365,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xff0B415A), width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => isHovered = true),
            onExit: (_) => setState(() => isHovered = false),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border(
                  bottom: BorderSide(color: Color(0xff0B415A), width: 3),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: Stack(
                children: [
                  AnimatedScale(
                    duration: Duration(milliseconds: 600),
                    scale: isHovered ? 1.2 : 1.0,
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.height * 1,
                    ),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 600),
                    opacity: isHovered ? 0.3 : 0.0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.25,
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
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: "${widget.title}\n\n"),
                  TextSpan(
                    text: widget.description,
                    style: TextStyle(fontWeight: FontWeight.w100, height: 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
