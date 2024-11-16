import 'package:flutter/material.dart';

//color
const backgroundColor = Color(0xff262626);
const mainRed = Color(0xffFF7A7A);
const mainTextColor = Colors.white;
const mainGold = Color(0xffF6C92B);

//padding
const appBarPadding = EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 20);
const fullPadding = EdgeInsets.fromLTRB(25.0, 10, 25.0, 20.0);

//Button
class Button {
  final Color buttonColor;
  final Color textColor;
  final String text;
  final Function function;

  Button(this.buttonColor, this.textColor, this.text, this.function);

  Widget button() {
    return TextButton(
      onPressed: () => function(),
      style: TextButton.styleFrom(
        backgroundColor: buttonColor, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor, 
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
