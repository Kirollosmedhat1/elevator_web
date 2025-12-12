import 'dart:async';
import 'package:flutter/material.dart';
import 'package:elevatorweb/controllers/animation_controller.dart';
import 'package:elevatorweb/widgets/about_us_card.dart';
import 'package:get/get.dart';

class ImpAboutusSecController extends GetxController {
  RxInt currentCardIndex = 0.obs;
  late PageController pageController;
  Timer? autoSlideTimer;

  // Track hover state for each card individually
  List<RxBool> cardHoverStates = [];

  List<Map<String, String>> get aboutCards => [
    {
      "image": "assets/images/7.png",
      "title": "full_engineering_supervision".tr,
      "description": "full_engineering_supervision_desc".tr,
    },
    {
      "image": "assets/images/6.png",
      "title": "five_year_warranty".tr,
      "description": "five_year_warranty_desc".tr,
    },
    {
      "image": "assets/images/8.png",
      "title": "after_sales_service".tr,
      "description": "after_sales_service_desc".tr,
    },
    {
      "image": "assets/images/5.png",
      "title": "wide_variety_of_products".tr,
      "description": "wide_variety_of_products_desc".tr,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    // Initialize hover states for each card
    cardHoverStates = List.generate(aboutCards.length, (index) => false.obs);
    startAutoSlide();
  }

  void startAutoSlide() {
    autoSlideTimer?.cancel();
    autoSlideTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      currentCardIndex.value = (currentCardIndex.value + 1) % aboutCards.length;
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentCardIndex.value,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void stopAutoSlide() {
    autoSlideTimer?.cancel();
  }

  void restartAutoSlide() {
    stopAutoSlide();
    startAutoSlide();
  }

  void previousCard() {
    restartAutoSlide();
    currentCardIndex.value =
        (currentCardIndex.value - 1 + aboutCards.length) % aboutCards.length;
    if (pageController.hasClients) {
      pageController.animateToPage(
        currentCardIndex.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void nextCard() {
    restartAutoSlide();
    currentCardIndex.value = (currentCardIndex.value + 1) % aboutCards.length;
    if (pageController.hasClients) {
      pageController.animateToPage(
        currentCardIndex.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onImageHover(bool isHovered, int cardIndex) {
    cardHoverStates[cardIndex].value = isHovered;
  }

  @override
  void onClose() {
    autoSlideTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}

class ImpAboutusSec extends StatelessWidget {
  const ImpAboutusSec({super.key});

  @override
  Widget build(BuildContext context) {
    final ImpAboutusSecController impController = Get.put(
      ImpAboutusSecController(),
    );
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:
            MediaQuery.of(context).size.width < 1000
                ? 20
                : MediaQuery.of(context).size.height * 0.06,
        vertical: MediaQuery.of(context).size.height * 0.05,
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width < 768 ? 10 : 0,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'why_us'.tr + "\n",
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width < 768 ? 12 : 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  TextSpan(
                    text: 'the_most_important_thing_about_us'.tr,
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width < 768 ? 24 : 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<HomeAnimationController>(
            builder: (controller) {
              return SlideTransition(
                position: controller.slideAnimation,
                child:
                    MediaQuery.of(context).size.width < 1000
                        ? _buildMobileSlideshow(context, impController)
                        : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 50),
                            AboutUsCard(
                              context: context,
                              image: impController.aboutCards[0]["image"]!,
                              title: impController.aboutCards[0]["title"]!,
                              description:
                                  impController.aboutCards[0]["description"]!,
                              controller: impController,
                              cardIndex: 0,
                            ),
                            AboutUsCard(
                              context: context,
                              image: impController.aboutCards[1]["image"]!,
                              title: impController.aboutCards[1]["title"]!,
                              description:
                                  impController.aboutCards[1]["description"]!,
                              controller: impController,
                              cardIndex: 1,
                            ),
                            AboutUsCard(
                              context: context,
                              image: impController.aboutCards[2]["image"]!,
                              title: impController.aboutCards[2]["title"]!,
                              description:
                                  impController.aboutCards[2]["description"]!,
                              controller: impController,
                              cardIndex: 2,
                            ),
                            AboutUsCard(
                              context: context,
                              image: impController.aboutCards[3]["image"]!,
                              title: impController.aboutCards[3]["title"]!,
                              description:
                                  impController.aboutCards[3]["description"]!,
                              controller: impController,
                              cardIndex: 3,
                            ),
                          ],
                        ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMobileSlideshow(
    BuildContext context,
    ImpAboutusSecController controller,
  ) {
    return Column(
      children: [
        // Mobile slideshow container
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          child: Row(
            children: [
              // Left arrow
              Container(
                width: 50,
                child: IconButton(
                  onPressed: controller.previousCard,
                  icon: Icon(Icons.chevron_left, color: Colors.white, size: 32),
                ),
              ),
              // PageView
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.currentCardIndex.value = index;
                  },
                  itemCount: controller.aboutCards.length,
                  itemBuilder: (context, index) {
                    final card = controller.aboutCards[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: AboutUsCard(
                        context: context,
                        image: card["image"]!,
                        title: card["title"]!,
                        description: card["description"]!,
                        controller: controller,
                        cardIndex: index,
                      ),
                    );
                  },
                ),
              ),
              // Right arrow
              Container(
                width: 50,
                child: IconButton(
                  onPressed: controller.nextCard,
                  icon: Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        // Pagination dots
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(controller.aboutCards.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      index == controller.currentCardIndex.value
                          ? Colors.white
                          : Colors.white54,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
