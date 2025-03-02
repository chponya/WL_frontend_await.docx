import 'package:get/get.dart';
import 'package:plant_care_app/screens/explore_screen.dart';
import 'package:plant_care_app/screens/home_screen.dart';
import 'package:plant_care_app/screens/my_plants_screen.dart';
import 'package:plant_care_app/screens/calendar_screen.dart';
import 'package:plant_care_app/screens/profile_screen.dart';
import 'package:plant_care_app/screens/plant_detail_screen.dart';
import 'package:plant_care_app/screens/settings_screen.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: '/', page: () => HomeScreen()),
    GetPage(name: '/explore', page: () => ExploreScreen()),
    GetPage(name: '/my-plants', page: () => MyPlantsScreen()),
    GetPage(name: '/calendar', page: () => CalendarScreen()),
    GetPage(name: '/profile', page: () => ProfileScreen()),
    GetPage(
      name: '/plant-detail',
      page: () => PlantDetailScreen(),
    ),
    GetPage(name: '/settings', page: () => SettingsScreen()),
  ];
}