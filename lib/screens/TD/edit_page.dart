import 'package:domino/apis/services/td_services.dart';
import 'package:domino/main.dart';
import 'package:domino/screens/TD/td_main.dart';
import 'package:flutter/material.dart';
import 'package:domino/widgets/TD/edit_calendar.dart';
import 'package:domino/widgets/TD/edit_repeat_settings.dart';

//import 'package:provider/provider.dart';
//import 'package:domino/provider/TD/event_provider';

class EditPage extends StatefulWidget {
  final DateTime date;
  final String title;
  final String content;
  final bool switchValue;
  final int interval;

  const EditPage(
      this.date, this.title, this.content, this.switchValue, this.interval,
      {super.key});
  @override
  State<EditPage> createState() => EditPageState();
}

class EditPageState extends State<EditPage> {
  bool switchValue = false;
  bool everyDay = false;
  bool everyWeek = false;
  bool everyTwoWeek = false;
  bool everyMonth = false;
  final formKey = GlobalKey<FormState>();
  String dominoValue = '';
  late TextEditingController dominoController; //텍스트폼필드에 기본으로 들어갈 초기 텍스트 값

  void editDomino(int goalId, String newGoal) async {
    final success =
        await EditDominoService.editDomino(goalId: goalId, newGoal: newGoal);

    if (success) {
      // 성공적으로 서버에 전송된 경우에 처리할 코드
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('도미노가 삭제되었습니다.')),
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TdMain(),
          ));
    } else {
      // 실패한 경우에 처리할 코드
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('도미노 삭제에 실패했습니다.')),
      );
    }
  }

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
    dominoController = TextEditingController(text: widget.content);
    switchValue = widget.switchValue; // 전달받은 switchValue로 초기화
    // howmany 함수를 사용하여 bool 변수들을 초기화합니다.
    /*Map<String, bool> intervalValues =
        context.read<EventProvider>().howmany(widget.interval);
    everyDay = intervalValues['everyDay'] ?? false;
    everyWeek = intervalValues['everyWeek'] ?? false;
    everyTwoWeek = intervalValues['everyTwoWeek'] ?? false;
    everyMonth = intervalValues['everyMonth'] ?? false;*/
  }

  @override
  Widget build(BuildContext context) {
    bool switchValue = widget.switchValue;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '도미노 수정하기',
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
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                      dominoValue = value;
                    });
                  },
                  validator: (value) {
                    if (value.length < 1) {
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
              EditCalendar(widget.date), //추가할 때 달력
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
              if (switchValue)
                EditRepeatSettings(
                    everyDay, everyWeek, everyTwoWeek, everyMonth),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '이전',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ), //취소 버튼
                TextButton(
                  onPressed: () {
                    /*context.read<EventProvider>().removeEvent(
                        widget.date,
                        Event(
                            title: 'Money',
                            content: widget.content,
                            switchValue: widget.switchValue,
                            interval: widget.interval));*/
                    deleteDialog(context);
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6767),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '삭제',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TdMain(),
                        ));
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '완료',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
            ],
          ),
        ]),
      ),
    );
  }
}

void deleteDialog(context) {
  const int goalId = 0;
  void deleteDomino(int goalId) async {
    final success = await DeleteDominoService.deleteDomino(goalId: goalId);

    if (success) {
      // 성공적으로 서버에 전송된 경우에 처리할 코드
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('도미노가 삭제되었습니다.')),
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TdMain(),
          ));
    } else {
      // 실패한 경우에 처리할 코드
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('도미노 삭제에 실패했습니다.')),
      );
    }
  }

  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 25, 5, 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    deleteDomino(goalId);
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ));
                  },
                  child: const Text(
                    '앞으로의 도미노 모두 삭제',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TdMain(),
                        ));
                  },
                  child: const Text(
                    '오늘의 도미노만 삭제',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      );
    },
  );
}
