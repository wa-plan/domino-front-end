import 'package:domino/screens/DP/create_complete_Page.dart';
import 'package:domino/widgets/DP/colorBox.dart';
import 'package:domino/widgets/DP/colorBox2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';
import 'package:domino/widgets/DP/color_option.dart';


class DPcreateColorPage extends StatefulWidget {
  const DPcreateColorPage({super.key});


  @override
  _DPcreateColorPageState createState()=>
  _DPcreateColorPageState();
}

class _DPcreateColorPageState extends State<DPcreateColorPage> {
  
  int selectIndex = 0;
  Map colorPalette = {
    const Color(0xffFF7A7A): const Color(0xffFFC2C2),
    const Color(0xffFFB82D): const Color(0xffFFD19B),
    const Color(0xffFCFF62): const Color(0xffFEFFCD),
    const Color(0xff72FF5B): const Color(0xffC1FFB7),
    const Color(0xff5DD8FF): const Color(0xff94E5FF),
    const Color(0xff929292): const Color(0xffC4C4C4),
    const Color(0xffFF5794): const Color(0xffFF8EB7),
    const Color(0xffAE7CFF): const Color(0xffD0B4FF),
    const Color(0xffC77B7F): const Color(0xffEBB6B9),
    const Color(0xff009255): const Color(0xff6DE1B0),
    const Color(0xff3184FF): const Color(0xff8CBAFF),
    const Color(0xff11D1C2): const Color(0xffAAF4EF),
  };

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
                const Text(
                  '플랜을 꾸밀 수 있어요.',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1),
                ),
                
                const SizedBox(
                  height: 20,
                ),

                Container(
                    height: 43,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                        shape: BoxShape.rectangle, color: const Color(0xffFCFF62)),
                    child: Text(
                        context.watch<SelectFinalGoalModel>().selectedFinalGoal,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ))),

                const SizedBox(
                  height: 30,
                ),

                Expanded(
                  flex:2 ,
                    child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1 ),
                  children: [
                    GestureDetector(
                      onTap: () {setState((){
                        selectIndex = 0;
                      });},
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: selectIndex == 0 ? Colors.white : const Color(0xff262626))
                      ),
                      child: colorBox(actionPlanid: 0, goalColorid: 0, detailGoalid: 0)
                    )),

                    GestureDetector(
                      onTap: () {setState((){
                        selectIndex = 1;
                      });},
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: selectIndex == 1 ? Colors.white : const Color(0xff262626))
                      ),
                      child:  colorBox(actionPlanid: 1, goalColorid: 1, detailGoalid: 1)
                    )),

                    GestureDetector(
                      onTap: () {setState((){
                        selectIndex = 2;
                      });},
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: selectIndex == 2 ? Colors.white : const Color(0xff262626))
                      ),
                      child:  colorBox(actionPlanid: 2, goalColorid: 2, detailGoalid: 2)
                    )),

                    GestureDetector(
                      onTap: () {setState((){
                        selectIndex = 3;
                      });},
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: selectIndex == 3 ? Colors.white : const Color(0xff262626))
                      ),
                      child:  colorBox(actionPlanid: 3, goalColorid: 3, detailGoalid: 3)
                    )),      
                    
                    SizedBox(
                      width: 100,
                      child: GridView.count(
                        crossAxisCount: 3,

                        children: [

                          const colorBox2(keyNumber: 0),
                          const colorBox2(keyNumber: 1),
                          const colorBox2(keyNumber: 2),
                          const colorBox2(keyNumber: 3),

                          Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),
                              color: const Color(0xffFCFF62),),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child: Text(
                                context
                                    .watch<SelectFinalGoalModel>()
                                    .selectedFinalGoal,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                            ),

                            const colorBox2(keyNumber: 5),
                            const colorBox2(keyNumber: 6),
                            const colorBox2(keyNumber: 7),
                            const colorBox2(keyNumber: 8),
                        ],
                      ),
                    ),

                    GestureDetector(
                      onTap: () {setState((){
                        selectIndex = 5;
                      });},
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: selectIndex == 5 ? Colors.white : const Color(0xff262626))
                      ),
                      child:  colorBox(actionPlanid: 5, goalColorid: 5, detailGoalid: 5)
                    )),

                    GestureDetector(
                      onTap: () {setState((){
                        selectIndex = 6;
                      });},
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: selectIndex == 6 ? Colors.white : const Color(0xff262626))
                      ),
                      child:  colorBox(actionPlanid: 6, goalColorid: 6, detailGoalid: 6)
                    )),

                    GestureDetector(
                      onTap: () {setState((){
                        selectIndex = 7;
                      });},
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: selectIndex == 7 ? Colors.white : const Color(0xff262626))
                      ),
                      child:  colorBox(actionPlanid: 7, goalColorid: 7, detailGoalid: 7)
                    )),

                    GestureDetector(
                      onTap: () {setState((){
                        selectIndex = 8;
                      });},
                      child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: selectIndex == 8 ? Colors.white : const Color(0xff262626))
                      ),
                      child:  colorBox(actionPlanid: 8, goalColorid: 8, detailGoalid: 8)
                    )),
                    
                  ],
                )),
                
                const SizedBox(
                  height: 20,
                ),

                const Text(
                  '컬러 테마',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),


                Expanded(
                    child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6, crossAxisSpacing: 11, mainAxisSpacing: 11),
                  children: [
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xffFF7A7A)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xffFFB82D)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xffFCFF62)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xff72FF5B)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xff5DD8FF)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xff929292)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xffFF5794)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xffAE7CFF)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xffC77B7F)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xff009255)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xff3184FF)),
                  color_option(selectIndex: selectIndex, colorCode: const Color(0xff11D1C2))
                  ]
                )),

                Align(
                  alignment: Alignment.centerRight,
                  child:TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DPcreateCompletePage(),
                        ));
                  },
                  style: TextButton.styleFrom( //api 넣기
                      backgroundColor: const Color(0xff131313),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0))),
                  child: const Text(
                    '완료',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )),

                const SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}

