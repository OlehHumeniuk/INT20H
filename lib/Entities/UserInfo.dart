


  import 'package:flutter/material.dart';

  class UserInfo
  {
    final int id;
    final String fullName;
    final String nikName;
    final String dateOfBirth;
    final String email;
    final String profileImageURL;
    final String gender;
    final String phoneNumber;

    UserInfo({
      required this.id, 
      required this.fullName,
      required this.nikName,
      required this.dateOfBirth,
      required this.email,
      required this.phoneNumber,
      required this.gender,
      required this.profileImageURL,
    });
    String getIconPath()
    {
      return profileImageURL;
    }
  }
  class StartEndtime
  {
    // final Time startTime;
    // final Time endTime;

    // StartEndtime({
    //   required this.startTime, 
    //   required this.endTime,
    // });
  }
  
  class TypeClass
  {
    final int id;
    final String classTypeName;

    TypeClass({
      required this.id, 
      required this.classTypeName,
    });
  }

  class Class
  {
    final int id;
    final String className;
    final String description;
    final String teacherName;
    final int typeClassId;

    Class({
      required this.id, 
      required this.className,
      required this.description, 
      required this.teacherName,
      required this.typeClassId,  
    });
  }
  class Day{
    // final Date date;
    final Map<int ,Class> classesList;

    Day({
      // required this.date, 
      required this.classesList, 
    });
  }