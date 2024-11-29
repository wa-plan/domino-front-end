import 'package:flutter/material.dart';
import 'dart:math';

class PieChart extends CustomPainter {
  final int successPercentage;
  final int inProgressPercentage;
  final int failPercentage;
  final double textScaleFactor;
  final String color;

  PieChart(
      {required this.successPercentage,
      required this.inProgressPercentage,
      required this.failPercentage,
      this.textScaleFactor = 1.0,
      required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 38.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    double radius = size.width * 0.8;
    Offset center = Offset(size.width / 2, size.height / 2);
    double startAngle = -pi / 2;

    // 모든 퍼센티지가 0인 경우 회색으로 채움
    if (successPercentage == 0 &&
        inProgressPercentage == 0 &&
        failPercentage == 0) {
      paint.color = Colors.black;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), 0, 2 * pi,
          false, paint);
      drawText(canvas, size, "달성률\n  0%");
      return;
    }

    // 1. 노란색 아크 그리기
    double successArcAngle = 2 * pi * (successPercentage / 100); // 1% 줄이기
    paint.color = Color(int.parse(color));
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        successArcAngle, false, paint);

    // 2. 회색 아크 그리기
    startAngle += successArcAngle;
    double inProgressArcAngle = 2 * pi * (inProgressPercentage / 100);
    //startAngle += separatorAngle;
    paint.color = const Color(0xffFEFFC4);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        inProgressArcAngle, false, paint);

    // 3. 검정 아크 그리기
    startAngle += inProgressArcAngle;
    double failArcAngle = 2 * pi * (failPercentage / 100); // 1% 줄이기
    //startAngle += separatorAngle;
    //paint.color = const Color(0xff383838);
    paint.color = Colors.black;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        failArcAngle, false, paint);

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
