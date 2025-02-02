import 'package:domino/screens/DP/dp_main.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({super.key});

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: fullPadding,
          child: Column(
            children: [
              const SizedBox(height: 100,),
              Stack(
                children: [
                  // 이미지가 뒤에 배치됨
                  Image.asset(
                    "assets/img/confetti.png",
                    height: 230,
                    fit: BoxFit.cover, // 이미지가 Stack의 크기를 덮도록 설정
                  ),

                  // 텍스트는 Positioned로 위치 조정
                  const Positioned(
                    top: 80, // 이미지와 텍스트 사이의 간격 조정
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          "플랜 만들기 성공!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white, // 이미지 위에 잘 보이도록 텍스트 색상 설정
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "이제 목표를 향해 달려볼까요?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white, // 이미지 위에 잘 보이도록 텍스트 색상 설정
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 45,
              ),
              Image.asset("assets/img/Complete.png", height: 220),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(Colors.black, Colors.white, "네!", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DPMain()),
                    );
                  }).button(),
                ],
              )
            ],
          ),
        ));
  }
}
