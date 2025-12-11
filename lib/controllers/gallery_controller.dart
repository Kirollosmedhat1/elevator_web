import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elevatorweb/services/supabase_service.dart';

class GalleryController extends GetxController {
  RxInt currentCardIndex = 0.obs;
  late PageController pageController;
  Timer? autoSlideTimer;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  RxList<Map<String, dynamic>> galleryItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    loadGalleryItems();
  }

  Future<void> loadGalleryItems() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final items = await SupabaseService().getGalleryItems();
      galleryItems.value = items;
      isLoading.value = false;

      // Start auto-slide if we have items
      if (items.isNotEmpty) {
        startAutoSlide();
      }
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;
    }
  }

  void startAutoSlide() {
    if (galleryItems.isEmpty) return;
    autoSlideTimer?.cancel();
    autoSlideTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      currentCardIndex.value =
          (currentCardIndex.value + 1) % galleryItems.length;
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
    if (galleryItems.isEmpty) return;
    restartAutoSlide();
    currentCardIndex.value =
        (currentCardIndex.value - 1 + galleryItems.length) %
        galleryItems.length;
    if (pageController.hasClients) {
      pageController.animateToPage(
        currentCardIndex.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void nextCard() {
    if (galleryItems.isEmpty) return;
    restartAutoSlide();
    currentCardIndex.value = (currentCardIndex.value + 1) % galleryItems.length;
    if (pageController.hasClients) {
      pageController.animateToPage(
        currentCardIndex.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void onClose() {
    autoSlideTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
