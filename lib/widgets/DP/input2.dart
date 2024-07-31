import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class input2 extends StatelessWidget {
  final int actionPlanId;
  final int selectedDetailGoalId;

  const input2(
      {super.key,
      required this.actionPlanId,
      required this.selectedDetailGoalId});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),
        color: const Color(0xff5C5C5C),),
        
        margin: const EdgeInsets.all(1.0),
        child: Center(
          child: TextFormField(
          initialValue: context.watch<SaveInputtedActionPlanModel>().inputtedActionPlan[selectedDetailGoalId]['$actionPlanId'],
            onChanged: (value) {
              context.read<SaveInputtedActionPlanModel>().updateActionPlan(
                  selectedDetailGoalId, '$actionPlanId', value);
            },
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ))));
  }
}
