import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _email = ""; 
  String _password = "";

  String get email => _email;
  String get password => _password;

  void set email(String input_email) {
    _email = input_email;
    notifyListeners();
  }

  void set password(String input_password) {
    _password = input_password;
    notifyListeners();
  }
}