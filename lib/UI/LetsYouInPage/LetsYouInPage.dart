import 'package:flutter/material.dart';

import 'package:schedule_t/UI/ProgramStyle.dart';
import 'package:schedule_t/UI/IntroScreen/MyStyles.dart';

import 'package:schedule_t/UI/RegisterPage/RegisterPage.dart';
import 'package:schedule_t/UI/LoginPage/LoginPage.dart';


class LetsYouInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = screenWidth * 350 / 428;
    double buttonHeight = screenHeight * 60 / 926;

    double scale = screenWidth / 428; // Adjusted base width

    return Scaffold(
      backgroundColor: Color(0xFFF5F9FF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenHeight / 2.4), // Start the display halfway down the screen
            Text(
              "Давайте увійдемо",
              textAlign: TextAlign.center,
              style: MyStyles.returnTitleStyle_2(scale),
            ),
            SizedBox(height: 20), // Add spacing
            AuthRButton(
              iconPath: 'lib/UI/Icons/Auth/GoogleIcon.png', // Replace with actual path
              text: 'Continue with Google',
            ),
            
            SizedBox(height: 20), // Add spacing
            AuthRButton(
              iconPath: 'lib/UI/Icons/Auth/AppleIcon.png', // Replace with actual path
              text: 'Continue with Apple',
            ),
            SizedBox(height: 60), // Add spacing
            Text(
              "( або )",
              textAlign: TextAlign.center,
              style: MyStyles.returnDescriptionStyle(scale),
            ),
            SizedBox(height: 40), // Add spacing
            CustomButton(
              text: 'Увійти за допомогою свого \n облікового запису',
              width: buttonWidth,
              height: buttonHeight,
              onPressedCallback: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
            SizedBox(height: 20), // Add spacing
            Row(
              mainAxisSize: MainAxisSize.min, // Align to the center of the row
              children: <Widget>[
                Text(
                  "Немає акаунту -",
                  style: MyStyles.returnDescriptionStyle(scale)
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()), // Replace with your registration page
                    );
                  },
                  child: Text(
                    " Реєстрація",
                    textAlign: TextAlign.center,
                    style: MyStyles.returnDescriptionStyle(scale).copyWith(
                      color: Colors.blue, // Make the text blue to resemble a hyperlink
                      decoration: TextDecoration.underline, // Underline it
                    ),
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
