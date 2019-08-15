import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fit/common/route/fluro_navigator_utils.dart';
import 'package:flutter_fit/page/me/slider/sports_goal_slider.dart';
import 'package:flutter_fit/page/me/slider/weigth_goal_slider.dart';

///[CupertinoSlider] 设置最大值 ，最小值，这区间的段数divisions。
///[CupertinoButton]
///
class GoalPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //暂时的目标
    double provisionalSportGoal;
    double provisionalWeightGoal;


    return Material(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Column(
          children: <Widget>[
            SportsGoal(onChanged: (sportsGoal){
              provisionalSportGoal = sportsGoal;

            },),
            WeightGoal(
              height: 178,onChanged: (weightGoal){
              provisionalWeightGoal = weightGoal;
            },
            ),
            Expanded(
              child: SizedBox(),
            ),
            CupertinoButton(
                minSize: 28,
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 6),
                child: Text(
                  "保存目标",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                ),
                onPressed: () {
                  _saveGoalData(context);
                },
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(18),
                disabledColor: Colors.grey[600],
                pressedOpacity: 0.8),
            SizedBox(height: 28,),

          ],
        ),
      ),
    );
  }
}

_saveGoalData([BuildContext context]) {
  //TODO 保存个人信息

  //返回。
  NavigatorUtils.goBack(context);
}

_buildAppBar(BuildContext context) {
  return AppBar(
    title: Text("目标"),
    leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: ()=>NavigatorUtils.goBack(context),),
  );
}
