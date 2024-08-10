import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
//import 'dart:collection'; //LinkedHashMap 객체 사용하기 위한 라이브러리
import 'package:domino/screens/TD/add_page1.dart';
import 'package:domino/screens/TD/edit_page.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/TD/event_provider.dart';
import 'package:intl/intl.dart'; // 요일 변환을 위한 패키지

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

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier([]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // EventProvider의 변경사항을 감지하여 _selectedEvents를 업데이트
    _selectedEvents.value =
        context.watch<EventProvider>().getEventsForDay(_selectedDay!);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value =
          context.read<EventProvider>().getEventsForDay(selectedDay);
    }
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TableCalendar<Event>(
            firstDay: DateTime.utc(2014, 1, 1),
            lastDay: DateTime.utc(2034, 12, 31),
            focusedDay: _focusedDay,
            eventLoader: (day) =>
                context.watch<EventProvider>().getEventsForDay(day),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
                _selectedDay = focusedDay;
                _selectedEvents.value = context
                    .read<EventProvider>()
                    .getEventsForDay(_selectedDay!);
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            availableCalendarFormats: const {
              CalendarFormat.month: '한달',
              CalendarFormat.week: '1주',
            },
            locale: 'ko-KR',
            calendarStyle: CalendarStyle(
                markerSize: 0.0,
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
            headerStyle: HeaderStyle(
              leftChevronMargin: const EdgeInsets.only(right: 55.0),
              // formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 20),
              leftChevronIcon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              rightChevronIcon: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              formatButtonVisible: true,
              formatButtonDecoration: BoxDecoration(
                color: Colors.transparent, // 버튼의 배경색을 투명으로 설정
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.white, // 윤곽선을 흰색으로 설정
                ),
              ),
              formatButtonTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
              ),
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width * (6 / 7)),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPage1(),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff262626),
                elevation: 0.0,
              ),
              icon: const Icon(Icons.add, color: Color(0xff5C5C5C), size: 30),
              alignment: Alignment.centerRight,
            ), //루틴 추가하기 아이콘
          ],
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ValueListenableBuilder<List<Event>>(
            //ValueNotifier의 값이 변경될 때마다 자신의 'builder' 콜백을 호출한다.
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              if (value.isEmpty) {
                // 이벤트가 없는 경우
                return const Center(
                  child: Column(
                    children: [
                      Text(
                        '오늘은 도미노가 없네요.',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff5C5C5C),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '여유를 가져도 되겠어요:)',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff5C5C5C),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              } else {
                // 이벤트가 있는 경우

                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        // 롱 프레스 이벤트 처리
                        editDialog(
                          context,
                          _focusedDay,
                          value[index].title,
                          value[index].content,
                          value[index].switchValue,
                          value[index].interval,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.transparent), // 테두리 제거
                        ),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.0),
                        child: Row(
                          children: [
                            Container(
                              width: 22,
                              height: 55,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value[index].title,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  value[index].content,
                                  style: const TextStyle(color: Colors.white),
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
                                    },
                                    icon: Icon(
                                      Icons.clear_outlined,
                                      color: value[index].didZero
                                          ? Colors.yellow
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
                                    },
                                    icon: Icon(
                                      Icons.change_history_outlined,
                                      color: value[index].didHalf
                                          ? Colors.yellow
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
                                    },
                                    icon: Icon(
                                      Icons.circle_outlined,
                                      color: value[index].didAll
                                          ? Colors.yellow
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

void editDialog(
  BuildContext context,
  DateTime date,
  String title,
  String content,
  bool switchvalue,
  int interval,
) {
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
        //title: const Text('팝업 메시지'),
        backgroundColor: const Color(0xff262626),
        content: Row(
          children: [
            Container(
              width: 15,
              height: 140,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '환상적인 세계여행',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          title,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 80,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPage(
                              date,
                              title,
                              content,
                              switchvalue,
                              interval,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                Text(
                  content,
                  style: const TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Container(
                    height: 1,
                    width: 200,
                    color: Colors.grey,
                  ),
                ),
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
          ],
        ),
      );
    },
  );
}
