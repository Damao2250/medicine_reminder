import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'package:medicine_reminder/utils/fontSize.dart';
import '../DataManager.dart';
import 'package:medicine_reminder/utils/TsUtils.dart';


class MinePage extends StatefulWidget {
  MinePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  // static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  var userAvatar;
  var userName;
  var titles = ["我的资料", "明细列表", "清除数据", "退出登录"];
  var titleTextStyle = new TextStyle(fontSize: 16.0);
  var rightArrowIcon = new Image.asset(
    'assets/images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _login() async {
    dataManager.deleteToken();
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new LoginPage();
    }));
  }

  _userDetail() {
    print("detail");
  }

  _getUserInfo() async {
    var token = await dataManager.getToken();
    var user = await dataManager.getUser(token[0]['token']);
    setState(() {
      userName = user[0].getUserName();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // 标题居中
        title: Text(
          "用药提醒",
          style: TextStyle(fontSize: oneSize),
        ),
      ),
      body: new CustomScrollView(reverse: false, shrinkWrap: false, slivers: <
          Widget>[
        new SliverAppBar(
            pinned: false,
            backgroundColor: Colors.deepOrange,
            expandedHeight: 200.0,
            iconTheme: new IconThemeData(color: Colors.transparent),
            flexibleSpace: new InkWell(
                onTap: () {
                  userName == null ? _login() : _userDetail();
                },
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      "assets/images/ic_avatar_default.png",
                      width: 60.0,
                      height: 60.0,
                    ),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                      child: new Text(
                        userName == null ? '点击头像登录' : userName,
                        style:
                            new TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    )
                  ],
                ))),
        new SliverFixedExtentList(
          itemExtent: 55.0,
          delegate:
              new SliverChildBuilderDelegate((BuildContext context, int index) {
            //创建列表项
            String title = titles[index];
            return new Container(
                alignment: Alignment.centerLeft,
                child: new InkWell(
                  onTap: () {
                    print("the is the item of $title");
                    if(title == "我的资料"){
                      Navigator.pushNamed(context, "InfoDetailPage");
                    }

                    if (title == "明细列表") {
                      Navigator.pushNamed(context, "AlarmPage");
                    }
                    
                    if(title == "清除数据"){
                     print("清除数据");
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('确定清除所有数据吗？'),
                              title: Center(
                                  child: Text(
                                '提示',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      await dataManager.deleteAllMedicine();
                                      TsUtils.showShort('清除成功');
                                    },
                                    child: Text('确定')),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('取消')),
                              ],
                            );
                          });
                    }
                    if (title == "退出登录") {
                      print("exit");
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('确定退出登录吗？'),
                              title: Center(
                                  child: Text(
                                '提示',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      _login();
                                    },
                                    child: Text('确定')),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('取消')),
                              ],
                            );
                          });
                    }
                  },
                  child: SingleChildScrollView(
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                          child: new Row(
                            children: <Widget>[
                              new Expanded(
                                  child: new Text(
                                title,
                                style: titleTextStyle,
                              )),
                              rightArrowIcon
                            ],
                          ),
                        ),
                        new Divider(
                          height: 1.0,
                        )
                      ],
                    ),
                  ),
                ));
          }, childCount: titles.length),
        ),
      ]),
    );
  }
}
