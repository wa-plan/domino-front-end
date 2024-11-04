//DP 디테일 페이지에서 이동한 3x3 만다라트 페이지 
import 'package:domino/styles.dart';
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        title: Padding(
          padding: appBarPadding,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                color: const Color(0xffD4D4D4),
                iconSize: 17,
              ),
              Text(
                '도미노 플랜',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor
      ),
      body: Padding(
        padding: fullPadding,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              
              Text(
                mandalart,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 25),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xff2A2A2A),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  height: 300,
                  width: 300,
                  child:Center(
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
      ),
    );
  }
}
