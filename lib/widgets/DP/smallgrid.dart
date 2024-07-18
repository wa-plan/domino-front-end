import 'package:flutter/material.dart';

class Smallgrid extends StatelessWidget {
  const Smallgrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(9, (index) {
              return Container(
                color: index == 4
                    ? const Color(0xff929292)
                    : const Color(0xff5C5C5C),
                margin: const EdgeInsets.all(1.0),
              );
            })));
  }
}
