import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class Input1 extends StatefulWidget {
  final int selectedDetailGoalId;

  const Input1({super.key, required this.selectedDetailGoalId});

  @override
  _Input1State createState() => _Input1State();
}

class _Input1State extends State<Input1> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    // Save 모델에서 초기 값을 가져옴
    final saveModel = context.read<SaveInputtedDetailGoalModel>();

    // TextEditingController를 초기화하여 Save 모델의 값을 표시
    controller = TextEditingController(
      text:
          saveModel.inputtedDetailGoal['${widget.selectedDetailGoalId}'] ?? '',
    );

    // 위젯이 빌드를 완료한 후 Test 모델에 초기 값 반영
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TestInputtedDetailGoalModel>().updateTestDetailGoal(
            '${widget.selectedDetailGoalId}',
            saveModel.inputtedDetailGoal['${widget.selectedDetailGoalId}'] ??
                '',
          );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DPInput2(
        context
                    .watch<GoalColor>()
                    .selectedGoalColor['${widget.selectedDetailGoalId}'] ==
                Colors.transparent
            ? const Color(0xff929292)
            : context
                .watch<GoalColor>()
                .selectedGoalColor['${widget.selectedDetailGoalId}'],
        controller, (value) {
      context.read<TestInputtedDetailGoalModel>().updateTestDetailGoal(
            '${widget.selectedDetailGoalId}',
            value,
          );
    }).dpInput2();
  }
}
