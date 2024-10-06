import 'package:domino/screens/DP/edit_create_input2_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class EditSmallgridwithdata extends StatelessWidget {
  final String mandalart;

  final Map<Color, Color> colorPalette = {
    const Color(0xffFF7A7A): const Color(0xffFFC2C2),
    const Color(0xffFFB82D): const Color(0xffFFD19B),
    const Color(0xffFCFF62): const Color(0xffFEFFCD),
    const Color(0xff72FF5B): const Color(0xffC1FFB7),
    const Color(0xff5DD8FF): const Color(0xff94E5FF),
    const Color(0xff929292): const Color(0xff5C5C5C),
    const Color(0xffFF5794): const Color(0xffFF8EB7),
    const Color(0xffAE7CFF): const Color(0xffD0B4FF),
    const Color(0xffC77B7F): const Color(0xffEBB6B9),
    const Color(0xff009255): const Color(0xff6DE1B0),
    const Color(0xff3184FF): const Color(0xff8CBAFF),
    const Color(0xff11D1C2): const Color(0xffAAF4EF),
    Colors.transparent : const Color(0xff5C5C5C),
  };
  
  
  final int goalId;

  EditSmallgridwithdata({super.key, required this.goalId, required this.mandalart,});

  @override
  Widget build(BuildContext context) {
    final inputtedActionPlan =
        context.watch<SaveInputtedActionPlanModel>().inputtedActionPlan[goalId];

    return GestureDetector(
      onTap: () {
        context.read<SelectDetailGoal>().selectDetailGoal('$goalId');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  EditInput2Page(
              mandalart: mandalart,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 100,
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          children: [
            // index 0
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: colorPalette[context.watch<GoalColor>().selectedGoalColor['$goalId']],
              ),
              margin: const EdgeInsets.all(1.0),
              child: Center(
                child: Text(
                  inputtedActionPlan['0']??"",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // index 1
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: colorPalette[context.watch<GoalColor>().selectedGoalColor['$goalId']],
              ),
              margin: const EdgeInsets.all(1.0),
              child: Center(
                child: Text(
                  inputtedActionPlan['1']??"",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,
                        ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // index 2
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: colorPalette[context.watch<GoalColor>().selectedGoalColor['$goalId']],
              ),
              margin: const EdgeInsets.all(1.0),
              child: Center(
                child: Text(
                  inputtedActionPlan['2']??"",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // index 3
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: colorPalette[context.watch<GoalColor>().selectedGoalColor['$goalId']],
              ),
              margin: const EdgeInsets.all(1.0),
              child: Center(
                child: Text(
                  inputtedActionPlan['3']??"",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // index 4 (특별 처리)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: context.watch<GoalColor>().selectedGoalColor['$goalId'] == Colors.transparent ? const Color(0xff929292) : context.watch<GoalColor>().selectedGoalColor['$goalId'],
              ),
              margin: const EdgeInsets.all(1.0),
              child: Center(
                child: Text(
                  context
                          .watch<SaveInputtedDetailGoalModel>()
                          .inputtedDetailGoal['$goalId'] ??
                      '',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // index 5
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: colorPalette[context.watch<GoalColor>().selectedGoalColor['$goalId']],
              ),
              margin: const EdgeInsets.all(1.0),
              child: Center(
                child: Text(
                  inputtedActionPlan['4']??"",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // index 6
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: colorPalette[context.watch<GoalColor>().selectedGoalColor['$goalId']],
              ),
              margin: const EdgeInsets.all(1.0),
              child: Center(
                child: Text(
                  inputtedActionPlan['5']??"",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // index 7
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: colorPalette[context.watch<GoalColor>().selectedGoalColor['$goalId']],
              ),
              margin: const EdgeInsets.all(1.0),
              child: Center(
                child: Text(
                  inputtedActionPlan['6']??"",
                  style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w500,
                        fontSize: 11,),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // index 8
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: colorPalette[context.watch<GoalColor>().selectedGoalColor['$goalId']],
              ),
              margin: const EdgeInsets.all(1.0),
              child: Center(
                child: Text(
                  inputtedActionPlan['7']??"",
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
