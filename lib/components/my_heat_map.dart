import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final Map<DateTime, int> dataset;
  final DateTime startDate;
  const MyHeatMap({
    super.key,
    required this.dataset,
    required this.startDate,
  });

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startDate,
      endDate: DateTime.now(),
      datasets: dataset,
      colorMode: ColorMode.color,
      defaultColor: Theme.of(context).colorScheme.secondary,
      textColor: Theme.of(context).colorScheme.inversePrimary,
      showText: true,
      scrollable: true,
      showColorTip: false,
      size: 30,
      colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade700,
      },
    );
  }
}
