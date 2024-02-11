import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:schedule_t/UI/FillProfileInfo/FillProfileInfo.dart';

const String baseUrl = 'http://127.0.0.1:5000'; // Replace with your server IP

Future<void> registerUser( context, String email, String password) async {
  final Uri url = Uri.parse('http://127.0.0.1:5000/register');
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
      'email': email,
      'password': password,
      }),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      // Перевіряємо, чи отримані дані містять ключ 'data'.
      final Map<String, dynamic> parsedData = json.decode(response.body);
              // If successful, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User registered successfully')),
      );
      // Then navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FillProfileInfo()),
      );
    } else {
        // If there is an error, show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register user: ${response.body}')),
        );
  }
  } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
      print('An error occurred: $e');
    }
}

Future<http.Response> loginUser(String login, String password) {
  return http.post(
    Uri.parse('$baseUrl/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'login': login, // 'login' can be either username or email
      'password': password,
    }),
  );
}

Future<http.Response> updateUserProfile({
  required int userId,
  String? fullName,
  String? nickname,
  String? dob, // date of birth
  String? phone,
  String? gender,
}) {
  Map<String, dynamic> data = {};
  if (fullName != null) data['full_name'] = fullName;
  if (nickname != null) data['nickname'] = nickname;
  if (dob != null) data['date_of_birth'] = dob;
  if (phone != null) data['phone'] = phone;
  if (gender != null) data['gender'] = gender;

  return http.put(
    Uri.parse('$baseUrl/update_profile/$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
}
