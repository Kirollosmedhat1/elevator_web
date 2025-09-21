import 'package:elevatorweb/routs/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
void main() {
  runApp(ElevatorApp());
} 

class ElevatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Saudi First Elevators',
       initialRoute: '/tabbar',
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}