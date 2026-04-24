import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:elevatorweb/controllers/tab_navigation_controller.dart';
import 'package:url_launcher/url_launcher.dart';

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
                        Text(
                          'saudi_first_elevators_caps'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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

                        // Language Selector Dropdown
                        DropdownButton<Locale>(
                          value: Get.locale ?? const Locale('en'),
                          underline: SizedBox(),
                          dropdownColor: Colors.black87,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: Locale('en'),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('🇬🇧', style: TextStyle(fontSize: 14)),
                                  SizedBox(width: 8),
                                  Text(
                                    'English',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            DropdownMenuItem(
                              value: Locale('ar'),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('🇸🇦', style: TextStyle(fontSize: 14)),
                                  SizedBox(width: 8),
                                  Text(
                                    'العربية',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          onChanged: (Locale? locale) {
                            if (locale != null) {
                              Get.updateLocale(locale);
                            }
                          },
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
                        SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: _openBranchLocation,
                          icon: Icon(
                            Icons.map_outlined,
                            color: Colors.white,
                            size: 18,
                          ),
                          label: Text(
                            'branch_location'.tr,
                            style: TextStyle(color: Colors.white),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white70),
                            padding: EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                          ),
                        ),
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

  Future<void> _openBranchLocation() async {
    final branchLocationUrl = Uri.parse(
      'https://maps.app.goo.gl/sFEDMedYvbwAucCm9?g_st=awb',
    );

    if (await canLaunchUrl(branchLocationUrl)) {
      await launchUrl(branchLocationUrl, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildMobileCompanyInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'saudi_first_elevators_caps'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
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
        DropdownButton<Locale>(
          value: Get.locale ?? const Locale('en'),
          underline: SizedBox(),
          dropdownColor: Colors.black87,
          icon: Icon(Icons.arrow_drop_down, color: Colors.white, size: 14),
          items: const [
            DropdownMenuItem(
              value: Locale('en'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🇬🇧', style: TextStyle(fontSize: 12)),
                  SizedBox(width: 6),
                  Text(
                    'English',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            DropdownMenuItem(
              value: Locale('ar'),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🇸🇦', style: TextStyle(fontSize: 12)),
                  SizedBox(width: 6),
                  Text(
                    'العربية',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
          onChanged: (Locale? locale) {
            if (locale != null) {
              Get.updateLocale(locale);
            }
          },
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
      ],
    );
  }
}
