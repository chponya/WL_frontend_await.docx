import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  final RxBool _notificationsEnabled = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Push-уведомления'),
            trailing: Obx(() => Switch(
              value: _notificationsEnabled.value,
              onChanged: (value) {
                _notificationsEnabled.value = value;
              },
            )),
          ),
          ListTile(
            title: Text('Изменить язык'),
            onTap: () {
              // Действие при нажатии на изменение языка
            },
          ),
          ListTile(
            title: Text('Аккаунт'),
            onTap: () {
              // Действие при нажатии на аккаунт
            },
          ),
        ],
      ),
    );
  }
}