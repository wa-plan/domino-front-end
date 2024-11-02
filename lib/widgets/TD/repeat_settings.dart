import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/TD/datelist_provider.dart';

class RepeatSettings extends StatefulWidget {
  const RepeatSettings({super.key});

  @override
  State<RepeatSettings> createState() => RepeatSettingsState();
}

class RepeatSettingsState extends State<RepeatSettings> {
  bool everyDay = false;
  bool everyWeek = false;
  bool everyTwoWeek = false;
  bool everyMonth = false; //변수: 체크박스 체크 여부

  // true 값을 가지는 변수의 이름을 반환하는 생성자

  @override
  Widget build(BuildContext context) {
    return 
        Container(
          padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            decoration: BoxDecoration(
                              color: const Color(0xff2A2A2A),
                              borderRadius: BorderRadius.circular(3),
                            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
                  Checkbox(
                    side: MaterialStateBorderSide.resolveWith((states) =>
                        const BorderSide(
                            width: 1, color: Colors.white)), //체크박스 테두리의 두께와 색깔 지정
                    activeColor: const Color(0xff262626),
                    checkColor: mainRed,
                    value: everyDay,
                    onChanged: (value) {
                      setState(() {
                        everyDay = value!;
                        everyWeek = false;
                        everyTwoWeek = false;
                        everyMonth = false;
                      });
                      context.read<DateListProvider>().setEveryday(everyDay);
                    },
                  ),
                  const Text(
                    '매일',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    side: MaterialStateBorderSide.resolveWith((states) =>
                        const BorderSide(
                            width: 1, color: Colors.white)), //체크박스 테두리의 두께와 색깔 지정
                    activeColor: const Color(0xff262626),
                    checkColor: mainRed,
                    value: everyWeek,
                    onChanged: (value) {
                      setState(() {
                        everyWeek = value!;
                        everyDay = false;
                        everyTwoWeek = false;
                        everyMonth = false;
                      });
                      context.read<DateListProvider>().setEveryweek(everyWeek);
                    },
                  ),
                  const Text(
                    '매주',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    side: MaterialStateBorderSide.resolveWith((states) =>
                        const BorderSide(
                            width: 1, color: Colors.white)), //체크박스 테두리의 두께와 색깔 지정
                    activeColor: const Color(0xff262626),
                    checkColor: mainRed,
                    value: everyTwoWeek,
                    onChanged: (value) {
                      setState(() {
                        everyTwoWeek = value!;
                        everyDay = false;
                        everyWeek = false;
                        everyMonth = false;
                      });
                      context.read<DateListProvider>().setEverytwoweek(everyTwoWeek);
                    },
                  ),
                  const Text(
                    '격주',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    side: MaterialStateBorderSide.resolveWith((states) =>
                        const BorderSide(
                            width: 1, color: Colors.white)), //체크박스 테두리의 두께와 색깔 지정
                    activeColor: const Color(0xff262626),
                    checkColor: mainRed,
                    value: everyMonth,
                    onChanged: (value) {
                      setState(() {
                        everyMonth = value!;
                        everyDay = false;
                        everyWeek = false;
                        everyTwoWeek = false;
                      });
                      context.read<DateListProvider>().setEverymonth(everyMonth);
                    },
                  ),
                  const Text(
                    '매월',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
