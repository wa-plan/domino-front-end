// DP 메인 페이지에 들어가는 만다라트
import 'package:flutter/material.dart';

class MandalartGrid extends StatelessWidget {
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;
  final int mandalartId;

  const MandalartGrid({
    super.key,
    required this.mandalart,
    required this.secondGoals,
    required this.mandalartId,
  });


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
        children: [

          SizedBox(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.5,
              children: [
                MandalartBox2(hintNum2: 0, hintNum3: 0, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 0, hintNum3: 1, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 0, hintNum3: 2, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 0, hintNum3: 3, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 0, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 0, hintNum3: 4, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 0, hintNum3: 5, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 0, hintNum3: 6, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 0, hintNum3: 7, mandalart: mandalart, secondGoals: secondGoals),
              ]
            )
          ),

          SizedBox(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.5,
              children: [
                MandalartBox2(hintNum2: 1, hintNum3: 0, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 1, hintNum3: 1, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 1, hintNum3: 2, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 1, hintNum3: 3, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 1, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 1, hintNum3: 4, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 1, hintNum3: 5, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 1, hintNum3: 6, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 1, hintNum3: 7, mandalart: mandalart, secondGoals: secondGoals),
              ]
            )
          ),

          SizedBox(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.5,
              children: [
                MandalartBox2(hintNum2: 2, hintNum3: 0, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 2, hintNum3: 1, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 2, hintNum3: 2, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 2, hintNum3: 3, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 2, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 2, hintNum3: 4, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 2, hintNum3: 5, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 2, hintNum3: 6, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 2, hintNum3: 7, mandalart: mandalart, secondGoals: secondGoals),
              ]
            )
          ),

          SizedBox(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.5,
              children: [
                MandalartBox2(hintNum2: 3, hintNum3: 0, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 3, hintNum3: 1, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 3, hintNum3: 2, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 3, hintNum3: 3, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 3, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 3, hintNum3: 4, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 3, hintNum3: 5, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 3, hintNum3: 6, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 3, hintNum3: 7, mandalart: mandalart, secondGoals: secondGoals),
              ]
            )
          ),

          SizedBox(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.5,
              children: [           
                MandalartBox1(hintNum: 0, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 1, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 2, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 3, mandalart: mandalart, secondGoals: secondGoals),

                Container(
                  margin: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.yellow,
                  ),
                  child: Center(
                    child: Text(
                      mandalart,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  )
                ),

                MandalartBox1(hintNum: 5, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 6, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 7, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 8, mandalart: mandalart, secondGoals: secondGoals),
              ],
            ),
          ),

          SizedBox(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.5,
              children: [
                MandalartBox2(hintNum2: 5, hintNum3: 0, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 5, hintNum3: 1, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 5, hintNum3: 2, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 5, hintNum3: 3, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 5, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 5, hintNum3: 4, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 5, hintNum3: 5, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 5, hintNum3: 6, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 5, hintNum3: 7, mandalart: mandalart, secondGoals: secondGoals),
              ]
            )
          ),

          SizedBox(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.5,
              children: [
                MandalartBox2(hintNum2: 6, hintNum3: 0, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 6, hintNum3: 1, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 6, hintNum3: 2, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 6, hintNum3: 3, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 6, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 6, hintNum3: 4, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 6, hintNum3: 5, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 6, hintNum3: 6, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 6, hintNum3: 7, mandalart: mandalart, secondGoals: secondGoals),
              ]
            )
          ),

          SizedBox(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.5,
              children: [
                MandalartBox2(hintNum2: 7, hintNum3: 0, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 7, hintNum3: 1, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 7, hintNum3: 2, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 7, hintNum3: 3, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 7, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 7, hintNum3: 4, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 7, hintNum3: 5, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 7, hintNum3: 6, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 7, hintNum3: 7, mandalart: mandalart, secondGoals: secondGoals),
              ]
            )
          ),

          SizedBox(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.5,
              children: [
                MandalartBox2(hintNum2: 8, hintNum3: 0, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 8, hintNum3: 1, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 8, hintNum3: 2, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 8, hintNum3: 3, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox1(hintNum: 8, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 8, hintNum3: 4, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 8, hintNum3: 5, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 8, hintNum3: 6, mandalart: mandalart, secondGoals: secondGoals),
                MandalartBox2(hintNum2: 8, hintNum3: 7, mandalart: mandalart, secondGoals: secondGoals),
              ]
            )
          ),


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
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
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
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                  )
                );
  }
}