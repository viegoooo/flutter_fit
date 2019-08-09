import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fit/page/sport/sports_routers.dart';
import 'package:flutter_fit/page/welcome/login_or_register_page.dart';
import 'package:flutter_fit/page/welcome/splash_page.dart';
import 'package:flutter_fit/page/home/home_page.dart';
import 'package:flutter_fit/page/sport/sports_history_page.dart';
import 'package:flutter_fit/page/welcome/welcome_page.dart';
import 'package:flutter_fit/common/style/fit_style.dart';
import 'package:flutter_fit/common/route/fluro_navigator_utils.dart';
///程序入口
void main() {
//  AMap.init("key");  //IOS
  runApp(MyApp());

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.white, //or set color with: Color(0xFF0000FF)
  ));


}




class MyApp extends StatelessWidget {

  final List<IRouter> _listRouter = [SportsRouters()];

  MyApp(){
    NavigatorUtils.configureRoutes(_listRouter);
  }

  // This widget is the root of your application.
  ///是一个Material 风格的application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Fit',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: FitColor.themeColors,
      ),

      ///程序的第一个界面，一般需要用Scaffold 包裹的 Material风格的widget
      home: SplashPage(),
      onGenerateRoute: NavigatorUtils.mRouter.generator,
      //home: SportsHistoryPage(),
//      routes: {
//        '/home': (BuildContext context) => HomePage(),
//        '/splash': (BuildContext context) => SplashPage(),
//        '/welcome': (BuildContext context) => WelcomePage(),
//        '/login': (BuildContext context) => LoginOrRegisterPage(),
//        '/history': (BuildContext context) => SportsHistoryPage(),
//      },
//      initialRoute: '/login',
    );
  }
}
