// mandalart.dart
import 'package:domino/screens/DP/detail2_page.dart';
import 'package:flutter/material.dart';

class MandalartGrid4 extends StatefulWidget {
  
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;
  final int selectedSecondGoal;

  const MandalartGrid4({
    super.key,
    required this.mandalart,
    required this.secondGoals,
    required this.selectedSecondGoal,
  });

  @override
  State<MandalartGrid4> createState() => _MandalartGrid4();
}

  class _MandalartGrid4 extends State<MandalartGrid4> {


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1),
        children: [
            for (int i = 0; i < 4; i++)
              MandalartBox2(hintNum2: widget.selectedSecondGoal, hintNum3: i, mandalart: widget.mandalart, secondGoals: widget.secondGoals),

            MandalartBox1(hintNum: widget.selectedSecondGoal, mandalart: widget.mandalart, secondGoals: widget.secondGoals),

            for (int i = 4; i < 8; i++)
              MandalartBox2(hintNum2: widget.selectedSecondGoal, hintNum3: i, mandalart: widget.mandalart, secondGoals: widget.secondGoals),
        ],              
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
                    color: colorPalette[color]
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
                        fontSize: 17,
                      ),
                    ),
                  )
                );
  }
}