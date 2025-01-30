import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/screens/DP/dp_main.dart';
import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/color_Grid23.dart';
import 'package:domino/widgets/DP/color_Grid2.dart';
import 'package:domino/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/widgets/DP/color_option.dart';

class EditColorPage extends StatefulWidget {
  final String mandalart;
  final String firstColor;

  const EditColorPage(
      {super.key, required this.firstColor, required this.mandalart});

  @override
  EditColorPageState createState() => EditColorPageState();
}

class EditColorPageState extends State<EditColorPage> {
  int selectIndex = 0;

  Future<bool> _editSecondGoal() async {
    List<int> secondGoalId =
        Provider.of<SaveEditedDetailGoalIdModel>(context, listen: false)
            .editedDetailGoalId
            .values
            .toList();
    List<String> newSecondGoal =
        Provider.of<SaveInputtedDetailGoalModel>(context, listen: false)
            .inputtedDetailGoal
            .values
            .toList();

    final success = await EditSecondGoalService.editSecondGoal(
      secondGoalId: secondGoalId,
      newSecondGoal: newSecondGoal,
    );

    return success; // Return success to indicate whether the operation was successful
  }

  Future<bool> _editColor() async {
    final List<String> color = Provider.of<GoalColor>(context, listen: false)
        .selectedGoalColor
        .values
        .map((color) => color.toString())
        .toList();

    List<int> secondGoalId =
        Provider.of<SaveEditedDetailGoalIdModel>(context, listen: false)
            .editedDetailGoalId
            .values
            .toList();

    final success = await EditGoalColorService.editGoalColor(
      secondGoalId: secondGoalId,
      color: color,
    );

    return success; // Return success to indicate whether the operation was successful
  }

  Future<bool> _editThirdGoal() async {
    //제3목표 id 가져오기

    final third0id =
        Provider.of<SaveEditedActionPlanIdModel>(context, listen: false)
            .editedActionPlanId[0]
            .values
            .toList();

    final third1id =
        Provider.of<SaveEditedActionPlanIdModel>(context, listen: false)
            .editedActionPlanId[1]
            .values
            .toList();

    final third2id =
        Provider.of<SaveEditedActionPlanIdModel>(context, listen: false)
            .editedActionPlanId[2]
            .values
            .toList();

    final third3id =
        Provider.of<SaveEditedActionPlanIdModel>(context, listen: false)
            .editedActionPlanId[3]
            .values
            .toList();

    final third4id =
        Provider.of<SaveEditedActionPlanIdModel>(context, listen: false)
            .editedActionPlanId[4]
            .values
            .toList();

    final third5id =
        Provider.of<SaveEditedActionPlanIdModel>(context, listen: false)
            .editedActionPlanId[5]
            .values
            .toList();

    final third6id =
        Provider.of<SaveEditedActionPlanIdModel>(context, listen: false)
            .editedActionPlanId[6]
            .values
            .toList();

    final third7id =
        Provider.of<SaveEditedActionPlanIdModel>(context, listen: false)
            .editedActionPlanId[7]
            .values
            .toList();

    final third8id =
        Provider.of<SaveEditedActionPlanIdModel>(context, listen: false)
            .editedActionPlanId[8]
            .values
            .toList();

    //제3목표 가져오기

    final third0 =
        Provider.of<SaveInputtedActionPlanModel>(context, listen: false)
            .inputtedActionPlan[0]
            .values
            .toList();
    final third1 =
        Provider.of<SaveInputtedActionPlanModel>(context, listen: false)
            .inputtedActionPlan[1]
            .values
            .toList();
    final third2 =
        Provider.of<SaveInputtedActionPlanModel>(context, listen: false)
            .inputtedActionPlan[2]
            .values
            .toList();
    final third3 =
        Provider.of<SaveInputtedActionPlanModel>(context, listen: false)
            .inputtedActionPlan[3]
            .values
            .toList();
    final third4 =
        Provider.of<SaveInputtedActionPlanModel>(context, listen: false)
            .inputtedActionPlan[4]
            .values
            .toList();
    final third5 =
        Provider.of<SaveInputtedActionPlanModel>(context, listen: false)
            .inputtedActionPlan[5]
            .values
            .toList();
    final third6 =
        Provider.of<SaveInputtedActionPlanModel>(context, listen: false)
            .inputtedActionPlan[6]
            .values
            .toList();
    final third7 =
        Provider.of<SaveInputtedActionPlanModel>(context, listen: false)
            .inputtedActionPlan[7]
            .values
            .toList();
    final third8 =
        Provider.of<SaveInputtedActionPlanModel>(context, listen: false)
            .inputtedActionPlan[8]
            .values
            .toList();

    final success = await EditThirdGoalService.editThirdGoal(
      third0id: third0id,
      third1id: third1id,
      third2id: third2id,
      third3id: third3id,
      third4id: third4id,
      third5id: third5id,
      third6id: third6id,
      third7id: third7id,
      third8id: third8id,
      third0: third0,
      third1: third1,
      third2: third2,
      third3: third3,
      third4: third4,
      third5: third5,
      third6: third6,
      third7: third7,
      third8: third8,
    );

    return success; // Return success to indicate whether the operation was successful
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: appBarPadding,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    PopupDialog.show(
                        context,
                        '지금 나가면,\n작성한 내용이 사라져!',
                        true, // cancel
                        false, // delete
                        false, // signout
                        true, //success
                        onCancel: () {
                      // 취소 버튼을 눌렀을 때 실행할 코드
                      Navigator.pop(context);
                    }, onSuccess: () async {
                      for (int i = 0; i < 9; i++) {
                        context
                            .read<SaveInputtedDetailGoalModel>()
                            .updateDetailGoal(i.toString(), "");
                      }

                      for (int i = 0; i < 9; i++) {
                        context
                            .read<TestInputtedDetailGoalModel>()
                            .updateTestDetailGoal(i.toString(), "");
                      }

                      for (int i = 0; i < 9; i++) {
                        context.read<GoalColor>().updateGoalColor(
                            i.toString(), const Color(0xff929292));
                      }

                      for (int i = 0; i < 9; i++) {
                        for (int j = 0; j < 9; j++) {
                          context
                              .read<SaveInputtedActionPlanModel>()
                              .updateActionPlan(i, j.toString(), "");
                        }
                      }

                      for (int i = 0; i < 9; i++) {
                        for (int j = 0; j < 9; j++) {
                          context
                              .read<TestInputtedActionPlanModel>()
                              .updateTestActionPlan(i, j.toString(), "");
                        }
                      }

                      // 팝업 닫기
                      Navigator.pop(context);

                      // 이전 페이지로 이동
                      Navigator.pop(context);

                      Navigator.pop(context);
                    });
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color(0xffD4D4D4),
                    size: 17,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '플랜 수정하기',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          backgroundColor: backgroundColor,
        ),
        body: Padding(
            padding: fullPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '다양한 색으로\n플랜을 꾸밀 수 있어요.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                      height: 290,
                      width: 290,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1),
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 0;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: selectIndex == 0
                                              ? const Color.fromARGB(
                                                  255, 182, 182, 182)
                                              : const Color(0xff222222))),
                                  child: const ColorBox(
                                      actionPlanId: 0,
                                      goalColorId: 0,
                                      detailGoalId: 0))),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 1;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: selectIndex == 1
                                              ? const Color.fromARGB(
                                                  255, 182, 182, 182)
                                              : const Color(0xff222222))),
                                  child: const ColorBox(
                                      actionPlanId: 1,
                                      goalColorId: 1,
                                      detailGoalId: 1))),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 2;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: selectIndex == 2
                                              ? const Color.fromARGB(
                                                  255, 182, 182, 182)
                                              : const Color(0xff222222))),
                                  child: const ColorBox(
                                      actionPlanId: 2,
                                      goalColorId: 2,
                                      detailGoalId: 2))),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 3;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: selectIndex == 3
                                              ? const Color.fromARGB(
                                                  255, 182, 182, 182)
                                              : const Color(0xff222222))),
                                  child: const ColorBox(
                                      actionPlanId: 3,
                                      goalColorId: 3,
                                      detailGoalId: 3))),
                          SizedBox(
                            width: 100,
                            child: GridView.count(
                              crossAxisCount: 3,
                              crossAxisSpacing: 0.5,
                              mainAxisSpacing: 0.5,
                              children: [
                                const ColorBox2(keyNumber: 0),
                                const ColorBox2(keyNumber: 1),
                                const ColorBox2(keyNumber: 2),
                                const ColorBox2(keyNumber: 3),
                                DPGrid1(
                                  widget.mandalart,
                                  ColorTransform(widget.firstColor).colorTransform(), 8).dpGrid1(),
                                const ColorBox2(keyNumber: 5),
                                const ColorBox2(keyNumber: 6),
                                const ColorBox2(keyNumber: 7),
                                const ColorBox2(keyNumber: 8),
                              ],
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 5;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: selectIndex == 5
                                              ? const Color.fromARGB(
                                                  255, 182, 182, 182)
                                              : const Color(0xff222222))),
                                  child: const ColorBox(
                                      actionPlanId: 5,
                                      goalColorId: 5,
                                      detailGoalId: 5))),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 6;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: selectIndex == 6
                                              ? const Color.fromARGB(
                                                  255, 182, 182, 182)
                                              : const Color(0xff222222))),
                                  child: const ColorBox(
                                      actionPlanId: 6,
                                      goalColorId: 6,
                                      detailGoalId: 6))),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 7;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: selectIndex == 7
                                              ? const Color.fromARGB(
                                                  255, 182, 182, 182)
                                              : const Color(0xff222222))),
                                  child: const ColorBox(
                                      actionPlanId: 7,
                                      goalColorId: 7,
                                      detailGoalId: 7))),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectIndex = 8;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color: selectIndex == 8
                                              ? const Color.fromARGB(
                                                  255, 182, 182, 182)
                                              : const Color(0xff222222))),
                                  child: const ColorBox(
                                      actionPlanId: 8,
                                      goalColorId: 8,
                                      detailGoalId: 8))),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      height: 120,
                      width: 330,
                      child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  crossAxisSpacing: 11,
                                  mainAxisSpacing: 11),
                          children: [
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xffFF7A7A)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xffFFB82D)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xffFCFF62)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xff72FF5B)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xff5DD8FF)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xff929292)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xffFF5794)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xffAE7CFF)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xffC77B7F)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xff009255)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xff3184FF)),
                            ColorOption(
                                selectIndex: selectIndex,
                                colorCode: const Color(0xff11D1C2))
                          ])),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        Colors.black,
                        Colors.white,
                        '이전',
                        () {
                          Navigator.pop(context);
                        },
                      ).button(),

                      Button(Colors.black, Colors.white, '완료', () async {
                        // Execute _addSecondGoal and wait for the result
                        final secondGoalSuccess = await _editSecondGoal();

                        // If _addSecondGoal was successful, proceed to _addThirdGoal
                        /*if (secondGoalSuccess) {
                        final thirdGoalSuccess = await _editThirdGoal();*/

                        if (secondGoalSuccess) {
                          print('제2목표 저장 성공');
                          final goalColorSuccess = await _editColor();

                          if (goalColorSuccess) {
                            final thirdGoalSuccess = await _editThirdGoal();

                            // If both are successful, navigate to DPlistPage
                            if (thirdGoalSuccess) {
                              print('제3목표 저장 성공');
                              for (int i = 0; i < 9; i++) {
                                context
                                    .read<SaveInputtedDetailGoalModel>()
                                    .updateDetailGoal(i.toString(), "");
                              }

                              for (int i = 0; i < 9; i++) {
                                context.read<GoalColor>().updateGoalColor(
                                    i.toString(), const Color(0xff929292));
                              }

                              for (int i = 0; i < 9; i++) {
                                for (int j = 0; j < 9; j++) {
                                  context
                                      .read<SaveInputtedActionPlanModel>()
                                      .updateActionPlan(i, j.toString(), "");
                                }
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DPMain()),
                              );
                            }
                          }
                        }
                      }).button(),
                    ]),
                
              ],
            )));
  }
}
