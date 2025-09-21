import 'package:elevatorweb/widgets/home/welcome_sec.dart';
import 'package:elevatorweb/widgets/home/intro_sec.dart';
import 'package:elevatorweb/widgets/home/imp_aboutus_sec.dart';
import 'package:elevatorweb/controllers/animation_controller.dart';
import 'package:elevatorweb/widgets/home/customer_reviews.dart';
import 'package:elevatorweb/widgets/footer.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeAnimationController animationController = Get.put(
      HomeAnimationController(),
    );

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          animationController.checkScrollTrigger(
            scrollInfo.metrics.pixels,
            800.0,
          );
          return false;
        },
        child: ListView(
          children: [
            WelcomeSec(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            IntroSec(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            ImpAboutusSec(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            CustomerReviews(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Footer(),
          ],
        ),
      ),
    );
  }
}
