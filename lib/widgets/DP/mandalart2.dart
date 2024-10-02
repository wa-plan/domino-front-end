// mandalart.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class MandalartGrid2 extends StatefulWidget {
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;

  const MandalartGrid2({
    super.key,
    required this.mandalart,
    required this.secondGoals,
  });

  @override
  State<MandalartGrid2> createState() => _MandalartGrid2();
}

class _MandalartGrid2 extends State<MandalartGrid2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: [
          SizedBox(
              width: 100,
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int i = 0; i < 4; i++)
                      MandalartBox2(
                          hintNum2: 0,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                    MandalartBox1(
                        hintNum: 0,
                        mandalart: widget.mandalart,
                        secondGoals: widget.secondGoals),
                    for (int i = 4; i < 8; i++)
                      MandalartBox2(
                          hintNum2: 0,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                  ])),
          SizedBox(
              width: 100,
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int i = 0; i < 4; i++)
                      MandalartBox2(
                          hintNum2: 1,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                    MandalartBox1(
                        hintNum: 1,
                        mandalart: widget.mandalart,
                        secondGoals: widget.secondGoals),
                    for (int i = 4; i < 8; i++)
                      MandalartBox2(
                          hintNum2: 1,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                  ])),
          SizedBox(
              width: 100,
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int i = 0; i < 4; i++)
                      MandalartBox2(
                          hintNum2: 2,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                    MandalartBox1(
                        hintNum: 2,
                        mandalart: widget.mandalart,
                        secondGoals: widget.secondGoals),
                    for (int i = 4; i < 8; i++)
                      MandalartBox2(
                          hintNum2: 2,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                  ])),
          SizedBox(
              width: 100,
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int i = 0; i < 4; i++)
                      MandalartBox2(
                          hintNum2: 3,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                    MandalartBox1(
                        hintNum: 3,
                        mandalart: widget.mandalart,
                        secondGoals: widget.secondGoals),
                    for (int i = 4; i < 8; i++)
                      MandalartBox2(
                          hintNum2: 3,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                  ])),
          SizedBox(
            width: 100,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                for (int i = 0; i < 4; i++)
                  MandalartBox1(
                      hintNum: i,
                      mandalart: widget.mandalart,
                      secondGoals: widget.secondGoals),
                Container(
                    margin: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.yellow,
                    ),
                    child: Center(
                      child: Text(
                        widget.mandalart,
                        textAlign: TextAlign.center,
                      ),
                    )),
                for (int i = 5; i < 9; i++)
                  MandalartBox1(
                      hintNum: i,
                      mandalart: widget.mandalart,
                      secondGoals: widget.secondGoals),
              ],
            ),
          ),
          SizedBox(
              width: 100,
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int i = 0; i < 4; i++)
                      MandalartBox2(
                          hintNum2: 5,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                    MandalartBox1(
                        hintNum: 5,
                        mandalart: widget.mandalart,
                        secondGoals: widget.secondGoals),
                    for (int i = 4; i < 8; i++)
                      MandalartBox2(
                          hintNum2: 5,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                  ])),
          SizedBox(
              width: 100,
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int i = 0; i < 4; i++)
                      MandalartBox2(
                          hintNum2: 6,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                    MandalartBox1(
                        hintNum: 6,
                        mandalart: widget.mandalart,
                        secondGoals: widget.secondGoals),
                    for (int i = 4; i < 8; i++)
                      MandalartBox2(
                          hintNum2: 6,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                  ])),
          SizedBox(
              width: 100,
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int i = 0; i < 4; i++)
                      MandalartBox2(
                          hintNum2: 7,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                    MandalartBox1(
                        hintNum: 7,
                        mandalart: widget.mandalart,
                        secondGoals: widget.secondGoals),
                    for (int i = 4; i < 8; i++)
                      MandalartBox2(
                          hintNum2: 7,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                  ])),
          SizedBox(
              width: 100,
              child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  children: [
                    for (int i = 0; i < 4; i++)
                      MandalartBox2(
                          hintNum2: 8,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                    MandalartBox1(
                        hintNum: 8,
                        mandalart: widget.mandalart,
                        secondGoals: widget.secondGoals),
                    for (int i = 4; i < 8; i++)
                      MandalartBox2(
                          hintNum2: 8,
                          hintNum3: i,
                          mandalart: widget.mandalart,
                          secondGoals: widget.secondGoals),
                  ])),
        ],
      ),
    );
  }
}

//제2목표 박스
class MandalartBox1 extends StatefulWidget {
  final int hintNum;
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;

  const MandalartBox1(
      {super.key,
      required this.hintNum,
      required this.mandalart,
      required this.secondGoals});

  @override
  State<MandalartBox1> createState() => _MandalartBox1State();
}

class _MandalartBox1State extends State<MandalartBox1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: widget.secondGoals.isNotEmpty &&
                  widget.secondGoals[widget.hintNum]['secondGoal'] != ""
              ? Color(int.parse(widget.secondGoals[widget.hintNum]['color']
                  .replaceAll('Color(', '')
                  .replaceAll(')', '')))
              : Colors.transparent,
        ),
        child: Center(
          child: Text(
            widget.secondGoals.isNotEmpty &&
                    widget.secondGoals[widget.hintNum]['secondGoal'] != ""
                ? widget.secondGoals[widget.hintNum]['secondGoal']
                : "",
            textAlign: TextAlign.center,
          ),
        ));
  }
}

//제3목표 박스
class MandalartBox2 extends StatefulWidget {
  final int hintNum2;
  final int hintNum3;
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;
  final Map<Color, Color> colorPalette = {
    const Color(0xffFF7A7A): const Color(0xffFFC2C2),
    const Color(0xffFFB82D): const Color(0xffFFD19B),
    const Color(0xffFCFF62): const Color(0xffFEFFCD),
    const Color(0xff72FF5B): const Color(0xffC1FFB7),
    const Color(0xff5DD8FF): const Color(0xff94E5FF),
    const Color(0xff929292): Colors.transparent,
    const Color(0xffFF5794): const Color(0xffFF8EB7),
    const Color(0xffAE7CFF): const Color(0xffD0B4FF),
    const Color(0xffC77B7F): const Color(0xffEBB6B9),
    const Color(0xff009255): const Color(0xff6DE1B0),
    const Color(0xff3184FF): const Color(0xff8CBAFF),
    const Color(0xff11D1C2): const Color(0xffAAF4EF),
  };

  MandalartBox2(
      {super.key,
      required this.hintNum2,
      required this.hintNum3,
      required this.mandalart,
      required this.secondGoals});

  @override
  State<MandalartBox2> createState() => _MandalartBox2State();
}

class _MandalartBox2State extends State<MandalartBox2> {
  @override
  Widget build(BuildContext context) {
    final color = widget.secondGoals.isNotEmpty &&
            widget.secondGoals[widget.hintNum2]['thirdGoals']
                .asMap()
                .containsKey(widget.hintNum3)
        ? Color(int.parse(widget.secondGoals[widget.hintNum2]['color']
            .replaceAll('Color(', '')
            .replaceAll(')', '')))
        : Colors.transparent;

    return GestureDetector(
        onTap: () {
          setState(() {
            widget.secondGoals[widget.hintNum2]['thirdGoals'].isNotEmpty &&
                    widget.secondGoals[widget.hintNum2]['thirdGoals']
                        .asMap()
                        .containsKey(widget.hintNum3) &&
                    widget.secondGoals[widget.hintNum2]['thirdGoals']
                            [widget.hintNum3]['thirdGoal'] !=
                        ""
                ? context.read<SelectAPModel>().selectAP(
                    widget.secondGoals[widget.hintNum2]['thirdGoals']
                        [widget.hintNum3]['thirdGoal'],
                    widget.secondGoals[widget.hintNum2]['thirdGoals']
                        [widget.hintNum3]['id'])
                : context.read<SelectAPModel>().selectAP("NA Name", null);
          });
        },
        child: Container(
            margin: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: widget.colorPalette[color]),
            child: Center(
              child: Text(
                widget.secondGoals.isNotEmpty &&
                        widget.secondGoals[widget.hintNum2]['thirdGoals']
                            .isNotEmpty &&
                        widget.secondGoals[widget.hintNum2]['thirdGoals']
                            .asMap()
                            .containsKey(widget.hintNum3)
                    ? widget.secondGoals[widget.hintNum2]['thirdGoals']
                        [widget.hintNum3]['thirdGoal']
                    : "",
                textAlign: TextAlign.center,
              ),
            )));
  }
}
