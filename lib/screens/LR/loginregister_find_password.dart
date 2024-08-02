import 'package:flutter/material.dart';
import 'package:domino/widgets/TD/nav_bar.dart';

class LoginregisterFindPassword extends StatelessWidget {
  const LoginregisterFindPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff262626),
        appBar: AppBar(
          backgroundColor: const Color(0xff262626),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Text(
              '나의 목표',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
          /*child: Container(
              margin = EdgeInsets.only(
                  top: heightRatio * 26,
                  left: widthRatio * 30,
                  right: widthRatio * 30),
              child = Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FindPasswordScreen()));
                    },
                    child: const Text(
                      "비밀번호 찾기",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5,
                        decorationColor: Colors.white,
                        height: 0,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),
                ],
              ),
            )*/
        ),
        bottomNavigationBar: const NavBar());
  }
}
