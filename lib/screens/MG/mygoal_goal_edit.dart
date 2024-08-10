import 'package:domino/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

//import 'package:domino/mg_api_function.dart';
import 'package:domino/screens/MG/mygoal_main.dart';
import 'package:provider/provider.dart';

class AddPage1 extends StatefulWidget {
  const AddPage1({super.key});

  @override
  State<AddPage1> createState() => _AddPage1State();
}

class _AddPage1State extends State<AddPage1> {
  String? selectedGoal;
  String nextStage = '';

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Text(
            '도미노 만들기',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '어떤 목표인가요?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: const Color(0xff5C5C5C),
                      )),
                  child: TextField(
                    ),
                   const Text(
                  '언제까지 목표를 이루고 싶나요?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        color: const Color(0xff5C5C5C),
                      )),
                  void _selectDataCalendar_Expecteddate_visit(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return SafeArea(
              child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: 550,
              child: SfDateRangePicker(
                monthViewSettings: DateRangePickerMonthViewSettings(
                  dayFormat: 'EEE',
                ),
                monthFormat: 'MMM',
                showNavigationArrow: true,
                headerStyle: DateRangePickerHeaderStyle(
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(fontSize: 25, color: Colors.blueAccent),
                ),
                headerHeight: 80,
                view: DateRangePickerView.month,
                allowViewNavigation: false,
                backgroundColor: ThemeData.light().scaffoldBackgroundColor,
                initialSelectedDate: DateTime.now(),
                minDate: DateTime.now(),
                maxDate: DateTime.now().add(new Duration(days: 365)),
                selectionMode: DateRangePickerSelectionMode.single,
                confirmText: '완료',
                cancelText: '취소',
                onSubmit: (args) => {
                  setState(() {
                    _EstimatedEditingController.clear();
                    //tempPickedDate = args as DateTime?;
                    _DataTimeEditingController.text = args.toString();
                    convertDateTimeDisplay(
                        _DataTimeEditingController.text, '방문');
                    Navigator.of(context).pop();
                  }),
                },
                onCancel: () => Navigator.of(context).pop(),
                showActionButtons: true,
              ),
            ),
          ));
        });
  }

  String convertDateTimeDisplay(String date, String text) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    if (text == '방문') {
      _EstimatedEditingController.clear();
      return _DataTimeEditingController.text =
          serverFormater.format(displayDate);
    } else
      return _EstimatedEditingController.text =
          serverFormater.format(displayDate);
  }
