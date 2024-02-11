import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schedule_t/UI/ProgramStyle.dart';
import 'package:schedule_t/UI/IntroScreen/MyStyles.dart';

import 'package:schedule_t/BusinessLogicLayer/UsernamePasswordAithentification/UsernamePasswordAithentification.dart';

class FillProfileInfo extends StatefulWidget {
  @override
  _FillProfileInfoState createState() => _FillProfileInfoState();
}

class _FillProfileInfoState extends State<FillProfileInfo> {
  final TextEditingController nameSurnameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();


  String genderValue = 'Attack Helicopter'; // Default gender value
  DateTime? selectedDate; // This will be null initially

  @override
  void dispose() {
    nameSurnameController.dispose();
    usernameController.dispose();
    phoneNumberController.dispose();
    dateController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }


  // Function to handle date selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate!,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Format the date and assign it to the controller's text
        dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

void _updateProfile() async {
  // Collect the profile data from the controllers and other inputs
  String fullName = nameSurnameController.text;
  String nickname = usernameController.text;
  // String password = passwordController.text; // Make sure to handle passwords securely
  String phoneNumber = phoneNumberController.text;
  String gender = genderValue;
  String birthDateString = dateController.text; // Assuming the date is in 'dd/MM/yyyy' format
  
  // Validate the collected data as needed
  if (fullName.isEmpty || nickname.isEmpty || phoneNumber.isEmpty || birthDateString.isEmpty) {
    // Show an error message if validation fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill in all the fields')),
    );
    return;
  }

  // Assuming the user ID is retrieved and stored somewhere in your app, e.g., user session
  int userId = 1; // Replace with your method to get the current user's ID

  try {
    var response = await updateUserProfile(
      userId: userId,
      fullName: fullName,
      nickname: nickname,
      dob: birthDateString, // Format the date as required by your backend
      phone: phoneNumber,
      gender: gender,
    );

    if (response.statusCode == 200) {
      // If successful, show a success message and maybe navigate to the next screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    } else {
      // If there is an error, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: ${response.body}')),
      );
    }
  } catch (e) {
    // Handle any errors here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e')),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заповніть свій профіль'),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('lib/UI/Icons/FillYourProfile/ExampleProfileIcon.png'),
            ),
            SizedBox(height: 20),
            LineEdit(
              defaultValue: "Ім'я та Фамілія",
              controller: nameSurnameController,
            ),
            SizedBox(height: 10),
            LineEdit(
              defaultValue: "Нікнейм",
              controller: usernameController,
            ),
            SizedBox(height: 10),
            DateLineEdit(
              dateController: dateController,
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 10),
            PhoneLineEdit(
              phoneController: phoneNumberController,
              focusNode: phoneFocusNode, // Pass the FocusNode here
            ),
            SizedBox(height: 10),
            GenderDropdown(
              genderValue: genderValue,
              onChanged: (String newValue) {
                setState(() {
                  genderValue = newValue;
                });
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              text: 'Продовжити',
              onPressedCallback: _updateProfile,
              width: MediaQuery.of(context).size.width * 0.85,
              height: 60.0,
            ),
          ],
        ),
      ),
    );
  }
}

class GenderDropdown extends StatelessWidget {
  final String genderValue;
  final Function(String) onChanged;

  GenderDropdown({required this.genderValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: genderValue,
      onChanged: (String? newValue) {
        onChanged(newValue!);
      },
      items:<String>['Man', 'Woman', 'Attack Helicopter'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
