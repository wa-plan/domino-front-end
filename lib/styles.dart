import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//color
const backgroundColor = Color(0xff262626);
const mainRed = Color(0xffFF7A7A);
const mainTextColor = Colors.white;
const mainGold = Color(0xffF6C92B);

//padding
const appBarPadding = EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 20);
const fullPadding = EdgeInsets.fromLTRB(25.0, 10, 25.0, 20.0);

//colorPalette
Map<Color, Color> colorPalette = {
    const Color(0xffFF7A7A):  const Color(0xffFFC2C2),
    const Color(0xffFFB82D):  const Color(0xffFFD19B),
    const Color(0xffFCFF62):  const Color(0xffFEFFCD),
    const Color(0xff72FF5B):  const Color(0xffC1FFB7),
    const Color(0xff5DD8FF):  const Color(0xff94E5FF),
    const Color(0xff929292):  const Color(0xff5C5C5C),
    const Color(0xffFF5794):  const Color(0xffFF8EB7),
    const Color(0xffAE7CFF):  const Color(0xffD0B4FF),
    const Color(0xffC77B7F):  const Color(0xffEBB6B9),
    const Color(0xff009255):  const Color(0xff6DE1B0),
    const Color(0xff3184FF):  const Color(0xff8CBAFF),
    const Color(0xff11D1C2):  const Color(0xffAAF4EF),
    Colors.transparent:  const Color(0xff5C5C5C),
  };


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


//MG Sub Title
class MGSubTitle {
  final String text;

  MGSubTitle(this.text);

  Widget mgSubTitle(BuildContext context){
    return Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                  fontWeight: FontWeight.w400,
                ),
              );
  }
}


//Fluttertoast
class Message {
  final String text;
  final Color textColor;
  final Color BgColor;

  Message(this.text, this.textColor, this.BgColor);

  Future<bool?> message(BuildContext context){
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: BgColor,
        textColor: textColor,
      );
  }
}

//DPMainGoal
class DPMainGoal {
  final String text;
  final Color color;

   DPMainGoal(this.text, this.color);

   Widget dpMainGoal(){
    return Container(
                    height: 43,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: color,
                    ),
                    child: Text(
                        textAlign: TextAlign.center,
                        text,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        )));
  }
}


