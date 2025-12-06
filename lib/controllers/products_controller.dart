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

  List<ProductModel> get products => productsList.isEmpty ? _getFallbackProducts() : productsList;

  /// Get fallback products for when Supabase is not available
  List<ProductModel> _getFallbackProducts() => [
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
    fetchProducts();
  }

  /// Fetch products from Supabase with language filter
  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Get current language (default to 'en')
      final String currentLang = Get.locale?.languageCode ?? 'en';

      // Fetch products for the current language
      final response = await SupabaseService.client
          .from('products')
          .select()
          .eq('lang', currentLang)
          .order('id', ascending: true);

      if (response.isNotEmpty) {
        productsList.value = (response as List)
            .map((item) => ProductModel.fromMap(item as Map<String, dynamic>))
            .toList();
      } else {
        // Fallback to English if current language has no data
        final fallbackResponse = await SupabaseService.client
            .from('products')
            .select()
            .eq('lang', 'en')
            .order('id', ascending: true);

        productsList.value = (fallbackResponse as List)
            .map((item) => ProductModel.fromMap(item as Map<String, dynamic>))
            .toList();
      }

      // Initialize hover states for each product
      cardHoverStates = List.generate(productsList.length, (index) => false.obs);
    } catch (e) {
      print('Error fetching products: $e');
      errorMessage.value = 'Failed to load products';
      // Use fallback products on error
      productsList.value = _getFallbackProducts();
      cardHoverStates = List.generate(productsList.length, (index) => false.obs);
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
