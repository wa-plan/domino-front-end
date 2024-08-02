import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:provider/provider.dart';
import 'package:domino/provider/TD/date_provider.dart';
import 'package:domino/provider/TD/event_provider.dart';
import 'package:domino/provider/ST/password_provider.dart';
import 'package:domino/provider/LR/user_provider.dart';

import 'package:domino/provider/DP/model.dart';

import 'package:domino/widgets/TD/nav_bar.dart';

import 'package:domino/widgets/TD/event_calendar.dart';

void main() async {
  await initializeDateFormatting();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => DateProvider()),
      ChangeNotifierProvider(create: (_) => EventProvider()),
      ChangeNotifierProvider(create: (_) => PasswordProvider()),
      ChangeNotifierProvider(
        create: (_) => SelectFinalGoalModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => SaveInputtedDetailGoalModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => SaveInputtedActionPlanModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => SelectDetailGoal(),
      ),
      ChangeNotifierProvider(create: (_) => GoalColor()),
      ChangeNotifierProvider(
        create: (_) => UserProvider(),
      ),
    ]),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'domino', debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

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
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: const Color(0xff262626),
        ),
        backgroundColor: const Color(0xff262626),
        body: const Expanded(
          child: EventCalendar(),
        ),
        bottomNavigationBar: const NavBar());
  }
}
