import 'package:flutter/material.dart';
import 'package:domino/screens/LR/login.dart';


class LoginregisterFindPassword extends StatelessWidget {
  const LoginregisterFindPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff262626),
        appBar: AppBar(
          backgroundColor: const Color(0xff262626),
          automaticallyImplyLeading: false,

        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(38.0, 30.0, 38.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children:[
              IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                  color: Colors.white,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: const VisualDensity(horizontal: -4),
                ),
                const SizedBox(width: 10.0),
                Text(
                    '아이디 / 비밀번호 찾기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),]),
                  const SizedBox(height: 30.0),
           const Text("아이디 찾기",
           style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),),
                const SizedBox(height: 10.0),
           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'Phone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                  height: 35,
                  width: 190,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: '숫자만 입력해 주세요.',
                        labelStyle: const TextStyle(
                          color: Color(0xff5C5C5C),
                          fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: Color(0xff5C5C5C),
                              width: 1.5,
                            ))),
                    obscureText: true,
                  )),
                   ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                      ),
          
              child: const Text(
                '확인',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
              ),
            )
            
            ]),
            const SizedBox(height: 50.0),
            const Text("비밀번호 찾기",
            style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),),
                const SizedBox(height: 10.0),
           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                'Phone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              SizedBox(
                  height: 35,
                  width: 190,
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: '숫자만 입력해 주세요.',
                        labelStyle: const TextStyle(
                          color: Color(0xff5C5C5C),
                          fontSize: 13),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: const BorderSide(
                              color: Color(0xff5C5C5C),
                              width: 1.5,
                            ))),
                    obscureText: true,
                  )),
                  ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(2)),
                      ),
          
              child: const Text(
                '확인',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 13,
                ),
              ),
            )
            
            ]),
          ],
        ),
        ),
        );
  }
}
