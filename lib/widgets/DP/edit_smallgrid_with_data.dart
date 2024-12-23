import 'package:domino/screens/DP/Edit/edit_create_input2_page.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class EditSmallgridwithdata extends StatelessWidget {
  final String mandalart;
  final String firstColor;
  final int goalId;

  const EditSmallgridwithdata({super.key, required this.goalId, required this.mandalart,
  required this.firstColor});

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
              firstColor: firstColor,
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
                  inputtedActionPlan['5']??"",
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
                  inputtedActionPlan['6']??"",
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
                  inputtedActionPlan['7']??"",
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
                  inputtedActionPlan['8']??"",
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
