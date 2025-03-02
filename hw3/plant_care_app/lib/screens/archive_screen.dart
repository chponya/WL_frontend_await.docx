// archive_screen.dart
import 'package:flutter/material.dart';
import 'package:plant_care_app/models/task_model.dart'; // Импортируем Task

class ArchiveScreen extends StatelessWidget {
  final List<Task> completedTasks;

  ArchiveScreen({required this.completedTasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Архив'),
      ),
      body: ListView.builder(
        itemCount: completedTasks.length,
        itemBuilder: (context, index) {
          final task = completedTasks[index];
          return ListTile(
            title: Text(task.name),
            trailing: Icon(Icons.check_circle, color: Colors.green),
          );
        },
      ),
    );
  }
}