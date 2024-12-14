import 'package:domino/styles.dart';
import 'package:domino/widgets/DP/Detail/Detail_23_mandalart.dart';
import 'package:flutter/material.dart';

class DPdetail2Page extends StatelessWidget {
  final String mandalart;
  final int mandalartId;
  final List<Map<String, dynamic>> secondGoals;
  final int selectedSecondGoal;
  final String firstColor;

  const DPdetail2Page({
    super.key,
    required this.mandalart,
    required this.mandalartId,
    required this.secondGoals,
    required this.selectedSecondGoal,
    required this.firstColor,
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
        backgroundColor: backgroundColor,
      ),
      body: Stack(
        children: [
          // 화면 전체의 클릭 이벤트 감지를 위한 투명 GestureDetector
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // 빈 영역 클릭 시 팝업 닫기
            },
            child: Container(
              color: Colors.transparent, // 투명 배경으로 클릭 이벤트만 전달
            ),
          ),
          Center(
            child: Column(
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
                // MandalartGrid4가 상호작용 가능한 영역
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xff2A2A2A),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  height: 300,
                  width: 300,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        // MandalartGrid4 내부는 아무 동작도 하지 않음
                      },
                      child: MandalartGrid4(
                        mandalart: mandalart,
                        secondGoals: secondGoals,
                        selectedSecondGoal: selectedSecondGoal,
                        firstColor: firstColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
