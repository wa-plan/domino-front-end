import 'package:domino/main.dart';
import 'package:flutter/material.dart';

class memberRegisterPage extends StatelessWidget {
  const memberRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: MaterialApp(
        title: '회원가입',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Color.fromARGB(255, 0, 0, 0)),
        Row(children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyApp(),
                      ));
                }
              )
]
)
      )
    )
};
  }

// set
String email = _userProvider.email;

// get
_userProvider.email = _emailConroller.text;

  void _submit() {
    _userProvider.email = _emailConroller.text;
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => EnrollPasswordWidget())));
  }
