import 'dart:io';

import 'package:flutter/material.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter_fit/widget/bottom_tab_bar_widget.dart';
import 'package:flutter_fit/page/me_page.dart';
import 'package:flutter_fit/page/sports_page.dart';
import 'package:flutter_fit/page/home_page.dart';

class MainPage extends StatelessWidget {
  //创建单个 底部tab按钮
  _renderTab(icon, text) {
    return new Tab(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[new Icon(icon, size: 16.0), new Text(text)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Tab> tabLists = [
      _renderTab(Icons.home, "主页"),
      _renderTab(Icons.settings, "设置"),
      _renderTab(Icons.perm_identity, "我的")
    ];
    // TODO: implement build
    return WillPopScope(
      child: new BottomTabBarWidget(
        tabItems: tabLists,
        pageViews: [new HomePage(), new SportsPage(), new MePage()],
        indicatorColor: Colors.white70,
        title: Text("Hello",),

      ),
      onWillPop: (){return _exitApp(context);},
    );
  }

  // android 按返回键 返回到桌面
  Future<bool> _exitApp(BuildContext context) async {
    if (Platform.isAndroid) {
      AndroidIntent androidIntent = AndroidIntent(
          action: 'android.intent.action.MAIN',
          category: "android.intent.category.HOME");
      await androidIntent.launch();
    }
    return Future.value(false);
  }
}


