import 'package:flutter/material.dart';
import '../models/plant.dart';

class PlantDetailScreen extends StatefulWidget {
  final Plant plant;
  final VoidCallback onDelete;
  final Function(String, String) onEdit;

  PlantDetailScreen({
    required this.plant,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.plant.name);
    _descriptionController = TextEditingController(text: widget.plant.description);
  }

  void _editPlant() {
    widget.onEdit(_nameController.text, _descriptionController.text);
    setState(() {
      widget.plant.name = _nameController.text;
      widget.plant.description = _descriptionController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showEditDialog();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.onDelete();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.plant.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.plant.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Редактировать растение'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Название'),
              ),
              TextField(
                controller: _descriptionController,
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
                _editPlant(); // Сохраняем изменения
                Navigator.of(context).pop(); // Закрываем диалог
              },
            ),
          ],
        );
      },
    );
  }
}