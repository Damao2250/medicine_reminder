import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class TsUtils{
  static showShort(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white
    );
  }
}