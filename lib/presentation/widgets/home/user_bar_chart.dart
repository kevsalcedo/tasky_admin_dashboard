import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';

class UserBarChart extends StatelessWidget {
  const UserBarChart({super.key, required this.userCountByDate});

  final Map<DateTime, int> userCountByDate;

  @override
  Widget build(BuildContext context) {
    final barGroups = _generateBarGroups(userCountByDate);
    final maxValue = userCountByDate.isNotEmpty
        ? userCountByDate.values.reduce((a, b) => a > b ? a : b).toDouble() + 5
        : 15.0;

    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          barTouchData: _barTouchData,
          titlesData: _titlesData(),
          borderData: _borderData(),
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: maxValue,
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups(Map<DateTime, int> countsByDate) {
    final now = DateTime.now();
    final days = List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      return DateTime(date.year, date.month, date.day);
    });

    return List.generate(7, (index) {
      final dateKey = days[index];
      final count = countsByDate[dateKey] ?? 0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: count.toDouble(),
            gradient: _barsGradient,
          ),
        ],
        showingTooltipIndicators: [0],
      );
    });
  }

  BarTouchData get _barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData _titlesData() => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: (value, meta) {
              final style = TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );

              final days = _getWeekdayLabels();
              String text;
              if (value.toInt() >= 0 && value.toInt() < days.length) {
                text = days[value.toInt()];
              } else {
                text = '';
              }
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 4,
                child: Text(text, style: style),
              );
            },
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData _borderData() => FlBorderData(
        show: false,
      );

  List<String> _getWeekdayLabels() {
    final now = DateTime.now();
    final days = ['Mn', 'Te', 'Wd', 'Th', 'Fr', 'St', 'Sn'];
    return List.generate(7, (index) {
      final dayIndex = (now.weekday + index) % 7;
      return days[dayIndex];
    });
  }

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
          deepPrimaryColor,
          primaryColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
