import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/screens/DP/create_input2_page.dart';

class Smallgridwithdata extends StatelessWidget {
  final int goalId;
  final String firstColor;

  const Smallgridwithdata({super.key, required this.goalId, required this.firstColor,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SelectDetailGoal>().selectDetailGoal('$goalId');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DPcreateInput2Page(firstColor: firstColor,),
            ));
      },
      child: SizedBox(
        width: 100,
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          children: List.generate(9, (index) {
            final inputtedActionPlan = context
                .watch<SaveInputtedActionPlanModel>()
                .inputtedActionPlan[goalId];
            final values = inputtedActionPlan.containsKey(index.toString())
                ? inputtedActionPlan[index.toString()]
                : '';

            print('Index: $index, Values: $values');

            if (index == 4) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: const Color(0xff929292),
                ),
                margin: const EdgeInsets.all(1.0),
                child: Center(
                    child: Text(
                  maxLines: 2, // 두 줄로 제한
                  overflow: TextOverflow.ellipsis,
                  context
                          .watch<SaveInputtedDetailGoalModel>()
                          .inputtedDetailGoal['$goalId'] ??
                      '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )),
              );
            } else {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: const Color(0xff5C5C5C),
                ),
                margin: const EdgeInsets.all(1.0),
                child: Center(
                    child: Text(
                  values.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                  textAlign: TextAlign.center,
                )),
              );
            }
          }),
        ),
      ),
    );
  }
}
