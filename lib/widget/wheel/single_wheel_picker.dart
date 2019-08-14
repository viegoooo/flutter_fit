import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'single_wheel_style.dart';
import 'data_model.dart';

typedef DateChangedCallback(int data);
typedef String StringAtIndexCallBack(int index);

enum WheelType {
  HEIGHT,
  WEIGHT,
}

///NotificationListener , CupertinoPicker
class WheelPicker {
  static void showWheelPickerByType(
    BuildContext context,
    WheelType wheelType, {
    int min,
    int max,
    DateChangedCallback onConfirm,
    int currentData,
    WheelPickerTheme theme,
  }) {
    BaseOnePickerModel pickerModel;
    switch (wheelType) {
      case WheelType.HEIGHT:
        pickerModel = HeightPickerModel(
            minHeight: min, maxHeight: max, currentHeight: currentData);
        break;
      case WheelType.WEIGHT:
        pickerModel = WeightPickerModel(
            minWeight: min, maxWeight: max, currentWeight: currentData);
        break;
    }

    theme = theme ?? WheelPickerTheme();
    Navigator.push(
        context,
        new WheelDataPickerRouter(
          pickerModel: pickerModel,
          onConfirm: onConfirm,
          theme: theme,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
        ));
  }
}

class WheelDataPickerRouter<T> extends PopupRoute<T> {
  final DateChangedCallback onConfirm;
  final WheelPickerTheme theme;
  final BaseOnePickerModel pickerModel;

  AnimationController _animationController;

  WheelDataPickerRouter(
      {this.onConfirm, this.theme, this.pickerModel, this.barrierLabel});

  @override
  Color get barrierColor => Colors.black54;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
        context: context,
        child: WheelDataPickerWidget(
          route: this,
          theme: theme,
          pickerModel: pickerModel,
          onConfirm: onConfirm,
        ));
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
  final WheelPickerTheme theme;
  final BaseOnePickerModel pickerModel;
  final ValueChanged<int> onConfirm;

  const WheelDataPickerWidget(
      {Key key, this.route, this.theme, this.pickerModel, this.onConfirm})
      : super(key: key);

  @override
  WheelDataPickerState createState() => WheelDataPickerState();
}

class WheelDataPickerState extends State<WheelDataPickerWidget> {
  BaseOnePickerModel pickerModel;

  FixedExtentScrollController dataControl;
  WheelPickerTheme theme;
  int currentIndex;
  ValueChanged<int> onValueConfirm;

  @override
  void initState() {
    pickerModel = widget.pickerModel;
    theme = widget.theme;
    onValueConfirm = widget.onConfirm;
    currentIndex = pickerModel.getCurrentIndex();
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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.route.animation,
      builder: (BuildContext context, Widget child) {
        return ClipRect(
          child: CustomSingleChildLayout(
            delegate: _PickerLayoutDelegate(
              widget.route.animation.value,
              theme,
            ),
            child: GestureDetector(
              child: Material(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: theme.borderRadius),
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

  Widget _buildTitle() {
    return Container(
      padding: const EdgeInsets.only(left: 24, top: 12),
      child: Row(
        children: <Widget>[
          Text(
            pickerModel.getTitle(),
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(
            child: SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget _buildTips() {
    return Container(
      color: theme.backgroundColor ?? Colors.white,
      height: theme.tipsHeight,
      child: Text(
        pickerModel.getTips(),
        style: TextStyle(
            fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black),
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
                print("确定按钮 pressed");
                if(onValueConfirm!=null){
                  onValueConfirm(pickerModel.finalData());
                  print("final Data = ${pickerModel.finalData()}");
                }

                Navigator.pop(context);

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
      padding: EdgeInsets.symmetric(horizontal: 48),
      height: theme.containerHeight,
      // decoration: BoxDecoration(color: theme.backgroundColor ?? Colors.white),
      ///https://book.flutterchina.club/chapter8/notification.html
      child: StatefulBuilder(
        builder: (context, StateSetter setState) {
          return CupertinoPicker.builder(
              backgroundColor: theme.backgroundColor ?? Colors.white,
              scrollController: dataControl,
              itemExtent: theme.itemHeight,
              onSelectedItemChanged: (int index) {
                //selectedChangedWhenScrolling(index);
                setState(() {
                  currentIndex = index;
                  pickerModel.setSelectedIndex(index);
                  print("setSelectedIndex = $index");
                });
              },
              useMagnifier: true,
              itemBuilder: (BuildContext context, int index) {
                final content = pickerModel.stringAtIndex(index);
                return Container(
                  height: theme.itemHeight,
                  alignment: Alignment.center,
                  child: Text(
                    content,
                    style: index == currentIndex
                        ? theme.itemSelectedStyle
                        : theme.itemUnselectedStyle,
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
      {this.itemCount, this.showTitle: true, this.showTips: true});

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
    if (showTips) {
      maxHeight += theme.tipsHeight;
    }
    return new BoxConstraints(
        minWidth: constraints.maxWidth - theme.marginToWindow * 2,
        maxWidth: constraints.maxWidth - theme.marginToWindow * 2,
        minHeight: 0.0,
        maxHeight: maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height =
        size.height - childSize.height * progress - theme.marginToWindow;
    return new Offset(theme.marginToWindow, height);
  }

  @override
  bool shouldRelayout(_PickerLayoutDelegate oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
