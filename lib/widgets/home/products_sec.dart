import 'package:flutter/material.dart';
import 'package:elevatorweb/controllers/animation_controller.dart';
import 'package:elevatorweb/controllers/products_controller.dart';
import 'package:elevatorweb/widgets/about_us_card.dart';
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
                    text: 'why_us'.tr + "\n",
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width < 768 ? 12 : 15,
                      color: Color(0xff0B415A),
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
                            Expanded(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children:
                                        impController.products
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                              final index = entry.key;
                                              final card = entry.value;
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0,
                                                ),
                                                child: AboutUsCard(
                                                  context: context,
                                                  image: card.image,
                                                  title: card.title,
                                                  description: card.description,
                                                  controller: impController,
                                                  cardIndex: index,
                                                ),
                                              );
                                            })
                                            .toList(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 50),
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
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final card = controller.products[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: AboutUsCard(
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
                          : Color(0xff0B415A),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
