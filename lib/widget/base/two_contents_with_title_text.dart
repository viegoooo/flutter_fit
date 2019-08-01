import 'package:flutter/material.dart';
import 'package:flutter_fit/common/style/fit_style.dart';

class TwoContentWithTitleText extends StatelessWidget {


  final String title1;
  final String content1;
  final String unit1;

  final String title2;
  final String content2;
  final String unit2;

//  final Color titleColor;
//  final Color contentColor;
//  final Color unitColor;

  final TextStyle titleStyle;
  final TextStyle contentStyle;
  final TextStyle unitStyle;

  final double splitHeight;

  const TwoContentWithTitleText(
      {Key key,
      this.title1,
      this.content1,
      this.unit1,
      this.title2,
      this.content2,
      this.unit2,
      this.titleStyle :FitConstant.smallSubLightText,
      this.contentStyle :FitConstant.normalTextMitWhiteBold,
      this.unitStyle:FitConstant.smallTextWhite,
      this.splitHeight:24.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(title1 ,style: titleStyle,),

              Row(children: <Widget>[
                Text(content1,style: contentStyle,),
                Padding(padding: EdgeInsets.only(right: 2.0),),
                Text(unit1,style: unitStyle,),
              ],),


            ],
          ),
          Container(
            height: splitHeight,
            width: 1,
            color: titleStyle.color
          ),
          Column(
            children: <Widget>[
              Text(title2 ,style: titleStyle,),
              Row(children: <Widget>[
                Text(content2,style: contentStyle,),
                Padding(padding: EdgeInsets.only(right: 2.0),),
                Text(unit2,style: unitStyle,),
              ],),

            ],
          ),
        ],
      ),
    );
  }
}
