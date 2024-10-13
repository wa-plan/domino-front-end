import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class ConfirmBox extends StatelessWidget {
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
    Colors.transparent: const Color(0xff5C5C5C),
  };
  final int actionPlanid;
  final int detailGoalid;

  ConfirmBox({super.key, required this.actionPlanid, required this.detailGoalid});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 0.5,
        mainAxisSpacing: 0.5,
        children: [
          // Child for index 0
          buildContainer(context, actionPlanid, '0'),

          // Child for index 1
          buildContainer(context, actionPlanid, '1'),

          // Child for index 2
          buildContainer(context, actionPlanid, '2'),

          // Child for index 3
          buildContainer(context, actionPlanid, '3'),

          // Child for index 4
          buildDetailGoalContainer(context, detailGoalid),

          // Child for index 5
          buildContainer(context, actionPlanid, '4'),

          // Child for index 6
          buildContainer(context, actionPlanid, '5'),

          // Child for index 7
          buildContainer(context, actionPlanid, '6'),

          // Child for index 8
          buildContainer(context, actionPlanid, '7'),
        ],
      ),
    );
  }

  Widget buildContainer(BuildContext context, int actionPlanid, String index) {
    final textValue = context.watch<SaveInputtedActionPlanModel>().inputtedActionPlan[actionPlanid][index] ?? '';
    final colorValue = textValue == "" 
        ? Colors.transparent 
        : context.watch<GoalColor>().selectedGoalColor['$actionPlanid'] ?? Colors.transparent; // Fallback color

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: textValue == "" ? Colors.transparent : colorPalette[colorValue], // Fallback color
      ),
      margin: const EdgeInsets.all(1.0),
      child: Center(
        child: Text(
          textValue,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildDetailGoalContainer(BuildContext context, int detailGoalid) {
    final detailGoalValue = context.watch<SaveInputtedDetailGoalModel>().inputtedDetailGoal['$detailGoalid'] ?? '';

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: detailGoalValue == ""  ? Colors.transparent : detailGoalValue != "" && context.watch<GoalColor>().selectedGoalColor['$actionPlanid'] == Colors.transparent ? const Color(0xff929292) : context.watch<GoalColor>().selectedGoalColor['$actionPlanid'],
      ),
      margin: const EdgeInsets.all(1.0),
      child: Center(
        child: Text(
          detailGoalValue,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500,
                        fontSize: 11,),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
