import 'package:flutter/material.dart';

class DateProvider extends ChangeNotifier {
  DateTime? _pickedDate;
  DateTime? get pickedDate => _pickedDate;

  bool _everyDay = false;
  bool _everyWeek = false;
  bool _everyTwoWeek = false;
  bool _everyMonth = false;
  int _interval = 0;

  bool get everyDay => _everyDay;
  bool get everyWeek => _everyWeek;
  bool get everyTwoWeek => _everyTwoWeek;
  bool get everyMonth => _everyMonth;
  int get interval => _interval;

  void setPickedDate(DateTime date) {
    _pickedDate = date;
    notifyListeners(); // 상태 변경 알림
  }

  void clearPickedDate() {
    _pickedDate = null;
    notifyListeners(); // 상태 변경 알림
  }

  void setEveryday(bool everyDay) {
    _everyDay = everyDay;
    _everyWeek = false;
    _everyTwoWeek = false;
    _everyMonth = false;
    notifyListeners();
  }

  void setEveryweek(bool everyWeek) {
    _everyWeek = everyWeek;
    _everyDay = false;
    _everyTwoWeek = false;
    _everyMonth = false;
    notifyListeners();
  }

  void setEverytwoweek(bool everyTwoWeek) {
    _everyTwoWeek = everyTwoWeek;
    _everyDay = false;
    _everyWeek = false;
    _everyMonth = false;
    notifyListeners();
  }

  void setEverymonth(bool everyMonth) {
    _everyMonth = everyMonth;
    _everyDay = false;
    _everyWeek = false;
    _everyTwoWeek = false;
    notifyListeners();
  }

  void setInterval(bool repeat) {
    _interval = 0;
    if (repeat && _pickedDate != null) {
      // Add null check here
      if (_everyDay) {
        _interval = 1;
      }
      if (_everyWeek) {
        _interval = 7;
      }
      if (_everyTwoWeek) {
        _interval = 14;
      }
      if (_everyMonth) {
        // 현재 선택된 날짜의 월과 일(day)을 기억
        int currentMonth = _pickedDate!.month;
        int currentDay = _pickedDate!.day;

        // 다음 달로 이동
        int nextMonth = currentMonth + 1;
        int nextYear = _pickedDate!.year;

        if (nextMonth > 12) {
          nextMonth = 1;
          nextYear++;
        }

        // 다음 달의 같은 일로 설정
        _interval = DateTime(nextYear, nextMonth, currentDay)
            .difference(_pickedDate!)
            .inDays;
      }
    }

    notifyListeners();
  }

  void updateRepeatSettings() {
    if (_interval == 1) {
      _everyDay = true;
      _everyWeek = false;
      _everyTwoWeek = false;
      _everyMonth = false;
    } else if (_interval == 7) {
      _everyDay = false;
      _everyWeek = true;
      _everyTwoWeek = false;
      _everyMonth = false;
    } else if (_interval == 14) {
      _everyDay = false;
      _everyWeek = false;
      _everyTwoWeek = true;
      _everyMonth = false;
    } else if (_interval > 14) {
      _everyDay = false;
      _everyWeek = false;
      _everyTwoWeek = false;
      _everyMonth = true;
    } else {
      _everyDay = false;
      _everyWeek = false;
      _everyTwoWeek = false;
      _everyMonth = false;
    }
    notifyListeners();
  }
}
