import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../views/explore_view.dart';
import '../views/my_plants_view.dart';
import '../views/home_view.dart';
import '../views/calendar_view.dart';
import '../views/profile_view.dart';
import '../widgets/custom_app_bar.dart';

class HomeView extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  final List<Widget> _pages = [
    ExploreView(),
    MyPlantsView(),
    HomeView(),
    CalendarView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Obx(() => _pages[_controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
            () => BottomNavigationBar(
          currentIndex: _controller.selectedIndex.value,
          onTap: _controller.changePage,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
            BottomNavigationBarItem(icon: Icon(Icons.local_florist), label: 'My Plants'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}