import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class IntroSec extends StatelessWidget {
  const IntroSec({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      // Mobile view: Column layout (text, buttons, slideshow)
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text section
            Text(
              "Saudi First Elevators",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Saudi First Elevators Company is honored in the field of supplying, installing, maintaining and modernizing elevators and escalators of all types of electric elevators, including: Elevators that work with a two-speed system, elevators that work with a variable speed system, hydraulic elevators. Food elevators (for villas and restaurants) (VVVF) service elevators in buildings. Cargo elevators. Patient elevators (bed elevator) Elevators without a machine room. Escalators. Mobile walkers outdoor elevators with the construction of all types of outdoor towers",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w100,
                height: 1.5,
              ),
            ),
            SizedBox(height: 30),

            // Buttons section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "More about us",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Our Services",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Contact Us",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),

            // Slideshow section
            Container(
              height: 250,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 250,
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
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              imgPath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          );
                        },
                      );
                    }).toList(),
              ),
            ),
          ],
        ),
      );
    } else {
      // Desktop view: Row layout (text + slideshow)
      return Container(
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
                        child: const Text("Our Services"),
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
                        child: const Text("Contact Us"),
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
      );
    }
  }
}
