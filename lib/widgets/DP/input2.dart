import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class Input2 extends StatelessWidget {
  final int actionPlanId;
  final int selectedDetailGoalId;

  const Input2(
      {super.key,
      required this.actionPlanId,
      required this.selectedDetailGoalId});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        color: const Color(0xff5C5C5C),
        margin: const EdgeInsets.all(1.0),
        child: TextField(
          onChanged: (value) {
            context
                .read<SaveInputtedActionPlanModel>()
                .updateActionPlan(selectedDetailGoalId, '$actionPlanId', value);
          },
        ));
  }
}
