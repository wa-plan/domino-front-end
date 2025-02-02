import 'package:domino/screens/TR/tr_4.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:domino/styles.dart';

class TR_3 extends StatefulWidget {
  const TR_3({super.key});

  @override
  State<TR_3> createState() => _TR_3State();
}

class _TR_3State extends State<TR_3> {
  String selectedOption = "디폴트";
  final List<String> gridTexts = [
    "", "스펙왕 되기", "나 자신을 찾아가기",
    "", "뿌듯한 학교생활하기", "자기관리하는 멋쟁이 되기",
    "", "다양한 사람 만나보기", "돈 많이 모으기",
  ];

  final int correctIndex = 1; // 정답 위치 (두 번째 그리드)

  void handleSelection(int index) {
    if (index == correctIndex) {
      setState(() {
        selectedOption = gridTexts[index];
      });
    } else {
      Fluttertoast.showToast(
        msg: "틀렸어!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  void handleNext() {
    if (selectedOption == gridTexts[correctIndex]) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TR_4()),
      );
    } else {
      Fluttertoast.showToast(
        msg: "정답을 선택해야 해!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            const Text(
              "2  세부 목표",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xffFF6767),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "나는 이번 학기에\n스펙을 많이 쌓고 싶어!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 25),

            // 9개 그리드
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return _buildGridItem(index);
              },
            ),

            const Spacer(),

            Center(
              child: SizedBox(
                width: 350,
                child: TextButton(
                  onPressed: handleNext,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(15, 10.5, 15, 10.5),
                    backgroundColor: const Color(0xffFF6767),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    '다음',
                    style: TextStyle(
                      color: Color(0xff262626),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(int index) {
    bool isCircle = index == 4; // 가운데만 원형
    bool isSelected = selectedOption == gridTexts[index];

    return GestureDetector(
      onTap: () => handleSelection(index),
      child: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xff555634) : const Color(0xff3B3B3B),
          borderRadius: isCircle ? BorderRadius.circular(50) : BorderRadius.circular(3),
          border: Border.all(
            color: isSelected ? Colors.yellow : Colors.transparent, // 정답 선택 시 노란색 테두리
            width: 2,
          ),
        ),
        child: Text(
          gridTexts[index],
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
