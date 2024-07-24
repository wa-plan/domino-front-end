import 'package:flutter/material.dart';
import 'dart:collection'; //LinkedHashMap 객체 사용하기 위한 라이브러리
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final String content;
  bool didZero, didHalf, didAll;
  bool switchValue;
  int interval;
  bool everyDay;
  bool everyWeek;
  bool everyTwoWeek;
  bool everyMonth;

  Event({
    required this.title,
    required this.content,
    required this.switchValue,
    required this.interval,
    this.didZero = false,
    this.didHalf = false,
    this.didAll = false,
    this.everyDay = false,
    this.everyWeek = false,
    this.everyTwoWeek = false,
    this.everyMonth = false,
  });

  @override
  String toString() => title;
}

class EventProvider with ChangeNotifier {
  final LinkedHashMap<DateTime, List<Event>> _events =
      LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  ); /*..addAll({
          DateTime(2024, 6, 29): [Event(title: "money", content: "저금하기")],
        });*/

  List<Event> getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void addEvent(DateTime date, Event event) {
    if (_events[date] != null) {
      _events[date]!.add(event);
    } else {
      _events[date] = [event];
    }
    notifyListeners(); // 상태 변경 알림
  }

  void addrepeatEvent(
    DateTime startDate,
    Event event,
    bool switchValue,
    int interval,
  ) {
    DateTime endDate = startDate.add(const Duration(days: 365)); // 1년 후의 날짜
    if (interval == 1 || interval == 7 || interval == 14) {
      for (DateTime date = startDate;
          date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
          date = date.add(Duration(days: interval))) {
        addEvent(date, event);
      }
    } else if (interval > 14) {
      for (DateTime date = startDate;
          date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
          date = DateTime(date.year, date.month + 1, date.day)) {
        addEvent(date, event);
      }
    }
  }

  void editEvent(DateTime date, Event oldEvent, Event newEvent) {
    // 기존 이벤트를 삭제하고
    removeEvent(date, oldEvent);

    // 새 이벤트를 추가합니다.
    addEvent(date, newEvent);
  }

  Map<String, bool> howmany(int interval) {
    bool everyDay = false;
    bool everyWeek = false;
    bool everyTwoWeek = false;
    bool everyMonth = false;

    if (interval == 1) {
      everyDay = true;
    } else if (interval == 7) {
      everyWeek = true;
    } else if (interval == 14) {
      everyTwoWeek = true;
    } else {
      everyMonth = true;
    }

    return {
      'everyDay': everyDay,
      'everyWeek': everyWeek,
      'everyTwoWeek': everyTwoWeek,
      'everyMonth': everyMonth,
    };
  }

  void removeEvent(DateTime date, Event event) {
    if (_events[date] != null) {
      _events[date]!.remove(event);
      if (_events[date]!.isEmpty) {
        _events.remove(date);
      }
      notifyListeners();
    }
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
