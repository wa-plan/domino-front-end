import 'package:domino/apis/services/dp_services.dart';
import 'package:domino/screens/DP/list_page.dart';
import 'package:flutter/material.dart';
import 'package:domino/widgets/DP/mandalart.dart';

class DPdetailPage extends StatelessWidget {
  final String mandalart;
  final int mandalartId; // Add mandalartId to handle deletion
  final List<Map<String, dynamic>> secondGoals;

  const DPdetailPage({
    super.key,
    required this.mandalart,
    required this.mandalartId, // Receive mandalartId from previous screen
    required this.secondGoals,
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
            PopupMenuButton(
              iconColor: const Color(0xff5C5C5C),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 'delete', // Changed 'edit' to 'delete' for clarity
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '삭제하기',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'edit',
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '수정하기',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ];
              },
              onSelected: (value) async {
                switch (value) {
                  case 'delete':
                    // Call the delete function
                    bool isDeleted = await DeleteMandalartService.deleteMandalart(
                      context,
                      mandalartId,
                    );
                    if (isDeleted) {
                      // If delete is successful, navigate back or refresh the UI
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DPlistPage(),
                              ),
                            ); // Navigate back after deletion
                    }
                    break;
                  case 'edit':
                    print('수정하기'); // Implement edit functionality here
                    break;
                }
              },
            ),
            const SizedBox(height: 20),
            Text(
              mandalart,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: MandalartGrid(
                  mandalart: mandalart,
                  secondGoals: secondGoals,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
