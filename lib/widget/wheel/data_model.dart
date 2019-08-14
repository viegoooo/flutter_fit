///
///
///
abstract class BaseOnePickerModel {
  //a getter method for  column content data, return null to end list
  String stringAtIndex(int index);

  //set selected index
  void setSelectedIndex(int index);

  //return current left index
  int getCurrentIndex();

  //return final time
  int finalData();

  //return title string content if there is
  String getTitle();

  // return tips string content if there is
  String getTips();
}

class HeightPickerModel extends BaseOnePickerModel {
  int maxHeight;
  int minHeight;
  List<String> heightList;
  int _currentIndex;
  int currentHeight;

  HeightPickerModel(
      {this.maxHeight: 220,
      this.minHeight: 0,
      this.heightList,
      this.currentHeight: 180}) {
    this.maxHeight = maxHeight ?? 220;
    this.minHeight = minHeight ?? 0;
    this.currentHeight = currentHeight ?? 180;
    this.heightList = List.generate(maxHeight - minHeight + 1, (int index) {
      return '${minHeight + index}厘米';
    });
    _currentIndex = currentHeight - minHeight;
  }

  @override
  int finalData() {
    return _currentIndex+minHeight;
  }

  @override
  int getCurrentIndex() {
    return _currentIndex;
  }

  @override
  void setSelectedIndex(int index) {
    _currentIndex = index;
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

  @override
  String getTips() {
    return "请选择正确的身高，确保热量消耗及运动距离计算准确。";
  }

  @override
  String getTitle() {
    return "身高";
  }
}

class WeightPickerModel extends BaseOnePickerModel {
  int maxWeight;
  int minWeight;
  List<String> weightList;
  int _currentIndex;
  int currentWeight;

  WeightPickerModel(
      {this.maxWeight: 150,
      this.minWeight: 0,
      this.weightList,
      this.currentWeight: 75}) {
    this.maxWeight = maxWeight ?? 150;
    this.minWeight = minWeight ?? 0;
    this.currentWeight = currentWeight ?? 75;
    this.weightList = List.generate(maxWeight - minWeight + 1, (int index) {
      return '${minWeight + index}公斤';
    });
    _currentIndex = currentWeight - minWeight;
  }

  @override
  int finalData() {
    return _currentIndex;
  }

  @override
  int getCurrentIndex() {
    return _currentIndex+minWeight;
  }

  @override
  void setSelectedIndex(int index) {
    _currentIndex = index;
  }

  ///返回 “75公斤”
  @override
  String stringAtIndex(int index) {
    if (index >= 0 && index < weightList.length) {
      return weightList[index];
    } else {
      return null;
    }
  }

  @override
  String getTips() {
    return "请选择正确的体重，确保热量消耗计算准确。";
  }

  @override
  String getTitle() {
    return "体重";
  }
}
