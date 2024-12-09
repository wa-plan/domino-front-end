import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class Input2 extends StatefulWidget {
  final int actionPlanId;
  final int selectedDetailGoalId;

  const Input2({
    super.key,
    required this.actionPlanId,
    required this.selectedDetailGoalId,
  });

  @override
  State<Input2> createState() => _Input2State();
}

class _Input2State extends State<Input2> {
  late String initialValue;
  late Color initialColor;

  @override
  void initState() {
    super.initState();

    // Save 모델에서 초기값 가져오기
    final saveModel = context.read<SaveInputtedActionPlanModel>();
    initialValue = saveModel.inputtedActionPlan[widget.selectedDetailGoalId]
            ['${widget.actionPlanId}'] ??
        ''; // 초기 값이 없으면 빈 문자열로 설정

    // 초기 색상 가져오기
    initialColor = context
            .read<GoalColor>()
            .selectedGoalColor['${widget.selectedDetailGoalId}'] ??
        Colors.transparent;

    // Test 모델에 초기화 반영
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int detailGoalId = 0;
          detailGoalId < saveModel.inputtedActionPlan.length;
          detailGoalId++) {
        final actionPlanData = saveModel.inputtedActionPlan[detailGoalId];
        actionPlanData.forEach((actionPlanId, value) {
          context.read<TestInputtedActionPlanModel>().updateTestActionPlan(
                detailGoalId,
                actionPlanId, // actionPlanId를 int로 변환
                value,
              );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: colorPalette[initialColor] ??
            colorPalette[Colors.transparent],
      ),
      margin: const EdgeInsets.all(1.0),
      child: Center(
        child: TextFormField(
          initialValue: initialValue, // 초기 값 표시
          onChanged: (value) {
            // 값 변경 시 Test 모델에 업데이트
            context.read<TestInputtedActionPlanModel>().updateTestActionPlan(
                  widget.selectedDetailGoalId,
                  widget.actionPlanId.toString(),
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
