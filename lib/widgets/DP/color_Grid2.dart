import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class ColorBox2 extends StatelessWidget {
  final int keyNumber;

  const ColorBox2({super.key, required this.keyNumber});

  @override
  Widget build(BuildContext context) {
    return DPCreateGrid(
            context
                .watch<SaveInputtedDetailGoalModel>()
                .inputtedDetailGoal['$keyNumber']!,
            context
                    .watch<SaveInputtedDetailGoalModel>()
                    .inputtedDetailGoal['$keyNumber']!
                    .isEmpty
                ? backgroundColor
                : context.watch<GoalColor>().selectedGoalColor['$keyNumber'],
                null)
        .dPCreateGrid();
  }
}
