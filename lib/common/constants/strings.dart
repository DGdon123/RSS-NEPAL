import 'package:flutter/animation.dart';

String baseUrl = "localhost:8000/api/v1/";
String orgMessage = " is required";
Color primaryColor = Color(0xff1F60BA);
bool checkEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
