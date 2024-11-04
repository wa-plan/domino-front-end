import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:domino/provider/TD/date_provider.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_application_1/todayDomino/widgets/event_calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:domino/widgets/TD/repeat_settings.dart';

class AddCalendar extends StatefulWidget {
  const AddCalendar({super.key});
  @override
  State<AddCalendar> createState() => AddCalendarState();
}

class AddCalendarState extends State<AddCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late DateTime pickedDate = DateTime.now(); //도미노로 저장할 때, 해당 페이지로 넘길 날짜 변수
  RepeatSettingsState repeatSettings =
      RepeatSettingsState(); // RepeatSettingsState 인스턴스 생성
  final GlobalKey<RepeatSettingsState> repeatSettingsKey = GlobalKey();
  Map pickDates = {};

  @override
  void initState() {
    super.initState();
    pickedDate = _focusedDay; // 초기에는 현재 날짜로 설정
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko-KR',
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) {
        return isSameDay(_selectedDay, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          // Call `setState()` when updating the selected day
          //bool everyDay = repeatSettingsKey.currentState!.everyDay;
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            pickedDate = selectedDay;
          });
          // DateProvider를 통해 상태 업데이트
          Provider.of<DateProvider>(context, listen: false)
              .setPickedDate(selectedDay);
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      calendarFormat: CalendarFormat.month,
      calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          isTodayHighlighted: true,
          todayDecoration: const BoxDecoration(
            color: Color(0xFF5B5B5B),
            shape: BoxShape.circle,
          ),
          selectedDecoration:
              const BoxDecoration(color: mainRed, shape: BoxShape.rectangle),
          defaultTextStyle: TextStyle(
            color: mainTextColor,
            fontSize: MediaQuery.of(context).size.width * 0.035,
          ),
          weekendTextStyle: TextStyle(
            color: mainTextColor,
            fontSize: MediaQuery.of(context).size.width * 0.035,
          )),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Color(0xffD4D4D4)), // 평일 색상
        weekendStyle: TextStyle(color: Color(0xffD4D4D4)), // 주말 색상
      ),
      headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 15),
          leftChevronIcon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffD4D4D4),
            size: 17,
          ),
          rightChevronIcon: Icon(Icons.arrow_forward_ios,
              color: Color(0xffD4D4D4), size: 17)),
      firstDay: DateTime.utc(2014, 1, 1),
      lastDay: DateTime.utc(2034, 12, 31),
    );
  }
}
