//DP 디테일 페이지에서 이동한 3x3 만다라트 페이지 
import 'package:domino/widgets/DP/mandalart4.dart';
import 'package:domino/widgets/DP/mandalart5.dart';
import 'package:flutter/material.dart';

class DPdetail3Page extends StatelessWidget {
  final String mandalart;
  final int mandalartId; 
  final List<Map<String, dynamic>> secondGoals;
  final int selectedSecondGoal;

  const DPdetail3Page({
    super.key,
    required this.mandalart,
    required this.mandalartId, 
    required this.secondGoals,
    required this.selectedSecondGoal,
  });

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
            '도미노 플랜',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 25.0, 40.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: const Color(0xff5C5C5C),
                      iconSize: 30.0,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                      onPressed: () {
                        Navigator.pop(
                          context
                        );
                      },
                    ),
              ],
            ),
            Text(
              mandalart,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: MandalartGrid5(
                  mandalart: mandalart,
                  secondGoals: secondGoals,
                  selectedSecondGoal: selectedSecondGoal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
