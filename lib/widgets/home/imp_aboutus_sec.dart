import 'dart:async';
import 'package:flutter/material.dart';
import 'package:elevatorweb/controllers/animation_controller.dart';
import 'package:get/get.dart';

class ImpAboutusSecController extends GetxController {
  RxInt currentCardIndex = 0.obs;
  late PageController pageController;
  Timer? autoSlideTimer;

  // Track hover state for each card individually
  List<RxBool> cardHoverStates = [];

  final List<Map<String, String>> aboutCards = [
    {
      "image": "assets/images/7.png",
      "title": "FULL ENGINEERING SUPERVISION",
      "description":
          "A specialized team of engineers and technicians with the highest degrees of efficiency and specialization performs installation, modernization and maintenance work for all types of elevators and escalators, which gives high accuracy in the implementation of works.",
    },
    {
      "image": "assets/images/6.png",
      "title": "5-YEAR WARRANTY",
      "description":
          "The company gives its customers a 3-year warranty on all types of elevators and escalators it offers against manufacturing defects and installation defects.",
    },
    {
      "image": "assets/images/8.png",
      "title": "AFTER SALES SERVICE",
      "description":
          "The company performs regular monthly maintenance by specialized technicians with the highest degree of skill and speed and under the supervision of engineers with a high degree of specialization and competence in maintenance work.",
    },
    {
      "image": "assets/images/5.png",
      "title": "WIDE VARIETY OF PRODUCTS",
      "description":
          "The wide variety of First Saudi products gives customers a lot of options that add to the beauty of the decorative form of the building and give a state of harmony and integration between them and the rest of the building components.",
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
      height: MediaQuery.of(context).size.height * 0.8,
      color: Color(0xFF89CFF0),
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
                    text: "Why us?\n",
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width < 768 ? 12 : 15,
                      color: Color(0xff0B415A),
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  TextSpan(
                    text: "THE MOST IMPORTANT THING ABOUT US",
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
                            _buildAboutCard(
                              context,
                              impController.aboutCards[0]["image"]!,
                              impController.aboutCards[0]["title"]!,
                              impController.aboutCards[0]["description"]!,
                              impController,
                              0,
                            ),
                            _buildAboutCard(
                              context,
                              impController.aboutCards[1]["image"]!,
                              impController.aboutCards[1]["title"]!,
                              impController.aboutCards[1]["description"]!,
                              impController,
                              1,
                            ),
                            _buildAboutCard(
                              context,
                              impController.aboutCards[2]["image"]!,
                              impController.aboutCards[2]["title"]!,
                              impController.aboutCards[2]["description"]!,
                              impController,
                              2,
                            ),
                            _buildAboutCard(
                              context,
                              impController.aboutCards[3]["image"]!,
                              impController.aboutCards[3]["title"]!,
                              impController.aboutCards[3]["description"]!,
                              impController,
                              3,
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
          height: MediaQuery.of(context).size.height * 0.6,
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
                      child: _buildAboutCard(
                        context,
                        card["image"]!,
                        card["title"]!,
                        card["description"]!,
                        controller,
                        index,
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
                          : Color(0xff0B415A),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutCard(
    BuildContext context,
    String image,
    String title,
    String description,
    ImpAboutusSecController controller,
    int cardIndex,
  ) {
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
            onEnter: (_) => controller._onImageHover(true, cardIndex),
            onExit: (_) => controller._onImageHover(false, cardIndex),
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
                  Obx(
                    () => AnimatedScale(
                      duration: Duration(milliseconds: 600),
                      scale:
                          controller.cardHoverStates[cardIndex].value
                              ? 1.2
                              : 1.0,
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.height * 1,
                      ),
                    ),
                  ),
                  Obx(
                    () => AnimatedOpacity(
                      duration: Duration(milliseconds: 600),
                      opacity:
                          controller.cardHoverStates[cardIndex].value
                              ? 0.3
                              : 0.0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.height * 1,
                        color: Colors.black,
                      ),
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
                  TextSpan(text: "$title\n\n"),
                  TextSpan(
                    text: description,
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
