import 'package:flutter/material.dart';
import 'package:elevatorweb/widgets/footer.dart';
import 'package:elevatorweb/widgets/page_name&photo.dart';
import 'package:elevatorweb/controllers/products_controller.dart';
import 'package:elevatorweb/view/product_details.dart';
import 'package:get/get.dart';

class Products_solutions extends StatelessWidget {
  const Products_solutions({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductsController productsController = Get.put(ProductsController());
    // Ensure products are refreshed when locale changes.
    final String currentLang = Localizations.localeOf(context).languageCode;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productsController.ensureProductsForLang(currentLang);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageNamePhoto(pagename: 'products_and_solutions'.tr),

            // Products Grid Section
            Obx(
              () =>
                  productsController.isLoading.value
                      ? Container(
                        height: 400,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff1438de),
                          ),
                        ),
                      )
                      : productsController.errorMessage.value.isNotEmpty &&
                          productsController.products.isEmpty
                      ? Container(
                        height: 400,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 48,
                                color: Colors.red,
                              ),
                              SizedBox(height: 16),
                              Text(
                                productsController.errorMessage.value,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  productsController.fetchProducts();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff1438de),
                                ),
                                child: Text(
                                  'Retry',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : Container(
                        padding: EdgeInsets.all(20),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    MediaQuery.of(context).size.width < 1000
                                        ? 2
                                        : 5,
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
                                          child:
                                              product.image.isNotEmpty
                                                  ? Image.network(
                                                    product.image,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Container(
                                                        color: Colors.grey[300],
                                                        child: Center(
                                                          child: Icon(
                                                            Icons
                                                                .image_not_supported,
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    loadingBuilder: (
                                                      context,
                                                      child,
                                                      loadingProgress,
                                                    ) {
                                                      if (loadingProgress ==
                                                          null)
                                                        return child;
                                                      return Center(
                                                        child: CircularProgressIndicator(
                                                          value:
                                                              loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                        ),
                                                      );
                                                    },
                                                  )
                                                  : Container(
                                                    color: Colors.grey[300],
                                                    child: Icon(
                                                      Icons.image,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.title,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
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
                                                    MediaQuery.of(
                                                              context,
                                                            ).size.width <
                                                            1000
                                                        ? 10
                                                        : 12,
                                                color: Colors.grey[600],
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines:
                                                  MediaQuery.of(
                                                            context,
                                                          ).size.width <
                                                          1000
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
            ),

            Footer(),
          ],
        ),
      ),
    );
  }
}
