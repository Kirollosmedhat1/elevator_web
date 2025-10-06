// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:elevatorweb/widgets/footer.dart';
import 'package:elevatorweb/widgets/page_name&photo.dart';
import 'package:elevatorweb/controllers/products_controller.dart';
import 'package:elevatorweb/view/product_details.dart';
import 'package:get/get.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});
  

  @override
  Widget build(BuildContext context) {
      final ProductsController productsController = Get.put(ProductsController());
     return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageNamePhoto(pagename: 'products_and_solutions'.tr),

            // Products Grid Section
            Container(
              padding: EdgeInsets.all(20),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width < 1000 ? 2 : 5,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                ),
                itemCount: productsController.products.length,
                itemBuilder: (context, index) {
                  final product = productsController.products[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ProductDetails(product: product));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Container(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                // child: Image.asset(
                                //   product.image,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff0B415A),
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    product.description,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width <
                                                  1000
                                              ? 10
                                              : 12,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines:
                                        MediaQuery.of(context).size.width < 1000
                                            ? 4
                                            : 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Footer(),
          ],
        ),
      ),
    );
  }
}
