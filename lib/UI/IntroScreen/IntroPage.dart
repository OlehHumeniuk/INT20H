import 'package:flutter/material.dart';
import 'package:schedule_t/UI/IntroScreen/MyStyles.dart';

class IntroPage extends StatelessWidget {
  final String title;
  final String description;
  final double? titleTopOffset; // Optional parameter for custom top offset for the title
  final bool? fontForTitle; // Optional parameter for custom font

  const IntroPage({
    Key? key,
    required this.title,
    required this.description,
    this.titleTopOffset, // Accept the top offset as a parameter
    this.fontForTitle, // Accept the font as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate scale factor for font size based on screen width
    double scale = screenWidth / 428; // Adjusted base width

    // Calculate top padding to position title at roughly 15% of screen height
    double topPadding = screenHeight * 0.15;

    return Container(
      padding: EdgeInsets.fromLTRB(40, topPadding, 40, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (titleTopOffset != null)
            SizedBox(height: titleTopOffset! / 926 * screenHeight), // Apply custom offset if provided
          Text(
            title,
            textAlign: TextAlign.center,
            style: fontForTitle == true
              ? MyStyles.returnTitleStyle(scale)
              : MyStyles.returnTitleStyle_2(scale),
          ),
          SizedBox(height: screenHeight * 0.03), // Space between title and description
          Text(
            description,
            textAlign: TextAlign.center,
            style: MyStyles.returnDescriptionStyle(scale),
          ),
        ],
      ),
    );
  }
}