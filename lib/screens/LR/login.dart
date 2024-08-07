import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 3,
    vsync: this,
    initialIndex: 0,

  );

  class _LRtabbar extends State<NestedTabBar> {
  late final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: '로그인'),
            Tab(text: '회원가입'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Card(
               class Login extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        elevation: 0.0,
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 50)),
          Form(
              child: Theme(
            data: ThemeData(
                primaryColor: Colors.yellow,
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0))),
            child: Container(
                padding: EdgeInsets.all(40.0),

                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: '아이디를 입력해주세요.'),
                        keyboardType: TextInputType.text,
                      ),
                      TextField(
                        decoration:
                            InputDecoration(labelText: '비밀번호를 입력해주세요.'),
                        keyboardType: TextInputType.text,
                        obscureText: true, // 비밀번호
                      ),
                      SizedBox(height: 40.0,),
                      ButtonTheme(
                        minWidth: 100.0,
                        height: 50.0,
                        child: ElevatedButton( 
                            onPressed: (){
                              
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black
                            ),
                        )
                      )
                    ],
                  ),
                )),
          ))
        ],
      ),
    );
  }
}

class TokenCheck extends StatefulWidget {
  const TokenCheck({super.key});
 
  @override
  State<TokenCheck> createState() => _TokenCheckState();
}
 
class _TokenCheckState extends State<TokenCheck> {
  bool isToken = false;
 
  @override
  void initState() {
    super.initState();
    _autoLoginCheck();
  }
 
  // 자동 로그인 설정 시, 저장소에 토큰 저장
  void _autoLoginCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
 
    if (token != null) {
      setState(() {
        isToken = true;
      });
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // 토큰이 있으면 메인 페이지, 없으면 로그인 페이지
      home: isToken ? profile_main() : login(),
    );
  }
}
//자동 로그인 체크박스 정렬하기,
              ),
              Card(
                //member_register_page.dart 붙여넣기?
              ),
            ],
          ),
        ),
      ],
    );
  }
}
