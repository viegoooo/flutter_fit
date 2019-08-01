import 'package:flutter/material.dart';
import 'package:flutter_fit/widget/chart_with_title.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BarChart.withSampleData(),

    );
  }
}
