import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schedule_t/UI/ProgramStyle.dart';
import 'package:schedule_t/UI/FillProfileInfo/FillProfileInfo.dart';

import 'package:schedule_t/BusinessLogicLayer/UsernamePasswordAithentification/UsernamePasswordAithentification.dart';

import 'package:schedule_t/UI/IntroScreen/MyStyles.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isTermsAccepted = false;
  bool isEmailValid = true;
  bool isPasswordValid = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _register(BuildContext contex) async {
    bool emailValidLocal = RegExp(r"^[a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@gmail\.com$")
        .hasMatch(emailController.text);
    bool passwordValidLocal = passwordController.text.isNotEmpty;

    setState(() {
      isEmailValid = emailValidLocal;
      isPasswordValid = passwordValidLocal;
    });

    if (isTermsAccepted && emailValidLocal && passwordValidLocal) {
      // Use your existing user registration logic here
      try {

        var response = await registerUser(contex,'qwerty@gmail.com','qwerty123');
                    
      } catch (e) {
        print('Error: $e');
      }

    } else {
      // If the terms are not accepted or the input is not valid, show error messages
      // Error messages will be shown because of the state change
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scale = MediaQuery.of(context).size.width / 428;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Давайте почнемо!",
              textAlign: TextAlign.center,
              style: MyStyles.returnTitleStyle_2(scale),
            ),
            SizedBox(height: 10*scale), // Reduced space between the icon and text
            Text(
              "Створіть обліковий запис, щоб продовжити всі курси",
              textAlign: TextAlign.center,
              style: MyStyles.returnDescriptionStyle(scale*0.9),
            ),
            SizedBox(height: 50*scale), // Reduced space between the icon and text
            LineEdit(
              defaultValue: "Пошта",
              iconPath: "lib/UI/Icons/LineEditIcons/MailIcon.png",
              controller: emailController, // Pass the email controller here
            ),
            SizedBox(height: 20*scale), // Reduced space between the icon and text
            LineEdit(
              defaultValue: "Пароль",
              iconPath: "lib/UI/Icons/LineEditIcons/LockIcon.png",
              lateralIconPath: "lib/UI/Icons/LineEditIcons/IncognitoIcon.png",
              controller: passwordController, // Pass the password controller here
            ),
            SizedBox(height: 20*scale), // Reduced space between the icon and text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: MyCustomCheckbox(
                    title: 'Погодьтесь з положеннями та умовами',
                    scale: scale,
                    onChanged: (bool? newValue) {
                      setState(() {
                        isTermsAccepted = newValue ?? false;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (!isTermsAccepted) Text('Ви не погодились з умовами'),
            if (!isEmailValid) Text('Email не валідний'),
            if (!isPasswordValid) Text('Пароль не може бути пустим'),
            SizedBox(height: 20*scale), // Reduced space between the icon and text
            CustomButton(
              text: 'Реєстрація',
              width: 250,
              height: 50,
              onPressedCallback: () => _register(context),
            ),
          ],
        ),
      ),
    );
  }
}
