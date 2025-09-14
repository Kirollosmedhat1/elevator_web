import 'package:flutter/material.dart';
import 'package:elevatorweb/widgets/footer.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Center(
                child: Text(
                  'Articles Page',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
