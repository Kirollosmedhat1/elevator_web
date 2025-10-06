import 'package:flutter/material.dart';

class PageNamePhoto extends StatelessWidget {
  const PageNamePhoto({super.key, required this.pagename});
  final String pagename;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/elevator.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          pagename,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
