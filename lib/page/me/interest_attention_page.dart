import 'package:flutter/material.dart';
import 'package:flutter_fit/common/route/fluro_navigator_utils.dart';
import 'package:flutter_fit/common/style/fit_style.dart';

/// 此界面主要是[CheckboxListTile] 的使用, (单条选择 互不影响)
/// 此Widget 一般父控件是一个[StatefulWidget] ,或者用 [StatefulBuilder]  包裹。
/// 类似的控件还有[RadioListTile] (多选一)
///
/// [AppBar]属性 leading 和 actions的使用
///
class InterestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}



_buildBody(BuildContext context) {
  return Column(
    children: <Widget>[
      _renderInterest(),
      Container(height: 8, color: Colors.grey[350],),
      _renderAttention(),
    ],
  );
}

_renderAttention() {
  List<bool> attentionList = [false,false,false,false];

  return StatefulBuilder(builder: (context, StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text("健康关注",style: FitConstant.smallText,),
          ),
          CheckboxListTile(
            value:attentionList[0],
            title: Text("血压"),
            onChanged: (change){
              setState((){
                attentionList[0] = change;
              });
            },
          ),
          CheckboxListTile(
            value:attentionList[1],///value 是bool 类型 , 和 [RadioListTile] 有区别
            title: Text("血糖"),
            onChanged: (change){
              setState((){
                attentionList[1] = change;
              });
            },
          ),
          CheckboxListTile(
            value:attentionList[2],
            title: Text("体重"),
            onChanged: (change){
              setState((){
                attentionList[2] = change;
              });
            },
          ),
          CheckboxListTile(
            value:attentionList[3],
            title: Text("睡眠"),
            onChanged: (change){
              setState((){
                attentionList[3] = change;
              });
            },
          ),

        ],
      ),
    );
  });
}

_renderInterest() {

  List<bool> interestList = [false,false,true,true];

  return StatefulBuilder(builder: (context, StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text("运动兴趣",style: FitConstant.smallText,),
          ),
          CheckboxListTile(
            value:interestList[0],
            title: Text("跑步"),
            onChanged: (change){
              setState((){
                interestList[0] = change;
              });
            },
          ),
          CheckboxListTile(
            value:interestList[1],
            title: Text("步行"),
            onChanged: (change){
              setState((){
                interestList[1] = change;
              });
            },
          ),
          CheckboxListTile(
            value:interestList[2],
            title: Text("骑车"),
            onChanged: (change){
              setState((){
                interestList[2] = change;
              });
            },
          ),
          CheckboxListTile(
            value:interestList[3],
            title: Text("健身"),
            onChanged: (change){
              setState((){
                interestList[3] = change;
              });
            },
          ),

        ],
      ),
    );
  });
}

_buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        NavigatorUtils.goBack(context);
      },
      padding: const EdgeInsets.all(12.0),
      icon: Icon(
        Icons.clear,
        size: 24,
//   color: FitColor.mainTextColor,
      ),
    ),
    title: Text("编辑兴趣及关注"),
    actions: <Widget>[
      IconButton(
        onPressed: () {
          NavigatorUtils.goBack(context);
        },
        padding: const EdgeInsets.all(12.0),
        icon: Icon(
          Icons.check,
          size: 24,
//              color: FitColor.mainTextColor,
        ),
      ),
    ],
  );
}
