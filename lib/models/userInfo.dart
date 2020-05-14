import 'package:flutter/material.dart';

class UserInfo {
  String userName = ""; // 用户名
  String pwd = ""; // 密码
  String phone = ""; // 电话号码
  String sex = "male"; // 性别：male/female
  int stature = 180; // 身高 cm
  int weight = 50; // 体重 KG
  int waistline = 80; // 腰围 cm

  UserInfo(this.userName, this.pwd, this.phone, this.sex,this.stature,this.weight,this.waistline);


  String getUserName() {
    return this.userName;
  }
  void setUserName(String userName) {
    this.userName = userName;
  }

  
  String getPwd() {
    return this.pwd;
  }
  void setPwd(String pwd) {
    this.pwd = pwd;
  }

  String getPhone() {
    return this.phone;
  }
  void setPhone(String phone) {
    this.phone = phone;
  }

  String getSex() {
    return this.sex;
  }
  void setSex(String sex) {
    this.sex = sex;
  }

  int getStature() {
    return this.stature;
  }
  void setStature(int stature) {
    this.stature = stature;
  }

  int getWeight() {
    return this.weight;
  }
  void setWeight(int weight) {
    this.weight = weight;
  }

  int getWaistline() {
    return this.waistline;
  }
  void setWaistline(int waistline) {
    this.waistline = waistline;
  }



}