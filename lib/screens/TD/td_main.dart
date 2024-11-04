import 'package:flutter/material.dart';
import 'package:domino/widgets/nav_bar.dart';
import 'package:domino/widgets/TD/event_calendar.dart';
import 'package:domino/styles.dart';

// TD 메인 페이지 
class TdMain extends StatelessWidget {
  const TdMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      //appBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Padding(
          padding: appBarPadding,
          child: Text(
            '오늘의 도미노',
            style: Theme.of(context).textTheme.titleLarge
          ),
        ),
        backgroundColor: backgroundColor,
      ),

      //body
      body: const Padding(
        padding: fullPadding,
        child: EventCalendar()),
      bottomNavigationBar: const NavBar(),
    );
  }
}
