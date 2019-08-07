import 'package:flutter/material.dart';
import 'package:flutter_fit/common/style/fit_style.dart';

/// 主要用到 TabBar 和 Page 的 联动 , 可参考  https://blog.csdn.net/weixin_33724059/article/details/88200232
///
class SportsPage extends StatefulWidget {
  @override
  _SportsPageState createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage>
    with SingleTickerProviderStateMixin {

  bool runningInHouse = false;
  final List<String> _tabValues = ['跑步', '步行', '骑行',];
  TabController tabController;
  PageController pageController = PageController(initialPage: 0);

  // 防止 以下情况： 当TabBar index =0时 点击 第三个TabBar label ,此时 TabBar应该 index  =2 ，Page也应该切换到第三页。但是结果是 index =1 ,Page在第二页 ，
  // 原因是pageController.animateToPage 是index 从 0-> 1 ->2 Page 会回调pageController#onPageChanged()回调又设置了pageController#animateTo(index);。
  // 故此增加flag 单方面取消拖动TabBar时 pageController#onPageChanged()回调
  bool isPageCanChanged = true;

  @override
  void initState() {
    tabController = TabController(length: _tabValues.length, vsync: this);

    ///TabBar 联动 Page
    tabController.addListener(() async {
      if (tabController.indexIsChanging) {
        isPageCanChanged = false;
        await pageController.animateToPage(tabController.index,
            duration: Duration(milliseconds: 500),
            curve: Curves.ease); //等待pageview切换完毕,再释放pageivew监听
        isPageCanChanged = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return SafeArea(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
//                color: Colors.blue,
                  padding: EdgeInsets.only(top: 12, bottom: 12,left: 48),
                  height: 60,
                  child: TabBar(
                    tabs: _tabValues.map((f) {
                      return Text(f);
                    }).toList(),
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: tabController,
                    labelColor: FitColor.themeColors,
                    unselectedLabelColor: Colors.black,
                    unselectedLabelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Icon(Icons.settings),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Container(
                  ///只有 当是跑步（index == 0） 并且是在室内的时候才用 室内背景图片（ 模仿 Colors.yellow），其他情况背景均是 地图定位（Colors.green）
                  //TODO 目前高德地图 package, a_map 使用有问题。
                  color: (runningInHouse && (tabController.index == 0))
                      ? Colors.yellow
                      : Colors.green,
                ),
                Positioned(
                  bottom: 48,
                  child: SizedBox(
                    width: width - 32,
                    height: width - 32,
                    child: Card(
                      elevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: Colors.white,
                      child: PageView(
                        controller: pageController,

                        ///Page 联动 TabBar
                        onPageChanged: (index) {
                          if (isPageCanChanged) {
                            tabController.animateTo(index);
                            setState(() {
                              //刷新背景 是地图还是室内图片
//                              print('onPageChanged :$index');
                            });
                          }
                        },
                        children: <Widget>[
                          _buildRunningPage(),
                          _buildWalkingPage(),
                          _buildRidingPage(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildRunningPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                  onTap: () => setState(() {
                        runningInHouse = false;
                      }),
                  child: Text(
                    '户外跑步',
                    style: runningInHouse
                        ? FitConstant.normalTextDeepBold
                        : FitConstant.normalTextOrangeBold,
                  )),
            ),
            Container(height: 12, width: 1, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  onTap: () => setState(() {
                        runningInHouse = true;
                      }),
                  child: Text(
                    '室内跑步',
                    style: runningInHouse
                        ? FitConstant.normalTextOrangeBold
                        : FitConstant.normalSubTextBold,
                  )),
            ),
          ],
        ),
        Expanded(
          child: SizedBox(
            child: runningInHouse
                ? Text(
                    '建议将手机固定在手臂上,可以提高数据的准确性',
                    style: TextStyle(fontSize: 10),
                  )
                : null,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: <Widget>[
              Text(
                "69.49",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 48),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '累计跑步(公里)',
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(
                Icons.people,
                size: 36,
              ),
              Icon(
                Icons.play_circle_filled,
                size: 96,
                color: Colors.red,
              ),
              Icon(
                Icons.music_video,
                size: 36,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Text(
            "设置目标",
            style: FitConstant.smallTextOrangeBold,
          ),
        ),
      ],
    );
  }

  _buildWalkingPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            '户外步行',
            style: FitConstant.normalTextDeepBold,
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: <Widget>[
              Text(
                "24.00",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 48),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '累计步行(公里)',
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 36,
              ),
              Icon(
                Icons.play_circle_filled,
                size: 96,
                color: Colors.red,
              ),
              Icon(
                Icons.music_video,
                size: 36,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Text(
            "设置目标",
            style: FitConstant.smallTextOrangeBold,
          ),
        ),
      ],
    );
  }

  _buildRidingPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            '户外骑行',
            style: FitConstant.normalTextDeepBold,
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: <Widget>[
              Text(
                "24.00",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 48),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '累计骑行(公里)',
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 36,
              ),
              Icon(
                Icons.play_circle_filled,
                size: 96,
                color: Colors.red,
              ),
              Icon(
                Icons.music_video,
                size: 36,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Text(
            "设置目标",
            style: FitConstant.smallTextOrangeBold,
          ),
        ),
      ],
    );
  }


}




//  final _amapLocation = AMapLocation();
//  var _result = '';
//
////初始化定位监听
//  void _initLocation() async {
//    _amapLocation.init();
//
//    final options = LocationClientOptions(
//      isOnceLocation: false,
//      locatingWithReGeocode: true,
//    );
//
//    if (await Permissions.requestMapPermission()) {
//      _amapLocation.startLocate(options).listen((_) => setState(() {
//        _result =
//        '坐标：${_.longitude}，${_.latitude} @ ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
//        print('定位坐标为：$_result');
//
//      }));
//    } else {
//      setState(() {
//        _result = "无定位权限";
//        print('定位坐标为：$_result');
//      });
//    }
//  }