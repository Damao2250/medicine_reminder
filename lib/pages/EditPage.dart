import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_reminder/utils/fontSize.dart';
import 'package:medicine_reminder/utils/time.dart';
import '../models/medicine.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var name = '药物名称';
  var number = "此";
  var inited = false;
  String unit = "片";
  List<TimeOfDay> times = [];

  _showTimePicker(index) async {
    var picker =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      print(picker);
      if (picker != null) {
        this.times[index] = picker;
      }
    });
  }

  void saveMedicine() async {
    Medicine medicine = Medicine(this.name, this.number, this.times, this.unit);
    Navigator.pop(context, medicine);
  }

  @override
  Widget build(BuildContext context) {
    print(" edit page" + context.toString());

    final Map args = ModalRoute.of(context).settings.arguments;
    if (inited == false && args['drug'] != null) {
      Medicine drug = args['drug'];
      this.name = drug.name;
      this.number = drug.number;
      print("init number");
      this.times = drug.getTimes();
      this.unit = drug.getUnit();
    }
    inited = true;
    var list = <Widget>[
      ListTile(
        title: Text(
          "药品名称",
          style: TextStyle(fontSize: oneSize),
        ),
        subtitle: Text(
          this.name,
          style: TextStyle(fontSize: oneSize),
        ),
      ),
      ListTile(
        title: Text(
          "每日次数",
          style: TextStyle(fontSize: oneSize),
        ),
        subtitle: TextField(
            decoration: InputDecoration(
              hintText: this.number.toString(),
              prefixIcon: Icon(Icons.description),
            ),
            onChanged: (val) {
              setState(() {
                this.number = int.parse(val);
              });
            },
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly, //只输入数字
              LengthLimitingTextInputFormatter(2), //限制长度
            ],
            style: TextStyle(fontSize: oneSize)),
      ),
      ListTile(
        title: Text(
          "剂量单位",
          style: TextStyle(fontSize: oneSize),
        ),
        subtitle: TextField(
          decoration: InputDecoration(
            hintText: this.unit,
            prefixIcon: Icon(Icons.description,size: oneSize),
          ),
          onChanged: (val) {
            setState(() {
              this.unit = val;
            });
          },
          style: TextStyle(fontSize: oneSize),
        ),
      ),
      ListTile(
        title: Text(
          "服药时间",
          style: TextStyle(fontSize: oneSize),
        ),
        subtitle: IconButton(
          icon: Icon(Icons.add_alarm,size: oneSize),
          onPressed: () {
            setState(() {
              this.times.add(TimeOfDay.now());
            });
          },
        ),
      ),
    ];

    for (int index = 0; index < this.times.length; index++) {
      list.add(
        RaisedButton(
            child: ListTile(
                leading: Icon(Icons.alarm,size: oneSize),
                title: Text(timeFormat(this.times[index]),
                    style: TextStyle(fontSize: oneSize)),
                trailing: IconButton(
                  icon: Icon(Icons.delete_forever,size: oneSize),
                  onPressed: () {
                    setState(() {
                      this.times.removeAt(index);
                    });
                  },
                )),
            onPressed: () => _showTimePicker(index)),
      );
      list.add(
        Divider(
          height: 10.0,
          indent: 0.0,
          color: Colors.red,
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "编辑",
          style: TextStyle(fontSize: oneSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: list,
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
            child: Text(
              "保存",
              style: TextStyle(fontSize: oneSize),
            ),
            onPressed: () {
              saveMedicine();
            }),
        FlatButton(
          child: Text(
            "取消",
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
