import 'package:flutter/material.dart';

class LoadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0961F5), // Фон
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Schedule',
              style: TextStyle(
                fontSize: 66.69, // Розмір тексту
                height: 1.0, // Висота рядка
                letterSpacing: 2.2, // Відстань між літерами
                fontWeight: FontWeight.w400, // Товщина шрифту
                color: Colors.white, // Колір тексту
                fontFamily: 'Aubrey', 
              ),
              textAlign: TextAlign.center, // Вирівнювання тексту по центру
            ),
            SizedBox(height: 24.0), // Додайте відступ
            CircularProgressIndicator( // Індикатор завантаження
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
