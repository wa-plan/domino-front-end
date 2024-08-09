import 'package:flutter/material.dart';

class NavBarProvider with ChangeNotifier {
  int _selectedIndex = 2;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
