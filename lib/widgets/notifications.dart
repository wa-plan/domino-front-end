import 'package:flutter_local_notifications/flutter_local_notifications.dart';
         
showNotification() async {
await flutterLocalNotificationsPlugin.zonedSchedule(
0, //알림 id
'도닦기',
'오늘이 거의 끝나간다... 오늘의 도미노를 체크해줘 ! 
From. 도민호',

NotificationDetails(
android: AndroidNotificationDetails('channelId', 'channelName')),
uiLocalNotificationDateInterpretation:
UILocalNotificationDateInterpretation.absoluteTime,
androidAllowWhileIdle: true,
);

curl -X 'PUT' ;
  'http://13.124.78.26:8080/api/user/night_alarm' ;
  -H 'accept: */*' ;
  -H 'Content-Type: application/json' ;
  -d '{
  "alarm": "ON"
}'

/* 시간 설정 */
makeDate(20h, 10m, 20s) {
var now = tz.TZDateTime.now(tz.local);
var when = tz.TZDateTime(tz.local, now.year, now.month, now.day, h, m, s);
if (when.isBefore(now)) {
return when.add(Duration(days: 1));
} else {
return when;
