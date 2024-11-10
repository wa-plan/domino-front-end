import 'package:flutter/material.dart';
import 'package:flutter_app_secure_storage/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LogOutPage extends StatefulWidget {
  //로그인 정보를 이전 페이지에서 전달 받기 위한 변수
  final String id;
  final String pass;
  LogOutPage({this.id, this.pass});
  @override
  _LogOutPage createState() => _LogOutPage();
}

class _LogOutPage extends State<LogOutPage> {
  static final storage = FlutterSecureStorage();
  //데이터를 이전 페이지에서 전달 받은 정보를 저장하기 위한 변수
  String id;
  String pass;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id; //LogOutPage에서 전달받은 id
    pass = widget.pass; //LogOutPage에서 전달받은 pass
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("로그아웃"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("id : " + id),
            Text("password : " + pass),
            RaisedButton(
              onPressed: () {
                //key name 로그인 폐기
                storage.delete(key: "login");
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => MyLoginPage(
                            title: "로그인",
                          )),
                );
              },
              child: Text("로그아웃"),
            ),
          ],
        ),
      ),
    );
  }
}
