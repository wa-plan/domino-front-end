import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class ColorBox2 extends StatelessWidget {
  final int keyNumber;

  const ColorBox2({super.key, required this.keyNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: context
                    .watch<SaveInputtedDetailGoalModel>()
                    .inputtedDetailGoal['$keyNumber']!
                    .isEmpty
                ? const Color(0xff2A2A2A)
                : context.watch<GoalColor>().selectedGoalColor['$keyNumber']),
        margin: const EdgeInsets.all(1.0),
        child: Center(
            child: Text(
          context
              .watch<SaveInputtedDetailGoalModel>()
              .inputtedDetailGoal['$keyNumber']!,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.w500,
              fontSize: 11),
        )));
  }
}
