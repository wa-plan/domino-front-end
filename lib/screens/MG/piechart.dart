import 'package:flutter/material.dart';
import 'dart:math'; // min 함수 사용을 위해 추가

class PieChart extends CustomPainter {
  final int yellowPercentage;
  final int grayPercentage;
  final int blackPercentage;
  final double textScaleFactor;

  PieChart(
      {required this.yellowPercentage,
      required this.grayPercentage,
      required this.blackPercentage,
      this.textScaleFactor = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 25.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    double radius = size.width * 0.8;

    Offset center = Offset(size.width / 2, size.height / 2);

    double startAngle = -pi / 2;

    // 1. 노란색 60% 그리기
    double yellowArcAngle = 2 * pi * (yellowPercentage / 100);
    paint.color = Colors.yellow;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        yellowArcAngle, false, paint);

    // 2. 회색 30% 그리기
    double grayArcAngle = 2 * pi * (grayPercentage / 100);
    startAngle += yellowArcAngle; // 이전 호 끝에서 시작
    paint.color = Colors.grey;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        grayArcAngle, false, paint);

    // 3. 검정색 10% 그리기
    double blackArcAngle = 2 * pi * (blackPercentage / 100);
    startAngle += grayArcAngle; // 이전 호 끝에서 시작
    paint.color = Colors.black;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        blackArcAngle, false, paint);

    // 4. 노란색 60% 텍스트 그리기
    drawText(canvas, size, "달성률\n  $yellowPercentage%");
  }

  void drawText(Canvas canvas, Size size, String text) {
    double fontSize = getFontSize(size, text);

    TextSpan sp = TextSpan(
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: Colors.white), // 텍스트 색상은 노란색으로 설정
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
    return old.yellowPercentage != yellowPercentage ||
        old.grayPercentage != grayPercentage ||
        old.blackPercentage != blackPercentage;
  }
}
