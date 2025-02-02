import 'package:auto_size_text/auto_size_text.dart';
import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/screens/DP/Create/complete_page.dart';
import 'package:domino/screens/DP/dp_main.dart';
import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/color_Grid23.dart';
import 'package:domino/widgets/DP/color_Grid2.dart';
import 'package:domino/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/widgets/DP/color_option.dart';

class DPcreateColorPage extends StatefulWidget {
  final String? mainGoalId;
  final String firstColor;
  const DPcreateColorPage({
    super.key,
    required this.mainGoalId,
    required this.firstColor,
  });

  @override
  DPcreateColorPageState createState() => DPcreateColorPageState();
}

class DPcreateColorPageState extends State<DPcreateColorPage> {
  int selectIndex = 0;
  int selectColorIndex = -1;
  bool isDetailGoalEmpty = false; // 상태 추가
  Map colorPalette = {
    const Color(0xffFF7A7A): const Color(0xffFFC2C2),
    const Color(0xffFFB82D): const Color(0xffFFD19B),
    const Color(0xffFCFF62): const Color(0xffFEFFCD),
    const Color(0xff72FF5B): const Color(0xffC1FFB7),
    const Color(0xff5DD8FF): const Color(0xff94E5FF),
    const Color(0xff929292): const Color(0xffC4C4C4),
    const Color(0xffFF5794): const Color(0xffFF8EB7),
    const Color(0xffAE7CFF): const Color(0xffD0B4FF),
    const Color(0xffC77B7F): const Color(0xffEBB6B9),
    const Color(0xff009255): const Color(0xff6DE1B0),
    const Color(0xff3184FF): const Color(0xff8CBAFF),
    const Color(0xff11D1C2): const Color(0xffAAF4EF),
  };

  Future<bool> _addSecondGoal() async {
    final mandalartId = Provider.of<SelectFinalGoalId>(context, listen: false)
        .selectedFinalGoalId;
    List<String> name =
        Provider.of<SaveInputtedDetailGoalModel>(context, listen: false)
            .inputtedDetailGoal
            .values
            .toList();
    final List<String> color = Provider.of<GoalColor>(context, listen: false)
        .selectedGoalColor
        .values
        .map((color) => color.toString())
        .toList();

    final success = await AddSecondGoalService.addSecondGoal(
      mandalartId: mandalartId,
      name: name,
      color: color,
    );

    return success; // Return success to indicate whether the operation was successful
  }

  Future<bool> _addThirdGoal() async {
    List<int> secondGoalId = [];
    final mandalartId = Provider.of<SelectFinalGoalId>(context, listen: false)
        .selectedFinalGoalId;

    final response =
        await SecondGoalListService.secondGoalList(context, mandalartId);
    if (response != null) {
      for (var secondGoal in response.first["secondGoals"]) {
        secondGoalId.add(secondGoal["id"]);
      }
    }

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

    final success = await AddThirdGoalService.addThirdGoal(
      secondGoalId: secondGoalId,
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
    List<Color> colors = [
      const Color(0xffFF7A7A),
      const Color(0xffFFB82D),
      const Color(0xffFCFF62),
      const Color(0xff72FF5B),
      const Color(0xff5DD8FF),
      const Color(0xff929292),
      const Color(0xffFF5794),
      const Color(0xffAE7CFF),
      const Color(0xffC77B7F),
      const Color(0xff009255),
      const Color(0xff3184FF),
      const Color(0xff11D1C2),
    ];
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: appBarPadding,
            child: Row(
              children: [
                CustomIconButton(() {
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

                    // DP 메인 페이지로 이동
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const DPMain()),
                              );
                  });
                }, Icons.keyboard_arrow_left_rounded)
                    .customIconButton(),
                const SizedBox(width: 10),
                Text(
                  '플랜 만들기',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff515151), // 첫 번째 색상
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      width: 8,
                      height: 8,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff515151), // 첫 번째 색상
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      width: 8,
                      height: 8,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9), // 첫 번째 색상
                        borderRadius: BorderRadius.circular(1.0),
                      ),
                      width: 8,
                      height: 8,
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: backgroundColor,
        ),
        body: Padding(
            padding: fullPadding,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15),
                        const Text(
                          '나만의 스타일로 만다라트를 꾸며요.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
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
                                mainAxisSpacing: 1,
                              ),
                              children: List.generate(9, (index) {
                                if (index == 4) {
                                  return SizedBox(
                                    width: 100,
                                    child: GridView.count(
                                      crossAxisCount: 3,
                                      children: [
                                        const ColorBox2(keyNumber: 0),
                                        const ColorBox2(keyNumber: 1),
                                        const ColorBox2(keyNumber: 2),
                                        const ColorBox2(keyNumber: 3),
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: ColorTransform(
                                                    widget.firstColor)
                                                .colorTransform(),
                                          ),
                                          margin: const EdgeInsets.all(1.0),
                                          child: Center(
                                            child: AutoSizeText(
                                              maxLines: 3,
                                              minFontSize: 6,
                                              overflow: TextOverflow.ellipsis,
                                              context
                                                  .watch<SelectFinalGoalModel>()
                                                  .selectedFinalGoal,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        const ColorBox2(keyNumber: 5),
                                        const ColorBox2(keyNumber: 6),
                                        const ColorBox2(keyNumber: 7),
                                        const ColorBox2(keyNumber: 8),
                                      ],
                                    ),
                                  );
                                }
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectIndex = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: isDetailGoalEmpty
                                          ? Border.all(
                                              color: selectIndex == index
                                                  ? Colors.red
                                                  : backgroundColor,
                                              width: 1,
                                            )
                                          : Border.all(
                                              color: selectIndex == index
                                                  ? const Color.fromARGB(
                                                      255, 125, 125, 125)
                                                  : backgroundColor,
                                              width: 1,
                                            ),
                                      borderRadius:
                                          BorderRadius.circular(3), // 모서리 둥글게
                                    ),
                                    child: ColorBox(
                                      actionPlanId: index,
                                      goalColorId: index,
                                      detailGoalId: index,
                                      onDetailGoalEmpty: (bool isEmpty) {
                                        if (isDetailGoalEmpty) {
                                          setState(() {
                                            isDetailGoalEmpty = true;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: const Color(0xff2A2A2A)),
                              height: 130,
                              width: 350,
                              child: GridView(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                children: List.generate(colors.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.read<GoalColor>().updateGoalColor(
                                          '$selectIndex', colors[index]);
                                      setState(() {
                                        selectColorIndex = index + 1;
                                      });
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: colors[index],
                                          ),
                                        ),
                                        if (selectColorIndex == index + 1)
                                          const Icon(
                                            Icons.check_circle_rounded,
                                            color: Color(0xff303030),
                                            size: 22,
                                          ),
                                      ],
                                    ),
                                  );
                                }),
                              )),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff131313),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0))),
                        child: const Text(
                          '이전',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          // Execute _addSecondGoal and wait for the result
                          final secondGoalSuccess = await _addSecondGoal();

                          // If _addSecondGoal was successful, update the created goals and proceed to _addThirdGoal
                          if (secondGoalSuccess) {
                            // Update the created goal using provider
                            context
                                .read<SaveMandalartCreatedGoal>()
                                .updateMandalartCreatedGoal(
                                    "${widget.mainGoalId}");

                            // Ensure that the update is completed before moving to next goal
                            final thirdGoalSuccess = await _addThirdGoal();

                            // If both goals are added successfully, navigate to DPMain
                            if (thirdGoalSuccess) {
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
                                    builder: (context) => const CompletePage()),
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff131313),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0)),
                        ),
                        child: const Text(
                          '완료',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ]),
              ],
            )));
  }
}
