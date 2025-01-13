import 'package:domino/screens/DP/Edit/edit_input23.dart';
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
            for (int i = 0; i < 4; i++)
              DPGrid3_E(inputtedActionPlan['$i']??"", const Color(0xff5C5C5C), 10).dpGrid3_E(),
    
            // 제2목표
            DPGrid3_E(
              context.watch<SaveInputtedDetailGoalModel>().inputtedDetailGoal['$goalId'] ??'', 
              const Color(0xff929292), 10).dpGrid3_E(),
            
            for (int i = 5; i < 9; i++)
              DPGrid3_E(inputtedActionPlan['$i']??"", const Color(0xff5C5C5C), 10).dpGrid3_E(),
          ],
        ),
      ),
    );
  }
}
