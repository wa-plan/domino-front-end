import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class ColorBox extends StatelessWidget {
  final int actionPlanId;
  final int detailGoalId;
  final int goalColorId;

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
  };

  ColorBox({
    super.key,
    required this.actionPlanId,
    required this.goalColorId,
    required this.detailGoalId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        children: List.generate(9, (index) {
          final inputtedActionPlan = context
              .watch<SaveInputtedActionPlanModel>()
              .inputtedActionPlan[actionPlanId];
          final values = inputtedActionPlan[index.toString()] ?? '';
          final detailGoal = context
                  .watch<SaveInputtedDetailGoalModel>()
                  .inputtedDetailGoal['$detailGoalId'] ??
              '';
          final color1 = detailGoal == "" ? Colors.transparent : detailGoal != "" && 
              context.watch<GoalColor>().selectedGoalColor['$goalColorId'] == Colors.transparent ? const Color(0xff929292) : context.watch<GoalColor>().selectedGoalColor['$goalColorId'];
                  

          final backgroundColor = index == 4
              ? color1
              : (values.isEmpty
                  ? const Color(0xff262626)
                  : colorPalette[color1] ?? Colors.transparent);

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: backgroundColor,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                index == 4 ? detailGoal : values.toString(),
                style: const TextStyle(color: Colors.black, fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }),
      ),
    );
  }
}
