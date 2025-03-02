import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Импортируем image_picker
import 'dart:io'; // Для работы с файлами

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false; // Режим редактирования
  String _userName = 'User Name'; // Имя пользователя
  String _userDescription = 'Это текст описания пользователя. Он может быть длинным и содержать много информации о пользователе. '
      'Выравнивание по ширине делает текст более читаемым и аккуратным.'; // Описание
  File? _profileImage; // Выбранное изображение

  // Контроллеры для текстовых полей
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = _userName;
    _descriptionController.text = _userDescription;
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
        _userName = _nameController.text;
        _userDescription = _descriptionController.text;
      }
    });
  }

  // Метод для выбора фото
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // Сохраняем выбранное изображение
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Центрирование картинки и имени
              Center(
                child: Column(
                  children: [
                    // Круглый аватар с возможностью выбора фото
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
                          : null, // В режиме просмотра фото нельзя изменить
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: _isEditing
                              ? Border.all(
                            color: Colors.grey, // Серый цвет рамки
                            width: 2.0, // Толщина рамки
                          )
                              : null, // В режиме просмотра рамки нет
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!) // Используем выбранное фото
                              : AssetImage('assets/images/profile.jpg') as ImageProvider, // Дефолтное фото
                        ),
                      ),
                    ),
                    SizedBox(height: 16), // Отступ между картинкой и именем
                    _isEditing
                        ? TextField(
                      controller: _nameController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey, // Серый цвет текста
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none, // Убираем границу
                        hintText: 'Введите имя', // Подсказка
                        hintStyle: TextStyle(color: Colors.grey), // Серый цвет подсказки
                      ),
                    )
                        : Text(
                      _userName,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Чёрный цвет текста
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24), // Отступ между именем и описанием

              // Заголовок "Описание" жирным шрифтом и выравнивание по левому краю
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Описание',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8), // Отступ между заголовком и текстом описания

              // Текст описания с выравниванием по ширине
              _isEditing
                  ? TextField(
                controller: _descriptionController,
                maxLines: 5, // Многострочное поле
                textAlign: TextAlign.justify,
                decoration: InputDecoration(
                  border: OutlineInputBorder(), // Граница для текстового поля
                ),
              )
                  : Text(
                _userDescription,
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
        child: Icon(_isEditing ? Icons.check : Icons.edit), // Иконка меняется в зависимости от режима
        backgroundColor: Colors.green, // Цвет кнопки
      ),
    );
  }
}