import 'package:get/get.dart';

class TabNavigationController extends GetxController {
  RxInt currentTabIndex = 0.obs;

  void navigateToTab(int index) {
    currentTabIndex.value = index;
  }

  void navigateToHome() {
    navigateToTab(0); // About tab is at index 1
  }

  void navigateToAbout() {
    navigateToTab(1); // About tab is at index 1
  }

  void navigateToProducts() {
    navigateToTab(2); // Products tab is at index 2
  }

  void navigateToPreviousWork() {
    navigateToTab(3); // Products tab is at index 2
  }

  void navigateToGallery() {
    navigateToTab(4); // Products tab is at index 2
  }

  void navigateToContact() {
    navigateToTab(5); // Contact tab is at index 5
  }
}
