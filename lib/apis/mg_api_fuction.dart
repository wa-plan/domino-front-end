/*import 'package:http/http.dart' as http;
import 'package:domino/apis/dp_api_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Goal {
  final String baseUrl = "http://13.124.78.26:8080/api/goal";

  Future<List<MyGoal>> getMyGoal() async {
    List<MyGoal> goalInstances = [];
    final url = Uri.parse("$baseUrl/$today");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> goal = jsonDecode(response.body);
      for (var Goal in MyGoal) {
        MygoalInstances.add(MyGoalModel.fromJson(domino));
      }
      return MyGoalInstances;
    }
    throw Error();
  }
}*/
