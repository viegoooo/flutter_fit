import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  BarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory BarChart.withSampleData() {
    return new BarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,

    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      animationDuration: Duration(milliseconds: 1000),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('9/1', 2145),
      new OrdinalSales('9/2', 4125),
      new OrdinalSales('9/3', 15100),
      new OrdinalSales('9/4', 13300),
      new OrdinalSales('9/5', 7775),

      new OrdinalSales('9/6', 5444),
      new OrdinalSales('9/7', 252),
      new OrdinalSales('9/8', 6100),
      new OrdinalSales('9/9', 7100),
      new OrdinalSales('today', 1175),

    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales steps, _) => steps.date,
        measureFn: (OrdinalSales steps, _) => steps.steps,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String date;
  final int steps;

  OrdinalSales(this.date, this.steps);
}