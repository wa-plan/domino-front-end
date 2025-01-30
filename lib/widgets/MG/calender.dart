import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:domino/styles.dart';



void showCalendarPopup(BuildContext context, Function(DateTime?) onDateSelected) {
  showDialog(
    context: context,
    builder: (context) {
      DateTime focusedDay = DateTime.now();
      DateTime? tempSelectedDate;

        return AlertDialog(
          backgroundColor: const Color(0xff262626),
          contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 350,
                child: TableCalendar(
                  locale: 'ko_KR',
                  firstDay: DateTime(2024),
                  lastDay: DateTime(2050),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) =>
                      isSameDay(tempSelectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      tempSelectedDate = selectedDay; // 임시 선택 날짜 업데이트
                      focusedDay = focusedDay; // 포커스된 날짜 업데이트
                    });
                  },
                  calendarStyle: const CalendarStyle(
                    selectedTextStyle: TextStyle(
                      color: backgroundColor, // 선택된 날짜의 텍스트 색상
                      fontWeight: FontWeight.w600, // 텍스트 굵기
                    ),
                    selectedDecoration: BoxDecoration(
                      color: mainRed, // 선택된 날짜의 배경색
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: backgroundColor, // 선택된 날짜의 텍스트 색상
                      fontWeight: FontWeight.w600, // 텍스트 굵기
                    ),
                    todayDecoration: BoxDecoration(
                      color: Color(0xFF5B5B5B), // 오늘 날짜의 배경색
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle:
                        TextStyle(color: Colors.grey), // 주말 텍스트 색상
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false, // 주/월 변경 버튼 숨기기
                    titleCentered: true, // 헤더의 날짜 중앙 정렬
                    leftChevronIcon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xffD4D4D4),
                      size: 17,
                    ),
                    rightChevronIcon: Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xffD4D4D4),
                      size: 17,
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.grey),
                    weekendStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            },
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(Colors.black, Colors.white, '취소', () {
                  Navigator.pop(context); // 팝업 닫기
                }).button(),
                Button(
                  Colors.black,
                  Colors.white,
                  '완료',
                  () {
                  onDateSelected(tempSelectedDate); // 콜백 호출
                  Navigator.pop(context); // 팝업 닫기
                },
                ).button(),
              ],
            )
          ],
        );
      },
    );
  }