import 'package:flutter/material.dart';
import 'package:elevatorweb/view/home.dart';
import 'package:elevatorweb/view/about_combany.dart';
import 'package:elevatorweb/view/contact_us.dart';
import 'package:elevatorweb/view/careers.dart';
import 'package:elevatorweb/view/gallery.dart';
import 'package:elevatorweb/view/products&solutions.dart';
import 'package:elevatorweb/view/previus_work.dart';
import 'package:elevatorweb/view/articles.dart';

class Tab_Bar extends StatefulWidget {
  const Tab_Bar({super.key});

  @override
  State<Tab_Bar> createState() => _Tab_BarState();
}

class _Tab_BarState extends State<Tab_Bar> {
  int _currentIndex = 0;

  static final List<String> menuItems = [
    'Home',
    'About',
    'Contact',
    'Careers',
    'Gallery',
    'Products',
    'Previous Work',
    'Articles',
  ];

  static final List<Widget> tabViews = [
    Home(),
    AboutCombany(),
    ContactUs(),
    Careers(),
    Gallery(),
    Products_solutions(),
    PreviusWork(),
    Articles(),
  ];

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });
    Navigator.pop(context); // Close drawer after selection
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    if (isMobile) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff89CFF0),
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Color(0xff0B415A)),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
          actions: [
            IconButton(
              icon: Image.asset(
                'assets/images/icon-youtube.png',
                width: 20,
                height: 20,
                color: Color(0xff0B415A),
              ),
              onPressed: () {},
              tooltip: 'YouTube',
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/icon-linkedin.png',
                width: 20,
                height: 20,
                color: Color(0xff0B415A),
              ),
              onPressed: () {},
              tooltip: 'LinkedIn',
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/icon-facebook.png',
                width: 20,
                height: 20,
                color: Color(0xff0B415A),
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
                      image: AssetImage("assets/images/company_logo.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 90,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        menuItems[_currentIndex],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0B415A),
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
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff89CFF0),
                  image: DecorationImage(
                    image: AssetImage("assets/images/company_logo.png"),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      selected: index == _currentIndex,
                      selectedTileColor: Color(0xff89CFF0).withOpacity(0.3),
                      leading: Icon(
                        _getIconForMenuItem(index),
                        color:
                            index == _currentIndex
                                ? Color(0xff0B415A)
                                : Colors.grey,
                      ),
                      title: Text(
                        menuItems[index],
                        style: TextStyle(
                          color:
                              index == _currentIndex
                                  ? Color(0xff0B415A)
                                  : Colors.black,
                          fontWeight:
                              index == _currentIndex
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                      onTap: () => _navigateToPage(index),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.phone, color: Color(0xff0B415A), size: 16),
                        SizedBox(width: 8),
                        Text(
                          "0223824776",
                          style: TextStyle(
                            color: Color(0xff0B415A),
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
                          color: Color(0xff0B415A),
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "info@saudifirstelevators.com",
                          style: TextStyle(
                            color: Color(0xff0B415A),
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
        body: tabViews[_currentIndex],
      );
    } else {
      // Desktop view with tabs
      return DefaultTabController(
        length: menuItems.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff89CFF0),
            leadingWidth: 120,
            leading: Row(
              children: [
                const SizedBox(width: 30),
                const Icon(Icons.phone, color: Color(0xff0B415A)),
                const SizedBox(width: 10),
                const Text(
                  "0223824776",
                  style: TextStyle(color: Color(0xff0B415A)),
                ),
                const SizedBox(width: 30),
                const Icon(Icons.email_rounded, color: Color(0xff0B415A)),
                const SizedBox(width: 10),
                const Text(
                  "info@saudifirstelevators.com",
                  style: TextStyle(color: Color(0xff0B415A)),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Image.asset(
                  'assets/images/icon-youtube.png',
                  width: 20,
                  height: 20,
                  color: Color(0xff0B415A),
                ),
                onPressed: () {},
                tooltip: 'YouTube',
              ),
              IconButton(
                icon: Image.asset(
                  'assets/images/icon-linkedin.png',
                  width: 20,
                  height: 20,
                  color: Color(0xff0B415A),
                ),
                onPressed: () {},
                tooltip: 'LinkedIn',
              ),
              IconButton(
                icon: Image.asset(
                  'assets/images/icon-facebook.png',
                  width: 20,
                  height: 20,
                  color: Color(0xff0B415A),
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
                        image: AssetImage("assets/images/company_logo.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width - 120,
                    color: Colors.white,
                    child: TabBar(
                      tabs: menuItems.map((item) => Tab(text: item)).toList(),
                      labelColor: Color(0xFF89CFF0),
                      unselectedLabelColor: const Color(0xff0B415A),
                      indicatorColor: Color(0xff0B415A),
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
          body: TabBarView(children: tabViews),
        ),
      );
    }
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
      case 6:
        return Icons.history;
      case 7:
        return Icons.article;
      default:
        return Icons.help;
    }
  }
}
