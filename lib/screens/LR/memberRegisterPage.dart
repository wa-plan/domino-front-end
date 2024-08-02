import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _email = ""; 
  String _password = "";

  String get email => _email;
  String get password => _password;

  void set email(String input_email) {
    _email = input_email;
    notifyListeners();
  }

  void set password(String input_password) {
    _password = input_password;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserProvider(),
        child: MaterialApp(
            title: 'Domino',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.orange),
            routes: {
              '/login': (BuildContext context) => LoginWidget(),
              '/main': (BuildContext context) => MainGridView(),
              '/enrollPassword': (BuildContext context) =>
                  EnrollPasswordWidget()
            },
            home: LoginWidget()));
  }
}

// 프로바이더 인스턴스 생성
late UserProvider _userProvider;

// 프로바이더 사용
_userProvider = Provider.of<UserProvider>(context);

// set
String email = _userProvider.email;

// get
_userProvider.email = _emailConroller.text;

  void _submit() {
    _userProvider.email = _emailConroller.text;
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => EnrollPasswordWidget())));
  }
