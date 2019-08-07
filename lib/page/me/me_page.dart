import 'package:flutter/material.dart';
import 'package:flutter_fit/common/style/fit_style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _createUserHeader(),
                SizedBox(
                  height: 8.0,
                ),
                _createPersonalInfoCard(),
                _createRecordsCard(),
                _createMyDevice(),
                _createListTitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _createUserHeader() {
    return Material(
      color: FitColor.primaryColor,
      elevation: 8,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding:
            EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0, bottom: 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
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
                      fit: BoxFit.fitWidth,
                      image:
                          'http://downhdlogo.yy.com/hdlogo/640640/510/510/17/0005177835/u5177835FGI15hbl5U.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(16.0)),

                ///TODO  为什么Container 放到 Row 中 width 和height 不会自动填充？
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
//                        mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('Barbecuelover',
                          style: FitConstant.largeTextWhiteBold),
                      Text('Darkside', style: FitConstant.middleSubLightText),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'A Rookie who lovers electronic music and barbecue.',
                style: FitConstant.middleSubLightText,
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///创建 个人资料，目标，群组，消息
  _createPersonalInfoCard() {
    Widget _buildButtonColumn(IconData icon, String label, String routeName) {
      Color color = Colors.black45;
      return GestureDetector(
        onTap: () => {Navigator.pushNamed(context, routeName)},
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Icon(
                  icon,
                  color: color,
                ),
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
            new Container(
              margin: const EdgeInsets.only(top: 8.0),
              child: new Text(
                label,
                style: new TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColumn(Icons.accessibility, "Info", "/login"),
          _buildButtonColumn(Icons.group, "group", "/login"),
          _buildButtonColumn(Icons.message, "message", "/login"),
          _buildButtonColumn(Icons.flag, "Goal", "/login"),
        ],
      ),
    );
  }

  ///创建 运动记录 周/月报 ..
  _createRecordsCard() {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    List<_RecordsCardMsg> recordsList = [
      _RecordsCardMsg("运动记录", "所有运动", "/111", Color(0xFFFAF1EA)),
      _RecordsCardMsg("成绩单", "累计与最佳", "/111", Color(0xFFEEF3F9)),
      _RecordsCardMsg("周/月/年报", "阶段统计", "/111", Color(0xFFF5F0F6)),
    ];

    ///SliverChildBuilderDelegate 中的第一个参数
    /// SliverList 的Item样式
    _builder() {
      return (BuildContext context, int index) {
        //function
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Material(
//                    elevation: 4.0,
//                    shadowColor: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12.0),
                  color: recordsList[index]._cardColor,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recordsList[index]._title,
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    Text(
                      recordsList[index]._subTitle,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      };
    }

    return Container(
      height: width / recordsList.length - 8,
      child: new CustomScrollView(
        //必须在外层设置一个有高度的 父布局， 因为外层column 的高度是无限的，CustomScrollView的高度也是无限的
        scrollDirection: Axis.horizontal,
        slivers: <Widget>[
          SliverList(
            //SliverChildBuilderDelegate 或者 SliverChildListDelegate
            delegate: SliverChildBuilderDelegate(
              _builder(), //builder
              childCount: recordsList.length, //必要参数
            ),
          )
        ],
      ),
    );
  }

  ///创建 我的设备，添加设备..
  _createMyDevice() {
    return Container(
      margin: EdgeInsets.all(8.0),
      height: 158,
      child: Column(
        children: <Widget>[
          //标题  我的设备  和 添加设备
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "我的设备",
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "添加设备",
                  style: TextStyle(
                      color: FitColor.themeColors,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          //设备信息  设备名称 ，图片，连接状态
          SizedBox(
            height: 8.0,
          ),
          Container(
              height: 120,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        "HUA WEI BAND 3 PRO-47D",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(FontAwesomeIcons.bluetooth),
                            onPressed: () => {debugPrint('按下 蓝牙按钮 ')},
                          ),
                          Text(
                            "已断开",
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "重新连接",
                            style: TextStyle(
                                fontSize: 16, color: Colors.orangeAccent),
                          ),
                        ],
                      ),
                    ],
                  ),

//                  Image.network(),

                  RawMaterialButton(
                    onPressed: null,
                    padding: EdgeInsets.all(0.0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    constraints: BoxConstraints(minHeight: 0.0, minWidth: 0.0),

                    child: ClipRect(

                      child: new FadeInImage.assetNetwork(
                        placeholder: FitIcons.DEFAULT_BAND,
                        fit: BoxFit.fitWidth,
                        image:
                        'http://www.90shouji.com/upload/cutthumbs/manager/image/201903/20/thumb_400_400_20190320113648836Y6857N.jpg',
                        width: 80,
                        height: 120,
                      ),
                    ),


//                    child: new ClipOval(
//                      //ClipOval
//                      child: new FadeInImage.assetNetwork(
//                        placeholder: FitIcons.DEFAULT_USER_ICON,
//                        fit: BoxFit.fitWidth,
//                        image:
//                            'http://www.90shouji.com/upload/cutthumbs/manager/image/201903/20/thumb_400_400_20190320113648836Y6857N.jpg',
//                        width: 80,
//                        height: 120,
//                      ),
//                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  ///包括 我的数据，设置 帮助 检测更新 关于 等等。
  _createListTitle() {
    _createItem(IconData iconData, String title, String routeName) {
      return ListTile(
        isThreeLine: false,
        leading: new Icon(iconData),
        title: new Text(title),
        trailing: new Icon(Icons.keyboard_arrow_right),
        onTap: () => Navigator.pop(context, routeName),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          _createItem(FontAwesomeIcons.solidChartBar, 'My data', '/w'),
          _createItem(FontAwesomeIcons.clipboardList, 'My orders', '/w'),
          _createItem(FontAwesomeIcons.chartLine, 'Data sharing', '/w'),
          _createItem(FontAwesomeIcons.cog, 'settings', '/w'),
          _createItem(FontAwesomeIcons.solidQuestionCircle, 'help', '/w'),
          _createItem(
              FontAwesomeIcons.solidFileAlt, 'Problems and suggestions', '/w'),
          _createItem(
              FontAwesomeIcons.arrowCircleUp, 'Check for updates', '/w'),
        ],
      ),
    );
  }
}

class _RecordsCardMsg {
  final String _title;
  final String _subTitle;
  final String _routeName;
  final Color _cardColor;

  _RecordsCardMsg(
      this._title, this._subTitle, this._routeName, this._cardColor);
}
