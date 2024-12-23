import 'package:domino/screens/MG/mygoal_goal_detail.dart';
import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GoalCard extends StatelessWidget {
  final String mandalartId;
  final String name;
  final String status;
  final List<String> photoList;
  final String dday;
  final String color;
  final int successNum;
  final bool bookmark;
  final Function(String id, String action) onBookmarkToggle;

  const GoalCard(
      {super.key,
      required this.mandalartId,
      required this.name,
      required this.status,
      required this.photoList,
      required this.dday,
      required this.color,
      required this.successNum,
      required this.bookmark,
      required this.onBookmarkToggle});

  @override
  Widget build(BuildContext context) {
    final colorValue =
        int.parse(color.replaceAll('Color(', '').replaceAll(')', ''));
    int ddayParsed = int.parse(dday);
    final List<Color> colors = _getColorsByCondition(Color(colorValue));

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyGoalDetail(
              id: mandalartId,
              name: name,
              status: status,
              photoList: photoList,
              dday: ddayParsed,
              color: color,
              colorValue: colorValue,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => onBookmarkToggle(
                        mandalartId,
                        bookmark ? "UNBOOKMARK" : "BOOKMARK",
                      ),
                      child: Icon(
                        Icons.star,
                        color: bookmark
                            ? mainGold
                            : const Color.fromARGB(255, 62, 62, 62),
                        size: 23,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: Color(colorValue).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: Color(colorValue), width: 0.5), // 테두리 색상
                    ),
                    child:  Text(
                      ddayParsed < 0 ? 'D+${ddayParsed * -1}' : 'D-$ddayParsed',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 194, 194, 194),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),),
                  
                    
                  ],
                ),
                const SizedBox(height: 10),
                if (photoList.isEmpty)
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff303030),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    width: 250,
                    height: 85,
                    child: const Center(
                      child: Text(
                        '이미지를 추가해 주세요',
                        style: TextStyle(color: Color(0xff979797)),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: 250,
                    height: 85,
                    child: CarouselSlider.builder(
                      itemCount: photoList.length.clamp(1, 3),
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        );
                      },
                      options: CarouselOptions(
                        height: 85,
                        autoPlay: true,
                        viewportFraction: photoList.length == 1 ? 1.0 : 0.9,
                        enlargeCenterPage: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Column(
                      children: [
                        const Text(
                          '나의 도미노',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 12),
                        ),
                        Text(
                          '$successNum개',
                          style: const TextStyle(
                            color: Color(0xffFCFF62),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 41),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 6,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff5DD8FF),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          width: 13,
                          height: 6,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff72FF5B),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          width: 13,
                          height: 15,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFCFF62),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          width: 13,
                          height: 25,
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffFFAC2F),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          width: 13,
                          height: 33,
                        ),
                      ],
                    )
],
                ),
              ],
            ),
            const SizedBox(width: 18),
            Container(
              decoration: BoxDecoration(
                color: Color(colorValue),
                borderRadius: BorderRadius.circular(2.0),
              ),
              width: 13,
              height: 172,
            ),
          ],
        ),
      ),
    );
  }
  /// 조건에 따라 색상 배열 반환
  List<Color> _getColorsByCondition(Color colorValue) {
    if (colorValue == const Color(0xffFF7A7A)) {
      return const [
        Color(0xff5DD8FF), // 파랑
        Color(0xff72FF5B), // 초록
        Color(0xffFCFF62), // 노랑
        Color(0xffFFAC2F), // 주황
      ];
    } else if (colorValue == const Color(0xffFFAC2F)) {
      return const [
        Color(0xffFF7A7A),        // 빨강
        Color(0xff5DD8FF), // 파랑
        Color(0xff72FF5B),
        Color(0xffFCFF62), 
      ];
    } else if (colorValue == const Color(0xffFCFF62) || colorValue == Colors.white) {
      return const [
        Color(0xffFF7A7A), // 빨강
        Color(0xffFFAC2F), // 주황
        Color(0xff72FF5B), // 초록
        Color(0xff5DD8FF), // 파랑
      ];
    } else if (colorValue == const Color(0xff5DD8FF)) {
      return const [
        Color(0xffFF7A7A),          // 빨강
        Color(0xffFFAC2F), // 주황
        Color(0xffFCFF62),
        Color(0xff72FF5B), // 초록
      ];
    } else if (colorValue == const Color(0xff72FF5B)) {
      return const [
        Color(0xffFF7A7A),          // 빨강
        Color(0xffFFAC2F), // 주황
        Color(0xffFCFF62),
        Color(0xff5DD8FF), // 초록
      ];
    } else {
    // Default case if no other conditions match
    return [
      const Color(0xffFFFFFF), // white
    ];
  }
   
  }
}

