import 'package:flutter/material.dart';

import 'package:tasky_admin_dashboard/presentation/views/views.dart';
import 'package:tasky_admin_dashboard/config/constants/constant.dart';
import 'package:tasky_admin_dashboard/presentation/widgets/shared/custom_bottom_navigationbar.dart';

class HomeScreen extends StatelessWidget {
  static const String name = homeScreen;

  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    SupportView(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.diamond, color: colors.primary),
        title: Text(
          appName,
          style: TextStyle(
            color: colors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIdex: pageIndex),
    );
  }
}
