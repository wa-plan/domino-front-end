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
                        builder: (context) => const main(),
                      ));
                }
              )
]
)
      )
    )
};
  }

