import 'package:domino/styles.dart';
import 'package:flutter/material.dart';

class SMART {
  Widget smart() {
    return const ExpansionTile(
      backgroundColor: Color(0xff2A2A2A),
      collapsedBackgroundColor: Color(0xff2A2A2A),
      childrenPadding: EdgeInsets.fromLTRB(30, 0, 30, 20),
      tilePadding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      iconColor: Colors.white,
      collapsedIconColor: Colors.white,
      shape: Border(),
      title: Text(
        'SMART 기법을 참고해보세요!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Row(
          children: [
            Text(
              'Specific',
              style: TextStyle(
                color: mainGold,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '명확하고 구체적인 목표.',
              style: TextStyle(
                color: Color.fromARGB(255, 146, 146, 146),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              'Measurable',
              style: TextStyle(
                color: mainGold,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              ' 정량화되고 측정 가능한 목표.',
              style: TextStyle(
                color: Color(0xff929292),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              'Attainable',
              style: TextStyle(
                color: mainGold,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '달성 가능한 목표.',
              style: TextStyle(
                color: Color.fromARGB(255, 146, 146, 146),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              'Realistic',
              style: TextStyle(
                color: mainGold,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '현실적인 목표.',
              style: TextStyle(
                color: Color.fromARGB(255, 146, 146, 146),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              'Timely',
              style: TextStyle(
                color: mainGold,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '마감기한이 있는 목표.',
              style: TextStyle(
                color: Color.fromARGB(255, 146, 146, 146),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
