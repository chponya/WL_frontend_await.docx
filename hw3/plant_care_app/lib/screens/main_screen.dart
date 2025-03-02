import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_care_app/routes/app_pages.dart';
import 'package:plant_care_app/screens/profile_screen.dart';

import 'calendar_screen.dart';
import 'explore_screen.dart';
import 'home_screen.dart';
import 'my_plants_screen.dart';
import 'settings_screen.dart'; // Импортируем экран настроек

class MainScreen extends StatelessWidget {
  final RxInt _selectedIndex = 0.obs;

  final List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    MyPlantsScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(_getAppBarTitle(_selectedIndex.value))),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Открываем Drawer
              },
            );
          },
        ),
        actions: [
          if (_selectedIndex.value != 3 && _selectedIndex.value != 4)
            IconButton(
              icon: Icon(Icons.scanner),
              onPressed: () {
                // Действие при нажатии на кнопку Scan
              },
            ),
        ],
      ),
      drawer: _buildDrawer(context), // Добавляем Drawer
      body: Obx(() => _screens[_selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: _selectedIndex.value,
        onTap: (index) => _selectedIndex.value = index,
        selectedItemColor: Colors.green, // Цвет выбранного элемента
        unselectedItemColor: Colors.grey, // Цвет невыбранных элементов
        backgroundColor: Colors.white, // Цвет фона
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: 'My Plants'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      )),
    );
  }

  // Метод для создания Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: SettingsScreen(), // Встраиваем SettingsScreen в Drawer
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Explore';
      case 2:
        return 'My Plants';
      case 3:
        return 'Calendar';
      case 4:
        return 'Profile';
      default:
        return 'Plant Care App';
    }
  }
}