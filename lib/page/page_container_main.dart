import 'package:flutter/material.dart';
import 'package:flutter_fit/common/style/fit_style.dart';
import 'package:flutter_fit/page/sport/sports_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_fit/page/home/home_page.dart';
import 'package:flutter_fit/page/me/me_page.dart';

class MainPageContainer extends StatefulWidget {
  @override
  _MainPageContainerState createState() => _MainPageContainerState();
}

class _MainPageContainerState extends State<MainPageContainer>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  int _selectedIndex = 0; //PageView选中的page

  final pages = [
    //body中PageView 的3页内容
    HomePage(),
    SportsPage(),
    MePage(),
  ];

  PageController _pageController;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _pageController = new PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    const List<BottomNavigationBarItem> list = [
      BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('主页')),
      BottomNavigationBarItem(icon: Icon(Icons.directions_run,), title: Text('运动')),
      BottomNavigationBarItem(
          icon: Icon(Icons.perm_identity), title: Text('我的')),
    ];

    return new Scaffold(
//      appBar: AppBar(
//          backgroundColor: Theme.of(context).primaryColor,
//          title: new Text('Main Page'),
//          centerTitle: true),
      body: PageView(
        children: pages,
        controller: _pageController,
        onPageChanged: (index) {
          ///PageView 滑动后 更改当前选中的 下标 _selectedIndex ,然后刷新界面 底部BottomNavigationBar 会更改选中的 index
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: list,
        backgroundColor: FitColor.mainBackgroundColor,
        //selectedItemColor: ,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  ///bottomNavigationBar item的点击事件 ,将其和 PageView 关联
  void _onItemTapped(int index) {
//    _pageController.animateToPage(index,
//        duration: const Duration(milliseconds: 300), curve: Curves.ease);
    _pageController.jumpToPage(index);
  }
}
