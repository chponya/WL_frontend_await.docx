import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/plant.dart';
import 'plant_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Plant> plants = mockPlants;

  void _addPlant(String name, String description) {
    final newPlant = Plant(
      id: DateTime.now().toString(),
      name: name,
      description: description,
    );
    setState(() {
      plants.add(newPlant);
    });
  }

  void _deletePlant(String id) {
    setState(() {
      plants.removeWhere((plant) => plant.id == id);
    });
  }

  void _editPlant(String id, String newName, String newDescription) {
    setState(() {
      final plant = plants.firstWhere((plant) => plant.id == id);
      plant.name = newName;
      plant.description = newDescription;
    });
  }

  void _navigateToPlantDetail(Plant plant) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlantDetailScreen(
          plant: plant,
          onDelete: () => _deletePlant(plant.id),
          onEdit: (newName, newDescription) {
            _editPlant(plant.id, newName, newDescription);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список растений'),
      ),
      body: ListView.builder(
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];
          return Dismissible(
            key: Key(plant.id),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              _deletePlant(plant.id);
            },
            child: ListTile(
              title: Text(plant.name),
              onTap: () => _navigateToPlantDetail(plant),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditPlantDialog(plant);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deletePlant(plant.id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddPlantDialog();
        },
      ),
    );
  }

  void _showAddPlantDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Добавить растение'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Название'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Описание'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Добавить'),
              onPressed: () {
                _addPlant(nameController.text, descriptionController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditPlantDialog(Plant plant) {
    final nameController = TextEditingController(text: plant.name);
    final descriptionController = TextEditingController(text: plant.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Редактировать растение'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Название'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Описание'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Отмена'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Сохранить'),
              onPressed: () {
                _editPlant(plant.id, nameController.text, descriptionController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}