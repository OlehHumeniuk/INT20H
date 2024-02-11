import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyles {
  static TextStyle returnTitleStyle(double pScale) {
    return GoogleFonts.aubrey(
      fontSize: 64 * pScale,
      height: 1.03, // Adjust the line height to match the design
      letterSpacing: 2.2,
      fontWeight: FontWeight.w400,
      color: Color(0xFF0961F5),
    );
  }

  static TextStyle returnTitleStyle_2(double pScale) {
    return GoogleFonts.jost(
      fontSize: 24 * pScale, // Adjust the font size by scale
      height: 1.45, // Adjust the line height to match the design
      fontWeight: FontWeight.w600, // Use FontWeight.w600 for Jost
      color: Color(0xFF202244),
    );
  }

  static TextStyle returnDescriptionStyle(double pScale) {
    return GoogleFonts.mulish(
      fontSize: 14 * pScale, // Adjust the font size by scale
      height: 1.25, // Adjust the line height to match the design
      fontWeight: FontWeight.w700,
      color: Color(0xFF545454),
    );
  }
  static TextStyle returnDescriptionButtonStyle(double pScale) {
    return GoogleFonts.mulish(
      fontSize: 16 * pScale, // Adjust the font size by scale
      height: 1.5, // Adjust the line height to match the design
      fontWeight: FontWeight.w800,
      color: Color(0xFF545454),
    );
  }

  static TextStyle returnSkipButtonStyle(double pScale) {
    return GoogleFonts.jost(
      fontSize: 16 * pScale, // Adjust the font size by scale
      height: 1, // Adjust the line height to match the design
      fontWeight: FontWeight.w400, // Use FontWeight.w600 for Jost
      color: Color(0xFF202244),
    );
  }
}