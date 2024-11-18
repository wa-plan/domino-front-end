import 'package:flutter_local_notifications/flutter_local_notifications.dart';
         
showNotification() async {
await flutterLocalNotificationsPlugin.zonedSchedule(
0, //알림 id
'도닦기',
'오늘도 힘내자!',
makeDate(18, 30, 0),
NotificationDetails(
android: AndroidNotificationDetails('channelId', 'channelName')),
uiLocalNotificationDateInterpretation:
UILocalNotificationDateInterpretation.absoluteTime,
androidAllowWhileIdle: true,
);

makeDate(20h, 10m, 20s) {
var now = tz.TZDateTime.now(tz.local);
var when = tz.TZDateTime(tz.local, now.year, now.month, now.day, h, m, s);
if (when.isBefore(now)) {
return when.add(Duration(days: 1));
} else {
return when;
