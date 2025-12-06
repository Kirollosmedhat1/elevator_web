import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elevatorweb/models/product_model.dart';
import 'package:elevatorweb/services/supabase_service.dart';

class ProductsController extends GetxController {
  RxInt currentCardIndex = 0.obs;
  late PageController pageController;
  Timer? autoSlideTimer;

  // Track hover state for each card individually
  List<RxBool> cardHoverStates = [];

  // Reactive products list from Supabase
  RxList<ProductModel> productsList = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  List<ProductModel> get products => productsList;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    fetchProducts();
  }

  /// Fetch products from Supabase with language filter
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Get current language (default to 'en')
      final String currentLang = Get.locale?.languageCode ?? 'en';

      // Fetch products for the current language from Supabase
      final response = await SupabaseService.client
          .from('products')
          .select()
          .eq('lang', currentLang)
          .order('id', ascending: true);

      // Map the response to ProductModel list
      productsList.value =
          (response as List)
              .map((item) => ProductModel.fromMap(item as Map<String, dynamic>))
              .toList();

      // Initialize hover states for each product
      cardHoverStates = List.generate(
        productsList.length,
        (index) => false.obs,
      );

      if (productsList.isEmpty) {
        errorMessage.value = 'No products found for language: $currentLang';
      }
    } catch (e) {
      print('Error fetching products: $e');
      errorMessage.value = 'Error: ${e.toString()}';
      productsList.value = [];
      cardHoverStates = [];
    } finally {
      isLoading.value = false;
    }
  }

  /// Refresh products when language changes
  void onLanguageChange() {
    fetchProducts();
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
