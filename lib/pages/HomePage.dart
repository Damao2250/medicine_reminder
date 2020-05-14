import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/utils/fontSize.dart';
import '../DataManager.dart';
import 'MedicineListComponent.dart';
import 'SelectPage.dart';
import 'MinePage.dart';
import '../models/medicine.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// 底部导航栏实现不同page的切换
class TabNavigator extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  // 定义默认状态
  int _currentIndex = 0;
  //定义一个pagecontroller 用于控制指定页面的显示
  final PageController _controller = PageController(
    initialPage: 0,
  );
  _addDrug() async {
    await Navigator.pushNamed(context, "SelectPage")
        .then((val) {
      if (val != null) {
        Medicine drug = val;
        setState(() {
          dataManager.addMedicine(drug);
          dataManager.save();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("用药提醒",style: TextStyle(fontSize: oneSize),),
      //   actions: <Widget>[
      //     FlatButton(
      //       child: Text("明细列表",style: TextStyle(fontSize: oneSize),),
      //       onPressed: () {
      //         Navigator.pushNamed(context, "AlarmPage");
      //       },
      //     ),
      //   ],
      // ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          //添加需要显示的页面
          MedicineListComponent(),
          MinePage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addDrug();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('用药提醒'),
          ),
          BottomNavigationBarItem(
            icon:Icon(Icons.person),
            title: Text('个人中心'),
          ),
        ],
        currentIndex: _currentIndex,
          onTap:(int index){
            _controller.jumpToPage(index);
            setState((){
              _currentIndex = index;
            });
          },
      )
    );
  }
}
