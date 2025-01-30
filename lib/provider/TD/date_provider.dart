import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime? _pickedDate;
  DateTime? get pickedDate => _pickedDate;

  void setPickedDate(DateTime date) {
    _pickedDate = date;
    notifyListeners(); // 상태 변경 알림
  }

  void clearPickedDate() {
    _pickedDate = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners(); // 빌드가 끝난 후 상태 변경 알림
    });
  }
}
