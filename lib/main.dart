import 'package:flutter/material.dart';
import 'package:flutter_fit/page/login_or_register_page.dart';
import 'package:flutter_fit/page/splash_page.dart';
import 'package:flutter_fit/page/home_page.dart';
import 'package:flutter_fit/page/welcome_page.dart';
import 'package:amap_base_location/amap_base_location.dart';
import 'package:flutter_fit/page/test.dart';
import 'package:flutter_fit/common/style/fit_style.dart';

///程序入口
void main() {
//  AMap.init("key");  //IOS
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  ///是一个Material 风格的application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fit',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.deepOrange,
      ),

      ///程序的第一个界面，一般需要用Scaffold 包裹的 Material风格的widget
//     home: Test(),
      home: SplashPage(),

      routes: {
        '/home': (BuildContext context) => HomePage(),
        '/splash': (BuildContext context) => SplashPage(),
        '/welcome': (BuildContext context) => WelcomePage(),
        '/login': (BuildContext context) => LoginOrRegisterPage(),
      },
//      initialRoute: '/login',
    );
  }
}
