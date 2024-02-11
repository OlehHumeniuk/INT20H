import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:schedule_t/UI/IntroScreen/IntroScreen.dart';
import 'package:schedule_t/BusinessLogicLayer/ConectWithServer/ConectWithServer.dart';
void main() {
  // HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(),
      theme: ThemeData(
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme, // This ensures we use Mulish by default
        ),
      ),
    );
  }
}
