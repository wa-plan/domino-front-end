/*import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:domino/screens/MG/mygoal_main.dart';
import 'package:domino/apis/mg_api_function.dart';

class _SampleScreenState extends State<SampleScreen> {
  final _status = ['진행 중', '달성 완료', '달성 실패'];
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedStatus = _status[0];
    });
  }//목표 진행 상황 드랍다운 리스트 정의

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262626),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff262626),        
        title: Row(
        Text (
          " "
          style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold),
          ),
        )
        action: [
          IconButton(
            onPressed: () {}, icon: Icon(Icons.edit),
          ),
        ],
        iconTheme: IconThemeDate(color: Colors.grey),
      ),//Icon Theme 지정
      body: Center(
        children: Column[
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
          title: Row(
          Text (
          "D- "
          style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold),
          ),
          Container: Row(
            Text (
              "이 목표는 "
              style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
          ),
            DropdownButton(
              value: _selectedStatus,
              items: _status
                .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
              .todList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              }
            )
          ),//목표 진행상황 변경
Row(
  children: [
    AddPhoto(
      onPressed: controller.onFileSelected,
    ),
    const SizedBox(width: 16),
    Obx(() => controller.selectedFile.isNotEmpty
        ? Expanded(
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.selectedFile.length,
                itemBuilder: (context, i) {
                  final imageBytes = controller.selectedFile[i].bytes;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1, color: grayLight),
                            color: Colors.white,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.memory(
                                imageBytes!,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return Container(
                                    color: grayLight,
                                    alignment: Alignment.center,
                                    child: const Text('not found'),
                                  );
                                },
                              )),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              controller.removeFile(i);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        : const SizedBox(width: 80, height: 80)),
  ],
),//Goal 업로드한 이미지 불러오기
            Padding(
              padding: EdgeInsets.all(15.0),
              child: new LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                animation: true,
                lineHeight: 20.0,
                percent: 0.67,
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: Colors.red,
              ),
            ),
          ),
          ],
        ],
        ),
      ),//Percentage 표시
  }
*/