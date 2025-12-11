import 'package:flutter/material.dart';
import 'package:elevatorweb/view/home.dart';
import 'package:elevatorweb/view/about_combany.dart';
import 'package:elevatorweb/view/contact_us.dart';
import 'package:elevatorweb/view/gallery.dart';
import 'package:elevatorweb/view/products&solutions.dart';
import 'package:elevatorweb/view/previus_work.dart';
import 'package:get/get.dart';
import 'package:elevatorweb/controllers/navigation_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class Tab_Bar extends StatefulWidget {
  const Tab_Bar({super.key});

  @override
  State<Tab_Bar> createState() => _Tab_BarState();
}

class _Tab_BarState extends State<Tab_Bar> {
  final NavigationController navController = Get.put(NavigationController());

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

  void _navigateToPage(int index) {
    navController.currentIndex.value = index;
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
                    onPressed: () {},
                    tooltip: 'YouTube',
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon-linkedin.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                    tooltip: 'LinkedIn',
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon-facebook.png',
                      width: 20,
                      height: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {},
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
                            child: Obx(() => Text(
                              menuItems[navController.currentIndex.value],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0B415A),
                              ),
                            )),
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
                      child: Obx(() => ListView.builder(
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          final selected = index == navController.currentIndex.value;
                          return ListTile(
                            selected: selected,
                            selectedTileColor: Colors.white.withOpacity(0.3),
                            leading: Icon(
                              _getIconForMenuItem(index),
                              color: selected ? Colors.white : Colors.grey,
                            ),
                            title: Text(
                              menuItems[index],
                              style: TextStyle(
                                color: selected ? Colors.white : Colors.black,
                                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            onTap: () => _navigateToPage(index),
                          );
                        },
                      )),
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
              body: Obx(() => tabViews[navController.currentIndex.value]),
            )
            : Obx(() => Scaffold(
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
                        const Text(
                          "01201424777",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 30),
                        const Icon(Icons.email_rounded, color: Colors.white),
                        const SizedBox(width: 10),
                        const Text(
                          "Beams.Elevators@gmail.com",
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 30),
                      ],
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
                      onPressed: () {},
                      tooltip: 'YouTube',
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/images/icon-linkedin.png',
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                      tooltip: 'LinkedIn',
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/images/icon-facebook.png',
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                      onPressed: () {},
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
                              120,
                          color: Colors.white,
                          child: TabBar(
                            onTap: (index) => navController.currentIndex.value = index,
                            tabs: menuItems.map((item) => Tab(text: item)).toList(),
                            labelColor: Colors.grey[400],
                            unselectedLabelColor: Colors.black,
                            indicatorColor: Colors.grey[400],
                            labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            unselectedLabelStyle: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: tabViews[navController.currentIndex.value],
              )),
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
                              'assets/images/whatsapp.png',
                              width: 20,
                              height: 20,
                              // color: Colors.white,
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
                              final url = Uri.parse('tel:201201424777');
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
