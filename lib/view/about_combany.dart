// ignore_for_file: sized_box_for_whitespace

import 'package:elevatorweb/widgets/home/intro_sec.dart';
import 'package:elevatorweb/widgets/page_name&photo.dart';
import 'package:flutter/material.dart';
import 'package:elevatorweb/widgets/footer.dart';
import 'package:get/get.dart';

class AboutCombany extends StatelessWidget {
  const AboutCombany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageNamePhoto(pagename: 'about_company'.tr),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            IntroSec(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Container(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width < 768
                    ? MediaQuery.of(context).size.height * 0.02
                    : MediaQuery.of(context).size.height * 0.05,
              ),
              child:
                  MediaQuery.of(context).size.width < 768
                      ? Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Our_vision".tr + "\n",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Our_vision_desc".tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Image.asset(
                              "assets/images/elevator.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.height * 0.8,
                            child: Image.asset(
                              "assets/images/elevator.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: RichText(
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Our_vision".tr + "\n",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Our_vision_desc".tr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
            ),
            Container(
              padding: EdgeInsets.all(
                MediaQuery.of(context).size.width < 768
                    ? MediaQuery.of(context).size.height * 0.02
                    : MediaQuery.of(context).size.height * 0.05,
              ),
              child:
                  MediaQuery.of(context).size.width < 768
                      ? Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Our_message".tr + "\n",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Our_message_desc".tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w100,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Image.asset(
                              "assets/images/elevator.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: RichText(
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Our_message".tr + "\n",
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Our_message_desc".tr,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.height * 0.8,
                            child: Image.asset(
                              "assets/images/elevator.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
            ),
            Footer(),
          ],
        ),
      ),
    );
  }
}
