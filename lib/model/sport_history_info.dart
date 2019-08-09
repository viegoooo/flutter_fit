
class SportMonthData{

  String  yearMonth;
  List <SportSingleData> data;
  static List <SportSingleData> sportDataList;
  double totalKm;
  double totalKCal;
  int times;
  SportsType type;

  SportMonthData(this.yearMonth, this.data, this.totalKm, this.totalKCal,this.times,{this.type});



  ///假数据
  static List<SportMonthData> createSampleData() {
    final sportData1 =[
      SportSingleData(3.69,"00:22:30",'6\'06\"','8/2',SportsType.RUNNING),
      SportSingleData(3.63,"00:22:10",'6\'06\"','8/1',SportsType.WALKING),
      SportSingleData(3.63,"00:22:10",'6\'06\"','8/1',SportsType.RIDING),
    ];
    final sportData2 =[
      SportSingleData(3.67,"00:22:30",'6\'12\"','7/31',SportsType.RUNNING),
      SportSingleData(3.65,"00:22:10",'5\'56\"','7/30',SportsType.RUNNING),
      SportSingleData(3.67,"00:22:30",'6\'12\"','7/29',SportsType.RUNNING),
      SportSingleData(3.65,"00:22:10",'5\'56\"','7/28',SportsType.RUNNING),

      SportSingleData(3.67,"00:22:30",'6\'12\"','7/27',SportsType.WALKING),
      SportSingleData(3.65,"00:22:10",'5\'56\"','7/26',SportsType.WALKING),
      SportSingleData(3.67,"00:22:30",'6\'12\"','7/25',SportsType.WALKING),
      SportSingleData(3.65,"00:22:10",'5\'56\"','7/24',SportsType.WALKING),

      SportSingleData(3.67,"00:22:30",'6\'12\"','7/23',SportsType.WALKING),
      SportSingleData(3.65,"00:22:10",'5\'56\"','7/22',SportsType.WALKING),
      SportSingleData(3.67,"00:22:30",'6\'12\"','7/21',SportsType.RIDING),
      SportSingleData(3.65,"00:22:10",'5\'56\"','7/19',SportsType.RIDING),

      SportSingleData(3.67,"00:22:30",'6\'12\"','7/18',SportsType.RIDING),
      SportSingleData(3.65,"00:22:10",'5\'56\"','7/17',SportsType.RIDING),
      SportSingleData(3.67,"00:22:30",'6\'12\"','7/16',SportsType.RIDING),
      SportSingleData(3.65,"00:22:10",'5\'56\"','7/15',SportsType.RIDING),

      SportSingleData(3.67,"00:22:30",'6\'12\"','7/14',SportsType.SWIMMING),
      SportSingleData(3.65,"00:22:10",'5\'56\"','7/13',SportsType.SWIMMING),
      SportSingleData(3.67,"00:22:30",'6\'12\"','7/11',SportsType.SWIMMING),
      SportSingleData(3.65,"00:22:10",'5\'56\"','7/9',SportsType.SWIMMING),
    ];


    final data = [
      new SportMonthData('2019/8', sportData1,7.32,503,2),
      new SportMonthData('2019/7', sportData2,76.8,5187,20),
    ];
    return data;
  }


}

class SportSingleData{

  double km; //3.65
  int time; //22*60
  String speed;
  String timeStr;
  String date;
  SportsType type;

  SportSingleData(this.km,this.timeStr,this.speed,this.date,this.type);


  SportSingleData.staple(this.km, this.time, this.date);

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

enum SportsType{
    RUNNING,
    WALKING,
    RIDING,
    SWIMMING,
}