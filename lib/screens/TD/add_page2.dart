import 'package:domino/main.dart';
import 'package:flutter/material.dart';
import 'package:domino/provider/TD/date_provider.dart';
import 'package:domino/screens/TD/add_page1.dart';
import 'package:domino/widgets/TD/add_calendar.dart';
import 'package:domino/widgets/TD/repeat_settings.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/TD/event_provider.dart';

class AddPage2 extends StatefulWidget {
  const AddPage2({super.key});
  @override
  State<AddPage2> createState() => AddPage2State();
}

class AddPage2State extends State<AddPage2> {
  final formKey = GlobalKey<FormState>();
  String dominoValue = '';
  TextEditingController dominoController =
      TextEditingController(text: "저금"); //텍스트폼필드에 기본으로 들어갈 초기 텍스트 값
  bool switchValue = false;

  RepeatSettingsState repeatSettings =
      RepeatSettingsState(); // RepeatSettingsState 인스턴스 생성

  //텍스트폼필드 함수 만들기
  renderTextFormField({
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
  void initState() {
    super.initState();
    context.read<DateProvider>().clearPickedDate();
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
                      const SizedBox(
                        height: 20,
                      ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        '언제 실행하고 싶나요?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                      const AddCalendar(), //추가할 때 달력
                      //반복하기 기능
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end, //오른쪽 정렬
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
                      if (switchValue) const RepeatSettings(),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddPage1(),
                        ));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '이전',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ), //취소 버튼
                TextButton(
                  onPressed: () {
                    String content =
                        dominoController.text; // 텍스트 필드에서 입력된 내용을 가져옴

                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      // DateProvider에서 pickedDate를 가져옴
                      DateTime? pickedDate =
                          context.read<DateProvider>().pickedDate;

                      if (pickedDate == null) {
                        // pickedDate가 null인 경우 오류 메시지 표시
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('날짜를 선택해 주세요.')),
                        );
                      } else {
                        if (switchValue) {
                          // EventProvider를 통해 루틴 추가
                          context.read<DateProvider>().setInterval(switchValue);
                          int interval = context.read<DateProvider>().interval;

                          context.read<EventProvider>().addrepeatEvent(
                                pickedDate,
                                Event(
                                  title: 'Money',
                                  content: content,
                                  switchValue: switchValue,
                                  interval: interval,
                                ),
                                switchValue,
                                interval,
                              );
                        } else {
                          // EventProvider를 통해 이벤트 추가
                          context.read<EventProvider>().addEvent(
                                pickedDate,
                                Event(
                                  title: 'Money',
                                  content: content,
                                  switchValue: switchValue,
                                  interval: 0,
                                ),
                              );
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
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
