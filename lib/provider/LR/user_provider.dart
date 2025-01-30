import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _email = "";
  String _password = "";

  String get email => _email;
  String get password => _password;

  set email(String inputEmail) {
    _email = inputEmail;
    notifyListeners();
  }

  set password(String inputPassword) {
    _password = inputPassword;
    notifyListeners();
  }
}
