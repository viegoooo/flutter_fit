library flutter_datetime_picker;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './src/datetime_picker_theme.dart';
import './src/date_model.dart';
import './src/i18n_model.dart';
import './src/date_format.dart';

export './src/datetime_picker_theme.dart';
export './src/date_model.dart';
export './src/i18n_model.dart';


typedef DateChangedCallback(DateTime time);
typedef String StringAtIndexCallBack(int index);

class DatePicker {
  ///
  /// Display date picker bottom sheet.
  ///
  static void showDatePicker(
    BuildContext context, {
    bool showActionsButton: true,
    DateTime minTime,
    DateTime maxTime,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    locale: LocaleType.zh,
    DateTime currentTime,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
            showActionsButton: showActionsButton,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: DatePickerModel(
                currentTime: currentTime,
                maxTime: maxTime,
                minTime: minTime,
                locale: locale)));
  }

  ///
  /// Display time picker bottom sheet.
  ///
  static void showTimePicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    DateTime currentTime,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
            showActionsButton: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel:
                TimePickerModel(currentTime: currentTime, locale: locale)));
  }

  ///
  /// Display date&time picker bottom sheet.
  ///
  static void showDateTimePicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    DateTime currentTime,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
            showActionsButton: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel:
                DateTimePickerModel(currentTime: currentTime, locale: locale)));
  }

  ///
  /// Display date picker bottom sheet witch custom picker model.
  ///
  static void showPicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateChangedCallback onChanged,
    DateChangedCallback onConfirm,
    locale: LocaleType.en,
    BasePickerModel pickerModel,
    DatePickerTheme theme,
  }) {
    Navigator.push(
        context,
        new _DatePickerRoute(
            showActionsButton: showTitleActions,
            onChanged: onChanged,
            onConfirm: onConfirm,
            locale: locale,
            theme: theme,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            pickerModel: pickerModel));
  }
}

class _DatePickerRoute<T> extends PopupRoute<T> {
  _DatePickerRoute({
    this.showActionsButton,
    this.onChanged,
    this.onConfirm,
    theme,
    this.barrierLabel,
    this.locale,
    RouteSettings settings,
    pickerModel,
  })  : this.pickerModel = pickerModel ?? DatePickerModel(),
        this.theme = theme ?? DatePickerTheme(),
        super(settings: settings);

  final bool showActionsButton;
  final DateChangedCallback onChanged;
  final DateChangedCallback onConfirm;
  final DatePickerTheme theme;
  final LocaleType locale;
  final BasePickerModel pickerModel;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _DatePickerComponent(
        onChanged: onChanged,
        locale: this.locale,
        route: this,
        pickerModel: pickerModel,
      ),
    );
    ThemeData inheritTheme = Theme.of(context, shadowThemeOnly: true);
    if (inheritTheme != null) {
      bottomSheet = new Theme(data: inheritTheme, child: bottomSheet);
    }
    return bottomSheet;
  }
}

class _DatePickerComponent extends StatefulWidget {
  _DatePickerComponent(
      {Key key,
      @required this.route,
      this.onChanged,
      this.locale,
      this.pickerModel});

  final DateChangedCallback onChanged;

  final _DatePickerRoute route;

  final LocaleType locale;

  final BasePickerModel pickerModel;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<_DatePickerComponent> {
  FixedExtentScrollController leftScrollCtrl, middleScrollCtrl, rightScrollCtrl;

  DateTime currentDateTime;

  @override
  void initState() {
    super.initState();
    currentDateTime =widget.pickerModel.finalTime();
    refreshScrollOffset();
  }

  void refreshScrollOffset() {
    leftScrollCtrl = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = new FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex());
  }

  @override
  Widget build(BuildContext context) {
    DatePickerTheme theme = widget.route.theme;
    return new GestureDetector(
      child: new AnimatedBuilder(
        animation: widget.route.animation,
        builder: (BuildContext context, Widget child) {
          return new ClipRect(

            child: new CustomSingleChildLayout(
              delegate: new _BottomPickerLayout(
                  widget.route.animation.value, theme,
                  showActionsButton: widget.route.showActionsButton),
              child: new GestureDetector(
                child: Material(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: theme.borderRadius),
                  color: theme.backgroundColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      _buildTitle(theme,formatDate(currentDateTime, [ymdw], widget.locale)),
                    _renderItemView(theme),
                     _renderActionsButton(theme),
                    ],
                  ),

                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      widget.onChanged(widget.pickerModel.finalTime());
    }
  }

  Widget _renderColumnView(
      ValueKey key,
      DatePickerTheme theme,
      StringAtIndexCallBack stringAtIndexCB,
      ScrollController scrollController,
      int layoutProportion,
      ValueChanged<int> selectedChangedWhenScrolling,
      ValueChanged<int> selectedChangedWhenScrollEnd,int nowIndex) {

    int currentIndex = nowIndex;

    return Expanded(
      flex: layoutProportion,
      child: Container(
          padding: EdgeInsets.all(8.0),
          height: theme.containerHeight,
          decoration:
              BoxDecoration(color: theme.backgroundColor ?? Colors.white),
          child: NotificationListener(
              onNotification: (ScrollNotification notification) {
                if (notification.depth == 0 &&
                    selectedChangedWhenScrollEnd != null &&
                    notification is ScrollEndNotification &&
                    notification.metrics is FixedExtentMetrics) {
                  final FixedExtentMetrics metrics = notification.metrics;
                  final int currentItemIndex = metrics.itemIndex;
                  selectedChangedWhenScrollEnd(currentItemIndex);
                }
                return false;
              },
              child: StatefulBuilder(
                  builder: (context, StateSetter setState) {
                    return CupertinoPicker.builder(
                  key: key,
                  backgroundColor: theme.backgroundColor ?? Colors.white,
                  scrollController: scrollController,
                  itemExtent: theme.itemHeight,
                  onSelectedItemChanged: (int index) {
                    selectedChangedWhenScrolling(index);//这个一定要在 setState()前面调用 里面设置了setCurrentIndex();
                    setState(() {
                      currentDateTime = widget.pickerModel.finalTime();
                      print('时间：${currentDateTime.toUtc()}');
                      currentIndex = index;
                    });
                  },
                  useMagnifier: true,
                  itemBuilder: (BuildContext context, int index) {
                    final content = stringAtIndexCB(index);
                    if (content == null) {
                      return null;
                    }
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
                  });}))),
    );
  }

  Widget _buildTitle( DatePickerTheme theme,String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 12,right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }


  Widget _renderItemView(DatePickerTheme theme) {
    return Container(
      color: theme.backgroundColor ?? Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _renderColumnView(
              ValueKey(widget.pickerModel.currentLeftIndex()),
              theme,
              widget.pickerModel.leftStringAtIndex,
              leftScrollCtrl,
              widget.pickerModel.layoutProportions()[0], (index) {
            widget.pickerModel.setLeftIndex(index);
          }, (index) {
            setState(() {
              refreshScrollOffset();
              _notifyDateChanged();
            });
          },widget.pickerModel.currentLeftIndex()),
          Text(
            widget.pickerModel.leftDivider(),
            style: theme.itemUnselectedStyle,
          ),
          _renderColumnView(
              ValueKey(widget.pickerModel.currentLeftIndex()),
              theme,
              widget.pickerModel.middleStringAtIndex,
              middleScrollCtrl,
              widget.pickerModel.layoutProportions()[1], (index) {
            widget.pickerModel.setMiddleIndex(index);
          }, (index) {
            setState(() {
              refreshScrollOffset();
              _notifyDateChanged();
            });
          },widget.pickerModel.currentMiddleIndex()),
          Text(
            widget.pickerModel.rightDivider(),
            style: theme.itemUnselectedStyle,
          ),
          _renderColumnView(
              ValueKey(widget.pickerModel.currentMiddleIndex() +
                  widget.pickerModel.currentLeftIndex()),
              theme,
              widget.pickerModel.rightStringAtIndex,
              rightScrollCtrl,
              widget.pickerModel.layoutProportions()[2], (index) {
            widget.pickerModel.setRightIndex(index);
            _notifyDateChanged();
          }, null,widget.pickerModel.currentRightIndex()),
        ],
      ),
    );
  }

  // Title View
  Widget _renderActionsButton(DatePickerTheme theme) {
    String done = _localeDone();
    String cancel = _localeCancel();

    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: theme.actionButtonHeight,
            child: CupertinoButton(
              pressedOpacity: 0.3,
              padding: EdgeInsets.only(left: 16, top: 0),
              child: Text(
                '$cancel',
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
                '$done',
                style: theme.doneStyle,
              ),
              onPressed: () {
                Navigator.pop(context);
                if (widget.route.onConfirm != null) {
                  widget.route.onConfirm(widget.pickerModel.finalTime());
                }
              },
            ),
          ),
        ],
    );
  }

  String _localeDone() {
    return i18nObjInLocale(widget.locale)['done'];
  }

  String _localeCancel() {
    return i18nObjInLocale(widget.locale)['cancel'];
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, this.theme,
      {this.itemCount, this.showActionsButton:true});

  final double progress;
  final int itemCount;
  final bool showActionsButton;
  final DatePickerTheme theme;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight +theme.titleHeight+theme.marginToWindow;
    if (showActionsButton) {
      maxHeight += theme.actionButtonHeight;
    }

    return new BoxConstraints(
        minWidth: constraints.maxWidth-theme.marginToWindow * 2,
        maxWidth: constraints.maxWidth-theme.marginToWindow * 2,
        minHeight: 0.0,
        maxHeight: maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress-theme.marginToWindow;
    return new Offset(theme.marginToWindow , height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
