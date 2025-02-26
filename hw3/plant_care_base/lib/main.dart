import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/home_controller.dart';
import 'views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Plant Care',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeView(),
    );
  }
}