import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_care_app/screens/plant_detail_screen.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Text('Plants', style: TextStyle(fontSize: 24)),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Plant $index'),
                  onTap: () {
                    Get.toNamed('/plant-detail');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}