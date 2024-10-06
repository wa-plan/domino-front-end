import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/TD/date_provider.dart';
import 'package:domino/provider/ST/password_provider.dart';
import 'package:domino/provider/LR/user_provider.dart';
import 'package:domino/provider/nav_provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/provider/TD/datelist_provider.dart';
import 'package:domino/screens/LR/login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 엔진 초기화
  await initializeDateFormatting();
  await dotenv.load(fileName: 'assets/config/.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DateProvider()),
        //ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => DateListProvider()),
        ChangeNotifierProvider(create: (_) => PasswordProvider()),
        ChangeNotifierProvider(create: (_) => SelectFinalGoalModel()),
        ChangeNotifierProvider(create: (_) => SelectFinalGoalId()),
        ChangeNotifierProvider(create: (_) => SaveInputtedDetailGoalModel()),
        ChangeNotifierProvider(create: (_) => SaveInputtedActionPlanModel()),
        ChangeNotifierProvider(create: (_) => SelectDetailGoal()),
        ChangeNotifierProvider(create: (_) => GoalColor()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => NavBarProvider()),
        ChangeNotifierProvider(create: (_) => SelectAPModel()),
        ChangeNotifierProvider(create: (_) => SaveEditedDetailGoalIdModel()),
        ChangeNotifierProvider(create: (_) => SaveEditedActionPlanIdModel()),
        ChangeNotifierProvider(create: (_) => SaveMandalartCreatedGoal()),
      ],
      child: const MyApp(), // MyApp 클래스를 사용
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'domino',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // 앱의 기본 화면
    );
  }
}
