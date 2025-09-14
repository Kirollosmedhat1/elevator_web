import 'package:carousel_slider/carousel_slider.dart';
import 'package:elevatorweb/widgets/aboutus_container.dart';
import 'package:elevatorweb/controllers/animation_controller.dart';
import 'package:elevatorweb/widgets/customer_reviews.dart';
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
            Container(
              width: double.infinity, // Take the full width of the parent
              height: 600,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "assets/images/elevator.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 70),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saudi First Elevators",
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "We seek to be the best choice for our customers in the field of elevators and to extend our branches beyond the \nboundaries of the local market to reach all markets in the Middle East.",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("More about us"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.01,
              ),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Saudi First Elevators",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Saudi First Elevators Company is honored in the field of supplying, installing, maintaining \nand modernizing elevators and escalators of all types of electric elevators, \nincluding : Elevators that work with a two-speed system, elevators that work with a variable \nspeed system, hydraulic elevators. Food elevators (for villas and restaurants) (VVVF) service \nelevators in buildings. Cargo elevators. Patient elevators (bed elevator) Elevators without a\nmachine room. Escalators. Mobile walkers outdoor elevators with the construction of \nall types of outdoor towers",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("More about us"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("More about us"),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("More about us"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 100),
                  Container(
                    height: 500,
                    width: 600,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 500,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        autoPlayInterval: Duration(seconds: 5),
                      ),
                      items:
                          [
                            "assets/images/stairs.jpeg",
                            "assets/images/elevator.png",
                            "assets/images/3.png",
                            "assets/images/4.png",
                            "assets/images/5.png",
                          ].map((imgPath) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.asset(
                                  imgPath,
                                  fit: BoxFit.cover,
                                  width: 600,
                                  height: 500,
                                );
                              },
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            //IMPORTANT THING ABOUT US SECTION
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.06,
                vertical: MediaQuery.of(context).size.height * 0.05,
              ),
              height: MediaQuery.of(context).size.height * 0.8,
              color: Color(0xFF89CFF0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Why us?\n",
                          style: TextStyle(
                            fontSize: 15,
                            // color: Color(0xff0B415A),
                            color: Color(0xff0B415A),
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        TextSpan(
                          text: "THE MOST IMPORTANT THING ABOUT US",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<HomeAnimationController>(
                    builder: (controller) {
                      return SlideTransition(
                        position: controller.slideAnimation,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 50),
                            AboutusContainer(
                              image: "assets/images/7.png",
                              title: "FULL ENGINEERING SUPERVISION",
                              description:
                                  "A specialized team of engineers and technicians with the highest degrees of efficiency and specialization performs installation, modernization and maintenance work for all types of elevators and escalators, which gives high accuracy in the implementation of works.",
                            ),
                            AboutusContainer(
                              image: "assets/images/6.png",
                              title: "5-YEAR WARRANTY",
                              description:
                                  "The company gives its customers a 3-year warranty on all types of elevators and escalators it offers against manufacturing defects and installation defects.",
                            ),
                            AboutusContainer(
                              image: "assets/images/8.png",
                              title: "AFTER SALES SERVICE",
                              description:
                                  "The company performs regular monthly maintenance by specialized technicians with the highest degree of skill and speed and under the supervision of engineers with a high degree of specialization and competence in maintenance work.",
                            ),
                            AboutusContainer(
                              image: "assets/images/5.png",
                              title: "WIDE VARIETY OF PRODUCTS",
                              description:
                                  "The wide variety of First Saudi products gives customers a lot of options that add to the beauty of the decorative form of the building and give a state of harmony and integration between them and the rest of the building components.",
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            CustomerReviews(),
            SizedBox(height: 30),
            Footer(),
          ],
        ),
      ),
    );
  }
}
