import 'package:domino/screens/DP/list_page.dart';
import 'package:domino/widgets/DP/color_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/widgets/DP/color_box2.dart';

class DPcreateCompletePage extends StatelessWidget {
  DPcreateCompletePage({super.key});

  final Map colorPalette = {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff262626),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff262626),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Text(
              '플랜 만들기 성공!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(38.0, 20.0, 40.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '새로운 플랜이 만들어졌어요. \n이제 목표를 향해 달려볼까요?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    height: 43,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        shape: BoxShape.rectangle,
                        color: Color(0xffFCFF62)),
                    child: Text(
                        context.watch<SelectFinalGoalModel>().selectedFinalGoal,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ))),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                    child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: [
                    ColorBox(actionPlanId: 0, goalColorId: 0, detailGoalId: 0),
                    ColorBox(actionPlanId: 1, goalColorId: 1, detailGoalId: 1),
                    ColorBox(actionPlanId: 2, goalColorId: 2, detailGoalId: 2),
                    ColorBox(actionPlanId: 3, goalColorId: 3, detailGoalId: 3),
                    SizedBox(
                      width: 100,
                      child: GridView.count(crossAxisCount: 3, children: [
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
                                fontSize: 8,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                        ),
                        const ColorBox2(keyNumber: 5),
                        const ColorBox2(keyNumber: 6),
                        const ColorBox2(keyNumber: 7),
                        const ColorBox2(keyNumber: 8),
                      ]),
                    ),
                    ColorBox(actionPlanId: 5, goalColorId: 5, detailGoalId: 5),
                    ColorBox(actionPlanId: 6, goalColorId: 6, detailGoalId: 6),
                    ColorBox(actionPlanId: 7, goalColorId: 7, detailGoalId: 7),
                    ColorBox(actionPlanId: 8, goalColorId: 8, detailGoalId: 8),
                  ],
                )),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DPlistPage(),
                            ));
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff131313),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0))),
                      child: const Text(
                        '확인',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
