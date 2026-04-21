import 'package:flutter/material.dart';
import 'package:elevatorweb/view/home.dart';
import 'package:elevatorweb/view/about_combany.dart';
import 'package:elevatorweb/view/contact_us.dart';
import 'package:elevatorweb/view/gallery.dart';
import 'package:elevatorweb/view/products&solutions.dart';
import 'package:elevatorweb/view/previus_work.dart';
import 'package:elevatorweb/controllers/tab_navigation_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

// Ignore the old navigation_controller import if it exists
// Using only TabNavigationController from now on

class Tab_Bar extends StatefulWidget {
  const Tab_Bar({super.key});

  @override
  State<Tab_Bar> createState() => _Tab_BarState();
}

class _Tab_BarState extends State<Tab_Bar> {
  final TabNavigationController tabNavController = Get.put(
    TabNavigationController(),
  );

  List<String> get menuItems => [
    'home'.tr,
    'about'.tr,
    'products'.tr,
    'previous_work'.tr,
    'gallery'.tr,
    'contact'.tr,
  ];

  static final List<Widget> tabViews = [
    Home(),
    AboutCombany(),
    Products_solutions(),
    PreviusWork(),
    Gallery(),
    ContactUs(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _navigateToPage(int index) {
    tabNavController.navigateToTab(index);
    Navigator.pop(context); // Close drawer after selection
  }

  @override
  Widget build(BuildContext context) {
    final FloatingContactController contactController = Get.put(
      FloatingContactController(),
    );
    final isMobile = MediaQuery.of(context).size.width < 768;
    // Language dropdown widget
    Widget languageDropdown() {
      return DropdownButton<Locale>(
        value: Get.locale ?? const Locale('ar'),
        icon: const Icon(Icons.language, color: Colors.white),
        underline: SizedBox(),
        items: const [
          DropdownMenuItem(value: Locale('en'), child: Text('English')),
          DropdownMenuItem(value: Locale('ar'), child: Text('العربية')),
        ],
        onChanged: (Locale? locale) {
          if (locale != null) {
            Get.updateLocale(locale);
          }
        },
      );
    }

    return Stack(
      children: [
        isMobile
            ? Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.black,
                leading: Builder(
                  builder:
                      (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                ),
                actions: [
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon-youtube.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final url = Uri.parse(
                        'https://youtube.com/@beamselevators1951?si=OlAsD9XdgCptTnBK',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    tooltip: 'YouTube',
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon-linkedin.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final url = Uri.parse(
                        'https://www.linkedin.com/in/beams-elevators-35a286386/',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    tooltip: 'LinkedIn',
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon-facebook.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final url = Uri.parse(
                        'https://www.facebook.com/share/1A93QjvLvx/?mibextid=wwXIfr',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    tooltip: 'Facebook',
                  ),
                  const SizedBox(width: 20),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage("assets/images/beamslogo.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 90,
                          color: Colors.white,
                          child: Center(
                            child: Obx(
                              () => Text(
                                menuItems[tabNavController
                                    .currentTabIndex
                                    .value],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff0B415A),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              drawer: Drawer(
                backgroundColor: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/images/beamslogo.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            final isSelected =
                                index == tabNavController.currentTabIndex.value;
                            return ListTile(
                              selected: isSelected,
                              selectedTileColor: Colors.white.withOpacity(0.3),
                              leading: Icon(
                                _getIconForMenuItem(index),
                                color: isSelected ? Colors.black : Colors.grey,
                              ),
                              title: Text(
                                menuItems[index],
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.black : Colors.grey,
                                  fontWeight:
                                      isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                ),
                              ),
                              onTap: () => _navigateToPage(index),
                            );
                          });
                        },
                      ),
                    ),
                    // Add language dropdown at the bottom of the drawer
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: languageDropdown(),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.white, size: 16),
                              SizedBox(width: 8),
                              Text(
                                "01201424777",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.email_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Beams.Elevators@gmail.com",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              body: Obx(() => tabViews[tabNavController.currentTabIndex.value]),
            )
            : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                leadingWidth: double.infinity,
                leading: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const SizedBox(width: 30),
                      const Icon(Icons.phone, color: Colors.white),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          final url = Uri.parse('tel:201204611333');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: const Text(
                          "01204611333",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(width: 30),
                      const Icon(Icons.email_rounded, color: Colors.white),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () async {
                          final url = Uri.parse(
                            'mailto:Beams.Elevators@gmail.com',
                          );
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                        child: const Text(
                          "Beams.Elevators@gmail.com",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 30),
                      // Removed languageDropdown from here
                    ],
                  ),
                ),
                actions: [
                  // Removed languageDropdown from here
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon-youtube.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final url = Uri.parse(
                        'https://youtube.com/@beamselevators1951?si=OlAsD9XdgCptTnBK',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    tooltip: 'YouTube',
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon-linkedin.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final url = Uri.parse(
                        'https://www.linkedin.com/in/beams-elevators-35a286386/',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    tooltip: 'LinkedIn',
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon-facebook.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final url = Uri.parse(
                        'https://www.facebook.com/share/1A93QjvLvx/?mibextid=wwXIfr',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                    tooltip: 'Facebook',
                  ),
                  const SizedBox(width: 50),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: Row(
                    children: [
                      Container(
                        height: 90,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage("assets/images/beamslogo.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      // Insert language dropdown here
                      Container(
                        color: Colors.white,
                        height: 90,
                        width: 120,
                        child: Center(child: languageDropdown()),
                      ),
                      Container(
                        height: 90,
                        width:
                            MediaQuery.of(context).size.width -
                            120 -
                            120, // adjust for logo and dropdown
                        color: Colors.white,
                        child: Obx(
                          () => Row(
                            children: List.generate(menuItems.length, (index) {
                              final isSelected =
                                  index ==
                                  tabNavController.currentTabIndex.value;
                              return Expanded(
                                child: InkWell(
                                  onTap:
                                      () =>
                                          tabNavController.navigateToTab(index),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        menuItems[index],
                                        style: TextStyle(
                                          color:
                                              isSelected
                                                  ? Colors.grey[400]
                                                  : Colors.black,
                                          fontSize: 14,
                                          fontWeight:
                                              isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                      if (isSelected)
                                        Container(
                                          height: 2,
                                          width: 40,
                                          color: Colors.grey[400],
                                          margin: EdgeInsets.only(top: 8),
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Obx(() => tabViews[tabNavController.currentTabIndex.value]),
            ),
        Obx(
          () =>
              contactController.isVisible.value
                  ? Positioned(
                    left: 0,
                    top: MediaQuery.of(context).size.height * 0.3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 8),
                        ],
                      ),
                      child: Column(
                        children: [
                          IconButton(
                           icon: Image.asset(
                      'assets/images/icon-whatsapp.png',
                      height: 20,
                      width: 20,
                    ),
                            onPressed: () async {
                              final url = Uri.parse(
                                'https://wa.me/201204611333',
                              );
                              if (await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              }
                            },
                            tooltip: 'WhatsApp',
                          ),
                          IconButton(
                            icon: Icon(Icons.phone, color: Colors.blue),
                            onPressed: () async {
                              final url = Uri.parse('tel:201204611333');
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url);
                              }
                            },
                            tooltip: 'Call',
                          ),
                          IconButton(
                            icon: Icon(Icons.chevron_left, color: Colors.black),
                            onPressed:
                                () => contactController.isVisible.value = false,
                            tooltip: 'Hide',
                          ),
                        ],
                      ),
                    ),
                  )
                  : Positioned(
                    left: 0,
                    top: MediaQuery.of(context).size.height * 0.3,
                    child: GestureDetector(
                      onTap: () => contactController.isVisible.value = true,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 8),
                          ],
                        ),
                        child: Icon(Icons.chevron_right, color: Colors.black),
                      ),
                    ),
                  ),
        ),
      ],
    );
  }

  IconData _getIconForMenuItem(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.info;
      case 2:
        return Icons.contact_phone;
      case 3:
        return Icons.work;
      case 4:
        return Icons.photo_library;
      case 5:
        return Icons.inventory;
      default:
        return Icons.help;
    }
  }
}

class FloatingContactController extends GetxController {
  RxBool isVisible = true.obs;
}
