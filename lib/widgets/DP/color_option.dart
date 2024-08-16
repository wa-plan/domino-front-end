import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class ColorOption extends StatelessWidget {
  final int selectIndex;
  final Color colorCode; // 타입을 명시적으로 지정

  const ColorOption(
      {super.key, required this.selectIndex, required this.colorCode});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.read<GoalColor>().updateGoalColor('$selectIndex', colorCode);
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3), color: colorCode),
        ));
  }
}
