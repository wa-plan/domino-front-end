import 'package:flutter/material.dart';
import 'package:domino/apis/dp_api_model.dart';
import 'package:domino/apis/dp_api_function.dart';

class JsonParse extends StatefulWidget {
  const JsonParse({super.key});

  @override
  State<JsonParse> createState() => _JsonParseState();
}

class _JsonParseState extends State<JsonParse> {
  List<Goal> _goal = <Goal>[];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    Services.getData().then((value) {
      setState(() {
        _goal = value;
        loading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(loading ? 'Goal' : 'Loading...')),
        body: ListView.builder(
            itemCount: _goal.length,
            itemBuilder: ((context, index) {
              Goal goal = _goal[index];
              return ListTile(
                leading: const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.blue,
                ),
                trailing: const Icon(
                  Icons.phone_android_outlined,
                  color: Colors.red,
                ),
                title: Text(goal.goal),
                subtitle: Text(goal.content),
              );
            })));
  }
}
