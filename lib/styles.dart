import 'package:auto_size_text/auto_size_text.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
  const Color(0xffFF7A7A): const Color(0xffFFC2C2),
  const Color(0xffFFB82D): const Color(0xffFFD19B),
  const Color(0xffFCFF62): const Color(0xffFEFFCD),
  const Color(0xff72FF5B): const Color(0xffC1FFB7),
  const Color(0xff5DD8FF): const Color(0xff94E5FF),
  const Color(0xff929292): const Color(0xff5C5C5C),
  const Color(0xffFF5794): const Color(0xffFF8EB7),
  const Color(0xffAE7CFF): const Color(0xffD0B4FF),
  const Color(0xffC77B7F): const Color(0xffEBB6B9),
  const Color(0xff009255): const Color(0xff6DE1B0),
  const Color(0xff3184FF): const Color(0xff8CBAFF),
  const Color(0xff11D1C2): const Color(0xffAAF4EF),
  Colors.transparent: const Color(0xff5C5C5C),
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

  Widget mgSubTitle(BuildContext context) {
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

  Future<bool?> message(BuildContext context) {
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

  Widget dpMainGoal() {
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

//ThirdGoalInput
class DPInput3 {
  final Color? color;
  final Function(String value) onChangedFunction;
  final String initialValue;

  DPInput3(this.color, this.onChangedFunction, this.initialValue);

  Widget dpInput3() {
    return Container(
      width: 80,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(4), color: color),
      margin: const EdgeInsets.all(1.0),
      child: Center(
        child: TextFormField(
          initialValue: initialValue,
          onChanged: onChangedFunction,
          textAlign: TextAlign.center,
          textInputAction: TextInputAction.newline,
          maxLines: null,
          style: const TextStyle(
            fontSize: 13,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

//SecondGoalInput
class DPInput2 {
  final Color? color;
  final TextEditingController controller;
  final Function(String value) onChangedFunction;

  DPInput2(this.color, this.controller, this.onChangedFunction);

  Widget dpInput2() {
    return Container(
      width: 80,
      margin: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: color,
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          onChanged: onChangedFunction,
          textAlign: TextAlign.center,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

//SecondGoalGrid
class DPGrid2 {
  final int hintNum;
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;
  final Border? border;
  final double maxFontSize;

  const DPGrid2(this.hintNum, this.mandalart, this.secondGoals, this.maxFontSize, this.border);

  Widget dpGrid2() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color:
            secondGoals.isNotEmpty && secondGoals[hintNum]['secondGoal'] != ""
                ? Color(int.parse(secondGoals[hintNum]['color']
                    .replaceAll('Color(', '')
                    .replaceAll(')', '')))
                : Colors.transparent,
        border: border,
      ),
      margin: const EdgeInsets.all(1.0),
      child: Center(
        child: AutoSizeText(
          secondGoals.isNotEmpty && secondGoals[hintNum]['secondGoal'] != ""
              ? secondGoals[hintNum]['secondGoal']
              : "",
          maxLines: 3,
          minFontSize: 6,
          maxFontSize: maxFontSize,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

//Grid for Creating
class DPCreateGrid {
  final String text;
  final Color? color;
  final Border? border;

  const DPCreateGrid(this.text, this.color, this.border);

  Widget dPCreateGrid() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: color,
        border: border,
      ),
      margin: const EdgeInsets.all(1.0),
      child: Center(
        child: AutoSizeText(
          maxLines: 3,
          minFontSize: 6,
          overflow: TextOverflow.ellipsis,
          text,
          style: const TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

//ThirdGoalGrid
class DPGrid3 {
  final int hintNum2;
  final int hintNum3;
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;
  final Border? border;
  final double maxFontSize;

  const DPGrid3(this.hintNum2, this.hintNum3, this.mandalart, this.secondGoals, this.maxFontSize,
      this.border);

  Widget dpGrid3() {
    final color = secondGoals.isNotEmpty &&
            secondGoals[hintNum2]['thirdGoals'].asMap().containsKey(hintNum3)
        ? Color(int.parse(secondGoals[hintNum2]['color']
            .replaceAll('Color(', '')
            .replaceAll(')', '')))
        : Colors.transparent;

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: secondGoals.isNotEmpty &&
                secondGoals[hintNum2]['thirdGoals'].isNotEmpty &&
                secondGoals[hintNum2]['thirdGoals']
                    .asMap()
                    .containsKey(hintNum3) &&
                secondGoals[hintNum2]['thirdGoals'][hintNum3]['thirdGoal'] == ""
            ? Colors.transparent
            : colorPalette[color],
        border: border,
      ),
      margin: const EdgeInsets.all(1.0),
      child: Center(
        child: AutoSizeText(
          secondGoals.isNotEmpty &&
                  secondGoals[hintNum2]['thirdGoals'].isNotEmpty &&
                  secondGoals[hintNum2]['thirdGoals']
                      .asMap()
                      .containsKey(hintNum3)
              ? secondGoals[hintNum2]['thirdGoals'][hintNum3]['thirdGoal']
              : "",
          maxLines: 3,
          minFontSize: 6,
          maxFontSize: maxFontSize,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

//ThirdGoalGrid for TD
class TDGrid3 {
  final int hintNum2;
  final int hintNum3;
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;
  final bool isSelected;
  final VoidCallback onSelect;
  final BuildContext context; // Pass context explicitly

  const TDGrid3(
    this.hintNum2,
    this.hintNum3,
    this.mandalart,
    this.secondGoals,
    this.isSelected,
    this.onSelect,
    this.context, // Add context as a parameter
  );

  Widget tdGrid3() {
    // Determine the cell color
    final color = secondGoals.isNotEmpty &&
            secondGoals[hintNum2]['thirdGoals'].asMap().containsKey(hintNum3)
        ? Color(int.parse(secondGoals[hintNum2]['color']
            .replaceAll('Color(', '')
            .replaceAll(')', '')))
        : Colors.transparent;

    // Define the GestureDetector widget
    return GestureDetector(
      onTap: () {
        onSelect();
        if (secondGoals.isNotEmpty &&
            secondGoals[hintNum2]['thirdGoals'].isNotEmpty &&
            secondGoals[hintNum2]['thirdGoals'].asMap().containsKey(hintNum3)) {
          final thirdGoal =
              secondGoals[hintNum2]['thirdGoals'][hintNum3]['thirdGoal'] ?? "";
          final id = secondGoals[hintNum2]['thirdGoals'][hintNum3]['id'];
          context
              .read<SelectAPModel>()
              .selectAP(thirdGoal.isEmpty ? "플랜선택없음" : thirdGoal, id);
        } else {
          context.read<SelectAPModel>().selectAP("플랜선택없음", null);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: secondGoals.isNotEmpty &&
                  secondGoals[hintNum2]['thirdGoals'].isNotEmpty &&
                  secondGoals[hintNum2]['thirdGoals']
                      .asMap()
                      .containsKey(hintNum3) &&
                  secondGoals[hintNum2]['thirdGoals'][hintNum3]['thirdGoal'] ==
                      ""
              ? Colors.transparent
              : colorPalette[color],
          border: isSelected &&
                  secondGoals.isNotEmpty &&
                  secondGoals[hintNum2]['thirdGoals'].isNotEmpty &&
                  secondGoals[hintNum2]['thirdGoals']
                      .asMap()
                      .containsKey(hintNum3) &&
                  secondGoals[hintNum2]['thirdGoals'][hintNum3]['thirdGoal'] !=
                      ""
              ? Border.all(color: Colors.white, width: 2)
              : null,
        ),
        margin: const EdgeInsets.all(1.0),
        child: Center(
          child: AutoSizeText(
            secondGoals.isNotEmpty &&
                    secondGoals[hintNum2]['thirdGoals'].isNotEmpty &&
                    secondGoals[hintNum2]['thirdGoals']
                        .asMap()
                        .containsKey(hintNum3)
                ? secondGoals[hintNum2]['thirdGoals'][hintNum3]['thirdGoal']
                : "",
            maxLines: 3,
            minFontSize: 6,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

//FirstGoalGrid
class DPGrid1 {
  final String text;
  final Color color;
  final double maxFontSize;

  const DPGrid1(this.text, this.color, this.maxFontSize);

  Widget dpGrid1() {
    return Container(
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(1.0),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(3), color: color),
        child: Center(
          child: AutoSizeText(
              maxLines: 3, // 최대 줄 수 (필요에 따라 변경 가능)
              minFontSize: 6,
              maxFontSize: maxFontSize, // 최소 글씨 크기
              overflow: TextOverflow.ellipsis, // 내용이 너무 길 경우 생략 표시
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: backgroundColor,
                  fontWeight: FontWeight.w600,
                  )),
        ));
  }
}

//ColorTransformer(String>Color)
class ColorTransform {
  final String color;

  const ColorTransform(this.color);

  Color colorTransform() {
    return Color(int.parse(color.replaceAll('Color(', '').replaceAll(')', '')));
  }
}
