import 'package:flutter/material.dart';

///这个类不只有 底部的导航栏， 也可以设置
class BottomTabBarWidget extends StatefulWidget {
  final Widget title; //顶部标题
  final List<Widget> pageViews; //body view
  final List<Widget> tabItems; //底部 导航按钮item
  final ValueChanged<int> onPageChanged; //viewpager changed 监听
  final Color indicatorColor;

  const BottomTabBarWidget(
      {Key key,
      this.title,
      this.pageViews,
      this.tabItems,
      this.onPageChanged,
      this.indicatorColor})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new _BottomTabBarWidgetState(
      pageViews, indicatorColor, title, onPageChanged);
}

//SingleTickerProviderStateMixin ??是什么
///State 用于 StatefulWidget 状态改变。
class _BottomTabBarWidgetState extends State<BottomTabBarWidget>
    with SingleTickerProviderStateMixin {
  //TabController ??
  TabController _tabController;

  final List<Widget> _pageViews;

  final Color _indicatorColor;

  final Widget _title;

  final PageController _pageController = PageController();

  final ValueChanged<int> _onPageChanged;

  _BottomTabBarWidgetState(
      this._pageViews, this._indicatorColor, this._title, this._onPageChanged);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController =
        new TabController(length: widget.tabItems.length, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold ?
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: _title,
          centerTitle: true),
      body: new PageView(
        children: _pageViews,
        controller: _pageController,
        onPageChanged: (index) {
          _tabController.animateTo(index);
          _onPageChanged?.call(index);
        },
      ),
      bottomNavigationBar: new Material(
        color: Theme.of(context).primaryColor,
        child: new SafeArea(
            child: new TabBar(
          tabs: widget.tabItems,
          controller: _tabController,
          indicatorColor: _indicatorColor,
          onTap: (index) {
            _onPageChanged?.call(index);
            _pageController.jumpToPage(index);
          },
        )),
      ),
    );
  }
}
