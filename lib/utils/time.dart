import 'package:flutter/material.dart';

String timeFormat(TimeOfDay t) {
  var ans = "";
  if (t.hour < 12) {
    ans = "上午 ";
  } else {
    ans = "下午 ";
  }
  if (t.hour > 12) {
    ans = ans + (t.hour - 12).toString();
  } else {
    ans = ans + t.hour.toString();
  }
  ans = ans + " 时 " + t.minute.toString() + " 分";
  return ans;
}

bool compareTimeOfDay(TimeOfDay a, TimeOfDay b) {
  // return a < b as bool;
  bool ans = true;
  if (a.hour.floor() != b.hour.floor()) {
    ans = a.hour.floor() < b.hour.floor();
  } else {
    ans = a.minute.floor() < b.minute.floor();
  }
//  print("compare " + a.hour.toString() + "~" + b.hour.toString() + " "+ans.toString());
  return ans;
}
