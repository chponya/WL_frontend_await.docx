import 'package:flutter/material.dart';

class ExploreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Text('Plants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Примерное количество растений
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Plant $index'),
                  onTap: () {
                    // Переход на страницу растения
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