import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class Input2 extends StatelessWidget {
  final int actionPlanId;
  final int selectedDetailGoalId;
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
    Colors.transparent: const Color(0xff5C5C5C),
  };

  Input2({super.key, required this.actionPlanId, required this.selectedDetailGoalId});

  @override
  Widget build(BuildContext context) {
    final saveModel = context.watch<SaveInputtedActionPlanModel>();

    // Initialize values
    final initialColor = context.watch<GoalColor>().selectedGoalColor['$selectedDetailGoalId'] ?? Colors.transparent;
    final initialValue = saveModel.inputtedActionPlan[selectedDetailGoalId]['$actionPlanId'] ?? '';

    // Print debug logs to check values
    print('Initial Color: $initialColor');
    print('Initial Value: $initialValue');

    // Ensure Test model is initialized with all values (including those that haven't been modified yet)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final saveModel = context.read<SaveInputtedActionPlanModel>();

      // Initialize all values in the Test model
      for (int detailGoalId = 0; detailGoalId < saveModel.inputtedActionPlan.length; detailGoalId++) {
        final actionPlanData = saveModel.inputtedActionPlan[detailGoalId];
        // actionPlanData는 Map<String, String>을 포함하므로, 각 actionPlanId에 대해 처리
        actionPlanData.forEach((actionPlanId, value) {
          // 초기 값을 Test 모델에 반영
          context.read<TestInputtedActionPlanModel>().updateTestActionPlan(
            detailGoalId,
            actionPlanId,
            value ?? '', // 값이 null이면 빈 문자열로 처리
          );
          print('Initialized: Detail Goal ID $detailGoalId, Action Plan ID $actionPlanId, Value: $value');
        });
            }
    });

    return Container(
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: colorPalette[initialColor] ?? colorPalette[Colors.transparent],
      ),
      margin: const EdgeInsets.all(1.0),
      child: Center(
        child: TextFormField(
          initialValue: initialValue,
          onChanged: (value) {
            // When the value changes, update the Test model with the new value
            print('Changed Value: $value');
            context.read<TestInputtedActionPlanModel>().updateTestActionPlan(
              selectedDetailGoalId,
              '$actionPlanId',
              value.isEmpty ? "" : value,
            );
          },
          textAlign: TextAlign.center,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
