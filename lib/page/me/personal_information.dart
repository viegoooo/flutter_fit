import 'package:flutter/material.dart';
import 'package:flutter_fit/common/route/fluro_navigator_utils.dart';
import 'package:flutter_fit/common/style/fit_style.dart';
import 'package:flutter_fit/widget/wheel/single_wheel_picker.dart';
import 'package:flutter_fit/page/me/date_picker/flutter_datetime_picker.dart';
/// AlertDialog

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  String _newGender = '男';
  int _heightValue = 178;
  int _weightValue = 70;
  DateTime birthDay = DateTime(1992,2,10);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildAppBar(),
              _buildGenderListTile(),
              _buildBirthDayListTile(),
              _buildHeightListTile(),
              _buildWeightListTile(),
              _buildInterestListTile(),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          NavigatorUtils.goBack(context);
        },
        padding: const EdgeInsets.all(12.0),
        icon: Icon(
          Icons.arrow_back,
          size: 24,
          color: FitColor.mainTextColor,
        ),
      ),
      title: Text('个人资料'),
    );
  }

  _buildGenderListTile() {
    return ListTile(
      onTap: () => {
        showDialog(
            context: context,
            builder: (BuildContext buildContext) {
              return _showSelectGenderDialog();
            })
      },
      isThreeLine: false,
      title: Text(
        "性别",
        style: FitConstant.normalText,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(_newGender),
          Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }

  _buildBirthDayListTile() {
    return ListTile(
      onTap: ()=>{
        DatePicker.showDatePicker(context,currentTime: birthDay,onConfirm: (dataTime){
          print("Config: ${dataTime.toUtc().toString()}");
          setState(() {
            birthDay = dataTime;
          });
        })
      },
      isThreeLine: false,
      title: Text("出生日期"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('${birthDay.year}/${birthDay.month}/${birthDay.day}'),
          Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }

  _buildHeightListTile() {
    return ListTile(
      onTap:(){
        WheelPicker.showWheelPickerByType(context,WheelType.HEIGHT,currentData:_heightValue,onConfirm: (height){
          setState(() {
            _heightValue = height;
          });
        });
      },
      isThreeLine: false,
      title: Text("身高"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('$_heightValue厘米'),
          Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }

  _buildWeightListTile() {
    return ListTile(
      onTap:(){
        WheelPicker.showWheelPickerByType(context,WheelType.WEIGHT,currentData:_weightValue,onConfirm: (weight){
          setState(() {
            _weightValue = weight;
          });
        });
      },
      isThreeLine: false,
      title: Text("体重"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('$_weightValue公斤'),
          Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }

  _buildInterestListTile() {
    return ListTile(
      isThreeLine: false,
      title: Text("兴趣及关注"),
      trailing: Icon(Icons.keyboard_arrow_right),
    );
  }

  /// 如何改变弹出的Dialog在屏幕中的位置？？
  _showSelectGenderDialog() {
    print(" ----------------");
    return AlertDialog(
      title: Text('性别'),
      ///RadioListTile 和 CheckBox 点击选择框以后 没有UI的切换 ,需要父控件是Stateful的控件。可以使用StatefulBuilder
      content: StatefulBuilder(builder: (context, StateSetter setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RadioListTile<String>(
              value: '男',
              title: Text('男'),
              groupValue: _newGender,
              onChanged: (value) {
                setState(() {
                  ///此SetState 是 AlertDialog UI 的刷新 （点击Item后选中提示图标的变化） 。
                  _newGender = value;
                  NavigatorUtils.goBack(context);
                  ///取消Dialog 和回退界面一样 需要调用 Navigator的pop方法
                  this.setState(() {});
                  ///此SetState 是Dialog 后面的PersonalInfoPage的更新
                });
              },
            ),
            RadioListTile<String>(
              value: '女',
              title: Text('女'),
              groupValue: _newGender,
              onChanged: (value) {
                setState(() {
                  _newGender = value;
                  NavigatorUtils.goBack(context);
                  this.setState(() {});
                });
              },
            ),
            RadioListTile<String>(
              value: '保密',
              title: Text('保密'),
              groupValue: _newGender,
              onChanged: (value) {
                setState(() {
                  _newGender = value;
                  NavigatorUtils.goBack(context);
                  this.setState(() {});
                });
              },
            ),
          ],
        );
      }),

      actions: <Widget>[
        FlatButton(
          child: Text('取消'),
          onPressed: () {
            NavigatorUtils.goBack(context);
          },
        ),
      ],
    );
  }

}
