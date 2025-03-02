import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant_care_app/screens/plant_detail_screen.dart';

class MyPlantsScreen extends StatefulWidget {
  @override
  _MyPlantsScreenState createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  final List<Map<String, dynamic>> _plants = []; // Список всех растений
  final List<Map<String, dynamic>> _filteredPlants = []; // Список отфильтрованных растений
  final TextEditingController _searchController = TextEditingController(); // Контроллер для поиска

  @override
  void initState() {
    super.initState();
    _filteredPlants.addAll(_plants); // Изначально отображаем все растения
    _searchController.addListener(_filterPlants); // Слушаем изменения в поисковой строке
  }

  @override
  void dispose() {
    _searchController.dispose(); // Освобождаем ресурсы
    super.dispose();
  }

  // Метод для фильтрации растений
  void _filterPlants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPlants.clear();
      if (query.isEmpty) {
        _filteredPlants.addAll(_plants); // Если строка пустая, показываем все растения
      } else {
        _filteredPlants.addAll(
          _plants.where((plant) =>
              plant['name'].toLowerCase().contains(query)), // Фильтруем по названию
        );
      }
    });
  }

  // Метод для очистки текста в поисковой строке
  void _clearSearch() {
    _searchController.clear(); // Очищаем текст
  }

  void _addPlant(String name, String? description, String? imagePath) {
    setState(() {
      _plants.insert(0, {
        'name': name,
        'description': description ?? 'Пустое описание', // Если описание не введено, используем "Пустое описание"
        'image': imagePath ?? 'assets/images/default_plant.png',
      });
      _filterPlants(); // Обновляем отфильтрованный список
    });
  }

  void _editPlant(int index, String name, String? description, String? imagePath) {
    setState(() {
      _plants[index]['name'] = name;
      _plants[index]['description'] = description ?? 'Пустое описание'; // Если описание не введено, используем "Пустое описание"
      if (imagePath != null) {
        _plants[index]['image'] = imagePath;
      }
      _filterPlants(); // Обновляем отфильтрованный список
    });
  }

  void _deletePlant(int index) {
    setState(() {
      _plants.removeAt(index);
      _filterPlants(); // Обновляем отфильтрованный список
    });
  }

  void _showAddPlantDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    String? imagePath;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Plant'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Plant Name'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: 'Plant Description (optional)'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  // Логика для выбора изображения
                  setState(() {
                    imagePath = 'assets/images/default_plant.png';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Фото добавлено')),
                  );
                },
                child: Text('Add Photo'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  _addPlant(
                    nameController.text,
                    descriptionController.text.isNotEmpty ? descriptionController.text : null,
                    imagePath,
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: _clearSearch, // Очищаем текст при нажатии
                )
                    : null, // Крестик отображается только если есть текст
              ),
            ),
          ),
          Expanded(
            child: _filteredPlants.isEmpty
                ? Center(
              child: Text(
                _plants.isEmpty
                    ? 'No plants added yet.\nTap the "+" button to add a new plant.'
                    : 'No plants found.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: _filteredPlants.length,
              itemBuilder: (context, index) {
                final plant = _filteredPlants[index];
                return ListTile(
                  leading: Image.asset(
                    plant['image'],
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                  title: Text(plant['name']),
                  onTap: () {
                    Get.toNamed(
                      '/plant-detail',
                      arguments: {
                        'plant': plant,
                        'onEdit': (String name, String? description, String? imagePath) {
                          _editPlant(index, name, description, imagePath);
                        },
                        'onDelete': () {
                          _deletePlant(index);
                        },
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPlantDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}