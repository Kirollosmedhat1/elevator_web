import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elevatorweb/utils/section_keys.dart';
import 'package:flutter/animation.dart';

class WelcomeSec extends StatelessWidget {
  const WelcomeSec({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.width < 768 ? 500 : 600,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/elevator.png", fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width < 768 ? 20 : 70,
              vertical: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'saudi_first_elevators'.tr,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 768 ? 28 : 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  MediaQuery.of(context).size.width < 768
                      ? 'welcome_subtitle'.tr
                      : 'welcome_subtitle'.tr,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width < 768 ? 14 : 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 2),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal:
                          MediaQuery.of(context).size.width < 768 ? 20 : 30,
                      vertical: 15,
                    ),
                  ),
                  onPressed: () {
                    final ctx = introSectionKey.currentContext;
                    if (ctx != null) {
                      Scrollable.ensureVisible(
                        ctx,
                        duration: Duration(milliseconds: 600),
                        curve: Curves.easeInOut,
                        alignment: 0.0,
                      );
                    }
                  },
                  child: Text(
                    'more_about_us'.tr,
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width < 768 ? 14 : 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
