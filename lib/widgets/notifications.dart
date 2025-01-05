import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;

curl -X 'PUT' ;
  'http://13.124.78.26:8080/api/user/morning_alarm' ;
  -H 'accept: */*' ;
  -H 'Content-Type: application/json' ;
  -d '{
  "alarm": "ON"
};

curl -X 'PUT' ;
  'http://13.124.78.26:8080/api/user/night_alarm' ;
  -H 'accept: */*' ;
  -H 'Content-Type: application/json' ;
  -d '{
  "alarm": "ON"
};

class Alarm extends Statefulwidget {
}
const AlarmPage({Key? key}): super(key: key);
@override
State<Alarm> createState() => _AlarmPageState();
class _AlarmPageState extends State<AlarmPage> {
final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin FlutterLocalNotificationsPlugin();

@override
void initState() {
super.initState();
_init();
  }
}

Future<void> configureTime() async {
tz.initializeTimeZones();
final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone(); tz.setLocalLocation(tz.getLocation(timeZoneName!));
Future<void> initializeNoti() async {
const Android InitializationSettings initializationSettingsAndroid
=
AndroidInitializationSettings('@mipmap/ic_launcher');
const InitializationSettings initializationSettings =
InitializationSettings(
android: initializationSettingsAndroid,
await _flutterLocalNotificationsPlugin.initialize(initializationSettings);)
}

required int hour,
Future<void> _MessasgeSetting({
required int minutes,
required message,
}) async {
final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
tz.TZDateTime scheduledDate = tz.TZDateTime(
tz.local,
now. year,
now.month,
now.day,
hour, 
minutes,
);

await _flutterLocalNotificationsPlugin.zonedSchedule(
'Push_notification',
message,
scheduledDate,
NotificationDetails(
android: AndroidNotificationDetails(
'channel id',
'channel name'
importance: Importance.max,
priority: Priority.high,
ongoing: true,
styleInformation: BigTextStyleInformation (message),
icon: 'assets/img/dominho.png',
),

androidAllowwhileIdle: true,
uiLocalNotificationDateInterpretation:
UILocalNotificationDateInterpretation. absoluteTime,
matchDateTimeComponents: DateTimeComponents.time,
);
}
Future<void> _init() async {
await configureTime();
await initializeNotice();
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: Container(
child: Center(
child: ElevatedButton(
onPressed: () async {
final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
await _MessasgeSetting(
message: '오늘의 도미노를 체크해줘!',
);
},
child: Text('오늘이 거의 끝나간다... 오늘의 도미노를 체크해줘 !\nFrom. 도민호'),
)),
)
)
}

@override
Widget build(BuildContext context) {
return Scaffold(
body: Container(
child: Center(
child: ElevatedButton(
onPressed: () async {
final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
await _MessasgeSetting(
message: '오늘도 화이팅!',
);
},
child: Text('상쾌한 마음으로 오늘 하루도 화이팅해보자!!\nFrom. 도민호'),
)),
)
)
}
