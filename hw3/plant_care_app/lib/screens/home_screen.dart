// home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'archive_screen.dart'; // Импортируем ArchiveScreen
import 'package:plant_care_app/models/task_model.dart'; // Импортируем Task

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = []; // Список всех задач
  List<Task> completedTasks = []; // Список выполненных задач
  int currentPage = 0;
  final int itemsPerPage = 10;

  void _addTask(String taskName) {
    setState(() {
      tasks.add(Task(taskName, false));
    });
  }

  void _editTask(int index, String newTaskName) {
    setState(() {
      tasks[index].name = newTaskName;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _completeTask(int index) {
    setState(() {
      Task task = tasks[index];
      task.isCompleted = true; // Помечаем задачу как выполненную
      completedTasks.add(task); // Добавляем задачу в список выполненных
      tasks.removeAt(index); // Удаляем задачу с главной страницы
    });
  }

  void _showAddTaskDialog() {
    TextEditingController taskController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: Text('Добавить задание'),
        content: TextField(
          controller: taskController,
          decoration: InputDecoration(hintText: 'Введите название задания'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                _addTask(taskController.text);
                Get.back();
              }
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }

  void _showEditTaskDialog(int index) {
    TextEditingController taskController = TextEditingController(text: tasks[index].name);
    Get.dialog(
      AlertDialog(
        title: Text('Редактировать задание'),
        content: TextField(
          controller: taskController,
          decoration: InputDecoration(hintText: 'Введите новое название задания'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (taskController.text.isNotEmpty) {
                _editTask(index, taskController.text);
                Get.back();
              }
            },
            child: Text('Сохранить'),
          ),
          TextButton(
            onPressed: () {
              _deleteTask(index);
              Get.back();
            },
            child: Text('Удалить', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  List<Task> getPaginatedTasks() {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    if (endIndex > tasks.length) {
      endIndex = tasks.length;
    }
    return tasks.sublist(startIndex, endIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сегодня'),
        actions: [
          IconButton(
            icon: Icon(Icons.archive),
            onPressed: () {
              Get.to(() => ArchiveScreen(completedTasks: completedTasks));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: getPaginatedTasks().length,
              itemBuilder: (context, index) {
                final taskIndex = currentPage * itemsPerPage + index;
                final task = tasks[taskIndex];
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(task.name),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditTaskDialog(taskIndex);
                        },
                      ),
                      Checkbox(
                        value: task.isCompleted,
                        onChanged: (value) {
                          _completeTask(taskIndex); // Помечаем задачу как выполненную
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: currentPage > 0
                    ? () {
                  setState(() {
                    currentPage--;
                  });
                }
                    : null,
              ),
              Text('Страница ${currentPage + 1}'),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: (currentPage + 1) * itemsPerPage < tasks.length
                    ? () {
                  setState(() {
                    currentPage++;
                  });
                }
                    : null,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}