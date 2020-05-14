import 'package:flutter/material.dart';
import 'package:medicine_reminder/models/userInfo.dart';
import 'package:medicine_reminder/utils/fontSize.dart';
import '../DataManager.dart';
import 'LoginPage.dart';
import 'package:medicine_reminder/utils/TsUtils.dart';
import 'package:flutter/services.dart';

class InfoDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new InfoDetailPageState();
  }
}

class InfoDetailPageState extends State<InfoDetailPage> {
  var userName = "未登录";
  var phone = "";
  var sex = "male";
  var stature = 0;
  var weight = 0;
  var waistline = 0;
  var token = "";
  var pwd = "";

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    var token = await dataManager.getToken();
    if (token[0]['token']!="" || token[0]['token']!=null) {
      var user = await dataManager.getUser(token[0]['token']);
      setState(() {
        token = token[0]['token'];
        pwd = user[0].getPwd();
        userName = user[0].getUserName();
        phone = user[0].getPhone();
        sex = user[0].getSex();
        stature = user[0].getStature();
        weight = user[0].getWeight();
        waistline = user[0].getWaistline();
      });
      print("userName");
      print(userName);
    }
  }

  isNotLogin() {
    // return (
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('当前用户未登录，马上去登录？'),
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
                    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                      return new LoginPage();
                    }));
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

    // );
  }

  void saveUserInfo() async {
    var res = await dataManager.updataUserInfo(this.userName,this.phone, this.sex, this.stature, this.weight, this.waistline);
    if(res == "succeed"){
      TsUtils.showShort('保存成功');
    }
  }

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[
      ListTile(
        title: Text(
          "用户名称",
          style: TextStyle(fontSize: oneSize),
        ),
        subtitle: Text(
          this.userName,
          style: TextStyle(fontSize: oneSize, height: 2),
        ),
      ),
      ListTile(
        title: Text(
          "手机号码",
          style: TextStyle(fontSize: oneSize),
        ),
        subtitle: TextField(
            decoration: InputDecoration(
              hintText: this.phone,
              prefixIcon: Icon(Icons.description),
            ),
            onChanged: (val) {
              setState(() {
                this.phone = val;
              });
            },
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly, //只输入数字
              LengthLimitingTextInputFormatter(13), //限制长度
            ],
            style: TextStyle(fontSize: oneSize)),
      ),
      ListTile(
        title: Text(
          "我的身高(cm)",
          style: TextStyle(fontSize: oneSize),
        ),
        subtitle: TextField(
          decoration: InputDecoration(
            hintText: this.stature.toString(),
            prefixIcon: Icon(Icons.description, size: oneSize),
          ),
          onChanged: (val) {
            setState(() {
              this.stature = int.parse(val);
            });
          },
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly, //只输入数字
            LengthLimitingTextInputFormatter(3), //限制长度
          ],
          style: TextStyle(fontSize: oneSize),
        ),
      ),
      ListTile(
        title: Text(
          "我的体重(kg)",
          style: TextStyle(fontSize: oneSize),
        ),
        subtitle: TextField(
          decoration: InputDecoration(
            hintText: this.weight.toString(),
            prefixIcon: Icon(Icons.description, size: oneSize),
          ),
          onChanged: (val) {
            setState(() {
              this.weight = int.parse(val);
            });
          },
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly, //只输入数字
            LengthLimitingTextInputFormatter(3), //限制长度
          ],
          style: TextStyle(fontSize: oneSize),
        ),
      ),
      ListTile(
        title: Text(
          "我的腰围(cm)",
          style: TextStyle(fontSize: oneSize),
        ),
        subtitle: TextField(
          decoration: InputDecoration(
            hintText: this.waistline.toString(),
            prefixIcon: Icon(Icons.description, size: oneSize),
          ),
          onChanged: (val) {
            setState(() {
              this.waistline = int.parse(val);
            });
          },
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly, //只输入数字
            LengthLimitingTextInputFormatter(3), //限制长度
          ],
          style: TextStyle(fontSize: oneSize),
        ),
      ),
    ];
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true, // 标题居中
        title: Text(
          "个人资料",
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
              // saveMedicine();
              if(this.userName == "未登录"){
                isNotLogin();
              }else{
                saveUserInfo();
              }
            }),
      ],
    );
  }
}
