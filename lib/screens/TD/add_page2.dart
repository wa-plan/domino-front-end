import 'package:domino/provider/TD/datelist_provider.dart';
import 'package:domino/screens/TD/td_main.dart';
import 'package:flutter/material.dart';
import 'package:domino/provider/TD/date_provider.dart';
import 'package:domino/widgets/TD/add_calendar.dart';
import 'package:domino/widgets/TD/repeat_settings.dart';
import 'package:provider/provider.dart';
import 'package:domino/apis/services/td_services.dart';

class AddPage2 extends StatefulWidget {
  final int thirdGoalId;
  final String thirdGoalName;

  const AddPage2({
    super.key,
    required this.thirdGoalId,
    required this.thirdGoalName,
  });

  @override
  State<AddPage2> createState() => AddPage2State();
}

class AddPage2State extends State<AddPage2> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController dominoController; // 'late'로 나중에 초기화될 것을 명시
  bool switchValue = false;
  String dominoValue = '';
  int thirdGoalId = 99;

  RepeatSettingsState repeatSettings = RepeatSettingsState(); // RepeatSettingsState 인스턴스 생성

  @override
  void initState() {
    super.initState();
    dominoController = TextEditingController(text: widget.thirdGoalName); // initState에서 widget에 접근하여 초기화
    context.read<DateProvider>().clearPickedDate(); // DateProvider 초기화
  }

  @override
  void dispose() {
    dominoController.dispose(); // 컨트롤러는 사용이 끝난 후 dispose로 메모리 정리
    super.dispose();
  }

  // 도미노 추가 함수
  void addDomino(int thirdGoalId, String name, List<DateTime> dateList,
      String repetition) async {
    final success = await AddDominoService.addDomino(
        thirdGoalId: thirdGoalId, name: name, dates: dateList, repetition: repetition);

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TdMain(),
        ),
      );
    }
  }

  // 텍스트폼필드 함수
  Widget renderTextFormField({
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
  }) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      controller: dominoController,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        suffixIcon: dominoController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  dominoController.clear();
                },
                icon: const Icon(Icons.clear_outlined),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '도미노 만들기',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w600),
          ),
        ),
        backgroundColor: const Color(0xff262626),
      ),
      backgroundColor: const Color(0xff262626),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 30.0, 40.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '더 자세하게 바꿀 수 있어요.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1),
                      ),
                      const Text(
                        '예시) 영어 공부 > 영단어 5개 암기',
                        style: TextStyle(
                            color: Color(0xffF6C92B),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: formKey,
                        child: renderTextFormField(
                          onSaved: (value) {
                            setState(() {
                              dominoValue = value!;
                            });
                          },
                          validator: (value) {
                            if (value!.length < 1) {
                              return '1자 이상 써주세요';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 35),
                      const Text(
                        '언제 실행하고 싶나요?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                      const AddCalendar(), // 달력 위젯 추가
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            '반복하기',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Switch(
                            value: switchValue,
                            onChanged: (value) {
                              setState(() {
                                switchValue = value;
                              });
                            },
                          ),
                        ],
                      ),
                      if (switchValue) const RepeatSettings(), // 반복 설정 위젯 추가
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff131313),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: const Text(
                    '이전',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      DateTime? pickedDate = context.read<DateProvider>().pickedDate;

                      if (pickedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('날짜를 선택해 주세요.')),
                        );
                      } else {
                        context
                            .read<DateListProvider>()
                            .setInterval(switchValue, pickedDate);
                        List<DateTime> dateList = context.read<DateListProvider>().dateList;
                        String repeatInfo = context.read<DateListProvider>().repeatInfo();

                        addDomino(widget.thirdGoalId, dominoController.text, dateList, repeatInfo);
                      }
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 57, 33, 33),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  child: const Text(
                    '완료',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
