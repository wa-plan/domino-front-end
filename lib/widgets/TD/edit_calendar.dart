import 'package:flutter/material.dart';
import 'package:domino/provider/TD/date_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class EditCalendar extends StatefulWidget {
  final DateTime date;
  const EditCalendar(this.date, {super.key});
  @override
  State<EditCalendar> createState() => EditCalendarState();
}

class EditCalendarState extends State<EditCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late DateTime pickedDate = DateTime.now(); //도미노로 저장할 때, 해당 페이지로 넘길 날짜 변수
  Map pickDates = {};

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.date;
    _selectedDay = widget.date;
    pickedDate = widget.date; // 초기에는 전달된 날짜로 설정
    Provider.of<DateProvider>(context, listen: false).setPickedDate(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
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
                  .setPickedDate(pickedDate);
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
                  color: Color(0xFF5B5B5B), shape: BoxShape.circle),
              selectedDecoration: const BoxDecoration(
                  color: Color(0xFFFF6767), shape: BoxShape.rectangle),
              defaultTextStyle: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.035,
              ),
              weekendTextStyle: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.035,
              )),
          headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(color: Colors.white),
              leftChevronIcon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              rightChevronIcon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              )),
          firstDay: DateTime.utc(2014, 1, 1),
          lastDay: DateTime.utc(2034, 12, 31),
        ),
      ],
    );
  }
}
