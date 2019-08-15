import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


///
/// BMI = 体重/（身高*身高）   20-25 => 体重 = 20*身高*身高    -    25*身高*身高
///
class WeightGoal extends StatefulWidget {
  final double currentGoal;
  //身高 是计算标准体重的必要条件
  final double height;
  final ValueChanged<double> onChanged;
  const WeightGoal({Key key, this.currentGoal:70, this.onChanged, @required this.height}) : super(key: key);

  @override
  _WeightGoalState createState() => _WeightGoalState();
}

class _WeightGoalState extends State<WeightGoal> {
  // goal范围： 10 - 150
  double currentValue ;

  @override
  void initState() {
    currentValue = widget.currentGoal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Icon(FontAwesomeIcons.weight,color: Colors.blueAccent,size: 24,),
              Text('体重目标',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("${currentValue.toInt()} ",style: TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.bold),),
                Text('公斤',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500)),
              ],
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 8),
            child: CupertinoSlider(
                value: currentValue,
                min: 10,
                max: 150,
                divisions: 140,
                activeColor:Colors.blueAccent,
                onChanged: (double value) {
                  print('value =  $value');
                  if(widget.onChanged!=null){
                    widget.onChanged(value);
                  }
                  setState(() {
                    currentValue = value;
                  });
                }),
          ),

          Row(
            children: <Widget>[
              Text('标准体重：${20*widget.height*widget.height~/10000}-${25*widget.height*widget.height~/10000}公斤'),
              IconButton(icon: Icon(Icons.info_outline,color: Colors.black54),onPressed: (){},),
            ],
          ),
        ],
      ),
    );
  }
}