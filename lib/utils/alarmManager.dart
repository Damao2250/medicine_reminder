import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import '../DataManager.dart';
import 'localNotification.dart';

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

void printPeriodic() async {
  print("开始播放闹钟");
  FlutterRingtonePlayer.playAlarm(
    looping: false,
    volume: 1.0,
  );
  await sleep(Duration(seconds: 5));
  FlutterRingtonePlayer.stop();
  print("停止播放闹钟");
}

void rington() async {
  Dao dao = new Dao();
  initNotification();
  await dao.openSqlite();
  DataManager dataManager = new DataManager(dao);
  await dataManager.load();
//  printHello();
  final DateTime now = DateTime.now();
  print("current time = (" +
      now.hour.toString() +
      ":" +
      now.minute.toString() +
      ")");
  var shouldPlay = false;
  var content = "";
  var medicines = await dao.getMedicinesAtTime(TimeOfDay.now());
  var flag = false;
  for (var medicine in medicines) {
    if (flag) {
      content = content +
          "，" +
          medicine.getName() +
          medicine.getNumber().toString() +
          medicine.getUnit();
    } else {
      content = medicine.getName() +
          medicine.getNumber().toString() +
          medicine.getUnit();
      flag = true;
    }
    shouldPlay = true;
  }
  content = content + "。";
  if (shouldPlay) {
    showNotification('该吃药了', content);
    await printPeriodic();
  } else {
    print("不响铃");
  }
}
