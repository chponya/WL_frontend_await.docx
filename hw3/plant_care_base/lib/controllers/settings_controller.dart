import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Состояние для push-уведомлений (включено/выключено)
  var isNotificationsEnabled = true.obs;

  // Метод для переключения состояния уведомлений
  void toggleNotifications(bool value) {
    isNotificationsEnabled.value = value;
  }
}