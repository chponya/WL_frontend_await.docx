import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homePage/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BottomNavigationBar with GetX',
      home: HomeScreen(),
    );
  }
}