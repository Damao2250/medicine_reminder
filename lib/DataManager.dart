import 'package:flutter/material.dart';
import 'package:medicine_reminder/utils/time.dart';
import 'package:sqflite/sqflite.dart';
// 创建数据表 model
import 'models/alarm.dart';
import 'models/medicine.dart';
import 'models/userInfo.dart';
import 'models/token.dart';

class Dao {
  Database db;

  // 删除Token表
  dropTokenTable() async {
    await db.execute('''
     DROP TABLE IF EXISTS Token;
    ''');
    print("删除Token");
  }

  // 创建Token表
  createTokeknTable() async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS Token (
            token TEXT
            )
          ''');
    print("创建用户表");
  }

  // 删除用户表
  dropUserTable() async {
    await db.execute('''
     DROP TABLE IF EXISTS UserInfo;
    ''');
    print("删除用户表");
  }

  // 创建用户表
  createUserTable() async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS UserInfo (
            id INTEGER PRIMARY KEY, 
            userName TEXT, 
            pwd Text,
            phone TEXT, 
            sex TEXT, 
            stature INT,
            weight INT,
            waistline INT
            )
          ''');
    print("创建用户表");
  }

  // 查询是否有数据表，有就删除
  dropTable() async {
    await db.execute('''
     DROP TABLE IF EXISTS Drug;
    ''');
    await db.execute('''
     DROP TABLE IF EXISTS DrugTime;
    ''');
    print("删除数据表");
  }

  // 创建数据表
  createTable() async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS Drug (
            id INTEGER PRIMARY KEY, 
            name TEXT, 
            number INT,
            unit TEXT
            )
          ''');
    await db.execute('''CREATE TABLE IF NOT EXISTS DrugTime (
            did INTETER,
            hour INTEGER,
            minute INTEGER
            )
         ''');
    print("创建数据表");
  }

  // 连接数据库
  openSqlite() async {
    db = await openDatabase("deno.db", version: 1);
    await createUserTable();
    await createTable();
    await createTokeknTable();
    print("打开数据库");
  }

  // 关闭数据库
  close() async {
    if (db != null) {
      await db.close();
    }
    print("关闭数据库");
  }

  // 删除所有药物
  deleteAllMedicine() async {
    await dropTable();
    await createTable();
  }

  // 插入药物
  void insertMedicines(List<Medicine> drugs) async {
    await dropTable();
    await createTable();
    for (int i = 0; i < drugs.length; i++) {
      await db.insert("Drug", {
        "id": i,
        "name": drugs[i].getName(),
        "number": drugs[i].getNumber(),
        "unit": drugs[i].getUnit()
      });
      List<TimeOfDay> times = drugs[i].getTimes();
      for (int j = 0; j < times.length; j++) {
        TimeOfDay time = times[j];
        await db.insert(
            "DrugTime", {"did": i, "hour": time.hour, "minute": time.minute});
      }
    }
  }

  // 插入用户
  void insertUser(List<UserInfo> users) async {
    for (int i = 0; i < users.length; i++) {
      await db.insert("UserInfo",{
        "username": users[i].userName,
        "pwd": users[i].pwd
      });
    }
    print("SQL插入用户");
  }

  // 更新用户信息
  void updateUser(userName,phone,sex,stature,weight,waistline) async {
    await db.rawUpdate(
    'UPDATE UserInfo SET phone = ?,sex = ?, stature= ?, weight = ?, waistline = ? WHERE userName = ?',
    [phone,sex,stature,weight,waistline,userName]);
    print("更新用户信息");
  }

  // 设置token
  void setUserToken(token) async {
    await dropTokenTable();
    await createTokeknTable();
    await db.insert("Token",{
        "token": token
      });
    var res = await db.query("Token");
    print(res);
  }

  // 获取token
  getUserToken() async {
    var res = await db.query("Token");
    print("token");
    print(res);
    return res;
  }

  // 删除Token
  deleteToken() async {
    await dropTokenTable();
    await createTokeknTable();
  }

  // 查询用户
  Future<List<UserInfo>> getUser(userName) async {
    List<UserInfo> users = [];
    List<Map<String, dynamic>> lmp =
        await db.query("UserInfo", where: "userName=?", whereArgs: [userName]);
        print("lmp");
        print(lmp);
        print(lmp.length);
        if (lmp.length == 0) return users;
        for (var item in lmp) {
          print("item");
          print(item['userName']);
          var user = UserInfo(item['userName'], item['pwd'], item['phone'], item['sex'], item['stature'], item['weight'], item['waistline']);

          users.add(user);
          print(user.getUserName());
          print(users);
        }
    print(users);
    return users;
  }

  // 获取时间列表
  Future<List<Medicine>> getMedicinesAtTime(TimeOfDay time) async {
    List<Medicine> drugs = [];
    List<Map<String, dynamic>> tmp = await db.query("DrugTime",
        columns: ["did"],
        where: "hour = ? and minute = ?",
        whereArgs: [time.hour, time.minute]);
    print("tmp=" + tmp.toString());
    for (var item in tmp) {
      var id = item['did'];
      List<Map<String, dynamic>> lmp =
          await db.query("Drug", where: "id=?", whereArgs: [id]);
      print("lmp=" + lmp.toString());
      for (var each in lmp) {
        var drug = Medicine(each['name'], each['number'], [time], each['unit']);
        drugs.add(drug);
      }
    }
    return drugs;
  }

  // 获取药物列表
  Future<List<Medicine>> getMedicines() async {
    List<Medicine> drugs = [];
    List<Map<String, dynamic>> lmp = await db.query("Drug");
//    print("lmp=" + lmp.toString());
    if (lmp == null) return drugs;
    for (var item in lmp) {
      List<Map<String, dynamic>> tmp =
          await db.query("DrugTime", where: "did=?", whereArgs: [item['id']]);
      List<TimeOfDay> times = [];
      for (var rt in tmp) {
        times.add(TimeOfDay(hour: rt['hour'], minute: rt['minute']));
      }
      var drug = Medicine(item['name'], item['number'], times, item['unit']);
      drugs.add(drug);
    }
    return drugs;
  }

  Future<List<UserInfo>> getUsers() async {
    List<UserInfo> users = [];
    List<Map<String, dynamic>> lmp = await db.query("UserInfo");
    if (lmp == null) return users;
    for (var item in lmp) {
      var user = UserInfo(item['userName'], item['pwd'], item['phone'], item['sex'], item['stature'], item['weight'], item['waistline']);
      users.add(user);
    }
    return users;
  }
}

class DataManager {
  List<Medicine> drugs = [];
  List<UserInfo> users = [];
  Dao dao;

  DataManager(this.dao);

  Medicine getMedicine(int index) {
    if (index < drugs.length)
      return drugs[index];
    else
      return null;
  }


  int getMedicineSize() {
    return drugs.length;
  }

  void addMedicine(Medicine medicine) {
    this.drugs.add(medicine);
  }

  void deleteMedicine(int index) {
    if (index < this.drugs.length) this.drugs.removeAt(index);
  }

  void deleteAllMedicine() async {
    this.drugs = [];
    await dao.deleteAllMedicine();
  }

  void setMedicine(int index, Medicine medicine) {
    if (index < this.drugs.length) this.drugs[index] = medicine;
  }

  void load() async {
    this.drugs = await dao.getMedicines();
    print("加载数据");
  }

  void loadUsers() async {
    this.users = await dao.getUsers();
    print("加载用户数据");
  }

  void save() async {
    await dao.insertMedicines(this.drugs);
    print("保存数据");
  }



  addUser(UserInfo userInfo) async {
    this.load();
    this.users.add(userInfo);
    await dao.insertUser(this.users);
    print("添加用户");
    return "succeed";
  }

  updataUserInfo(userName,phone,sex,stature,weight,waistline) async {
    await dao.updateUser(userName,phone,sex,stature,weight,waistline);
    print("更新用户");
    return "succeed";
  }

  getUser(userName) async {
    print("666->"+userName);
    this.users = await dao.getUser(userName);
    print("查询用户");
    return this.users;
  }

  setToken(token) async {
    await dao.setUserToken(token);
    print("设置token");
  }

  getToken() async {
    var res = await dao.getUserToken();
    print("获取token");
    print(res);
    return res;
  }

  deleteToken() async {
    await dao.deleteToken();
  }

  List<Alarm> getAlarms() {
    List<Alarm> alarms = [];
    for (var drug in this.drugs) {
      for (var time in drug.getTimes()) {
        bool has = false;
        for (int j = 0; j < alarms.length; j++) {
          if (alarms[j].time == time) {
            alarms[j].medicines.add(drug);
            has = true;
            break;
          }
        }
        if (has == false) {
          alarms.add(Alarm(time, [drug]));
        }
      }
    }

    // 冒泡排序
    int n = alarms.length;
    for (int i = 0; i < n; i++) {
      for (int j = i + 1; j < n; j++) {
        if (compareTimeOfDay(alarms[i].time, alarms[j].time) == false) {
          var tmp = alarms[i];
          alarms[i] = alarms[j];
          alarms[j] = tmp;
        }
      }
    }

//    for (int i = 0; i < alarms.length; i++) {
//      print(alarms[i].time.hour.toString() +
//          ":" +
//          alarms[i].time.minute.toString());
//    }

    return alarms;
  }
}

Dao dao = new Dao();

DataManager dataManager = new DataManager(dao);

