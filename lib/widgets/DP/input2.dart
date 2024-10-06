import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class Input2 extends StatelessWidget {
  final int actionPlanId;
  final int selectedDetailGoalId;
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
    Colors.transparent : const Color(0xff5C5C5C),};

   Input2(
      {super.key,
      required this.actionPlanId,
      required this.selectedDetailGoalId});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: colorPalette[context.watch<GoalColor>().selectedGoalColor['$selectedDetailGoalId']],
        ),
        margin: const EdgeInsets.all(1.0),
        child: Center(
            child: TextFormField(
                initialValue: context
                    .watch<SaveInputtedActionPlanModel>()
                    .inputtedActionPlan[selectedDetailGoalId]['$actionPlanId'],
                onChanged: (value) {
                  value.isEmpty ? context.read<SaveInputtedActionPlanModel>().updateActionPlan(
                      selectedDetailGoalId, '$actionPlanId', "") : context.read<SaveInputtedActionPlanModel>().updateActionPlan(
                      selectedDetailGoalId, '$actionPlanId', value);
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ))));
  }
}
