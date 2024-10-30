import 'package:flutter/material.dart';
import 'dart:math';

class PieChart extends CustomPainter {
  final int successPercentage;
  final int inProgressPercentage;
  final int failPercentage;
  final double textScaleFactor;

  PieChart(
      {required this.successPercentage,
      required this.inProgressPercentage,
      required this.failPercentage,
      this.textScaleFactor = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 38.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    double radius = size.width * 0.8;
    Offset center = Offset(size.width / 2, size.height / 2);
    double startAngle = -pi / 2;

    // 검은색 구분선 각도
    double separatorAngle = 2 * pi * (1 / 100);

    // 1. 노란색 아크 그리기
    double successArcAngle = 2 * pi * ((successPercentage - 1) / 100); // 1% 줄이기
    paint.color = const Color(0xffFCFF62);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        successArcAngle, false, paint);

    // 노란색과 회색 사이 검은색 구분선 추가
    startAngle += successArcAngle;
    paint.color = Colors.black;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        separatorAngle, false, paint);

    // 2. 회색 아크 그리기
    double inProgressArcAngle =
        2 * pi * ((inProgressPercentage - 1) / 100); // 1% 줄이기
    startAngle += separatorAngle;
    paint.color = const Color(0xffFEFFC4);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        inProgressArcAngle, false, paint);

    // 회색과 검정 사이 검은색 구분선 추가
    startAngle += inProgressArcAngle;
    paint.color = Colors.black;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        separatorAngle, false, paint);

    // 3. 검정 아크 그리기
    double failArcAngle = 2 * pi * ((failPercentage - 1) / 100); // 1% 줄이기
    startAngle += separatorAngle;
    paint.color = const Color(0xff383838);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        failArcAngle, false, paint);

    // 마지막 검은색 구분선 추가
    startAngle += failArcAngle;
    paint.color = Colors.black;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        separatorAngle, false, paint);

    // 달성률 텍스트 그리기
    drawText(canvas, size, "달성률\n  $successPercentage%");
  }

  void drawText(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(
      style: TextStyle(
          fontSize: fontSize, fontWeight: FontWeight.w600, color: Colors.white),
      text: text,
    );

    TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);
    tp.layout();

    double dx = size.width / 2 - tp.width / 2;
    double dy = size.height / 2 - tp.height / 2;

    Offset offset = Offset(dx, dy);
    tp.paint(canvas, offset);
  }

  double getFontSize(Size size, String text) {
    return (size.width / text.length * textScaleFactor) * 1.5;
  }

  @override
  bool shouldRepaint(PieChart old) {
    return old.successPercentage != successPercentage ||
        old.inProgressPercentage != inProgressPercentage ||
        old.failPercentage != failPercentage;
  }
}
