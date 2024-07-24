import 'package:domino/widgets/DP/input2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class DPcreateInput2Page extends StatelessWidget {
  const DPcreateInput2Page({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDetailGoal = int.parse(context.watch<SelectDetailGoal>().selectedDetailGoal);

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

      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.fromLTRB(38.0, 20.0, 40.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "목표를 이루기 위한 \n작은 계획들을 세워봐요.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1
              )
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

              Center(
                child: SizedBox(
                height: 300,
                width: 260,
                child: GridView(
                  
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
                  children: [

                   input2(actionPlanId: 0, selectedDetailGoalId: selectedDetailGoal),             

                   input2(actionPlanId: 1, selectedDetailGoalId: selectedDetailGoal),

                   input2(actionPlanId: 2, selectedDetailGoalId: selectedDetailGoal),

                   input2(actionPlanId: 3, selectedDetailGoalId: selectedDetailGoal),

                  Container(
                        width:80,
                        color: const Color(0xff929292),
                        margin: const EdgeInsets.all(1.0),
                        child: Center(
                          child:Text(
                          context.watch<SaveInputtedDetailGoalModel>().inputtedDetailGoal['$selectedDetailGoal'],
                          style: const TextStyle(color:Colors.white, fontSize: 15, fontWeight:FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                      ),
                 
                    input2(actionPlanId: 5, selectedDetailGoalId: selectedDetailGoal),

                    input2(actionPlanId: 6, selectedDetailGoalId: selectedDetailGoal),

                    input2(actionPlanId: 7, selectedDetailGoalId: selectedDetailGoal),

                    input2(actionPlanId: 8, selectedDetailGoalId: selectedDetailGoal),
                  ]

                ))),

                const SizedBox(height: 70,),

              

                 Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                  onPressed: () {
                        Navigator.pop(context);
                      }, 
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff131313),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)
                    )
                  ),
                  child: const Text('완료',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
            
              ))

            
          ],
        )
      )
      ));
  }
}

