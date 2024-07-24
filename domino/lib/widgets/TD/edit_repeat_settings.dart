import 'package:flutter/material.dart';
import 'package:domino/provider/TD//date_provider.dart';
import 'package:provider/provider.dart';

class EditRepeatSettings extends StatefulWidget {
  final bool everyDay;
  final bool everyWeek;
  final bool everyTwoWeek;
  final bool everyMonth;
  const EditRepeatSettings(
      this.everyDay, this.everyWeek, this.everyTwoWeek, this.everyMonth,
      {super.key});

  @override
  State<EditRepeatSettings> createState() => EditRepeatSettingsState();
}

class EditRepeatSettingsState extends State<EditRepeatSettings> {
  late bool everyDay;
  late bool everyWeek;
  late bool everyTwoWeek;
  late bool everyMonth;

  @override
  void initState() {
    super.initState();
    everyDay = widget.everyDay;
    everyWeek = widget.everyWeek;
    everyTwoWeek = widget.everyTwoWeek;
    everyMonth = widget.everyMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Checkbox(
              side: MaterialStateBorderSide.resolveWith((states) =>
                  const BorderSide(
                      width: 1.5, color: Colors.white)), //체크박스 테두리의 두께와 색깔 지정
              activeColor: const Color(0xff262626),
              checkColor: const Color(0xffFF6767),
              value: everyDay,
              onChanged: (value) {
                setState(() {
                  everyDay = value!;
                  everyWeek = false;
                  everyTwoWeek = false;
                  everyMonth = false;
                });
                context.read<DateProvider>().setEveryday(everyDay);
              },
            ),
            const Text(
              '매일',
              style: TextStyle(color: Colors.white),
            ),
            Checkbox(
              side: MaterialStateBorderSide.resolveWith((states) =>
                  const BorderSide(
                      width: 1.5, color: Colors.white)), //체크박스 테두리의 두께와 색깔 지정
              activeColor: const Color(0xff262626),
              checkColor: const Color(0xffFF6767),
              value: everyWeek,
              onChanged: (value) {
                setState(() {
                  everyWeek = value!;
                  everyDay = false;
                  everyTwoWeek = false;
                  everyMonth = false;
                });
                context.read<DateProvider>().setEveryweek(everyWeek);
              },
            ),
            const Text(
              '매주',
              style: TextStyle(color: Colors.white),
            ),
            Checkbox(
              side: MaterialStateBorderSide.resolveWith((states) =>
                  const BorderSide(
                      width: 1.5, color: Colors.white)), //체크박스 테두리의 두께와 색깔 지정
              activeColor: const Color(0xff262626),
              checkColor: const Color(0xffFF6767),
              value: everyTwoWeek,
              onChanged: (value) {
                setState(() {
                  everyTwoWeek = value!;
                  everyDay = false;
                  everyWeek = false;
                  everyMonth = false;
                });
                context.read<DateProvider>().setEverytwoweek(everyTwoWeek);
              },
            ),
            const Text(
              '격주',
              style: TextStyle(color: Colors.white),
            ),
            Checkbox(
              side: MaterialStateBorderSide.resolveWith((states) =>
                  const BorderSide(
                      width: 1.5, color: Colors.white)), //체크박스 테두리의 두께와 색깔 지정
              activeColor: const Color(0xff262626),
              checkColor: const Color(0xffFF6767),
              value: everyMonth,
              onChanged: (value) {
                setState(() {
                  everyMonth = value!;
                  everyDay = false;
                  everyWeek = false;
                  everyTwoWeek = false;
                });
                context.read<DateProvider>().setEverymonth(everyMonth);
              },
            ),
            const Text(
              '매월',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
