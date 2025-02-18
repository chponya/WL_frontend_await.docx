import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homePage/home_screen.dart';
import 'profilePage/profile_screen.dart';
import 'settingsPage/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Navigation',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/profile', page: () => ProfileScreen()),
        GetPage(name: '/settings', page: () => SettingsScreen()),
      ],
    );
  }
}