import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  final SettingsController _settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          // Переключатель для push-уведомлений
          Obx(
                () => SwitchListTile(
              title: Text('Push Notifications'),
              value: _settingsController.isNotificationsEnabled.value,
              onChanged: _settingsController.toggleNotifications,
            ),
          ),
          // Пункт для изменения языка
          ListTile(
            title: Text('Change Language'),
            onTap: () {
              // Действие при нажатии на изменение языка
            },
          ),
          // Пункт для управления аккаунтом
          ListTile(
            title: Text('Account'),
            onTap: () {
              // Действие при нажатии на аккаунт
            },
          ),
        ],
      ),
    );
  }
}