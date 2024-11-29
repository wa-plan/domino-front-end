import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/input1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class DPcreateInput1Page extends StatefulWidget {
  final String firstColor;
  const DPcreateInput1Page({
    super.key,
    required this.firstColor,
  });

  @override
  State<DPcreateInput1Page> createState() => _DPcreateInput1Page();
}

class _DPcreateInput1Page extends State<DPcreateInput1Page> {
  String Clicked = 'no';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: appBarPadding,
            child: Text(
              '플랜 만들기',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          backgroundColor: backgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: fullPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "목표를 이루기 위한 \n작은 계획들을 세워봐요.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 43,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                        color: Color(int.parse(widget.firstColor
                            .replaceAll('Color(', '')
                            .replaceAll(')', ''))),
                      ),
                      child: Text(
                          context
                              .watch<SelectFinalGoalModel>()
                              .selectedFinalGoal,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xff2A2A2A),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Column(
                      children: [
                        Center(
                            child: SizedBox(
                                height: 300,
                                width: 260,
                                child: GridView(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5),
                                    children: [
                                      const Input1(selectedDetailGoalId: 0),
                                      const Input1(selectedDetailGoalId: 1),
                                      const Input1(selectedDetailGoalId: 2),
                                      const Input1(selectedDetailGoalId: 3),
                                      Container(
                                        width: 80,
                                        margin: const EdgeInsets.all(1.0),
                                        padding: const EdgeInsets.all(7.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          color: Color(int.parse(widget
                                              .firstColor
                                              .replaceAll('Color(', '')
                                              .replaceAll(')', ''))),
                                        ),
                                        child: Center(
                                            child: Text(
                                          context
                                              .watch<SelectFinalGoalModel>()
                                              .selectedFinalGoal,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                      const Input1(selectedDetailGoalId: 5),
                                      const Input1(selectedDetailGoalId: 6),
                                      const Input1(selectedDetailGoalId: 7),
                                      const Input1(selectedDetailGoalId: 8),
                                    ]))),
                        const SizedBox(
                          height: 5,
                        ),
                        const Center(
                            child: Text(
                          '모든 칸을 다 채우지 않아도 괜찮아요:)',
                          style: TextStyle(
                              color: Color.fromARGB(255, 158, 158, 158),
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Button(
                          Colors.black,
                          Colors.white,
                          '취소',
                          () {
                            // TestInputtedDetailGoalModel만 초기화
                            context
                                .read<TestInputtedDetailGoalModel>()
                                .resetDetailGoals();
                            Navigator.pop(context);
                          },
                        ).button(),
                        Button(Colors.black, Colors.white, '저장', () {
                          // 현재 context를 통해 두 모델에 접근
                          final testModel =
                              context.read<TestInputtedDetailGoalModel>();
                          final saveModel =
                              context.read<SaveInputtedDetailGoalModel>();
                          print(
                              'Test Model: ${testModel.testinputtedDetailGoal}');
                          // TestInputtedDetailGoalModel의 데이터를 SaveInputtedDetailGoalModel로 복사
                          testModel.testinputtedDetailGoal
                              .forEach((key, value) {
                            saveModel.updateDetailGoal(
                                key, value); // Save 모델에 값 저장
                          });
                          print(
                              'Updated Save Model: ${saveModel.inputtedDetailGoal}');

                          Navigator.pop(context);
                        }).button()
                      ])
                ],
              )),
        ));
  }
}
