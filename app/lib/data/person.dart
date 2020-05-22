import 'package:flutter/material.dart';

class Person {
  String firstname;
  String lastname;
  String get fullname => "$firstname $lastname";

  //Replace this with an Image.network Widget in production
  get avatar => (photo != null) ? AssetImage("assets/fake-faces/$photo.jpg") : AssetImage("assets/images/default-photo.png");

  SocialRole socialrole;

  String phonenumber;
  String photo;

  Person({
    @required this.firstname,
    this.lastname,
    this.photo,
  });

  Person.fromJson(Map<String, dynamic> data) 
    : firstname = data["firstname"],
      lastname = data["lastname"],
      photo = data["photo"];
  
  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "photo": photo,
  };
}

enum SocialRole {
  student,
  parent,
  employee,
}
