import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SportsGoal extends StatefulWidget {
  final double currentGoal;
  final ValueChanged<double> onChanged;

  const SportsGoal({Key key, this.currentGoal:10000, this.onChanged}) : super(key: key);


  @override
  _SportsGoalState createState() => _SportsGoalState();
}

class _SportsGoalState extends State<SportsGoal> {
  // goal范围：  2000 - 20000
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
              Icon(FontAwesomeIcons.walking,color: Colors.deepOrange,size: 24,),
              Text('运动目标',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("${currentValue.toInt()} ",style: TextStyle(color: Colors.black,fontSize: 32,fontWeight: FontWeight.bold),),
                Text('步',style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500)),
              ],
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 8),
            child: CupertinoSlider(
                value: currentValue,
                min: 2000,
                max: 20000,
                divisions: 18,
//                activeColor:Colors.red,
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


          Padding(
            padding: const EdgeInsets.only(left:12,right: 24,bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('少量',style: TextStyle(fontSize: 14,fontWeight:(currentValue<=7000)?FontWeight.bold:FontWeight.w400,color: (currentValue<=7000)?Colors.black:Colors.black54),),
                Text("|"),
                Text('适量',style: TextStyle(fontSize: 14,fontWeight:(currentValue>7000&&currentValue<14000)?FontWeight.bold:FontWeight.w400,color: (currentValue>7000&&currentValue<14000)?Colors.black:Colors.black54),),
                Text("|"),
                Text('大量',style: TextStyle(fontSize: 14,fontWeight:(currentValue>=14000)?FontWeight.bold:FontWeight.w400,color: (currentValue>=14000)?Colors.black:Colors.black54),),

              ],
            ),
          ),

          Text('约${(currentValue*0.02615).toInt()}千卡',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black54),),
          Text('相当于',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black54),),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ///相当于大概的走路时间
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.walking,size: 14,color: Colors.black54),
                    SizedBox(width: 2,),
                    Text('${currentValue*0.74~/100}分钟',style: TextStyle(color: Colors.black54),),
                  ],
                ),
                ///相当于大概的跑步时间
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.running,size: 14,color: Colors.black54),
                    SizedBox(width: 2,),
                    Text('${currentValue*0.32~/100}分钟' ,style: TextStyle(color: Colors.black54),),
                  ],
                ),
                ///相当于大概的骑行时间
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.biking,size: 14,color: Colors.black54,),
                    SizedBox(width: 4,),
                    Text('${currentValue*0.29~/100}分钟',style: TextStyle(color: Colors.black54),),
                  ],
                ),

              ],

            ),
          ),


        ],
      ),
    );
  }
}