import 'dart:math';

import 'package:flutter/material.dart';

/// 2019/07/24
///自定义的圆形进度条
///《flutter实战》
/// https://book.flutterchina.club/chapter13/gradient_circular_progress_demo.html
class CircleProgressBar extends StatelessWidget {
  ///粗细
  final double stokeWidth;

  /// 圆的半径
  final double radius;

  ///两端是否为圆角
  final bool strokeCapRound;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条背景色
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 渐变色数组
  final List<Color> colors;

  /// 渐变色的终止点，对应colors属性
  final List<double> stops;

  const CircleProgressBar(
      {Key key,
      this.stokeWidth :18.0,
      this.radius :40,
      this.strokeCapRound :true,
      this.value :0,
      this.backgroundColor:Colors.white,
      this.totalAngle :2 *pi,
      this.colors:const [Colors.orange,Colors.deepOrange],
      this.stops})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    // 如果两端为圆角，则需要对起始位置进行调整，否则圆角部分会偏离起始位置
    // 下面调整的角度的计算公式是通过数学几何知识得出，读者有兴趣可以研究一下为什么是这样
    if (strokeCapRound) {
      _offset = asin(stokeWidth / (radius * 2 - stokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).accentColor;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
          size: Size.fromRadius(radius),
          painter: _ProgressPainter(
            stokeWidth: stokeWidth,
            strokeCapRound: strokeCapRound,
            backgroundColor: backgroundColor,
            value: value*2*pi,
            totalAngle: totalAngle,
            radius: radius,
            colors: _colors,
          )),
    );
  }
}

class _ProgressPainter extends CustomPainter {
  ///粗细
  final double stokeWidth;

  /// 圆的半径
  final double radius;

  ///两端是否为圆角
  final bool strokeCapRound;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条背景色
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 渐变色数组
  final List<Color> colors;

  /// 渐变色的终止点，对应colors属性
  final List<double> stops;

  _ProgressPainter(
      {this.value,
      this.radius,
      this.colors,
      this.stokeWidth: 18.0,
      this.strokeCapRound: false,
      this.backgroundColor: const Color(0xFFEEEEEE),
      this.totalAngle: 2 * pi,
      this.stops});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    size = Size.fromRadius(radius);

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..strokeWidth = stokeWidth;
    //..isAntiAlias = true;

    ///1.先画背景色
    //背景区域 除去圆圈部分
    Rect rect = Offset(stokeWidth / 2, stokeWidth / 2) &
        Size(size.width - stokeWidth, size.height - stokeWidth);

    double _startAngle;
    double _sweepAngle = totalAngle;
    bool _useCenter = false;

    if (strokeCapRound) {
      _startAngle = asin(stokeWidth / (size.width - stokeWidth));
    }

    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _startAngle, _sweepAngle, _useCenter, paint);
    }

    /// 再画前景，应用渐变
    if (value > 0) {
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: value,
        colors: colors,
        stops: stops,
      ).createShader(rect);

      canvas.drawArc(rect, _startAngle, value, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
