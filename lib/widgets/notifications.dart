import 'package:flutter_local_notifications/flutter_local_notifications.dart';

curl -X 'PUT' ;
  'http://13.124.78.26:8080/api/user/morning_alarm' ;
  -H 'accept: */*' ;
  -H 'Content-Type: application/json' ;
  -d '{
  "alarm": "ON"
}'

curl -X 'PUT' ;
  'http://13.124.78.26:8080/api/user/night_alarm' ;
  -H 'accept: */*' ;
  -H 'Content-Type: application/json' ;
  -d '{
  "alarm": "ON"
}'
         
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
         
/* 시간 설정 */
makeDate(20h, 10m, 20s) {
var now = tz.TZDateTime.now(tz.local);
var when = tz.TZDateTime(tz.local, now.year, now.month, now.day, h, m, s);
if (when.isBefore(now)) {
return when.add(Duration(days: 1));
} else {
return when;

showNotification() async {
await flutterLocalNotificationsPlugin.zonedSchedule(
0, //알림 id
'오늘의 할일!'
'오늘 해야하는 일은 총 [number]개야!'
'그럼 오늘도 같이 열심히 수련하자 !!'

[goalName]        

NotificationDetails(
android: AndroidNotificationDetails('channelId', 'channelName')),
uiLocalNotificationDateInterpretation:
UILocalNotificationDateInterpretation.absoluteTime,
androidAllowWhileIdle: true,
);
         
/* 시간 설정 */
makeDate(10h, 00m, 00s) {
var now = tz.TZDateTime.now(tz.local);
var when = tz.TZDateTime(tz.local, now.year, now.month, now.day, h, m, s);
if (when.isBefore(now)) {
return when.add(Duration(days: 1));
} else {
return when;
