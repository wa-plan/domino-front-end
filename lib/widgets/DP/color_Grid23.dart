import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class ColorBox extends StatelessWidget {
  final int actionPlanId;
  final int detailGoalId;
  final int goalColorId;


  const ColorBox({
    super.key,
    required this.actionPlanId,
    required this.goalColorId,
    required this.detailGoalId,
  });

  @override
  Widget build(BuildContext context) {
    final inputtedActionPlan = context
        .watch<SaveInputtedActionPlanModel>()
        .inputtedActionPlan[actionPlanId];

    final detailGoal = context
        .watch<SaveInputtedDetailGoalModel>()
        .inputtedDetailGoal['$detailGoalId'] ?? '';

    // Determine color
    Color color1 = detailGoal == ""
        ? Colors.transparent
        : (context.watch<GoalColor>().selectedGoalColor['$goalColorId'] ?? const Color(0xff929292)); // Default color

    // Second/Third Goal Grid
    List<Widget> buildGridItems() {
      return List.generate(9, (index) {
        // Second Goal
        if (index == 4) {
          return DPCreateGrid(
            detailGoal, 
            color1,
            null).dPCreateGrid();
        }

        // Third Goal
        return DPCreateGrid(
          inputtedActionPlan['$index'] ?? '', 
          inputtedActionPlan['$index']?.isEmpty == true
                ? const Color(0xff2A2A2A)
                : colorPalette[color1] ?? Colors.transparent,
                null).dPCreateGrid();
      });
    }

    return SizedBox(
      width: 100,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        children: buildGridItems(),
      ),
    );
  }
}
