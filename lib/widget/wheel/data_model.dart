

abstract class BaseOnePickerModel{
  //a getter method for  column content data, return null to end list
  String stringAtIndex(int index);
  //set selected index
  void setSelectedIndex(int index);
  //return current left index
  int getCurrentIndex();
  //return final time
  int finalData();
}


class HeightPickerModel extends BaseOnePickerModel{

  int maxHeight;
  int minHeight;
  List<String> heightList;
  int _currentIndex;
  int currentHeight;

  HeightPickerModel({this.maxHeight:220, this.minHeight:0, this.heightList,
    this.currentHeight:180}){
    this.heightList = List.generate(maxHeight - minHeight + 1, (int index) {
      // print('LEFT LIST... ${minTime.year + index}${_localeYear()}');
      return '${minHeight + index}厘米';
    });
    _currentIndex = currentHeight - minHeight;
  }

  @override
  int finalData() {
    return currentHeight;
  }

  @override
  int getCurrentIndex() {
    return _currentIndex;
  }

  @override
  void setSelectedIndex(int index) {
   _currentIndex =index;
  }

  ///返回 “178厘米”
  @override
  String stringAtIndex(int index) {
    if (index >= 0 && index < heightList.length) {
      return heightList[index];
    } else {
      return null;
    }
  }

}