import 'package:flutter/material.dart';
import 'package:flutter_fit/model/sport_history_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_fit/common/style/fit_style.dart';

class SportsHistoryPage extends StatefulWidget {
  @override
  _SportsHistoryPageState createState() => _SportsHistoryPageState();
}

class _SportsHistoryPageState extends State<SportsHistoryPage> {
  List<SportMonthData> timeList;

  @override
  void initState() {
    timeList = SportMonthData.createSampleData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: CustomScrollView(
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
      List<SportDayData> data = timeList[index].data;
      SportMonthData  monthData = timeList[index];
      //return Text( "${timeList[index].totalKCal} KM");
      // return SliverList(delegate:SliverChildBuilderDelegate(_sportInfoItemBuilder(data),childCount: data.length),);

      return Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: <Widget>[
                  Text( monthData.yearMonth,style: FitConstant.largeTextBold,),
                  Expanded(
                    child: SizedBox(height: 0,),
                  ),
                  Icon(Icons.keyboard_arrow_up),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('距离(公里)',style: FitConstant.smallText,),
                      SizedBox(height: 4,),
                      Text("${monthData.totalKm}",style: FitConstant.largeTextBold ,),
                    ],

                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Column(
                    children: <Widget>[
                      Text('热量(千卡)',style: FitConstant.smallText,),
                      SizedBox(height: 4,),
                      Text("${monthData.totalKCal}",style: FitConstant.largeTextBold ,),
                    ],

                  ),
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Column(
                    children: <Widget>[
                      Text('次数',style: FitConstant.smallText,),
                      SizedBox(height: 4,),
                      Text("${monthData.times}",style: FitConstant.largeTextBold ,),
                    ],

                  ),


                ],
              ),
            ),
            Column(
              children: data.map((f) {
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  isThreeLine: true,
                  leading:  Icon(FontAwesomeIcons.running),
                  title:  Text("${f.km} 公里",style: FitConstant.normalText, ),
                  subtitle:  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.timer,color: Colors.grey,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(f.timeStr ,style: FitConstant.normalSubText,),
                      ),
                      SizedBox(width: 24,),
                      Icon(Icons.av_timer,color: Colors.grey,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text("${f.speed}/公里",style: FitConstant.normalSubText,),
                      ),
                    ],
                  ),
                  trailing:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(f.date,style: FitConstant.normalSubText),
                      Icon(Icons.keyboard_arrow_right),
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      );
    };
  }

  _sportInfoItemBuilder(List<SportDayData> list) {
    return (BuildContext context, int index) {
      return ListTile(
        isThreeLine: false,
        leading:  Icon(FontAwesomeIcons.running),
        title:  Text(list[index].km as String),
        trailing:  Icon(Icons.keyboard_arrow_right),
//        onTap: () => Navigator.pop(context, routeName),
      );
    };
  }
}
