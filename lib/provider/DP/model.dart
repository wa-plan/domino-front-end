import 'package:flutter/material.dart';

class SelectFinalGoalModel with ChangeNotifier {
  String _selectedFinalGoal = "선택 안됨!"; // 초기값 설정
  String get selectedFinalGoal => _selectedFinalGoal;

  void selectFinalGoal(String value) {
    _selectedFinalGoal = value;
    notifyListeners();
  }
}

class SelectFinalGoalId with ChangeNotifier {
  String _selectedFinalGoalId = "선택 안됨!"; // 초기값 설정
  String get selectedFinalGoalId => _selectedFinalGoalId;

  void selectFinalGoalId(String value) {
    _selectedFinalGoalId = value;
    notifyListeners();
  }
}

class SelectAPModel with ChangeNotifier {
  String _selectedAPName = "선택안됨"; // 초기값 설정
  String get selectedAPName => _selectedAPName;
  int? _selectedAPID; // 초기값 설정
  int? get selectedAPID => _selectedAPID;

  void selectAP(String name, int? ID) {
    _selectedAPName = name;
    _selectedAPID = ID;
    notifyListeners();
  }
}

class SaveInputtedDetailGoalModel with ChangeNotifier {
  final Map<String, String> _inputtedDetailGoal = {
    '0': '',
    '1': '',
    '2': '',
    '3': '',
    '4': '',
    '5': '',
    '6': '',
    '7': '',
    '8': ''
  };

  Map<String, String> get inputtedDetailGoal => _inputtedDetailGoal;

  void updateDetailGoal(String key, String value) {
    if (_inputtedDetailGoal.containsKey(key)) {
      // 키가 존재하는지 확인
      _inputtedDetailGoal[key] = value;
      notifyListeners();
    }
  }
}

class SaveInputtedActionPlanModel with ChangeNotifier {
  final List<Map<String, String>> _inputtedActionPlan = List.generate(9, (_) {
    return {
      '0': '',
      '1': '',
      '2': '',
      '3': '',
      '4': '',
      '5': '',
      '6': '',
      '7': '',
      '8': ''
    };
  });

  List<Map<String, String>> get inputtedActionPlan => _inputtedActionPlan;

  void updateActionPlan(int goalId, String key, String value) {
    if (goalId >= 0 && goalId < _inputtedActionPlan.length) {
      // 유효한 인덱스인지 확인
      if (_inputtedActionPlan[goalId].containsKey(key)) {
        // 키가 존재하는지 확인
        _inputtedActionPlan[goalId][key] = value;
        notifyListeners();
      }
    }
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
  final Map<String, Color> _selectedGoalColor = {
    '0': const Color(0xff929292),
    '1': const Color(0xff929292),
    '2': const Color(0xff929292),
    '3': const Color(0xff929292),
    '4': const Color(0xff929292),
    '5': const Color(0xff929292),
    '6': const Color(0xff929292),
    '7': const Color(0xff929292),
    '8': const Color(0xff929292)
  };

  Map<String, Color> get selectedGoalColor => _selectedGoalColor;

  void updateGoalColor(String key, Color value) {
    if (_selectedGoalColor.containsKey(key)) {
      // 키가 존재하는지 확인
      _selectedGoalColor[key] = value;
      notifyListeners();
    }
  }
}

class SaveEditedDetailGoalIdModel with ChangeNotifier {
  final Map<String, int> _editedDetailGoalId = {
    '0': 0,
    '1': 0,
    '2': 0,
    '3': 0,
    '4': 0,
    '5': 0,
    '6': 0,
    '7': 0,
    '8': 0
  };

  Map<String, int> get editedDetailGoalId => _editedDetailGoalId;

  void editDetailGoalId(String key, int value) {
    if (_editedDetailGoalId.containsKey(key)) {
      // 키가 존재하는지 확인
      _editedDetailGoalId[key] = value;
      notifyListeners();
    }
  }
}

class SaveEditedActionPlanIdModel with ChangeNotifier {
  final List<Map<String, int>> _editedActionPlanId = List.generate(9, (_) {
    return {
      '0': 0,
      '1': 0,
      '2': 0,
      '3': 0,
      '4': 0,
      '5': 0,
      '6': 0,
      '7': 0,
      '8': 0
    };
  });

  List<Map<String, int>> get editedActionPlanId => _editedActionPlanId;

  void editActionPlanId(int goalId, String key, int value) {
    if (goalId >= 0 && goalId < _editedActionPlanId.length) {
      // 유효한 인덱스인지 확인
      if (_editedActionPlanId[goalId].containsKey(key)) {
        // 키가 존재하는지 확인
        _editedActionPlanId[goalId][key] = value;
        notifyListeners();
      }
    }
  }
}


class SaveMandalartCreatedGoal with ChangeNotifier {
  final List<String> _mandalartCreatedGoal = [];

  List<String> get mandalartCreatedGoal => _mandalartCreatedGoal;

  void updateMandalartCreatedGoal(String goalId) {
    _mandalartCreatedGoal.add(goalId);  
    notifyListeners();  
  }
}

