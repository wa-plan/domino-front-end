import 'package:auto_size_text/auto_size_text.dart';
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
      padding: const EdgeInsets.all(2),
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
            child: AutoSizeText(
              maxLines: 3, // 최대 줄 수 (필요에 따라 변경 가능)
            minFontSize: 6, // 최소 글씨 크기
            overflow: TextOverflow.ellipsis, // 내용이 너무 길 경우 생략 표시
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
