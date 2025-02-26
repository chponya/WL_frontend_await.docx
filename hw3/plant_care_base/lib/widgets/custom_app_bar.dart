import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../views/settings_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          Get.to(SettingsView());
        },
      ),
      title: Text('Home'), // Заголовок будет меняться в зависимости от экрана
      actions: [
        if (Get.find<HomeController>().selectedIndex.value != 3 &&
            Get.find<HomeController>().selectedIndex.value != 4)
          IconButton(
            icon: Icon(Icons.scanner),
            onPressed: () {
              // Действие при нажатии на кнопку сканирования
            },
          ),
      ],
    );
  }
}