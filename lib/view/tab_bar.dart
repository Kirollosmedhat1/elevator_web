import 'package:flutter/material.dart';
import 'package:elevatorweb/view/home.dart';
import 'package:elevatorweb/view/about_combany.dart';
import 'package:elevatorweb/view/contact_us.dart';
import 'package:elevatorweb/view/careers.dart';
import 'package:elevatorweb/view/gallery.dart';
import 'package:elevatorweb/view/products&solutions.dart';
import 'package:elevatorweb/view/previus_work.dart';
import 'package:elevatorweb/view/articles.dart';

class Tab_Bar extends StatelessWidget {
  const Tab_Bar({super.key});

  static final List<Tab> myTabs = [
    const Tab(text: 'Home'),
    const Tab(text: 'About'),
    const Tab(text: 'Contact'),
    const Tab(text: 'Careers'),
    const Tab(text: 'Gallery'),
    const Tab(text: 'Products'),
    const Tab(text: 'Previous Work'),
    const Tab(text: 'Articles'),
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: const Color(0xFF1438de),
          backgroundColor: const Color(0xff89CFF0),
          leadingWidth: 120,
          leading: Row(
            children: [
              const SizedBox(width: 30),
              const Icon(Icons.phone, color: Color(0xff0B415A)),
              const SizedBox(width: 10),
              const Text("0223824776", style: TextStyle(color:  Color(0xff0B415A))),
              const SizedBox(width: 30),
              const Icon(Icons.email_rounded, color:  Color(0xff0B415A)),
              const SizedBox(width: 10),
              const Text(
                "info@saudifirstelevators.com",
                style: TextStyle(color:  Color(0xff0B415A)),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Image.asset(
                'assets/images/icon-youtube.png',
                width: 20,
                height: 20,
                color:  Color(0xff0B415A),
              ),
              onPressed: () {},
              tooltip: 'YouTube',
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/icon-linkedin.png',
                width: 20,
                height: 20,
                color:  Color(0xff0B415A),
              ),
              onPressed: () {},
              tooltip: 'LinkedIn',
            ),
            IconButton(
              icon: Image.asset(
                'assets/images/icon-facebook.png',
                width: 20,
                height: 20,
                color:  Color(0xff0B415A),
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
                Container(height: 90, width: 120, decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: AssetImage("assets/images/company_logo.png"))),),

                Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width*1,
                  color: Colors.white,
                  child: TabBar(
                    tabs: myTabs,
                    isScrollable: true,
                    labelColor: Color(0xFF89CFF0),
                    unselectedLabelColor: const Color(0xff0B415A),
                    indicatorColor:
                        Color(0xff0B415A),
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
