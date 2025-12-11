import 'package:elevatorweb/widgets/products_card.dart';
import 'package:flutter/material.dart';
import 'package:elevatorweb/controllers/animation_controller.dart';
import 'package:elevatorweb/controllers/products_controller.dart';
import 'package:get/get.dart';

class ProductsSec extends StatelessWidget {
  const ProductsSec({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController impController = Get.put(ProductsController());
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:
            MediaQuery.of(context).size.width < 1000
                ? 20
                : MediaQuery.of(context).size.height * 0.06,
        vertical: MediaQuery.of(context).size.height * 0.05,
      ),
      height: MediaQuery.of(context).size.height * 0.8,

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
                    text: 'products'.tr,
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width < 768 ? 24 : 40,
                      color: Colors.black,
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
                child: Obx(() {
                  // Show loading indicator
                  if (impController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // Show error message if products failed to load
                  if (impController.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(impController.errorMessage.value),
                    );
                  }

                  // Show message if no products available
                  if (impController.products.isEmpty) {
                    return Center(child: Text('no_products'.tr));
                  }

                  // Display products
                  return MediaQuery.of(context).size.width < 1000
                      ? _buildMobileSlideshow(context, impController)
                      : _buildDesktopProducts(context, impController);
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMobileSlideshow(
    BuildContext context,
    ProductsController controller,
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
                  icon: Icon(Icons.chevron_left, color: Colors.black, size: 32),
                ),
              ),
              // PageView
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.currentCardIndex.value = index;
                  },
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final card = controller.products[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ProductsCard(
                        context: context,
                        image: card.image,
                        title: card.title,
                        description: card.description,
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
                    color: Colors.black,
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
            children: List.generate(controller.products.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      index == controller.currentCardIndex.value
                          ? Colors.white
                          : Colors.black,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopProducts(
    BuildContext context,
    ProductsController controller,
  ) {
    const int productsPerPage = 4;
    final totalPages = (controller.products.length / productsPerPage).ceil();

    return Column(
      children: [
        // Desktop products container with navigation
        Container(
          height: MediaQuery.of(context).size.height * 0.55,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left arrow
              Container(
                width: 50,
                child: IconButton(
                  onPressed: controller.previousCard,
                  icon: Icon(Icons.chevron_left, color: Colors.black, size: 40),
                ),
              ),
              // Products grid (4 per page)
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.currentCardIndex.value = index;
                  },
                  itemCount: totalPages,
                  itemBuilder: (context, pageIndex) {
                    final startIdx = pageIndex * productsPerPage;
                    final endIdx = (startIdx + productsPerPage).clamp(
                      0,
                      controller.products.length,
                    );
                    final pageProducts = controller.products.sublist(
                      startIdx,
                      endIdx,
                    );

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          pageProducts.asMap().entries.map((entry) {
                            final card = entry.value;
                            final cardIndex = startIdx + entry.key;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: ProductsCard(
                                  context: context,
                                  image: card.image,
                                  title: card.title,
                                  description: card.description,
                                  controller: controller,
                                  cardIndex: cardIndex,
                                ),
                              ),
                            );
                          }).toList(),
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
                    color: Colors.black,
                    size: 40,
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
            children: List.generate(totalPages, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      index == controller.currentCardIndex.value
                          ? Colors.white
                          : Colors.black,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
