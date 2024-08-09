import 'package:flutter/material.dart';
import 'package:domino/widgets/TD/nav_bar.dart';
import 'package:domino/widgets/TD/event_calendar.dart';

class TdMain extends StatelessWidget {
  const TdMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '오늘의 도미노',
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.06,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: const Color(0xff262626),
      ),
      backgroundColor: const Color(0xff262626),
      body: const EventCalendar(),
      bottomNavigationBar: const NavBar(),
    );
  }
}
