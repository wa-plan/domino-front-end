import 'package:domino/screens/LR/login.dart';
import 'package:domino/screens/TD/td_main.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:provider/provider.dart';
import 'package:domino/provider/TD/date_provider.dart';
import 'package:domino/provider/TD/event_provider.dart';
import 'package:domino/provider/ST/password_provider.dart';
import 'package:domino/provider/LR/user_provider.dart';
import 'package:domino/provider/nav_provider.dart';

import 'package:domino/provider/DP/model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화
  await initializeDateFormatting();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DateProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => PasswordProvider()),
        ChangeNotifierProvider(create: (_) => SelectFinalGoalModel()),
        ChangeNotifierProvider(create: (_) => SaveInputtedDetailGoalModel()),
        ChangeNotifierProvider(create: (_) => SaveInputtedActionPlanModel()),
        ChangeNotifierProvider(create: (_) => SelectDetailGoal()),
        ChangeNotifierProvider(create: (_) => GoalColor()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NavBarProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    ),
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
      title: 'domino',
      debugShowCheckedModeBanner: false,
      home: TdMain(),
    );
  }
}
