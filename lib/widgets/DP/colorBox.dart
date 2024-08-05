import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class colorBox extends StatelessWidget {

  final int actionPlanid;
  final int detailGoalid;
  final int goalColorid;

  final Map colorPalette = {
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
  
  colorBox({super.key, required this.actionPlanid, required this.goalColorid, required this.detailGoalid});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
                    width: 100,
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      children: List.generate(9, (index) {

                        final inputtedActionPlan = context.watch<SaveInputtedActionPlanModel>().inputtedActionPlan[actionPlanid];
                        final values = inputtedActionPlan.containsKey(index.toString()) ? inputtedActionPlan[index.toString()] : '';
                        final detailGoal = context.watch<SaveInputtedDetailGoalModel>().inputtedDetailGoal['$detailGoalid'];
                        final color1 = context.watch<GoalColor>().selectedGoalColor['$goalColorid'];
                        final backgroundColor1 = detailGoal.isEmpty ? const Color(0xff262626) : color1;
                

                        if (index == 4) {
                            return Container(
                              
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),
                              color: backgroundColor1,),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                  detailGoal,
                                  style: const TextStyle(color: Colors.black, fontSize: 15),
                                  textAlign: TextAlign.center,
                                )),
                              
                            );
                          } else {
                            final isValueEmpty = values.isEmpty;
                            final backgroundColor2 = isValueEmpty ? const Color(0xff262626) : colorPalette[color1];

                            return Container(
                              
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),
                              color: backgroundColor2,),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                values.toString(),
                                style: const TextStyle(color: Colors.black, fontSize: 15),
                                textAlign: TextAlign.center,
                              )),
                            );
                          }
                      })
                    )
                  );
             
  }
}