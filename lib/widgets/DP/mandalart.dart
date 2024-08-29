// mandalart.dart
import 'package:flutter/material.dart';

class MandalartGrid extends StatelessWidget {
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;

  // 필요한 데이터를 인자로 받아 위젯 생성
  const MandalartGrid({
    super.key,
    required this.mandalart,
    required this.secondGoals,
  });

  // 각 그리드 아이템을 생성하는 함수
  Widget buildGrid(int secondGoalIndex, String type) {
    return SizedBox(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
        ),
        itemCount: 9,
        itemBuilder: (context, gridIndex) {
          if (gridIndex == 4) {
            // Center of the grid
            return Container(
              decoration: BoxDecoration(
                color: type == 'mandalart'
                    ? Colors.yellow
                    : const Color(0xff929292),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  type == 'mandalart'
                      ? mandalart
                      : secondGoals[secondGoalIndex]['secondGoal'],
                  style: const TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            final adjustedIndex = gridIndex < 4 ? gridIndex : gridIndex - 1;
            if (adjustedIndex < secondGoals.length) {
              final secondGoalData = secondGoals[secondGoalIndex];
              final thirdGoals = (secondGoalData['thirdGoals'] as List?) ?? [];

              if (type == 'mandalart') {
                if (adjustedIndex < secondGoals.length) {
                  final secondGoal =
                      secondGoals[adjustedIndex]['secondGoal'];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff929292),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(
                        secondGoal,
                        style: const TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff929292),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }
              } else {
                // Filter out empty third goals
                final validThirdGoals = thirdGoals
                    .where((goal) =>
                        goal['thirdGoal'] != null &&
                        goal['thirdGoal'].isNotEmpty)
                    .toList();

                if (adjustedIndex < validThirdGoals.length) {
                  final thirdGoal =
                      validThirdGoals[adjustedIndex]['thirdGoal'];
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff5C5C5C),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Center(
                      child: Text(
                        thirdGoal,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff262626),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }
              }
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xff262626),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      children: [
        buildGrid(0, 'secondGoal'),
        buildGrid(1, 'secondGoal'),
        buildGrid(2, 'secondGoal'),
        buildGrid(3, 'secondGoal'),
        buildGrid(4, 'mandalart'),
        buildGrid(5, 'secondGoal'),
        buildGrid(6, 'secondGoal'),
        buildGrid(7, 'secondGoal'),
        buildGrid(8, 'secondGoal'),
      ],
    );
  }
}
