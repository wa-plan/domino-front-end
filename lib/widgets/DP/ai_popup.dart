import 'package:flutter/material.dart';

class AIPopup extends StatelessWidget {
  final List<String> subgoals;
  final VoidCallback onRefresh;

  const AIPopup({
    super.key,
    required this.subgoals,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              ImageIcon(
                AssetImage('assets/img/AI_icon.png'),
                color: Color(0xFF4d00bb),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'AI 세부목표 추천',
                style: TextStyle(
                    color: Color(0xFF4d00bb), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
            color: const Color(0xFF4d00bb),
          )
        ],
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.35,
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AICard(goal: subgoals[0]),
                      AICard(goal: subgoals[1]),
                      AICard(goal: subgoals[2]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AICard(goal: subgoals[3]),
                      AICard(goal: subgoals[4]),
                      AICard(goal: subgoals[5]),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: onRefresh,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                        color: Color(0xFFCFADFF),
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '새로고침하기',
                        style: TextStyle(color: Color(0xFFCFADFF)),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
      actions: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 40,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ButtonStyle(
                backgroundColor:
                    WidgetStateProperty.all(const Color(0xFF4D00BB)),
              ),
              child: const Text(
                '지금 바로 적용하기',
                style: TextStyle(color: Color(0xFFede0ff)),
              ),
            ),
          ),
        ),
      ],
      elevation: 10.0,
      backgroundColor: const Color(0xFFe0cbff),
    );
  }
}

class AICard extends StatefulWidget {
  final String goal;
  const AICard({super.key, required this.goal});

  @override
  AICardState createState() => AICardState();
}

class AICardState extends State<AICard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  color: isChecked
                      ? const Color(0xFF4d00bb)
                      : const Color(0xFFe0cbff),
                  border: Border.all(color: const Color(0xFFCFADFF)),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                widget.goal,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isChecked
                        ? const Color(0xFFEDE0FF)
                        : const Color(0xFF4D00BB),
                    fontSize: 16),
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Icon(
              isChecked
                  ? Icons.circle
                  : Icons.circle_outlined, // 테두리가 있는 체크 아이콘
              color: const Color(0xFFede0ff), // 체크 부분 색상
              size: 18, // 아이콘 크기
            ),
          ),
        ],
      ),
    );
  }
}
