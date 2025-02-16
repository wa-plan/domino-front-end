import 'package:flutter/material.dart';

class Smallgrid extends StatelessWidget {
  const Smallgrid({super.key});

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        width: 100,
        child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            children: List.generate(9, (index) {
              return Container(
                margin: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(currentWidth < 600 ? 3 : 6),
                  color: index == 4
                      ? const Color(0xff929292)
                      : const Color(0xff5C5C5C),
                ),
              );
            })));
  }
}
