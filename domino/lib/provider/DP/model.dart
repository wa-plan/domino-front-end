import 'package:flutter/material.dart';

class SelectFinalGoalModel with ChangeNotifier {
  String _selectedFinalGoal = "선택 안됨!.";
  String get selectedFinalGoal => _selectedFinalGoal;

  void selectFinalGoal(String value) {
    _selectedFinalGoal = value;
    notifyListeners();
  }
}

class SaveInputtedDetailGoalModel with ChangeNotifier {
  final Map  _inputtedDetailGoal = {
    '0':'',
    '1':'',
    '2':'',
    '3':'',
    '4':'',
    '5':'',
    '6':'',
    '7':'',
    '8':''
  };
  Map get inputtedDetailGoal => _inputtedDetailGoal;

  void updateDetailGoal(String key, String value) {
    _inputtedDetailGoal[key] = value;
    notifyListeners();
  }
}

class SaveInputtedActionPlanModel with ChangeNotifier {
  final List<Map> _inputtedActionPlan = [
    {
    '0':'',
    '1':'',
    '2':'',
    '3':'',
    '4':'',
    '5':'',
    '6':'',
    '7':'',
    '8':''
  },
  {
    '0':'',
    '1':'',
    '2':'',
    '3':'',
    '4':'',
    '5':'',
    '6':'',
    '7':'',
    '8':''
  },
  {
    '0':'',
    '1':'',
    '2':'',
    '3':'',
    '4':'',
    '5':'',
    '6':'',
    '7':'',
    '8':''
  },
  {
    '0':'',
    '1':'',
    '2':'',
    '3':'',
    '4':'',
    '5':'',
    '6':'',
    '7':'',
    '8':''
  },

  {
    '0':'',
    '1':'',
    '2':'',
    '3':'',
    '4':'',
    '5':'',
    '6':'',
    '7':'',
    '8':''
  },
  
  {
    '0':'',
    '1':'',
    '2':'',
    '3':'',
    '4':'',
    '5':'',
    '6':'',
    '7':'',
    '8':''
  },
  {
    '0':'',
    '1':'',
    '2':'',
    '3':'',
    '4':'',
    '5':'',
    '6':'',
    '7':'',
    '8':''
  },
  {
    '0':'',
    '1':'',
    '2':'',
    '3':'',
    '4':'',
    '5':'',
    '6':'',
    '7':'',
    '8':''
  },
  {
    '0':'',
    '1':'',
    '2':'',
    '3':'',
    '4':'',
    '5':'',
    '6':'',
    '7':'',
    '8':''
  },
  
 
  ];

  List<Map> get inputtedActionPlan => _inputtedActionPlan;

  void updateActionPlan(int goalId, String key, String value) {
    _inputtedActionPlan[goalId][key] = value;
    notifyListeners();
  }
}

class SelectDetailGoal with ChangeNotifier {
  String _selectedDetailGoal = "";
  String get selectedDetailGoal => _selectedDetailGoal;

  void selectDetailGoal(String value) {
    _selectedDetailGoal = value;
    notifyListeners();
  }
}


class GoalColor with ChangeNotifier {
  final Map  _selectedGoalColor = {
    '0':const Color(0xff929292),
    '1':const Color(0xff929292),
    '2':const Color(0xff929292),
    '3':const Color(0xff929292),
    '4':const Color(0xff929292),
    '5':const Color(0xff929292),
    '6':const Color(0xff929292),
    '7':const Color(0xff929292),
    '8':const Color(0xff929292)
  };
  Map get selectedGoalColor => _selectedGoalColor;

  void updateGoalColor(String key, Color value) {
    _selectedGoalColor[key] = value;
    notifyListeners();
  }
}