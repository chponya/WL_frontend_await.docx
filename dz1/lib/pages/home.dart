import 'package:flutter/material.dart';

class HackathonInfoScreen extends StatefulWidget {
  @override
  _HackathonInfoScreenState createState() => _HackathonInfoScreenState();
}

class _HackathonInfoScreenState extends State<HackathonInfoScreen> {
  int likeCount = 0;
  bool isParticipating = false;
  bool isBeforeIntensive = true; // Переменная для отслеживания режима

  void _toggleParticipation() {
    setState(() {
      isParticipating = !isParticipating;
    });
  }

  void _incrementLike() {
    setState(() {
      likeCount++;
    });
  }

  void _toggleIntensiveMode() {
    setState(() {
      isBeforeIntensive = !isBeforeIntensive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Информация о хакатоне'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'ВЫСШАЯ ЛИГА: на максимальных скоростях',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Дата: ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: '3 февраля - 3 марта 2025',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Описание: ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '• 4 НЕДЕЛИ ИНТЕНСИВНОГО ДРАЙВА.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '• 8 пар полного погружения в мир элитных хакатонов.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '• Никаких компромиссов.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '• Только действие.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _toggleParticipation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isParticipating ? Colors.blue[900] : Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 50),
                ),
                child: Text(isParticipating ? 'Отменить участие' : 'Участвовать'),
              ),
            ),
            SizedBox(height: 20),
            // Кастомный слайдер
            Center(
              child: GestureDetector(
                onTap: _toggleIntensiveMode,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 200,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isBeforeIntensive ? Colors.blue[200] : Colors.green[200],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        left: isBeforeIntensive ? 0 : 100,
                        right: isBeforeIntensive ? 100 : 0,
                        child: Container(
                          width: 100,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'До',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isBeforeIntensive ? Colors.blue[900] : Colors.grey,
                                ),
                              ),
                              Text(
                                'После',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isBeforeIntensive ? Colors.grey : Colors.green[900],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Добавьте этот код после кнопки "До/После"
            SizedBox(height: 20),
            Center(
              child: isBeforeIntensive
                  ? Image.asset(
                'assets/before_intensive.png', // Путь к картинке для режима "До"
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              )
                  : Image.asset(
                'assets/after_intensive.png', // Путь к картинке для режима "После"
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                Text(
                  'Лайков: $likeCount',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _incrementLike,
                  child: Text('Лайкнуть'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}