import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesSummary extends StatefulWidget {
  const SalesSummary({Key? key}) : super(key: key);

  @override
  State<SalesSummary> createState() => _SalesSummaryState();
}

class _SalesSummaryState extends State<SalesSummary> {
  int selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(foregroundColor: Colors.white, title: const Text('Sales Summary')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<int>(
              value: selectedValue,
              items: const [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text("This week"),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text("This month"),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text("This year"),
                ),
              ],
              onChanged: (value) {
                selectedValue = value ?? selectedValue;
                setState(() {});
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 3)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 1)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 2)]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 3)]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 1)]),
                    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 2)]),
                    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 3)]),
                  ],
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Text("Days"),
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: getTitles,
                        reservedSize: 36,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Mon', style: style);
        break;
      case 1:
        text = const Text('Tue', style: style);
        break;
      case 2:
        text = const Text('Wed', style: style);
        break;
      case 3:
        text = const Text('Thu', style: style);
        break;
      case 4:
        text = const Text('Fri', style: style);
        break;
      case 5:
        text = const Text('Sat', style: style);
        break;
      case 6:
        text = const Text('Sun', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}