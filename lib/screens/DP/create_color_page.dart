import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/screens/DP/dp_main.dart';
import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/color_box.dart';
import 'package:domino/widgets/DP/color_box2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/widgets/DP/color_option.dart';

class DPcreateColorPage extends StatefulWidget {
  final String? mainGoalId;
   const DPcreateColorPage({super.key, required this.mainGoalId});

  @override
  DPcreateColorPageState createState() => DPcreateColorPageState();
}

class DPcreateColorPageState extends State<DPcreateColorPage> {
  int selectIndex = 0;
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
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          title: Padding(
            padding: appBarPadding,
            child: Text(
              '플랜 만들기',
              style:Theme.of(context).textTheme.titleLarge,
            ),
          ),
          backgroundColor: backgroundColor,
        ),
        body: Padding(
            padding: fullPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '다양한 색으로\n플랜을 꾸밀 수 있어요.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                /*const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 43,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        shape: BoxShape.rectangle,
                        color: const Color(0xffFCFF62)),
                    child: Text(
                        context.watch<SelectFinalGoalModel>().selectedFinalGoal,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ))),*/
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                      height: 290,
                      width: 290,
                      padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xff2A2A2A),
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
                                      border: Border.all(
                                          color: selectIndex == 0
                                              ? Colors.white
                                              : const Color(0xff2A2A2A))),
                                  child: ColorBox(
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
                                      border: Border.all(
                                          color: selectIndex == 1
                                              ? Colors.white
                                              : const Color(0xff2A2A2A))),
                                  child: ColorBox(
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
                                      border: Border.all(
                                          color: selectIndex == 2
                                              ? Colors.white
                                              : const Color(0xff2A2A2A))),
                                  child: ColorBox(
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
                                      border: Border.all(
                                          color: selectIndex == 3
                                              ? Colors.white
                                              : const Color(0xff2A2A2A))),
                                  child: ColorBox(
                                      actionPlanId: 3,
                                      goalColorId: 3,
                                      detailGoalId: 3))),
                          SizedBox(
                            width: 100,
                            child: GridView.count(
                              crossAxisCount: 3,
                              children: [
                                const ColorBox2(keyNumber: 0),
                                const ColorBox2(keyNumber: 1),
                                const ColorBox2(keyNumber: 2),
                                const ColorBox2(keyNumber: 3),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: const Color(0xffFCFF62),
                                  ),
                                  margin: const EdgeInsets.all(1.0),
                                  child: Center(
                                      child: Text(
                                    context
                                        .watch<SelectFinalGoalModel>()
                                        .selectedFinalGoal,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                                ),
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
                                      border: Border.all(
                                          color: selectIndex == 5
                                              ? Colors.white
                                              : const Color(0xff2A2A2A))),
                                  child: ColorBox(
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
                                      border: Border.all(
                                          color: selectIndex == 6
                                              ? Colors.white
                                              : const Color(0xff2A2A2A))),
                                  child: ColorBox(
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
                                      border: Border.all(
                                          color: selectIndex == 7
                                              ? Colors.white
                                              : const Color(0xff2A2A2A))),
                                  child: ColorBox(
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
                                      border: Border.all(
                                          color: selectIndex == 8
                                              ? Colors.white
                                              : const Color(0xff2A2A2A))),
                                  child: ColorBox(
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
                                  mainAxisSpacing: 11,
                                  ),
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
                    const SizedBox(height: 20),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [
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
                      context.read<SaveMandalartCreatedGoal>().updateMandalartCreatedGoal("${widget.mainGoalId}");
                      

                      // If _addSecondGoal was successful, proceed to _addThirdGoal
                      if (secondGoalSuccess) {
                        final thirdGoalSuccess = await _addThirdGoal();

                        // If both are successful, navigate to DPlistPage
                        if (thirdGoalSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DPMain()),
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
                  ),]
                ),
                
              ],
            )));
  }
}
