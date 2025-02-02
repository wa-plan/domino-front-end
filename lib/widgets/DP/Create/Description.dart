import 'package:domino/styles.dart';
import 'package:flutter/material.dart';

class Description {
  final String color;

  Description(this.color);

  Widget description() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: ExpansionTile(
        backgroundColor: const Color(0xff2A2A2A),
        collapsedBackgroundColor: const Color(0xff2A2A2A),
        childrenPadding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
        tilePadding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        iconColor: const Color(0xffAAAAAA),
        collapsedIconColor: const Color(0xffAAAAAA),
        shape: const Border(
      ),
        title:  const Text(
          '만다라트 작성 꿀팁',
          style: TextStyle(
            color: Color(0xffAAAAAA),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        children: [
          Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: ColorTransform(color).colorTransform()),
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                '제1목표 ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                '이루고자 하는 최종목표에요',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: const Color(0xff929292),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                '제2목표',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                '최종 목표를 이루기 위한 세부목표에요',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: const Color(0xff5C5C5C),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                '제3목표',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              const Text(
                '세부목표를 위한 구체적인 계획이에요',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}