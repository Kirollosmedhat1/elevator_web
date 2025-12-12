import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elevatorweb/controllers/tab_navigation_controller.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final TabNavigationController tabNavController =
        Get.find<TabNavigationController>();

    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.04,
      ),
      child: Column(
        children: [
          width < 768
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMobileCompanyInfo(context),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(child: _buildMobileLinks(context)),
                      SizedBox(width: 20),
                      Expanded(child: _buildMobileProducts(context)),
                    ],
                  ),
                  SizedBox(height: 30),
                  _buildMobileBranches(context),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column 1: Company Information
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo and Company Name
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'sfe'.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
                            Text(
                              'saudi_first_elevators_caps'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Company Description
                        Text(
                          'company_desc'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 30),

                        // Social Media Icons
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.play_circle_fill,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.business,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.facebook,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 40),

                  // Column 2: Important Links
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'important_links'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),

                        _buildLink(
                          'home'.tr,
                          true,
                          false,
                          () => tabNavController.navigateToTab(0),
                        ),
                        _buildLink(
                          'about_company'.tr,
                          false,
                          false,
                          () => tabNavController.navigateToTab(1),
                        ),
                        _buildLink(
                          'products_and_solutions'.tr,
                          false,
                          false,
                          () => tabNavController.navigateToTab(2),
                        ),
                        _buildLink(
                          'studio'.tr,
                          false,
                          true,
                          () => tabNavController.navigateToTab(4),
                        ),
                        _buildLink(
                          'contact_us_caps'.tr,
                          false,
                          false,
                          () => tabNavController.navigateToTab(5),
                        ),

                        SizedBox(height: 20),

                        // Language Selector
                        Row(
                          children: [
                            Container(
                              width: 20,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Center(
                                child: Text(
                                  "🇬🇧",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "EN",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 40),

                  // Column 3: Products
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'products_caps'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),

                        Text(
                          'elevators'.tr,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 40),

                  // Column 4: Branch Locations
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'headings'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),

                        _buildBranchLocation('main_branch'.tr),
                        SizedBox(height: 15),

                        _buildBranchLocation('october_branch'.tr),
                        SizedBox(height: 15),

                        _buildBranchLocation('mansoura_branch'.tr),
                      ],
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildLink(
    String text, [
    bool isHighlighted = false,
    bool hasDropdown = false,
    VoidCallback? onTap,
  ]) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(
                color: isHighlighted ? Colors.white : Colors.white,
                fontSize: 14,
              ),
            ),
            if (hasDropdown)
              Icon(Icons.arrow_drop_down, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchLocation(String address) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.location_on, color: Colors.white, size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            address,
            style: TextStyle(color: Colors.white, fontSize: 12, height: 1.3),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileCompanyInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Text(
                  'sfe'.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'saudi_first_elevators_caps'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Text(
          'company_desc'.tr,
          style: TextStyle(color: Colors.white, fontSize: 11, height: 1.4),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.play_circle_fill, color: Colors.white, size: 25),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.business, color: Colors.white, size: 25),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.facebook, color: Colors.white, size: 25),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLinks(BuildContext context) {
    final TabNavigationController tabNavController =
        Get.find<TabNavigationController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'links'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        _buildLink(
          'home'.tr,
          true,
          false,
          () => tabNavController.navigateToTab(0),
        ),
        _buildLink(
          'about_company'.tr,
          false,
          false,
          () => tabNavController.navigateToTab(1),
        ),
        _buildLink(
          'products_caps'.tr,
          false,
          false,
          () => tabNavController.navigateToTab(2),
        ),
        _buildLink(
          'contact_us_caps'.tr,
          false,
          false,
          () => tabNavController.navigateToTab(5),
        ),
      ],
    );
  }

  Widget _buildMobileProducts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'products_caps'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'elevators'.tr,
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Container(
              width: 18,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Center(child: Text("🇬🇧", style: TextStyle(fontSize: 8))),
            ),
            SizedBox(width: 6),
            Text("EN", style: TextStyle(color: Colors.white, fontSize: 12)),
            Icon(Icons.arrow_drop_down, color: Colors.white, size: 14),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileBranches(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'branches'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        _buildBranchLocation('main_branch_short'.tr),
        SizedBox(height: 8),
        _buildBranchLocation('october_branch_short'.tr),
        SizedBox(height: 8),
        _buildBranchLocation('mansoura_branch_short'.tr),
      ],
    );
  }
}
