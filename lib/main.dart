import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/pages/DetailPage.dart';
import 'package:medicine_reminder/pages/SelectPage.dart';
import 'package:medicine_reminder/pages/WarningPage.dart';
import 'package:medicine_reminder/utils/alarmManager.dart';
import 'pages/EditPage.dart';
import 'pages/MyAlarmPage.dart';
import 'DataManager.dart';
import 'pages/HomePage.dart';
import 'utils/localNotification.dart';
import 'pages/LoginPage.dart';
import 'pages/MinePage.dart';
import 'pages/InfoDetailPage.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initNotification();
  await AndroidAlarmManager.initialize();
  await dao.openSqlite();
  await dataManager.loadUsers();
  await dataManager.load();

  runApp(MyApp());
//  await AndroidAlarmManager.periodic(const Duration(seconds: 5), 1, printHello);
  await AndroidAlarmManager.periodic(const Duration(seconds: 5), 2, rington);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

    
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      routes: {
        "LoginPage": (context) => LoginPage(),
        "HomePage": (context) => MyHomePage(),
        "AlarmPage": (context) => MyAlarmPage(),
        "EditPage": (context) => EditPage(),
        "WarningPage": (context) => WarningPage(),
        "SelectPage": (context) => SelectPage(),
        "DetailPage": (context) => DetailPage(),
        "MinePage": (context) => MinePage(),
        "InfoDetailPage": (context) => InfoDetailPage(),
      },
      
      // home: MyHomePage(),
      home: LoginPage(),
    );
  }
}
