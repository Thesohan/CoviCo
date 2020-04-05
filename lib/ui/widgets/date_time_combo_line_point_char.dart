/// Example of a combo time series chart with two series rendered as lines, and
/// a third rendered as points along the top line with a different color.
///
/// This example demonstrates a method for drawing points along a line using a
/// different color from the main series color. The line renderer supports
/// drawing points with the "includePoints" option, but those points will share
/// the same color as the line.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DateTimeComboLinePointChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DateTimeComboLinePointChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Configure the default renderer as a line renderer. This will be used
      // for any series that does not define a rendererIdKey.
      //
      // This is the default configuration, but is shown here for  illustration.
      defaultRenderer: charts.LineRendererConfig(),
      // Custom renderer configuration for the point series.
      customSeriesRenderers: [
        charts.PointRendererConfig(

            // ID used to link series to this renderer.
            customRendererId: 'customPoint')
      ],
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }
}
