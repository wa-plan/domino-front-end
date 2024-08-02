import 'package:domino/screens/DP/create_color_page.dart';
import 'package:domino/widgets/DP/confirmBox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class DPcreateConfirmPage extends StatelessWidget {
  const DPcreateConfirmPage({super.key});

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

            const Text('작성한 내용을 확인해주세요.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1
                            ),
                  ),

                  const SizedBox(height: 20,),

                  Container(
                      height: 43,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        color: Color(0xffFCFF62)
                      ),
                      child: Text(
                        context.watch<SelectFinalGoalModel>().selectedFinalGoal,
                        style: const TextStyle(
                        color: Colors.black,
                        fontSize:13,
                        fontWeight: FontWeight.bold,))
                      ),

        

            const SizedBox(height: 40,),

            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
                children: [

                  const confirmBox(actionPlanid: 0, detailGoalid: 0),

                  const confirmBox(actionPlanid: 1, detailGoalid: 1),

                  const confirmBox(actionPlanid: 2, detailGoalid: 2),

                  const confirmBox(actionPlanid: 3, detailGoalid: 3),

                  SizedBox(
                      width: 100,
                      child: GridView.count(
                        crossAxisCount: 3,
                        children: List.generate(9, (index) {
                        
                          if (index == 4) {
                            return Container(
                              color: const Color(0xffFCFF62),
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                                child:Text(
                                  context.watch<SelectFinalGoalModel>().selectedFinalGoal,
                                  style: const TextStyle(color: Colors.black, fontSize: 8, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                            )),
                              
                            );
                          } else {
                            final inputtedDetailGoals = context.watch<SaveInputtedDetailGoalModel>().inputtedDetailGoal;
                            final values = inputtedDetailGoals.containsKey(index.toString()) ? inputtedDetailGoals[index.toString()] : '';
                            final isValueEmpty = values.isEmpty;
                            final backgroundColor2 = isValueEmpty ? const Color(0xff262626) : const Color(0xff929292);

                            return Container(
                              
                              decoration:BoxDecoration(borderRadius: BorderRadius.circular(3),
                              color: backgroundColor2,) ,
                              margin: const EdgeInsets.all(1.0),
                              child: Center(
                               child: Text(
                                values,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.black, fontSize: 15),
                              )),
                            );
                          }
                        }),
                      ),
                    ),

                  

                  const confirmBox(actionPlanid: 5, detailGoalid: 5),

                  const confirmBox(actionPlanid: 6, detailGoalid: 6),

                  const confirmBox(actionPlanid: 7, detailGoalid: 7),

                  const confirmBox(actionPlanid: 8, detailGoalid: 8),

                ],)
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
                      borderRadius: BorderRadius.circular(6.0)
                    )
                  ),
                  child: const Text('수정',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
            
              ),

              TextButton(
                  onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const DPcreateColorPage(),)
                          );
                      }, 
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff131313),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)
                    )
                  ),
                  child: const Text('다음',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
            
              )
          ]),

          const SizedBox(
                  height: 20,
                ),
            
          ],
        )
      )
      );
  }
}

