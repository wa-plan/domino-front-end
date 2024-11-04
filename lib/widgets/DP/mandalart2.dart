import 'package:domino/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:domino/provider/DP/model.dart';

class MandalartGrid2 extends StatefulWidget {
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;

  const MandalartGrid2({
    super.key,
    required this.mandalart,
    required this.secondGoals,
  });

  @override
  State<MandalartGrid2> createState() => _MandalartGrid2();
}

class _MandalartGrid2 extends State<MandalartGrid2> {
  int? _selectedBoxHintNum2; // Track selected box's hintNum2
  int? _selectedBoxHintNum3; // Track selected box's hintNum3

  void _selectBox(int hintNum2, int hintNum3) {
    setState(() {
      // Update selected box coordinates
      _selectedBoxHintNum2 = hintNum2;
      _selectedBoxHintNum3 = hintNum3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: [
          // First Grid
          SizedBox(
            width: 100,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: [
                for (int i = 0; i < 4; i++)
                  MandalartBox2(
                    hintNum2: 0,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 0 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(0, i), // Pass selection callback
                  ),
                MandalartBox1(
                  hintNum: 0,
                  mandalart: widget.mandalart,
                  secondGoals: widget.secondGoals,
                ),
                for (int i = 4; i < 8; i++)
                  MandalartBox2(
                    hintNum2: 0,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 0 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(0, i), // Pass selection callback
                  ),
              ],
            ),
          ),

          // Second Grid
          SizedBox(
            width: 100,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: [
                for (int i = 0; i < 4; i++)
                  MandalartBox2(
                    hintNum2: 1,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 1 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(1, i), // Pass selection callback
                  ),
                MandalartBox1(
                  hintNum: 1,
                  mandalart: widget.mandalart,
                  secondGoals: widget.secondGoals,
                ),
                for (int i = 4; i < 8; i++)
                  MandalartBox2(
                    hintNum2: 1,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 1 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(1, i), // Pass selection callback
                  ),
              ],
            ),
          ),

          // Third Grid
          SizedBox(
            width: 100,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: [
                for (int i = 0; i < 4; i++)
                  MandalartBox2(
                    hintNum2: 2,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 2 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(2, i), // Pass selection callback
                  ),
                MandalartBox1(
                  hintNum: 2,
                  mandalart: widget.mandalart,
                  secondGoals: widget.secondGoals,
                ),
                for (int i = 4; i < 8; i++)
                  MandalartBox2(
                    hintNum2: 2,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 2 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(2, i), // Pass selection callback
                  ),
              ],
            ),
          ),

          // Fourth Grid
          SizedBox(
            width: 100,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: [
                for (int i = 0; i < 4; i++)
                  MandalartBox2(
                    hintNum2: 3,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 3 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(3, i), // Pass selection callback
                  ),
                MandalartBox1(
                  hintNum: 3,
                  mandalart: widget.mandalart,
                  secondGoals: widget.secondGoals,
                ),
                for (int i = 4; i < 8; i++)
                  MandalartBox2(
                    hintNum2: 3,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 3 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(3, i), // Pass selection callback
                  ),
              ],
            ),
          ),

          // Fifth Grid
          SizedBox(
            width: 100,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                for (int i = 0; i < 4; i++)
                  MandalartBox1(
                    hintNum: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                  ),
                Container(
                  margin: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.yellow,
                  ),
                  child: Center(
                    child: Text(
                      widget.mandalart,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: backgroundColor, fontWeight: FontWeight.w600, fontSize: 12)
                    ),
                  ),
                ),
                for (int i = 5; i < 9; i++)
                  MandalartBox1(
                    hintNum: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                  ),
              ],
            ),
          ),

          // Sixth Grid
          SizedBox(
            width: 100,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: [
                for (int i = 0; i < 4; i++)
                  MandalartBox2(
                    hintNum2: 5,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 5 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(5, i), // Pass selection callback
                  ),
                MandalartBox1(
                  hintNum: 5,
                  mandalart: widget.mandalart,
                  secondGoals: widget.secondGoals,
                ),
                for (int i = 4; i < 8; i++)
                  MandalartBox2(
                    hintNum2: 5,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 5 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(5, i), // Pass selection callback
                  ),
              ],
            ),
          ),

          // Seventh Grid
          SizedBox(
            width: 100,
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: [
                for (int i = 0; i < 4; i++)
                  MandalartBox2(
                    hintNum2: 6,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 6 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(6, i), // Pass selection callback
                  ),
                MandalartBox1(
                  hintNum: 6,
                  mandalart: widget.mandalart,
                  secondGoals: widget.secondGoals,
                ),
                for (int i = 4; i < 8; i++)
                  MandalartBox2(
                    hintNum2: 6,
                    hintNum3: i,
                    mandalart: widget.mandalart,
                    secondGoals: widget.secondGoals,
                    isSelected:
                        _selectedBoxHintNum2 == 6 && _selectedBoxHintNum3 == i,
                    onSelect: () => _selectBox(6, i), // Pass selection callback
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MandalartBox1 extends StatelessWidget {
  final int hintNum;
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;

  const MandalartBox1({
    super.key,
    required this.hintNum,
    required this.mandalart,
    required this.secondGoals,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color:
            secondGoals.isNotEmpty && secondGoals[hintNum]['secondGoal'] != ""
                ? Color(int.parse(secondGoals[hintNum]['color']
                    .replaceAll('Color(', '')
                    .replaceAll(')', '')))
                : Colors.transparent,
      ),
      child: Center(
        child: Text(
          secondGoals.isNotEmpty && secondGoals[hintNum]['secondGoal'] != ""
              ? secondGoals[hintNum]['secondGoal']
              : "",
          textAlign: TextAlign.center,
          style: const TextStyle(color: backgroundColor, fontWeight: FontWeight.w600, fontSize: 12)
        ),
      ),
    );
  }
}

class MandalartBox2 extends StatefulWidget {
  final int hintNum2;
  final int hintNum3;
  final String mandalart;
  final List<Map<String, dynamic>> secondGoals;
  final bool isSelected; // New parameter to track selection
  final VoidCallback onSelect; // Callback to handle selection
  final Map<Color, Color> colorPalette = {
    const Color(0xffFF7A7A): const Color(0xffFFC2C2),
    const Color(0xffFFB82D): const Color(0xffFFD19B),
    const Color(0xffFCFF62): const Color(0xffFEFFCD),
    const Color(0xff72FF5B): const Color(0xffC1FFB7),
    const Color(0xff5DD8FF): const Color(0xff94E5FF),
    const Color(0xff929292): Colors.transparent,
    const Color(0xffFF5794): const Color(0xffFF8EB7),
    const Color(0xffAE7CFF): const Color(0xffD0B4FF),
    const Color(0xffC77B7F): const Color(0xffEBB6B9),
    const Color(0xff009255): const Color(0xff6DE1B0),
    const Color(0xff3184FF): const Color(0xff8CBAFF),
    const Color(0xff11D1C2): const Color(0xffAAF4EF),
  };

  MandalartBox2({
    super.key,
    required this.hintNum2,
    required this.hintNum3,
    required this.mandalart,
    required this.secondGoals,
    required this.isSelected, // Accept isSelected
    required this.onSelect, // Accept onSelect callback
  });

  @override
  State<MandalartBox2> createState() => _MandalartBox2State();
}

class _MandalartBox2State extends State<MandalartBox2> {
  @override
  Widget build(BuildContext context) {
    final color = widget.secondGoals.isNotEmpty &&
            widget.secondGoals[widget.hintNum2]['thirdGoals']
                .asMap()
                .containsKey(widget.hintNum3)
        ? Color(int.parse(widget.secondGoals[widget.hintNum2]['color']
            .replaceAll('Color(', '')
            .replaceAll(')', '')))
        : Colors.transparent;

    return GestureDetector(
      onTap: () {
        widget.onSelect();
        widget.secondGoals[widget.hintNum2]['thirdGoals'].isNotEmpty &&
                widget.secondGoals[widget.hintNum2]['thirdGoals']
                    .asMap()
                    .containsKey(widget.hintNum3) &&
                widget.secondGoals[widget.hintNum2]['thirdGoals']
                        [widget.hintNum3]['thirdGoal'] !=
                    ""
            ? context.read<SelectAPModel>().selectAP(
                widget.secondGoals[widget.hintNum2]['thirdGoals']
                    [widget.hintNum3]['thirdGoal'],
                widget.secondGoals[widget.hintNum2]['thirdGoals']
                    [widget.hintNum3]['id'])
            : context.read<SelectAPModel>().selectAP("NA Name", null);
        // Call the onSelect callback
      },
      child: Container(
        margin: const EdgeInsets.all(1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: widget.secondGoals.isNotEmpty &&
                  widget
                      .secondGoals[widget.hintNum2]['thirdGoals'].isNotEmpty &&
                  widget.secondGoals[widget.hintNum2]['thirdGoals']
                      .asMap()
                      .containsKey(widget.hintNum3) &&
                  widget.secondGoals[widget.hintNum2]['thirdGoals']
                          [widget.hintNum3]['thirdGoal'] ==
                      ""
              ? Colors.transparent
              : widget.colorPalette[color],
          border: widget.isSelected // Use the passed isSelected
              ? Border.all(color: Colors.blue, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            widget.secondGoals.isNotEmpty &&
                    widget.secondGoals[widget.hintNum2]['thirdGoals']
                        .isNotEmpty &&
                    widget.secondGoals[widget.hintNum2]['thirdGoals']
                        .asMap()
                        .containsKey(widget.hintNum3)
                ? widget.secondGoals[widget.hintNum2]['thirdGoals']
                    [widget.hintNum3]['thirdGoal']
                : "",
            textAlign: TextAlign.center,
            style: const TextStyle(color: backgroundColor, fontWeight: FontWeight.w400, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
