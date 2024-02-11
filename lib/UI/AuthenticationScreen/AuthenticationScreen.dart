import 'package:flutter/material.dart';

import 'package:schedule_t/BusinessLogicLayer/UsernamePasswordAithentification/UsernamePasswordAithentification.dart';


class LoginRegisterForm extends StatefulWidget {
  @override
  _LoginRegisterFormState createState() => _LoginRegisterFormState();
}

class _LoginRegisterFormState extends State<LoginRegisterForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  ElevatedButton _registerButton()
  {
    return 
      ElevatedButton(
        onPressed: () async {
          try {
            var response = await registerUser(context,
              _usernameController.text,
              _passwordController.text,
            );
          } catch (e) {
            print('Error: $e');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('An error occurred: $e')),
            );
          }
        },
        child: Text('Register'),
      );
  }

  ElevatedButton _loginButton()
  {
    return 
      ElevatedButton(
        onPressed: () async {
          var response = await loginUser(
            _usernameController.text,
            _passwordController.text,
          );
          if (response.statusCode == 200) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login successful')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to log in')),
            );
          }
        },
        child: Text('Login'),
      );
  }
  TextField _retturnTextField(TextEditingController  pController, String pLabelString, [bool pObscureText = false])
  {
    return 
      TextField(
        controller: pController,
        decoration: InputDecoration(labelText: pLabelString),
        obscureText: pObscureText,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login/Register Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _retturnTextField(_usernameController, 'Username'),
            _retturnTextField(_passwordController, 'Password', true),
            SizedBox(height: 20),
            _registerButton(),
            SizedBox(height: 20),
           _loginButton(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
