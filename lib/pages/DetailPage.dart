import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/models/mlsWarn.dart';
import 'package:medicine_reminder/utils/fontSize.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    print(" warn page" + context.toString());

    final Map args = ModalRoute.of(context).settings.arguments;

    Warn detail = args['detail'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "药品详情",
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
              style: TextStyle(fontSize: twoSize),
            ),
          ),
          ListTile(
            title: Text(
              "用药注意事项:",
              style: TextStyle(fontSize: oneSize),
            ),
            subtitle: Text(
              detail.attention,
              style: TextStyle(fontSize: twoSize),
            ),
          ),
          ListTile(
            title: Text(
              "老年人用药安全:",
              style: TextStyle(fontSize: oneSize),
            ),
            subtitle: Text(
              detail.safe,
              style: TextStyle(fontSize: twoSize),
            ),
          ),
        ],
      ),
      persistentFooterButtons: <Widget>[
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
