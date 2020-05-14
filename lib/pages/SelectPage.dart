import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/models/conflits.dart';
import 'package:medicine_reminder/models/mlsWarn.dart';
import 'package:medicine_reminder/utils/editlength.dart';
import 'package:medicine_reminder/utils/fontSize.dart';

import '../DataManager.dart';

class SelectPage extends StatefulWidget {
  SelectPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SelectPageState createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  var options = [];
  var name = "";

  Warn getDetail(name) {
    for (int i = 0; i < Warns.length; i++) {
      if (Warns[i].nameWithUnit == name) {
        return Warns[i];
      }
    }
    return null;
  }

  List<String> searchNames(String name) {
//    print("search name " + name);
    var ans = List();
    int n = Warns.length;
    for (int i = 0; i < n; i++) {
      var cl = longest_common_sequence(Warns[i].name, name);
      var el = edit_length(Warns[i].name, name);
      ans.add({'cl': cl, 'el': el, 'name': Warns[i].nameWithUnit});
    }
//    print("cal end");
    // 冒泡排序，先按cl从大到小，然后el从小到大
    for (int i = 0; i < n; i++) {
      for (int j = i + 1; j < n; j++) {
        if ((ans[i]['cl'] < ans[j]['cl']) ||
            ((ans[i]['cl'] == ans[j]['cl']) && (ans[i]['el'] > ans[j]['el']))) {
          var t = ans[i];
          ans[i] = ans[j];
          ans[j] = t;
        }
      }
    }
    List<String> ret = List();
    for (int i = 0; i < n; i++) {
      ret.add(ans[i]['name']);
    }
    return ret;
  }

  void getOptions() async {
    var res = searchNames(name);
    // print(res);
    options = [];
    for (int i = 0; i < res.length; i++) {
      var flag = true;
      var tmp = res[i];
      for (int j = 0; j < dataManager.getMedicineSize(); j++) {
        var medicine = dataManager.getMedicine(j);
//        print(tmp + medicine.getName());
        if (medicine.getName() == tmp || isConfilts(medicine.getName(), tmp)) {
          flag = false;
          break;
        }
      }
      if (flag) {
        options.add(tmp);
      }
    }
    setState(() {});
  }

  void nextPage(String selectedName) async {
    Warn detail = getDetail(selectedName);
    Navigator.pushNamed(context, "WarningPage", arguments: {"detail": detail})
        .then((val) {
      Navigator.pop(context, val);
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(" select page" + context.toString());
    List<Widget> list = <Widget>[];
    for (int index = 0; index < this.options.length; index++) {
      list.add(
        ListTile(
            title: Text(
              options[index],
              style: TextStyle(fontSize: oneSize),
            ),
            onTap: () {
              nextPage(options[index]);
            }),
      );
      list.add(Divider(
        height: 10.0,
        indent: 0.0,
        color: Colors.red,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "选择药品",
          style: TextStyle(fontSize: oneSize),
        ),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "关键字",
              style: TextStyle(fontSize: oneSize),
            ),
            subtitle: TextField(
              autofocus: true, //是否自动获取焦点
              decoration: InputDecoration(
                hintText: this.name,
                prefixIcon: Icon(
                  Icons.search,
                  size: oneSize,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  this.name = val;
                  getOptions();
                });
              },
              style: TextStyle(fontSize: oneSize),
            ),
          ),
          ListTile(
            title: Text(
              "可吃药品",
              style: TextStyle(fontSize: oneSize),
            ),
          ),
          Expanded(
            child: ListView(
              children: list,
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
