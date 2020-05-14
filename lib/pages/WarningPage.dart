import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/models/medicine.dart';
import 'package:medicine_reminder/models/mlsWarn.dart';
import 'package:medicine_reminder/utils/fontSize.dart';

class WarningPage extends StatefulWidget {
  WarningPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WarningPageState createState() => _WarningPageState();
}

class _WarningPageState extends State<WarningPage> {
  void nextPage(String name) async {
    Medicine drug = Medicine(name, 0, [], "片");
    Navigator.pushNamed(context, "EditPage", arguments: {"drug": drug})
        .then((val) {
      Navigator.pop(context, val);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(" warn page" + context.toString());

    final Map args = ModalRoute.of(context).settings.arguments;

    Warn detail = args['detail'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "安全警告",
          style: TextStyle(fontSize: oneSize),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(
              "药物名称:",
              style: TextStyle(fontSize: oneSize),
            ),
            subtitle: Text(
              detail.nameWithUnit,
              style: TextStyle(fontSize: oneSize),
            ),
          ),
          ListTile(
            title: Text(
              "用药注意事项:",
              style: TextStyle(fontSize: oneSize),
            ),
            subtitle: Text(
              detail.attention,
              style: TextStyle(fontSize: oneSize),
            ),
          ),
          ListTile(
            title: Text(
              "老年人用药安全:",
              style: TextStyle(fontSize: oneSize),
            ),
            subtitle: Text(
              detail.safe,
              style: TextStyle(fontSize: oneSize),
            ),
          ),
        ],
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          child: Text(
            "继续",
            style: TextStyle(fontSize: oneSize),
          ),
          onPressed: () {
            nextPage(detail.nameWithUnit);
          },
        ),
        FlatButton(
          child: Text(
            "返回",
            style: TextStyle(fontSize: oneSize),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
