
class SportMonthData{

  String  yearMonth;
  List <SportDayData> data;
  double totalKm;
  double totalKCal;
  int times;
  SportMonthData(this.yearMonth, this.data, this.totalKm, this.totalKCal,this.times);


  ///假数据
  static List<SportMonthData> createSampleData() {
    final sportData1 =[
      SportDayData(3.69,"00:22:30",'6\'06\"','8/2'),
      SportDayData(3.63,"00:22:10",'6\'06\"','8/1'),
    ];
    final sportData2 =[
      SportDayData(3.67,"00:22:30",'6\'12\"','7/31'),
      SportDayData(3.65,"00:22:10",'5\'56\"','7/30'),
      SportDayData(3.67,"00:22:30",'6\'12\"','7/29'),
      SportDayData(3.65,"00:22:10",'5\'56\"','7/28'),

      SportDayData(3.67,"00:22:30",'6\'12\"','7/27'),
      SportDayData(3.65,"00:22:10",'5\'56\"','7/26'),
      SportDayData(3.67,"00:22:30",'6\'12\"','7/25'),
      SportDayData(3.65,"00:22:10",'5\'56\"','7/24'),

      SportDayData(3.67,"00:22:30",'6\'12\"','7/23'),
      SportDayData(3.65,"00:22:10",'5\'56\"','7/22'),
      SportDayData(3.67,"00:22:30",'6\'12\"','7/21'),
      SportDayData(3.65,"00:22:10",'5\'56\"','7/19'),

      SportDayData(3.67,"00:22:30",'6\'12\"','7/18'),
      SportDayData(3.65,"00:22:10",'5\'56\"','7/17'),
      SportDayData(3.67,"00:22:30",'6\'12\"','7/16'),
      SportDayData(3.65,"00:22:10",'5\'56\"','7/15'),

      SportDayData(3.67,"00:22:30",'6\'12\"','7/14'),
      SportDayData(3.65,"00:22:10",'5\'56\"','7/13'),
      SportDayData(3.67,"00:22:30",'6\'12\"','7/11'),
      SportDayData(3.65,"00:22:10",'5\'56\"','7/9'),
    ];


    final data = [
      new SportMonthData('2019/8', sportData1,7.32,503,2),
      new SportMonthData('2019/7', sportData2,76.8,5187,20),
    ];
    return data;
  }


}

class SportDayData{

  double km; //3.65
  int time; //22*60
  String speed;
  String timeStr;
  String date;

  SportDayData(this.km,this.timeStr,this.speed,this.date);


  SportDayData.staple(this.km, this.time, this.date);

  String getTimeStr(){
    int hour = (time/3600) as int;
    int minute = (time~/3600)/60 as int;
    int second =time~/60;
    return '$hour:$minute:$second';
  }

  String getSpeedStr(){
    int speedMinute = (time/60/km) as int;
    int speedSecond = (((time/60/km)-speedMinute) *100) as int;
    return '$speedMinute\'$speedSecond\"';
  }

}