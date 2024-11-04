import 'package:flutter/material.dart';

class DateListProvider extends ChangeNotifier {
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

  final List<DateTime> _dateList = [];
  List<DateTime> get dateList => _dateList;

  String repeatInfo() {
    if (_everyDay) {
      return "EVERYDAY";
    }
    if (_everyWeek) {
      return "EVERYWEEK";
    }
    if (_everyTwoWeek) {
      return "BIWEEKLY";
    }
    if (_everyMonth) {
      return "EVERYMONTH";
    }
    return "NONE";
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

  void setInterval(bool switchValue, DateTime date) {
    _interval = 0;
    if (switchValue) {
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
        int currentMonth = date.month;
        int currentDay = date.day;

        // 다음 달로 이동
        int nextMonth = currentMonth + 1;
        int nextYear = date.year;

        if (nextMonth > 12) {
          nextMonth = 1;
          nextYear++;
        }

        // 다음 달의 같은 일로 설정
        _interval =
            DateTime(nextYear, nextMonth, currentDay).difference(date).inDays;
      }
      _generateDateList(date);
    } else {
      _dateList.clear();
      _dateList.add(date);
    }

    notifyListeners();
  }

  void _generateDateList(DateTime startDate) {
    _dateList.clear();
    DateTime currentDate = startDate;

    while (currentDate.isBefore(startDate.add(const Duration(days: 365)))) {
      _dateList.add(currentDate);
      currentDate = currentDate.add(Duration(days: _interval));
    }
    notifyListeners();
  }

  void updateRepeatSettings(int interval) {
    if (interval == 1) {
      _everyDay = true;
      _everyWeek = false;
      _everyTwoWeek = false;
      _everyMonth = false;
    } else if (interval == 7) {
      _everyDay = false;
      _everyWeek = true;
      _everyTwoWeek = false;
      _everyMonth = false;
    } else if (interval == 14) {
      _everyDay = false;
      _everyWeek = false;
      _everyTwoWeek = true;
      _everyMonth = false;
    } else if (interval > 14) {
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
