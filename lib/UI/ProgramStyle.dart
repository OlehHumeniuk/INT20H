import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schedule_t/UI/IntroScreen/MyStyles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback onPressedCallback;

  CustomButton({
    required this.text,
    required this.width,
    required this.height,
    required this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    // Розрахунок розміру круглої кнопки зі стрілкою
    final double circleDiameter = height * 0.8;
    final double circlePadding = height * 0.1;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        gradient: LinearGradient(
          colors: [Color(0xFF007AFF), Color(0xFF007AFF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressedCallback,
          borderRadius: BorderRadius.circular(30.0),
          child: Stack(
            alignment: Alignment.centerRight, // Вирівнювання іконки стрілки вправо
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: circlePadding), // Відступ з правого краю
                child: Container(
                  width: circleDiameter, // Діаметр круга
                  height: circleDiameter, // Діаметр круга
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios, // Іконка стрілки
                    color: Color(0xFF007AFF),
                    size: circleDiameter * 0.6, // Розмір іконки стрілки
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthRButton extends StatelessWidget {
  final String iconPath;
  final String text;

  AuthRButton({
    required this.iconPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidthScale  = screenWidth/428;
    double screenHeightScale = screenHeight/926;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0), // Reduced padding for less space between icon and text
      height: 48.0 * screenHeightScale, // Height of the button
      decoration: BoxDecoration(
        // color: Colors.white, // Light gray background color for the button
        borderRadius: BorderRadius.circular(24.0), // Rounded corners
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Use the minimum space that children need
        children: <Widget>[
          Container(
            width : 48.0 * screenWidthScale, // Width of the circle
            height: 48.0 * screenWidthScale, // Height of the circle
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // White color for the circle
            ),
            child: Center(
              child: Image.asset(
                iconPath,
                width : 24.0 * screenWidthScale, // Size of the icon
                height: 24.0 * screenWidthScale, // Size of the icon
              ),
            ),
          ),
          SizedBox(width: 20*screenHeightScale), // Reduced space between the icon and text
          Text(
            text,
            style: TextStyle(
              color: Colors.black, // Font color
              fontWeight: FontWeight.bold, // Font weight
              fontSize: 16.0, // Font size
            ),
          ),
        ],
      ),
    );
  }
}

class LineEdit extends StatelessWidget {
  final String defaultValue;
  final String? iconPath;
  final TextEditingController controller; // Add a controller here
  final double iconSize;
  final String? lateralIconPath;

  LineEdit({
    required this.defaultValue,
    this.iconPath,
    required this.controller, // Initialize the controller
    this.iconSize = 20.0,
    this.lateralIconPath,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.85, // 85% of screen width
      height: 60.0, // Fixed height for the TextField
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0), // Rounded corners for the container
        color: Colors.white, // Background color for the text field
      ),
      child: TextField(
        controller: controller, // Use the controller here
        decoration: InputDecoration(
          hintText: defaultValue,
          hintStyle: TextStyle(
            color: Colors.grey, // Style for the hint text
            fontWeight: FontWeight.bold,
            fontSize: 16.0, // Match your design
          ),
          alignLabelWithHint: true, // Centers the hint text vertically
          prefixIcon: iconPath != null
           ? Padding(
            padding: EdgeInsets.symmetric(vertical: (60.0 - iconSize!) / 2), // Centers the prefix icon vertically
            child: ImageIcon(
              AssetImage(iconPath!),
              size: iconSize,
              color: Colors.grey,
            ),
          )
          : null,
          suffixIcon: lateralIconPath != null
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: (60.0 - iconSize!) / 2), // Centers the suffix icon vertically
                  child: ImageIcon(
                    AssetImage(lateralIconPath!),
                    size: iconSize,
                    color: Colors.grey,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(20.0, (60.0 - 16.0) / 2, 20.0, (60.0 - 16.0) / 2), // Adjust text field padding
        ),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16.0, // Font size for the text entered by the user
        ),
      ),
    );
  }
}


class MyCustomCheckbox extends StatefulWidget {
  final String title;
  final double scale;
  final ValueChanged<bool?> onChanged;

  MyCustomCheckbox({
    required this.title,
    required this.scale,
    required this.onChanged,
  });

  @override
  _MyCustomCheckboxState createState() => _MyCustomCheckboxState();
}

class _MyCustomCheckboxState extends State<MyCustomCheckbox> {
  bool isTermsAccepted = false;
  
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.grey, // колір коли чекбокс не вибрано
        // Оновлено 'secondary' до 'primary' в colorScheme
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF0961F5), // колір коли чекбокс активний/вибраний
        ),
      ),
      child: CheckboxListTile(
        title: Text(widget.title,
        style: MyStyles.returnDescriptionStyle(widget.scale*0.9)), // текст, який ви хочете відобразити поруч з чекбоксом
        value: isTermsAccepted,
        onChanged: (bool? newValue) {
          setState(() {
            isTermsAccepted = newValue ?? false;
          });
          widget.onChanged(newValue); // Виклик колбеку з RegisterPage
        },
        controlAffinity: ListTileControlAffinity.leading, // розмістити чекбокс перед текстом
        // Колір коли чекбокс активний/вибраний береться з Theme
        activeColor: Theme.of(context).colorScheme.primary, 
        checkColor: Colors.white, // колір галочки в чекбоксі
      ),
    );
  }
}

class PhoneLineEdit extends StatelessWidget {
  final TextEditingController phoneController;
  final FocusNode focusNode;

  PhoneLineEdit({
    required this.phoneController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: phoneController,
        focusNode: focusNode,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          prefixText: '+38',
          hintText: '(XXX) XXX-XX-XX',
          border: InputBorder.none,
        ),
        onFieldSubmitted: (_) {
          focusNode.nextFocus(); // Moves focus to the next focusable element
        },
        // Add additional styling and logic as required
      ),
    );
  }
}



class DateLineEdit extends StatelessWidget {
  final TextEditingController dateController;
  final VoidCallback onTap;

  DateLineEdit({
    required this.dateController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Your styling code here, similar to LineEdit with the addition of GestureDetector to handle taps
        child: Text(dateController.text),
      ),
    );
  }
}
