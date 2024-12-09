import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class ColorBox extends StatelessWidget {
  final int actionPlanId;
  final int detailGoalId;
  final int goalColorId;

  final Map<Color, Color> colorPalette = {
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

  ColorBox({
    super.key,
    required this.actionPlanId,
    required this.goalColorId,
    required this.detailGoalId,
  });

  @override
  Widget build(BuildContext context) {
    final inputtedActionPlan = context
        .watch<SaveInputtedActionPlanModel>()
        .inputtedActionPlan[actionPlanId];

    final detailGoal = context
        .watch<SaveInputtedDetailGoalModel>()
        .inputtedDetailGoal['$detailGoalId'] ?? '';

    // Determine color
    Color color1 = detailGoal == ""
        ? Colors.transparent
        : (context.watch<GoalColor>().selectedGoalColor['$goalColorId'] ?? const Color(0xff929292)); // Default color

    // Build grid items
    List<Widget> buildGridItems() {
      return List.generate(9, (index) {
        // Center item logic
        if (index == 4) {
          return Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: color1,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: AutoSizeText(
                maxLines: 3, // 최대 줄 수 (필요에 따라 변경 가능)
            minFontSize: 6, // 최소 글씨 크기
            overflow: TextOverflow.ellipsis, // 내용이 너무 길 경우 생략 표시
                detailGoal,
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // Other grid items
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: inputtedActionPlan['$index']?.isEmpty == true
                ? const Color(0xff2A2A2A)
                : colorPalette[color1] ?? Colors.transparent,
          ),
          margin: const EdgeInsets.all(1.0),
          child: Center(
            child: AutoSizeText(
              maxLines: 3, // 최대 줄 수 (필요에 따라 변경 가능)
            minFontSize: 6, // 최소 글씨 크기
            overflow: TextOverflow.ellipsis, // 내용이 너무 길 경우 생략 표시
              inputtedActionPlan['$index'] ?? '',
              style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
        );
      });
    }

    return SizedBox(
      width: 100,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        children: buildGridItems(),
      ),
    );
  }
}
