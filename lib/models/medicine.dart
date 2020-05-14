import 'package:flutter/material.dart';

class Medicine {
  String name = "name"; // 药品名称
  int number = 0; // 每次剂量
  List<TimeOfDay> times = []; // 每天吃药时间
  String unit;  // 剂量单位

  Medicine(this.name, this.number, this.times, this.unit);

  String getName() {
    return this.name;
  }

  int getNumber() {
    return this.number;
  }

  List<TimeOfDay> getTimes() {
    return this.times;
  }

  void setName(String name) {
    this.name = name;
  }

  void setNumber(int number) {
    this.number = number;
  }

  void setTimes(List<TimeOfDay> times) {
    this.times = times;
  }

  void setUnit(String unit) {
    this.unit = unit;
  }

  String getUnit() {
    return this.unit;
  }
}
