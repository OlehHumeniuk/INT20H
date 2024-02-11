import 'package:flutter/material.dart';

import 'package:schedule_t/Entities/UserInfo.dart';


class ClassInfoProvider with ChangeNotifier {
  List<StartEndtime> _startEndtimeList = [];
  Map<int, Map<int, bool>> _selectedToppings = {};
}

class UserProfileProvider with ChangeNotifier {
  UserInfo? _userInfo;

  // Constructor and getters not shown for brevity.

  Future<void> updateUserProfile() async {
    // Implement the logic to call server API and update the profile
  }

  // More methods to manage user data...
}

class ClassTimeList with ChangeNotifier {

  final List<StartEndtime> classTimeList= [];

  List<StartEndtime> get classTimets => classTimeList;

}
