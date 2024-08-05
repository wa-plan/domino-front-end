import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';


class color_option extends StatelessWidget {
  final int selectIndex;
  final colorCode;

  const color_option({super.key, required this.selectIndex, required this.colorCode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                      onTap: () {context.read<GoalColor>().updateGoalColor('$selectIndex', colorCode);},
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),
                      color: colorCode),
                  ));
  }
}