import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'wheel_style.dart';
import 'data_model.dart';

typedef DateChangedCallback(DateTime time);
typedef String StringAtIndexCallBack(int index);

///NotificationListener , CupertinoPicker
class WheelPicker {

  static void showWheelPicker(
      BuildContext context, {
        int min,
        int max,
        DateChangedCallback onConfirm,
        int currentData,
        WheelPickerTheme theme,
        HeightPickerModel pickerModel,
      }) {
    Navigator.push(
        context,
        new WheelDataPickerRouter(
          pickerModel: pickerModel,
          onConfirm: onConfirm,
          theme: theme,
          barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        )
    );
  }



}

class WheelDataPickerRouter<T> extends PopupRoute<T> {

  final DateChangedCallback onConfirm;
  final WheelPickerTheme theme;
  final BaseOnePickerModel pickerModel;

  AnimationController _animationController;

  WheelDataPickerRouter({this.onConfirm, this.theme, this.pickerModel, this.barrierLabel});

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  final String  barrierLabel ;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(context: context, child: WheelDataPickerWidget(route: this,));
  }

  ///此方法必须实现
  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

}

class WheelDataPickerWidget extends StatefulWidget {

  final WheelDataPickerRouter route;

  const WheelDataPickerWidget({Key key, this.route}) : super(key: key);

//  const _WheelDatePickerWidget({Key key, this.route}) : super(key: key);

  @override
  WheelDataPickerState createState() => WheelDataPickerState();
}

class WheelDataPickerState extends State<WheelDataPickerWidget> {

  HeightPickerModel heightPickerModel ;
  FixedExtentScrollController dataControl;
  WheelPickerTheme theme;
  int currentIndex;
  ValueChanged<int> valueScrollEnd;

  @override
  void initState() {
    heightPickerModel = HeightPickerModel();
    theme = WheelPickerTheme();
    currentIndex = heightPickerModel.getCurrentIndex();
    dataControl = new FixedExtentScrollController(
      initialItem: currentIndex,
    );
    super.initState();
  }

  @override
  void dispose() {
    dataControl?.dispose();
    super.dispose();
  }

//  @override
//  Widget build(BuildContext context) {
//    return Material(
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          _buildTitle(),
//          _buildWheelView(),
//          _buildActionButton(),
//        ],
//      ),
//    );
//  }


  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation:widget.route.animation,
      builder: (BuildContext context, Widget child) {
        return ClipRect(
          child: CustomSingleChildLayout(
            delegate: _PickerLayoutDelegate(
              widget.route.animation.value,
              theme,
            ),
            child: GestureDetector(
              child: Material(
                elevation:4,
                shape:RoundedRectangleBorder(borderRadius: theme.borderRadius),
                color: theme.backgroundColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildTitle(),
                    _buildWheelView(),
                    _buildTips(),
                    _buildActionButton(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(){
    return Container(
      padding: const EdgeInsets.only(left:24 ,top: 12),
      child: Row(
        children: <Widget>[
          Text(
            "身高",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildTips(){
    return Container(
      color: theme.backgroundColor ?? Colors.white,
      height: theme.tipsHeight,
      child: Text(
          "请选择正确的身高，确保热量消耗及运动距离计算准确。",
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black
          ),
      ),
    );
  }

  // Title View
  Widget _buildActionButton() {
    return Container(
      color: theme.backgroundColor ?? Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: theme.actionButtonHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsets.only(left: 16, top: 0),
              child: Text(
                '取消',
                style: theme.cancelStyle,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Container(
            height: theme.actionButtonHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsets.only(right: 16, top: 0),
              child: Text(
                '确定',
                style: theme.doneStyle,
              ),
              onPressed: () {
                Navigator.pop(context);
//                if (widget.route.onConfirm != null) {
//                  widget.route.onConfirm(widget.pickerModel.finalTime());
//                }
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildWheelView() {
    return Container(
     color: theme.backgroundColor ?? Colors.white,
      padding: EdgeInsets.symmetric(horizontal:48),
      height: theme.containerHeight,
     // decoration: BoxDecoration(color: theme.backgroundColor ?? Colors.white),
      ///https://book.flutterchina.club/chapter8/notification.html
      child: StatefulBuilder(
        builder: (context, StateSetter setState){
          return CupertinoPicker.builder(
              backgroundColor: theme.backgroundColor ?? Colors.white,
              scrollController: dataControl,
              itemExtent: theme.itemHeight,
              onSelectedItemChanged: (int index) {
                //selectedChangedWhenScrolling(index);
                print("index = $index");
                setState(() {
                  currentIndex = index;
                }
                );
              },
              useMagnifier: true,
              itemBuilder: (BuildContext context, int index) {
                final content = heightPickerModel.stringAtIndex(index);
                return Container(
                  height: theme.itemHeight,
                  alignment: Alignment.center,
                  child: Text(
                    content,
                    style: index==currentIndex?theme.itemSelectedStyle:theme.itemUnselectedStyle,
                    textAlign: TextAlign.start,
                  ),
                );
              });
        },
      ),
    );
  }
}


///
class _PickerLayoutDelegate extends SingleChildLayoutDelegate {
  _PickerLayoutDelegate(this.progress, this.theme,
      {this.itemCount, this.showTitle: true,this.showTips:true});

  final double progress;
  final int itemCount;
  final bool showTitle;
  final bool showTips;
  final WheelPickerTheme theme;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight + theme.actionButtonHeight;
    if (showTitle) {
      maxHeight += theme.titleHeight;
    }
    if(showTips){
      maxHeight += theme.tipsHeight;
    }
    return new BoxConstraints(
        minWidth: constraints.maxWidth-theme.marginToWindow*2,
        maxWidth: constraints.maxWidth-theme.marginToWindow*2,
        minHeight: 0.0,
        maxHeight: maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress-theme.marginToWindow;
    return new Offset(theme.marginToWindow, height);
  }

  @override
  bool shouldRelayout(_PickerLayoutDelegate oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
