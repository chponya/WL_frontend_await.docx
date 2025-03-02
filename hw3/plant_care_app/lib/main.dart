import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_care_app/routes/app_pages.dart';
import 'package:plant_care_app/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Plant Care App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      getPages: AppPages.pages,
      home: MainScreen(),
    );
  }
}