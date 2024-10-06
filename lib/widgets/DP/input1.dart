import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class Input1 extends StatelessWidget {
  

  final int selectedDetailGoalId;

   const Input1({super.key, required this.selectedDetailGoalId});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        margin: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: context.watch<GoalColor>().selectedGoalColor['$selectedDetailGoalId'] == Colors.transparent ? const Color(0xff929292) : context.watch<GoalColor>().selectedGoalColor['$selectedDetailGoalId'],
        ),
        child: Center(
            child: TextFormField(
                initialValue: context
                    .watch<SaveInputtedDetailGoalModel>()
                    .inputtedDetailGoal['$selectedDetailGoalId'],
                onChanged: (value) {
                  context
                      .read<SaveInputtedDetailGoalModel>()
                      .updateDetailGoal('$selectedDetailGoalId', value);
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ))));
  }
}
