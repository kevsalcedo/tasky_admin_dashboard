import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';
import 'package:tasky_admin_dashboard/notifier/user_notifier/get_user_notifier.dart';

class UserPieChart extends ConsumerWidget {
  const UserPieChart({super.key, required this.userByGender});

  final Map<String, int> userByGender;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int menCount = userByGender[men] ?? 0;
    final int womenCount = userByGender[women] ?? 0;

    final int totalUsers = menCount + womenCount;

    final List<MyData> myList = [
      MyData(
        value: totalUsers == 0 ? 0 : (womenCount / totalUsers) * 100,
        color: womanColor,
        icon: const Icon(
          Icons.woman,
          color: iconPieChartColor,
          size: 38,
        ),
      ),
      MyData(
        value: totalUsers == 0 ? 0 : (menCount / totalUsers) * 100,
        color: manColor,
        icon: const Icon(
          Icons.man,
          color: iconPieChartColor,
          size: 38,
        ),
      ),
    ];

    const textStyle = TextStyle(
      color: valuePieChartColor,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PieChart(
            PieChartData(
                sections: myList.asMap().entries.map((mapEntry) {
                  final data = mapEntry.value;

                  return PieChartSectionData(
                    value: data.value,
                    color: data.color,
                    radius: 100,
                    titleStyle: textStyle,
                    title: "${data.value.toStringAsFixed(1)}%",
                    showTitle: true,
                    badgeWidget: data.icon,
                    badgePositionPercentageOffset: 0.75,
                    titlePositionPercentageOffset: 0.4,
                  );
                }).toList(),
                centerSpaceRadius: 0,
                sectionsSpace: 6,
                pieTouchData: PieTouchData(
                  touchCallback: (
                    FlTouchEvent e,
                    PieTouchResponse? r,
                  ) {
                    if (r != null && r.touchedSection != null) {
                      ref
                          .read(userByGenderProvider.notifier)
                          .getNumberOfUsersByGender();
                    }
                  },
                )),
            swapAnimationDuration: const Duration(milliseconds: 150),
            swapAnimationCurve: Curves.linear,
          ),
        ),
      ),
    );
  }
}

class MyData {
  final double value;
  final Color color;
  final Icon icon;

  MyData({required this.value, required this.color, required this.icon});
}
