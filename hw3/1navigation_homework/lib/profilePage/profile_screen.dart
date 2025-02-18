import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Получаем аргументы, переданные при переходе на этот экран
    final String username = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Center(
        child: Text('Username: $username'),
      ),
    );
  }
}