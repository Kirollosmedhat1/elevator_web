import 'package:elevatorweb/view/about_combany.dart';
import 'package:elevatorweb/view/articles.dart';
import 'package:elevatorweb/view/careers.dart';
import 'package:elevatorweb/view/contact_us.dart';
import 'package:elevatorweb/view/gallery.dart';
import 'package:elevatorweb/view/home.dart';
import 'package:elevatorweb/view/previus_work.dart';
import 'package:elevatorweb/view/products&solutions.dart';
import 'package:elevatorweb/view/tab_bar.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/tabbar', page: () => Tab_Bar()),
    GetPage(name: '/home', page: () => Home()),
    GetPage(name: '/about', page: () => AboutCombany()),
    GetPage(name: '/contact', page: () => ContactUs()),
    GetPage(name: '/careers', page: () => Careers()),
    GetPage(name: '/gallery', page: () => Gallery()),
    GetPage(name: '/products', page: () => Products_solutions()),
    GetPage(name: '/prevwork', page: () => PreviusWork()),
    GetPage(name: '/articles', page: () => Articles()),
  ];
}
