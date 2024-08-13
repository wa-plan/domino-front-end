import 'package:flutter/material.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatlessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        home: Scaffold(
            body: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                )
                child: Column(
                    mainAxisAlignment: mainAxisAlignment.end
                    children: [
                    Text("도닦기",
                    style: TextStyle(
                        fontWeight: fontWeight.bold,
                        fontSize:30,
                        color: Colors.white,
                    ),
                    ),
                    Text("목표를 이루려면\n도를 닦아야 한다.",
                    style: TextStyle(
                        fontWeight: fontWeight.bold,
                        fontSize:30,
                        color: Colors.white,
                    ),
                    ),
                    //Text
                    Image.asset(
                        "assets/img/Dominho.png",
                    ),//Image
                    ]
                )
            )
        )
    )
  }
}
