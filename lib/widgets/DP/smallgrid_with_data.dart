import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/screens/DP/create_input2_page.dart';

class Smallgridwithdata extends StatelessWidget {
  final int goalId;
  final String firstColor;

  const Smallgridwithdata({
    super.key,
    required this.goalId,
    required this.firstColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
  final isDetailAllEmpty =
      context.read<SaveInputtedDetailGoalModel>().isAllEmpty();
  final emptyKeys = context.read<SaveInputtedDetailGoalModel>().getEmptyKeys();

  if (isDetailAllEmpty) {
    // 모든 값이 ''이면 메시지 표시
    Fluttertoast.showToast(
      msg: '세부 목표를 먼저 입력해 주세요.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black,
    );
  } else {
    // 비어있는 키가 goalId와 1을 뺀 값이 일치하는지 확인
    final emptyKeyMinusOne = emptyKeys
        .map((key) => int.parse(key)).toList();
    for(int i=0; i < emptyKeyMinusOne.length; i++){
    print(emptyKeyMinusOne[i]);
    }
    print(goalId);

    if (emptyKeyMinusOne.contains(goalId)) {
      
      // goalId와 비어있는 key + 1이 일치하면 네비게이션 하지 않음
      Fluttertoast.showToast(
        msg: '세부 목표를 먼저 입력해 주세요.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
      );
    } else {
      for(int i=0; i < emptyKeyMinusOne.length; i++){
    print(emptyKeyMinusOne[i]);
    }
    print(goalId);
      // 조건을 만족하면 SelectDetailGoal 동작 후 페이지 이동
      context.read<SelectDetailGoal>().selectDetailGoal('$goalId');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DPcreateInput2Page(
            firstColor: firstColor,
          ),
        ),
      );
    }
  }
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
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: const Color(0xff929292),
                ),
                margin: const EdgeInsets.all(1.0),
                child: Center(
                    child: AutoSizeText(
                      maxLines: 3, // 최대 줄 수 (필요에 따라 변경 가능)
                        minFontSize: 6, // 최소 글씨 크기
                        overflow: TextOverflow.ellipsis, // 내용이 너무 길 경우 생략 표시
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
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: const Color(0xff5C5C5C),
                ),
                margin: const EdgeInsets.all(1.0),
                child: Center(
                    child: AutoSizeText(
                      maxLines: 3, // 최대 줄 수 (필요에 따라 변경 가능)
                        minFontSize: 6, // 최소 글씨 크기
                        overflow: TextOverflow.ellipsis, // 내용이 너무 길 경우 생략 표시
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
