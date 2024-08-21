import 'package:domino/screens/DP/create99_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/widgets/DP/smallgrid.dart';
import 'package:domino/apis/services/dp_services.dart';

class DPcreateSelectPage extends StatefulWidget {
  const DPcreateSelectPage({super.key});

  @override
  State<DPcreateSelectPage> createState() => _DPcreateSelectPageState();
}

class _DPcreateSelectPageState extends State<DPcreateSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff262626),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff262626),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Text(
              '플랜 만들기',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(38.0, 20.0, 40.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("어떤 목표를 이루고 싶나요?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1)),
                const SizedBox(height: 20),
                Container(
                  height: 43,
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: const Color(0xff5C5C5C),
                    ),
                  ),
                  child: const MyDropdownButton(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1),
                    children: List.generate(9, (index) {
                      if (index == 4) {
                        return SizedBox(
                            width: 100,
                            child: GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                                children: List.generate(9, (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: index == 4
                                          ? const Color(0xffFCFF62)
                                          : const Color(0xff929292),
                                    ),
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.all(1.0),
                                    child: index == 4
                                        ? Consumer<SelectFinalGoalModel>(
                                            builder: (_, selectedFinalGoal,
                                                    __) =>
                                                Text(
                                                  selectedFinalGoal
                                                      .selectedFinalGoal,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 8,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ))
                                        : const Text(""),
                                  );
                                })));
                      } else {
                        return const Smallgrid();
                      }
                    }),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff131313),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0))),
                        child: const Text(
                          '취소',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DPcreate99Page(),
                              ));
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff131313),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0))),
                        child: const Text(
                          '다음',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      )
                    ]),
                const SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}

const List<String> list = <String>["선택 안됨", "환상적인 세계여행", "행복한 2024년"];

class MyDropdownButton extends StatefulWidget {
  const MyDropdownButton({super.key});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String dropdownValue = list.first;
  void mainGoalList() async {
    String? result = await MainGoalListService.mainGoalList(context);

    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return (DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? value) {
        context.read<SelectFinalGoalModel>().selectFinalGoal(value!);
        setState(() {
          dropdownValue = value;
        });
        mainGoalList();
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      isExpanded: true,
      elevation: 1,
      dropdownColor: const Color(0xff262626),
      underline: Container(),
      icon: const Icon(Icons.arrow_drop_down),
      iconEnabledColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
      ),
    ));
  }
}
