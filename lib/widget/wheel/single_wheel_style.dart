import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WheelPickerTheme extends Diagnosticable {
  final TextStyle cancelStyle;
  final TextStyle doneStyle;
  final TextStyle itemUnselectedStyle;
  final TextStyle itemSelectedStyle;
  final Color backgroundColor;

  final double containerHeight;
  final double titleHeight;
  final double tipsHeight;
  final double itemHeight;
  final double actionButtonHeight;
  final double marginToWindow;
  final BorderRadius borderRadius;

  const WheelPickerTheme({
    this.cancelStyle = const TextStyle(color: Colors.deepOrange, fontSize: 16),
    this.doneStyle = const TextStyle(color: Colors.deepOrange, fontSize: 16),
    this.itemUnselectedStyle = const TextStyle(color: Colors.black, fontSize: 18),
    this.itemSelectedStyle = const TextStyle(color: Colors.deepOrange, fontSize: 18,fontWeight: FontWeight.bold),
    this.backgroundColor = Colors.white,
    this.containerHeight = 260.0,
    this.titleHeight = 48.0,
    this.itemHeight = 48.0,
    this.actionButtonHeight = 42.0,
    this.marginToWindow = 24.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.tipsHeight = 24.0,
  });
}