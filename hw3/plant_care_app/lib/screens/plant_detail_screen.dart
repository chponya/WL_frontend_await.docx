import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PlantDetailScreen extends StatefulWidget {
  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> {
  late Map<String, dynamic> plant;
  late Function(String, String, String?) onEdit;
  late Function() onDelete;

  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _plantImage;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments;
    plant = arguments['plant'];
    onEdit = arguments['onEdit'];
    onDelete = arguments['onDelete'];

    _nameController.text = plant['name'];
    _descriptionController.text = plant['description'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Сохраняем изменения при выходе из режима редактирования
        onEdit(
          _nameController.text,
          _descriptionController.text,
          _plantImage?.path ?? plant['image'],
        );
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _plantImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              onDelete();
              Get.back();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Центрирование картинки и названия
              Center(
                child: Column(
                  children: [
                    // Круглый контейнер для изображения растения
                    GestureDetector(
                      onTap: _isEditing
                          ? () {
                        // Показываем диалог выбора фото
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Выберите фото"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text("Снять фото"),
                                    onTap: () {
                                      _pickImage(ImageSource.camera);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo_library),
                                    title: Text("Выбрать из галереи"),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                          : null,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: _isEditing
                              ? Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          )
                              : null,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _plantImage != null
                              ? FileImage(_plantImage!)
                              : AssetImage(plant['image']) as ImageProvider,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    _isEditing
                        ? TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Введите название',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    )
                        : Text(
                      plant['name'],
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Заголовок "Описание"
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Описание',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              // Текст описания
              _isEditing
                  ? TextField(
                controller: _descriptionController,
                maxLines: 5,
                textAlign: TextAlign.justify,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              )
                  : Text(
                plant['description'],
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
      // Плавающая кнопка редактирования
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleEditing,
        child: Icon(_isEditing ? Icons.check : Icons.edit),
        backgroundColor: Colors.green,
      ),
    );
  }
}