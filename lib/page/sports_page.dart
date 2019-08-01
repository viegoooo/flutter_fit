import 'package:flutter/material.dart';
import 'package:flutter_fit/common/style/fit_style.dart';
import 'package:amap_base_location/amap_base_location.dart';

class SportsPage extends StatefulWidget {
  @override
  _SportsPageState createState() => _SportsPageState();
}

class _SportsPageState extends State<SportsPage> with SingleTickerProviderStateMixin {

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


//  AnimationController _controller;
  TabController tabController ;

  final List<Widget> tabs =[
    Text('跑步' ,style: FitConstant.normalTextOrange,),
    Text('步行',style: FitConstant.normalTextOrange,),
    Text('骑行',style: FitConstant.normalTextOrange,),
  ];


  @override
  void initState() {
    tabController = TabController(vsync: this,length: 3);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
       child: Column(
         children: <Widget>[
           TabBar(
             tabs: tabs,
             controller:  tabController,
           ),
           Stack(


           ),

           Container(
             color: Colors.green,
             height: 400,
             width: 400,
             child: PageView(
               children: <Widget>[

                 Text('Page1'),
                 Text("page2"),
                 Text("page3"),

               ],
             ),
           ),
         ],
       ),
    );
  }
}



