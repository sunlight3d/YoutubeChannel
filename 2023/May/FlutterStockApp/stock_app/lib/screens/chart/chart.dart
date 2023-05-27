import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class Chart extends StatefulWidget {
  @override
  _MyAreaChartState createState() => _MyAreaChartState();
}

class _MyAreaChartState extends State<Chart> {
  List<ChartData> chartData1 = [];
  List<ChartData> chartData2 = [];
  List<ChartData> chartData3 = [];
  Timer? timer;

  final colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  @override
  void initState() {
    super.initState();
    refreshData();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => refreshData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<ChartData> generateData(int series) {
    final random = Random();
    return List<ChartData>.generate(
      30,
          (i) => ChartData(i, 300 + random.nextInt(101), colors[series]),
    );
  }

  void refreshData() {
    setState(() {
      chartData1 = generateData(0);
      chartData2 = generateData(1);
      chartData3 = generateData(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      primaryXAxis: NumericAxis(),
      primaryYAxis: NumericAxis(),
      legend: Legend(isVisible: true),
      series: <ChartSeries<ChartData, int>>[
        StackedAreaSeries<ChartData, int>(
          dataSource: chartData1,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: chartData1.first.color,
          name: 'Series 1',
        ),
        StackedAreaSeries<ChartData, int>(
          dataSource: chartData2,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: chartData2.first.color,
          name: 'Series 2',
        ),
        StackedAreaSeries<ChartData, int>(
          dataSource: chartData3,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: chartData3.first.color,
          name: 'Series 3',
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final int x;
  final int y;
  final Color color;
}
/*
class Chart extends StatefulWidget {
  @override
  _MyPieChartState createState() => _MyPieChartState();
}

class _MyPieChartState extends State<Chart> {
  late List<ChartData> chartData;
  Timer? timer;

  final colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
  ];

  @override
  void initState() {
    super.initState();
    chartData = generateData();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => refreshData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<ChartData> generateData() {
    final random = Random();
    return List<ChartData>.generate(
      5,
          (i) => ChartData('Region ${i + 1}', random.nextInt(101), colors[i]),
    );
  }

  void refreshData() {
    setState(() {
      chartData = generateData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Container()),
          Expanded(child: SfCircularChart(
            backgroundColor: Colors.white,
            series: <PieSeries<ChartData, String>>[
              PieSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                pointColorMapper: (ChartData data, _) => data.color,
                enableTooltip: true,
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.inside,
                ),
                explode: true,
                explodeIndex: 0,
                //enable3D: true,
              )
            ],
          ))
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final int y;
  final Color color;
}
*/
/*
class Chart extends StatefulWidget {
  @override
  _MyLineChartState createState() => _MyLineChartState();
}

class _MyLineChartState extends State<Chart> {
  List<ChartData> chartData = List<ChartData>.generate(
    100,
        (i) => ChartData(i, Random().nextInt(601) + 400),
  );

  Timer? timer;

  int getMinY() => chartData.reduce((val1, val2) => val1.y < val2.y ? val1 : val2).y;
  int getMaxY() => chartData.reduce((val1, val2) => val1.y > val2.y ? val1 : val2).y;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => refreshData());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void refreshData() {
    setState(() {
      chartData = List<ChartData>.generate(
        100,
            (i) => ChartData(i, Random().nextInt(601) + 400),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      primaryXAxis: NumericAxis(),
      primaryYAxis: NumericAxis(minimum: getMinY().toDouble(), maximum: getMaxY().toDouble()),
      series: <LineSeries<ChartData, int>>[
        LineSeries<ChartData, int>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          color: Colors.blue,
        )
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final int x;
  final int y;
}
*/