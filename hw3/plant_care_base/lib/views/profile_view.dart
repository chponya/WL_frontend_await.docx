import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Обработка выбранного изображения
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile.png'), // Заглушка для изображения профиля
          ),
          Text('User Name'),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Edit Photo'),
          ),
          Text('Description'),
          ElevatedButton(
            onPressed: () {
              // Действие при нажатии на кнопку "Saved"
            },
            child: Text('Saved'),
          ),
        ],
      ),
    );
  }
}