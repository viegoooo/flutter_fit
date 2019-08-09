import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fit/common/route/fluro_navigator_utils.dart';
import 'package:flutter_fit/model/sport_history_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_fit/common/style/fit_style.dart';

class SportsHistoryPage extends StatefulWidget {
  @override
  _SportsHistoryPageState createState() => _SportsHistoryPageState();
}

class _SportsHistoryPageState extends State<SportsHistoryPage> {
  List<SportMonthData> timeList;
  List<bool> showList = List();// 切换具体运动信息Item的 隐藏与显示
  List<DropdownMenuItem> dropdownMenuItems = new List();
  var selectedSportsType; //当前界面选择的运动类型  从不同的运动界面跳过来 值不一样。 比如 跑步，步行。
  SportsType currentType ;

  @override
  void initState() {
    timeList = SportMonthData.createSampleData();
    timeList.forEach((f) {
      showList.add(true);
    });
    _generateItemList();
    super.initState();
  }

  _generateItemList() {
    dropdownMenuItems.clear();
    DropdownMenuItem item4 =
        new DropdownMenuItem(value: '所有运动', child: new Text('所有运动'));
    DropdownMenuItem item1 =
        new DropdownMenuItem(value: '跑步', child: new Text('跑步'));
    DropdownMenuItem item2 =
        new DropdownMenuItem(value: '步行', child: new Text('步行'));
    DropdownMenuItem item3 =
        new DropdownMenuItem(value: '骑行', child: new Text('骑行'));
    dropdownMenuItems.add(item1);
    dropdownMenuItems.add(item2);
    dropdownMenuItems.add(item3);
    dropdownMenuItems.add(item4);

    selectedSportsType = dropdownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _AppBar(
          onChanged: (value) {
            setState(() {
              selectedSportsType = value;
            });
          },
          items: dropdownMenuItems,
          value: selectedSportsType,
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                _timeListItemBuilder(),
                childCount: timeList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _timeListItemBuilder() {
    return (BuildContext context, int index) {
      List<SportSingleData> data = timeList[index].data;
      SportMonthData monthData = timeList[index];
      bool showDetail = showList[index]; //是否显示每条Item信息, 点击Icon的keyboard_arrow_up 或者keyboard_arrow_down 切换
      //return Text( "${timeList[index].totalKCal} KM");
      // return SliverList(delegate:SliverChildBuilderDelegate(_sportInfoItemBuilder(data),childCount: data.length),);
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
            child: Row(
              children: <Widget>[
                Text(
                  monthData.yearMonth,
                  style: FitConstant.largeTextBold,
                ),
                Expanded(
                  child: SizedBox(
                    height: 0,
                  ),
                ),
                GestureDetector(
                  child: Icon(showList[index]
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down),
                  onTap: () => this.setState(() {
                    showList[index] = !showDetail;
                  }),
                ),
              ],
            ),
          ),
          showDetail
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            '距离(公里)',
                            style: FitConstant.smallText,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "${monthData.totalKm}",
                            style: FitConstant.largeTextBold,
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '热量(千卡)',
                            style: FitConstant.smallText,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "${monthData.totalKCal}",
                            style: FitConstant.largeTextBold,
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.grey,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '次数',
                            style: FitConstant.smallText,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "${monthData.times}",
                            style: FitConstant.largeTextBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : SizedBox(),
          showDetail
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  child: Column(
                    children: data.map((f) {
                      return ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                        isThreeLine: true,
                        leading: Icon(FontAwesomeIcons.running),
                        title: Text(
                          "${f.km} 公里",
                          style: FitConstant.normalText,
                        ),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.timer,
                              color: Colors.grey,
                            ),
                            Text(
                              f.timeStr,
                              style: FitConstant.smallSubText,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Icon(
                              Icons.av_timer,
                              color: Colors.grey,
                            ),
                            Text(
                              "${f.speed}/公里",
                              style: FitConstant.smallSubText,
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(f.date, style: FitConstant.smallSubText),
                            Icon(Icons.keyboard_arrow_right),
                          ],
                        ),
                      );
                    }).toList(),
                  ))
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  height: (index == timeList.length - 1) ? 0 : 8,
                  color: FitColor.subLightTextColor,
                ),
        ],
      );
    };
  }
}

class _AppBar<T> extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({
    Key key,
    this.backgroundColor: Colors.white,
    this.backImg: Icons.arrow_back,
    @required this.onChanged,
    @required this.items,
    @required this.value,
  }) : super(key: key);

  final Color backgroundColor;
  final IconData backImg;
  final ValueChanged<T> onChanged;
  final List<DropdownMenuItem> items;
  final T value;

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: backgroundColor,
        child: SafeArea(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
//                    FocusScope.of(context).requestFocus(FocusNode());
//                    Navigator.maybePop(context);
                    NavigatorUtils.goBack(context);
                  },
                  padding: const EdgeInsets.all(12.0),
                  icon: Icon(
                    backImg,
                    color: _overlayStyle == SystemUiOverlayStyle.light
                        ? Colors.white
                        : FitColor.mainTextColor,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                DropdownButton<T>(
                  items: items,
                  onChanged: onChanged,
                  value: value,
                  hint: new Text('选择运动'),
                  underline: Container(),
                )
              ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
