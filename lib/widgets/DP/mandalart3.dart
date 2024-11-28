// DP 디테일 페이지에 들어가는 9x9 만다라트 (3x3 만다라트 선택 가능)
import 'package:domino/screens/DP/detail2_page.dart';
import 'package:domino/screens/DP/detail3_page.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';

class MandalartGrid3 extends StatefulWidget {
  final String firstColor;
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;
  final int mandalartId;

  const MandalartGrid3({
    super.key,
    required this.mandalart,
    required this.secondGoals,
    required this.mandalartId,
    required this.firstColor,
  });

  @override
  State<MandalartGrid3> createState() => _MandalartGrid3();
}

class _MandalartGrid3 extends State<MandalartGrid3> {
  int selectedSecondGoal = 0;

  void navigateToDetail(int selectedGoal) {
    setState(() {
      selectedSecondGoal = selectedGoal;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DPdetail2Page(
          mandalart: widget.mandalart,
          secondGoals: widget.secondGoals,
          mandalartId: widget.mandalartId,
          selectedSecondGoal: selectedSecondGoal,
          firstColor: widget.firstColor,
        ),
      ),
    );
  }

  Widget buildGridCell(int hintNum2) {
  // 체크: 모든 그리드 박스 컬러가 투명한지 확인
  bool isAllTransparent = widget.secondGoals.isNotEmpty &&
      widget.secondGoals[hintNum2]['thirdGoals'].every((goal) => goal['thirdGoal'] == "");

  return GestureDetector(
    onTap: isAllTransparent 
        ? null // 투명하면 아무 동작도 하지 않음
        : () => navigateToDetail(hintNum2),
    child: SizedBox(
      width: 100,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 0.5,
        mainAxisSpacing: 0.5,
        children: [
          for (int i = 0; i < 4; i++)
            MandalartBox2(
              hintNum2: hintNum2,
              hintNum3: i,
              mandalart: widget.mandalart,
              secondGoals: widget.secondGoals,
            ),
          MandalartBox1(
            hintNum: hintNum2,
            mandalart: widget.mandalart,
            secondGoals: widget.secondGoals,
          ),
          for (int i = 5; i < 9; i++)
            MandalartBox2(
              hintNum2: hintNum2,
              hintNum3: i,
              mandalart: widget.mandalart,
              secondGoals: widget.secondGoals,
            ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          if (index == 4) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DPdetail3Page(
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    mandalartId: widget.mandalartId,
                    selectedSecondGoal: selectedSecondGoal,
                    firstColor: widget.firstColor,
                  ),
                ),
              ),
              child: SizedBox(
                width: 100,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    for (int i = 0; i < 4; i++)
                      MandalartBox1(
                        hintNum: i,
                        mandalart: widget.mandalart,
                        secondGoals: widget.secondGoals,
                      ),
                    Container(
                      margin: const EdgeInsets.all(1.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Color(int.parse(widget.firstColor
                            .replaceAll('Color(', '')
                            .replaceAll(')', ''))),
                      ),
                      child: Center(
                        child: Text(
                          widget.mandalart,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: backgroundColor,
                          ),
                        ),
                      ),
                    ),
                    for (int i = 5; i < 9; i++)
                      MandalartBox1(
                        hintNum: i,
                        mandalart: widget.mandalart,
                        secondGoals: widget.secondGoals,
                      ),
                  ],
                ),
              ),
            );
          }
          return buildGridCell(index);
        },
      ),
    );
  }
}


class MandalartBox1 extends StatelessWidget {
  final int hintNum;
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;

  const MandalartBox1({
    super.key, 
    required this.hintNum,
    required this. mandalart,
    required this. secondGoals});

  @override
  Widget build(BuildContext context){
    return Container(
                  margin: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: secondGoals.isNotEmpty 
                    && secondGoals[hintNum]['secondGoal'] != ""
                    ? Color(int.parse(secondGoals[hintNum]['color'].replaceAll('Color(', '').replaceAll(')',''))) 
                    : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      secondGoals.isNotEmpty && secondGoals[hintNum]['secondGoal'] != "" ? secondGoals[hintNum]['secondGoal'] : "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                        color: backgroundColor,)
                    ),
                  )
                );
  }
}

class MandalartBox2 extends StatelessWidget {
  final int hintNum2;
  final int hintNum3;
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;
  final Map<Color, Color> colorPalette = {
    const Color(0xffFF7A7A): const Color(0xffFFC2C2),
    const Color(0xffFFB82D): const Color(0xffFFD19B),
    const Color(0xffFCFF62): const Color(0xffFEFFCD),
    const Color(0xff72FF5B): const Color(0xffC1FFB7),
    const Color(0xff5DD8FF): const Color(0xff94E5FF),
    const Color(0xff929292): Colors.transparent,
    const Color(0xffFF5794): const Color(0xffFF8EB7),
    const Color(0xffAE7CFF): const Color(0xffD0B4FF),
    const Color(0xffC77B7F): const Color(0xffEBB6B9),
    const Color(0xff009255): const Color(0xff6DE1B0),
    const Color(0xff3184FF): const Color(0xff8CBAFF),
    const Color(0xff11D1C2): const Color(0xffAAF4EF),
  };

  MandalartBox2({
    super.key, 
    required this.hintNum2,
    required this.hintNum3,
    required this. mandalart,
    required this. secondGoals});

  @override
  Widget build(BuildContext context){
    final color = secondGoals.isNotEmpty
    &&  secondGoals[hintNum2]['thirdGoals'].asMap().containsKey(hintNum3) 
    ? Color(int.parse(secondGoals[hintNum2]['color'].replaceAll('Color(', '').replaceAll(')',''))) 
    : Colors.transparent;

    return Container(
                  margin: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: secondGoals.isNotEmpty &&
                      secondGoals[hintNum2]['thirdGoals'].isNotEmpty 
                      && secondGoals[hintNum2]['thirdGoals'].asMap().containsKey(hintNum3) && secondGoals[hintNum2]['thirdGoals'][hintNum3]['thirdGoal'] == "" ? Colors.transparent : colorPalette[color]
                  ),
                  child: Center(
                    child: Text(
                      secondGoals.isNotEmpty &&
                      secondGoals[hintNum2]['thirdGoals'].isNotEmpty 
                      && secondGoals[hintNum2]['thirdGoals'].asMap().containsKey(hintNum3)  
                      ? secondGoals[hintNum2]['thirdGoals'][hintNum3]['thirdGoal']
                      : "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: backgroundColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,)
                    ),
                  )
                );
  }
}