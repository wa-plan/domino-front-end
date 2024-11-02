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

    return SizedBox(
      width: 100,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        children: [
          // Grid item 0
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: inputtedActionPlan['0']?.isEmpty == true
                  ? const Color(0xff2A2A2A)
                  : colorPalette[color1] ?? Colors.transparent,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                inputtedActionPlan['0'] ?? '',
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Grid item 1
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: inputtedActionPlan['1']?.isEmpty == true
                  ? const Color(0xff2A2A2A)
                  : colorPalette[color1] ?? Colors.transparent,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                inputtedActionPlan['1'] ?? '',
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Grid item 2
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: inputtedActionPlan['2']?.isEmpty == true
                  ? const Color(0xff2A2A2A)
                  : colorPalette[color1] ?? Colors.transparent,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                inputtedActionPlan['2'] ?? '',
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Grid item 3
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: inputtedActionPlan['3']?.isEmpty == true
                  ? const Color(0xff2A2A2A)
                  : colorPalette[color1] ?? Colors.transparent,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                inputtedActionPlan['3'] ?? '',
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Grid item 4 (center item)
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: color1,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                detailGoal,
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Grid item 5
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: inputtedActionPlan['5']?.isEmpty == true
                  ? const Color(0xff2A2A2A)
                  : colorPalette[color1] ?? Colors.transparent,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                inputtedActionPlan['5'] ?? '',
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Grid item 6
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: inputtedActionPlan['6']?.isEmpty == true
                  ? const Color(0xff2A2A2A)
                  : colorPalette[color1] ?? Colors.transparent,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                inputtedActionPlan['6'] ?? '',
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Grid item 7
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: inputtedActionPlan['7']?.isEmpty == true
                  ? const Color(0xff2A2A2A)
                  : colorPalette[color1] ?? Colors.transparent,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                inputtedActionPlan['7'] ?? '',
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          // Grid item 8
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: inputtedActionPlan['8']?.isEmpty == true
                  ? const Color(0xff2A2A2A)
                  : colorPalette[color1] ?? Colors.transparent,
            ),
            margin: const EdgeInsets.all(1.0),
            child: Center(
              child: Text(
                inputtedActionPlan['8'] ?? '',
                style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
