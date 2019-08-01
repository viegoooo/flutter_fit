import 'package:flutter/material.dart';

class User {
  String uID;//唯一
  String name;
  int gender;
  int age;
  double height;
  double weight;
  int targetSteps;
  var health;

  //私有构造函数
  User._internal(){
    this.name = "";
    this.gender =1;
    this.age =1;
    this.height =178;
    this.weight =130;
    this.targetSteps =8000;
  }

  //保存单例
  static User _singleton = new User._internal();

  //工厂构造函数
  factory User()=> _singleton;




}

//个人健康相关信息
class Health {
  double sleepTime;
  var stress;
  var heartBeat;
  var bloodPressure;
  var bloodOxygen;
  var oxygenSaturation;
}

//运动（步行和跑步） 相关信息
class Sports {
  int todaySteps;
  double km;
  double kCal;
  int averageSteps; //平均步数
  int reachDays; //达标天数
  int sportDays; //运动天数
  double sportKm; //运动总公里数
}

// 各项记录信息
class Record {}
