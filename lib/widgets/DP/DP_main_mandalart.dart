// DP 메인 페이지에 들어가는 만다라트
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';

class MandalartGrid extends StatelessWidget {
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;
  final int mandalartId;
  final String firstColor;

  const MandalartGrid(
      {super.key,
      required this.mandalart,
      required this.secondGoals,
      required this.mandalartId,
      required this.firstColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: 250,
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          children: List.generate(9, (j) {
            if (j == 4) {
              // Middle 3x3 Grid
              return SizedBox(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 0.5,
                  children: [
                    for (int i = 0; i < 9; i++)
                      if (i == 4)
                      //First Goal Grid
                        DPGrid1(mandalart,
                                ColorTransform(firstColor).colorTransform(), 8)
                            .dpGrid1()
                      else
                      //Second Goal Grid
                        DPGrid2(i, mandalart, secondGoals, 8, null).dpGrid2()
                  ],
                ),
              );
            } else {
              // Other 3x3 Grids
              return SizedBox(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.5,
                  mainAxisSpacing: 0.5,
                  children: List.generate(9, (i) {
                    if (i == 4) {
                      //Second Goal Grid
                      return DPGrid2(j, mandalart, secondGoals, 8, null).dpGrid2();
                    } else {
                      //Third Goal Grid
                      return DPGrid3(j, i, mandalart, secondGoals, 8, null)
                          .dpGrid3();
                    }
                  }),
                ),
              );
            }
          }),
        ));
  }
}
