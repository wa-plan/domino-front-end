import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/screens/DP/list_page.dart';
import 'package:domino/widgets/DP/mandalart4.dart';
import 'package:flutter/material.dart';
import 'package:domino/widgets/DP/mandalart.dart';

class DPdetail2Page extends StatelessWidget {
  final String mandalart;
  final int mandalartId; // Add mandalartId to handle deletion
  final List<Map<String, dynamic>> secondGoals;
  final int selectedSecondGoal;

  const DPdetail2Page({
    super.key,
    required this.mandalart,
    required this.mandalartId, // Receive mandalartId from previous screen
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
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              mandalart,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: MandalartGrid4(
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
