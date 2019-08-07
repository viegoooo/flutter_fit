import 'package:flutter/material.dart';
import 'package:flutter_fit/widget/base/circle_progress_bar.dart';
import 'package:flutter_fit/widget/base/two_contents_with_title_text.dart';
import 'package:flutter_fit/common/style/fit_style.dart';
import 'package:flutter_fit/widget/chart_with_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<_HealthCardItemInfo> healthLists = [
    _HealthCardItemInfo('睡眠', FitColor.sleepBackgroundColor, '点击查看', ''),
    _HealthCardItemInfo('心率', FitColor.heartBackgroundColor, '点击查看', ''),
    _HealthCardItemInfo(
        '体重', FitColor.weightBackgroundColor, '体重管理,\n健康生活', ''),
    _HealthCardItemInfo('压力', FitColor.pressBackgroundColor, '快来测测自己的压力吧', ''),
    _HealthCardItemInfo(
        '血氧饱和度', FitColor.bloodOxyBackgroundColor, '检测您的血氧饱和度', ''),
    _HealthCardItemInfo(
        '血压', FitColor.bloodPressBackgroundColor, '血压变化,\n精准掌控', ''),
    _HealthCardItemInfo(
        '血糖', FitColor.bloodSugarBackgroundColor, '血糖记录,\n科学管理', ''),
  ];

  List<Widget> _data;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: FitPadding.pagePadding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _createAppBar(),
                SizedBox(height: 8),
                _createTodayCard(),
                SizedBox(height: 12),
                _createExerciseRecordsWidget(),
                _createHealthInfoCard(),
                _createStepsChart(),
                _createRecommendationOfToday()
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///创建 Appbar ,包括头像 设备
  _createAppBar() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RawMaterialButton(
          onPressed: null,
          padding: EdgeInsets.all(0.0),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          constraints: BoxConstraints(minHeight: 0.0, minWidth: 0.0),
          child: new ClipOval(
            //ClipOval
            child: new FadeInImage.assetNetwork(
              placeholder: FitIcons.DEFAULT_USER_ICON,
              fit: BoxFit.fill,
              image:
                  'http://downhdlogo.yy.com/hdlogo/640640/510/510/17/0005177835/u5177835FGI15hbl5U.png',
              width: 40,
              height: 40,
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 2,
          ),
        ),
        Icon(FontAwesomeIcons.qrcode),
        SizedBox(
          width: 24,
        ),
        Container(
          padding: EdgeInsets.all(2),
          child: new FadeInImage.assetNetwork(
            placeholder: FitIcons.DEFAULT_BAND,
            fit: BoxFit.fitWidth,
            image:
            'http://www.90shouji.com/upload/cutthumbs/manager/image/201903/20/thumb_400_400_20190320113648836Y6857N.jpg',
            width: 28,
            height: 28,
          ),
          decoration: new BoxDecoration(
            border: new Border.all(color: Colors.grey, width: 1),
            // 边色与边宽度
            color: Colors.white,
            // 底色
            //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
            shape: BoxShape.circle, // 默认值也是矩形
            // 圆角度
          ),
        ),

        SizedBox(
          width: 12,
        ),
      ],
    );
  } //end of _createAppBar

  ///创建 今日信息,包括 步数和 消耗的卡路里等
  _createTodayCard() {
    // 让Card里面的 Container 和Card 保持相同的 圆角。
    double radius = 12.0;

    return Card(
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Container(
        //多一层Container是为了用颜色渐变效果。导致的问题就是 需要为Container设置圆角，否则Card的圆角效果出不来。
        decoration: BoxDecoration(
            gradient: FitColor.todayCardLinearGradient,
            borderRadius: BorderRadius.circular(radius)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              height: 4,
            ),
            Text(
              'Today',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontFamily: "WorkSansSemiBold",
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                GestureDetector(
                  onTap: () => {debugPrint('mmmmmmmmmmm')},
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      CircleProgressBar(
                        colors: [Colors.white, Colors.white],
                        radius: 56.0,
                        stokeWidth: 10.0,
                        value: 0.8,
                        backgroundColor: FitColor.circleProgressBackgroundColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.walking,
                            color: Colors.white,
                          ),
                          Text(
                            '3562',
                            style: FitConstant.largeLargeTextWhite,
                          ),
                          Text(
                            '步',
                            style: FitConstant.smallTextWhite,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 36,
                ),
                GestureDetector(
                  onTap: () => {debugPrint('wwwwwwwwwwwwww')},
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      CircleProgressBar(
                        colors: [Colors.white, Colors.white],
                        radius: 56.0,
                        stokeWidth: 10.0,
                        value: 0.4,
                        backgroundColor: FitColor.circleProgressBackgroundColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.clock,
                            color: Colors.white,
                          ),
                          Text(
                            '30',
                            style: FitConstant.largeLargeTextWhite,
                          ),
                          Text(
                            '分钟',
                            style: FitConstant.smallTextWhite,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
//                color: FitColor.twoContentBackgroundColor,
              decoration: BoxDecoration(
                color: FitColor.twoContentBackgroundColor,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(radius)),
              ),
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: TwoContentWithTitleText(
                  title1: "Distance",
                  content1: '3.13',
                  unit1: 'Km',
                  title2: '热量',
                  content2: "12",
                  unit2: 'kcal',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 创建 最近一次 运动记录,包括 运动距离,时间 速率 等
  _createExerciseRecordsWidget() {
    return Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(8.0),
      decoration: new BoxDecoration(
        color: FitColor.exerciseRecordsBackgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Exercise records',
            style: FitConstant.normalTextBold,
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '7/23',
                style: FitConstant.smallText,
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
              ),
              Text(
                'outdoor run',
                style: FitConstant.smallText,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                '3.63',
                style: FitConstant.largeLargeTextOrange,
              ),
              Text(
                ' KM',
                style: FitConstant.smallTextOrange,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                ' 6\'28\"',
                style: FitConstant.normalTextBold,
              ),
              Text(
                '/km',
                style: FitConstant.normalText,
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0),
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                ' 28:01:24',
                style: FitConstant.normalTextBold,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
          ),
        ],
      ),
    );
  }

  ///创建 个人健康信息,包括 体重 心率 血压 等、
  _createHealthInfoCard() {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    _data = healthLists
        .map((f) => Container(
              height: width / 3 - 4,
              width: width / 3 - 4,
              key: Key(f._title),
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Material(
//                    elevation: 4.0,
//                    shadowColor: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.0),
                      color: f._backgroundColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          f._title,
                          style: FitConstant.normalTextBold,
                        ),
                        Text(
                          f._tips,
                          maxLines: 2,
                          softWrap: true,
                          style: FitConstant.smallText,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ))
        .toList();

    return Container(
      margin: EdgeInsets.all(2.0),
      height: width / 3 - 8,
      child: ReorderableListView(
        scrollDirection: Axis.horizontal,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            //交换数据
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            var item = healthLists.removeAt(oldIndex);
            healthLists.insert(newIndex, item);
          });
        },
        children: _data,
      ),
    );
  }

  ///创建 步数图表
  _createStepsChart() {
    return Column(
      children: <Widget>[
        ListTile(
          isThreeLine: false,
          title: Text(
            "步数",
            style: FitConstant.normalTextDeepBold,
          ),
          trailing: Container(
            width: 80,
            child: Row(
              children: <Widget>[Text('更多'), Icon(Icons.keyboard_arrow_right)],
            ),
          ),
        ),
        TwoContentWithTitleText(
          title1: "目标达成",
          content1: '19',
          unit1: '天',
          title2: '日均步数',
          content2: "10268",
          unit2: '步',
          titleStyle: FitConstant.smallText,
          contentStyle: FitConstant.normalTextBold,
          unitStyle: FitConstant.smallTextBold,
        ),
        Container(height: 160, child: BarChart.withSampleData()),
      ],
    );

    // return
  } //end of _createHealthInfoCard()

  ///TODO
  _createRecommendationOfToday() {
    return Container();
  }
} //end of  class _HomePageState

class _HealthCardItemInfo {
  String _title;
  String _tips;
  String _routeName;
  Color _backgroundColor;

  _HealthCardItemInfo(
      this._title, this._backgroundColor, this._tips, this._routeName);
}
