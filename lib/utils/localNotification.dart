import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> onDidReceiveLocalNotification(int id, String title, String body, String payload) async {}
Future onSelectNotification(String payload) async {}
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future showNotification(String title,String content) async {
  //安卓的通知配置，必填参数是渠道id, 名称, 和描述, 可选填通知的图标，重要度等等。
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  //IOS的通知配置
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //显示通知，其中 0 代表通知的 id，用于区分通知。
  await flutterLocalNotificationsPlugin.show(
      0, title, content, platformChannelSpecifics,
      payload: 'complete');
}

void initNotification() {
  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
  new AndroidInitializationSettings('xigua');
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}
