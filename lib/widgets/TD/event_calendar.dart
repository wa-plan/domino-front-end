import 'package:domino/apis/services/td_services.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:domino/screens/TD/add_page1.dart';
import 'package:domino/screens/TD/edit_page.dart';
import 'package:intl/intl.dart';
import 'package:domino/styles.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key});

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  late final ValueNotifier<List<Event>> _selectedEvents;
  bool _isExpanded = false; // 달력 확장 상태

  void mandalartInfo(context, int mandalartId) async {
    final data =
        await MandalartInfoService.mandalartInfo(mandalartId: mandalartId);
    if (data != null) {
      setState(() {
        String firstColor = data['color']; // name을 가져오기
        print(firstColor);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('만다라트 조회에 실패했습니다.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier([]);
    dominoInfo(_selectedDay!);
  }

  Future<void> dominoInfo(DateTime date) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final events =
        await DominoInfoService.dominoInfo(context, date: formattedDate);

    if (events != null) {
      setState(() {
        _selectedEvents.value = events;
      });
    } else {
      setState(() {
        _selectedEvents.value = [];
      });
    }
  }

  void dominoStatus(int goalId, String attainment, String date) async {
    final success = await DominoStatusService.dominoStatus(
        goalId: goalId, attainment: attainment, date: date);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('상태가 $attainment(으)로 업데이트 되었습니다.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('업데이트에 실패했습니다.')),
      );
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      dominoInfo(selectedDay);
    }
  }

  // 캘린더 형식을 토글하는 함수
  void _toggleCalendarFormat() {
    setState(() {
      if (_calendarFormat == CalendarFormat.week) {
        _calendarFormat = CalendarFormat.month;
        _isExpanded = true;
      } else {
        _calendarFormat = CalendarFormat.week;
        _isExpanded = false;
      }
    });
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar<Event>(
          firstDay: DateTime.utc(2014, 1, 1),
          lastDay: DateTime.utc(2034, 12, 31),
          focusedDay: _focusedDay,
          eventLoader: (day) {
            if (isSameDay(day, _selectedDay)) {
              return _selectedEvents.value;
            }
            return [];
          },
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: _onDaySelected,
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
              _selectedDay = focusedDay;
            });
            dominoInfo(focusedDay);
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          availableCalendarFormats: const {
            CalendarFormat.month: '열기',
            CalendarFormat.week: '닫기',
          },
          locale: 'ko-KR',
          calendarStyle: CalendarStyle(
            markerSize: 0.0,
            isTodayHighlighted: true,
            todayDecoration: const BoxDecoration(
                color: Color(0xFF5B5B5B), shape: BoxShape.circle),
            selectedDecoration: const BoxDecoration(
              color: mainRed,
              shape: BoxShape.circle,
            ),
            defaultTextStyle: TextStyle(
              color: mainTextColor,
              fontSize: MediaQuery.of(context).size.width * 0.035,
            ),
            weekendTextStyle: TextStyle(
              color: mainTextColor,
              fontSize: MediaQuery.of(context).size.width * 0.035,
            ),
          ),
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Color(0xffD4D4D4)), // 평일 색상
            weekendStyle: TextStyle(color: Color(0xffD4D4D4)), // 주말 색상
          ),
          headerStyle: const HeaderStyle(
            titleCentered: true,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 15),
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
            formatButtonVisible:
                false, //원래 달력 열고 닫는 버튼. 지금은 화살표 아이콘이 역할을 대신하고 있음.
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              padding: EdgeInsets.zero, // 패딩 설정
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.add, color: backgroundColor, size: 26),
            ),
            // 화살표 버튼 추가
            IconButton(
              onPressed: _toggleCalendarFormat,
              padding: EdgeInsets.zero, // 패딩 설정
              constraints: const BoxConstraints(), // constraints
              icon: Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: const Color(0xffD4D4D4),
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPage1(),
                    ));
              },
              padding: EdgeInsets.zero, // 패딩 설정
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.add, color: Color(0xffD4D4D4), size: 26),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              if (value.isEmpty) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                  child: const Column(
                    children: [
                      Text(
                        '오늘은 도미노가 없네요.',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff5C5C5C),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '여유를 가져도 되겠어요:)',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff5C5C5C),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(
                          value[index]
                              .color
                              .replaceAll('Color(', '') // 'Color(' 부분 제거
                              .replaceAll(')', ''),
                        );

                        // 롱 프레스 이벤트 처리
                        if (value[index].repetition != 'NONE') {
                          value[index].switchValue = true;
                          if (value[index].repetition == 'EVERYDAY') {
                            value[index].interval = 1;
                          }
                          if (value[index].repetition == 'EVERYWEEK') {
                            value[index].interval = 7;
                          }
                          if (value[index].repetition == 'BIWEEKLY') {
                            value[index].interval = 14;
                          }
                          if (value[index].repetition == 'EVERYMONTH') {
                            value[index].interval = 31;
                          }
                        } else {
                          value[index].switchValue = false;
                          value[index].interval = 0;
                        }

                        editDialog(
                            context,
                            _focusedDay,
                            value[index].goalName,
                            value[index].thirdGoal,
                            value[index].switchValue,
                            value[index].interval,
                            value[index].id,
                            value[index].color);
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 14),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xff2A2A2A),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 17,
                              height: 50,
                              margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                              decoration: BoxDecoration(
                                color: Color(int.parse(
                                  value[index]
                                      .color
                                      .replaceAll(
                                          'Color(', '') // 'Color(' 부분 제거
                                      .replaceAll(')', ''),
                                )),
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value[index].thirdGoal,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  value[index].goalName,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        value[index].didZero =
                                            !value[index].didZero;
                                        value[index].didHalf = false;
                                        value[index].didAll = false;
                                      });
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(_selectedDay!);
                                      dominoStatus(value[index].id, "FAIL",
                                          formattedDate);
                                    },
                                    icon: Icon(
                                      Icons.clear_outlined,
                                      size: 20,
                                      color: value[index].didZero
                                          ? mainGold
                                          : const Color(0xff5C5C5C),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        value[index].didHalf =
                                            !value[index].didHalf;
                                        value[index].didZero = false;
                                        value[index].didAll = false;
                                      });
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(_selectedDay!);
                                      dominoStatus(value[index].id,
                                          "IN_PROGRESS", formattedDate);
                                    },
                                    icon: Icon(
                                      Icons.change_history_outlined,
                                      size: 20,
                                      color: value[index].didHalf
                                          ? mainGold
                                          : const Color(0xff5C5C5C),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        value[index].didAll =
                                            !value[index].didAll;
                                        value[index].didZero = false;
                                        value[index].didHalf = false;
                                      });
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(_selectedDay!);
                                      dominoStatus(value[index].id, "SUCCESS",
                                          formattedDate);
                                    },
                                    icon: Icon(
                                      Icons.circle_outlined,
                                      size: 20,
                                      color: value[index].didAll
                                          ? mainGold
                                          : const Color(0xff5C5C5C),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

void editDialog(BuildContext context, DateTime date, String title,
    String content, bool switchvalue, int interval, int goalId, String color) {
  String getIntervalText() {
    if (!switchvalue) {
      return 'X';
    }

    String weekday = DateFormat('EEEE', 'ko_KR').format(date); // 요일을 한국어로 변환
    String dayOfMonth = date.day.toString(); // 날짜 가져오기

    if (interval == 1) {
      return '매일';
    } else if (interval == 7) {
      return '매주 $weekday';
    } else if (interval == 14) {
      return '격주 $weekday';
    } else if (interval > 14) {
      return '매월 $dayOfMonth일';
    }

    return 'X'; // 기본값
  }

  showDialog(
    context: context,
    barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
    builder: (BuildContext context) {
      return AlertDialog(

        backgroundColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(0),
        elevation: 30.0,
        content: Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 26, 26, 26),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          height: 200,
          width: 400,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 15,
                height: 140,
                decoration: const BoxDecoration(
                  color: mainRed,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const Text(
                            '환상적인 세계여행',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            content,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13),
                          ),
                        
                      
                    
                  
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 15),
                 
                  const Text(
                    '반복',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    getIntervalText(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPage(date, content,
                                  title, switchvalue, interval, goalId),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        color: const Color.fromARGB(255, 98, 98, 98),
                        padding: EdgeInsets.zero,
                        iconSize: 25,
                      ),
            ],
          ),
        ),
      );
    },
  );
}
