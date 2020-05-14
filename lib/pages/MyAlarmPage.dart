import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/models/mlsWarn.dart';
import 'package:medicine_reminder/utils/fontSize.dart';
import 'package:medicine_reminder/utils/screenSize.dart';
import 'package:medicine_reminder/utils/time.dart';
import '../DataManager.dart';
import '../models/alarm.dart';

class MyAlarmPage extends StatefulWidget {
  MyAlarmPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyAlarmPageState createState() => _MyAlarmPageState();
}

class _MyAlarmPageState extends State<MyAlarmPage> {
  List<Alarm> alarms = dataManager.getAlarms();

  Warn getDetail(name) {
    for (int i = 0; i < Warns.length; i++) {
      if (Warns[i].nameWithUnit == name) {
        return Warns[i];
      }
    }
    return null;
  }

  void goToDetail(name) async {
    Warn detail = getDetail(name);
    if (detail != null) {
      Navigator.pushNamed(context, "DetailPage", arguments: {"detail": detail});
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = <Widget>[];

    for (int i = 0; i < alarms.length; i++) {
//      print(alarms[i].time.hour.toString() +":"+alarms[i].time.minute.toString());
      List<Widget> tmp = <Widget>[];
      for (int j = 0; j < alarms[i].medicines.length; j++) {
        tmp.add(ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text(
              alarms[i].medicines[j].getName(),
              style: TextStyle(fontSize: oneSize),
            ),
            subtitle: Text(
              alarms[i].medicines[j].getNumber().toString() +
                  " " +
                  alarms[i].medicines[j].getUnit(),
              style: TextStyle(fontSize: oneSize),
            ),
            onTap: () {
              goToDetail(alarms[i].medicines[j].getName());
            }));
      }

      list.add(Container(
        child: ListTile(
          leading: Icon(Icons.access_time),
          title: Text(
            timeFormat(alarms[i].time),
            style: TextStyle(fontSize: oneSize),
          ),
          subtitle: ListView(
            children: tmp,
            shrinkWrap: true, //解决无限高度问题
            physics: NeverScrollableScrollPhysics(), //禁用滑动事件
          ),
        ),
        width: width / pix,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "明细列表",
          style: TextStyle(fontSize: oneSize),
        ),
      ),
      body: ListView(children: list),
    );
  }
}
