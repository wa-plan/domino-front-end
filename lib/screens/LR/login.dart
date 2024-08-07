<<<<<<< YujinPark
import 'package:domino/apis/lr_api_function.dart';
import 'package:flutter/material.dart';
import 'package:domino/screens/LR/member_register_page.dart'; // 회원가입 페이지 경로

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  final ApiService apiService = ApiService();

  void _login() async {
    final username = controller.text;
    final password = controller2.text;
    final user = await apiService.login(username, password);
    if (user != null) {
      // 로그인 성공
      print('로그인 성공: ${user.userid}');
      // TODO: Navigate to the next screen
    } else {
      // 로그인 실패
      print('로그인 실패');
      // TODO: Show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262626),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff262626),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Row(
            children: [
              Text(
                '로그인',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: '아이디를 입력해주세요.'),
            ),
            TextField(
              controller: controller2,
              decoration: const InputDecoration(labelText: '비밀번호를 입력해주세요.'),
              obscureText: true,
            ),
            const SizedBox(height: 40.0),
            TextButton(
              onPressed: _login,
              child: const Text('로그인'),
            ),
          ],
        ),
      ),
=======
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
>>>>>>> dev
    );
  }
}
