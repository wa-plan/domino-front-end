import 'package:http/http.dart' as http;
import 'package:domino/apis/api_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Services {
  static const String url = 'http://192.168.0.29:8080';

  static Future<List<Goal>> getData() async {
    try {
      final response = await http.get(Uri.parse(url));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<Goal> goals = goalFromJson(response.body);
        return goals;
      } else {
        Fluttertoast.showToast(msg: 'Error occurred. Please try again');
        return <Goal>[];
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      print('Exception: $e');
      return <Goal>[];
    }
  }
}
