import 'package:flutter/material.dart';
import 'package:medicine_reminder/utils/fontSize.dart';
import '../DataManager.dart';

class MedicineListComponent extends StatefulWidget {
  @override
  _MedicineListComponentState createState() {
    return _MedicineListComponentState();
  }
}

class _MedicineListComponentState extends State<MedicineListComponent> {
  @override
  Widget build(BuildContext context) {
    print(" list page" + context.toString());

    //定义列表widget的list
    List<Widget> list = <Widget>[];

    //根据Demo数据，构造列表ListTile组件list
    for (int index = 0; index < dataManager.getMedicineSize(); index++) {
      var drug = dataManager.getMedicine(index);
      list.add(
        ListTile(
          onTap: () {
            print("onPressed");
            Navigator.pushNamed(context, "EditPage", arguments: {"drug": drug})
                .then((val) {
              print(val);
              if (val != null) {
                setState(() {
                  dataManager.setMedicine(index, val);
                  dataManager.save();
                });
              }
            });
          },
          title: Text(
            drug.getName(),
            style: TextStyle(fontSize: oneSize),
          ),
          subtitle: Text(
            "每日 " +
                // drug.getTimes().length.toString() +
                drug.getNumber().toString()  +
                " 次，每次 " +
                drug.getUnit() + "片",
                //  +
                // " " +
                // drug.getUnit(),
            style: TextStyle(fontSize: oneSize),
          ),
          leading: Icon(
            Icons.fastfood,
            color: Colors.orange,
              size: oneSize,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete_forever,size: oneSize),
            onPressed: () {
              setState(
                () {
                  dataManager.deleteMedicine(index);
                  dataManager.save();
                },
              );
            },
          ),
        ),
      );
    }
    //返回整个页面
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "用药提醒",
          style: TextStyle(fontSize: oneSize),
        ),
      ),
      body: ListView(
        children: list,
      ),
    );
  }
}
