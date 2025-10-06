import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elevatorweb/models/product_model.dart';

class ProductsController extends GetxController {
  RxInt currentCardIndex = 0.obs;
  late PageController pageController;
  Timer? autoSlideTimer;

  // Track hover state for each card individually
  List<RxBool> cardHoverStates = [];

  List<ProductModel> get products => [
    ProductModel(
      image: "assets/images/5.png",
      title: "escalator".tr,
      description: "escalator_desc".tr,
    ),
    ProductModel(
      image: "assets/images/3.png",
      title: "home_elevators".tr,
      description: "home_elevators_desc".tr,
    ),
    ProductModel(
      image: "assets/images/8.png",
      title: "external_elevator".tr,
      description: "external_elevator_desc".tr,
    ),
    ProductModel(
      image: "assets/images/5.png",
      title: "freight_elevators".tr,
      description: "freight_elevators_desc".tr,
    ),
    ProductModel(
      image: "assets/images/5.png",
      title: "hydraulic_elevators".tr,
      description: "hydraulic_elevators_desc".tr,
    ),
    ProductModel(
      image: "assets/images/5.png",
      title: "panoramic_elevators".tr,
      description: "panoramic_elevators_desc".tr,
    ),
     ProductModel(
      image: "assets/images/5.png",
      title: 'patient_elevators'.tr,
      description: "patient_elevators_desc".tr,
    ),
    ProductModel(
      image: "assets/images/5.png",
      title: "moving_walkways".tr,
      description: "moving_walkways_desc".tr,
    ),
    ProductModel(
      image: "assets/images/5.png",
      title: "dumbwaiters".tr,
      description: "dumbwaiters_desc".tr,
    ),
    ProductModel(
      image: "assets/images/5.png",
      title: "passenger_elevators".tr,
      description: "passenger_elevators_desc".tr,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    // Initialize hover states for each card
    cardHoverStates = List.generate(products.length, (index) => false.obs);
    startAutoSlide();
  }

  void startAutoSlide() {
    autoSlideTimer?.cancel();
    autoSlideTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      currentCardIndex.value = (currentCardIndex.value + 1) % products.length;
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
        (currentCardIndex.value - 1 + products.length) % products.length;
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
    currentCardIndex.value = (currentCardIndex.value + 1) % products.length;
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
