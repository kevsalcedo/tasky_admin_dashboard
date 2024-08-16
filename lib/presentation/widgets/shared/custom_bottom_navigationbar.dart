import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIdex;

  const CustomBottomNavigation({super.key, required this.currentIdex});

  void onItemTapped(BuildContext context, index) {
    switch (index) {
      case 0:
        context.go(homeViewPath);
        break;
      case 1:
        context.go(supportViewPath);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return NavigationBar(
      selectedIndex: currentIdex,
      onDestinationSelected: (index) {
        onItemTapped(context, index);
      },
      indicatorColor: colors.onSecondary,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      height: size.height * 0.1,
      backgroundColor: colors.onInverseSurface,
      elevation: 10,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.house_outlined),
          selectedIcon: Icon(
            Icons.house,
            color: primaryColor,
          ),
          label: homeLabel,
        ),
        NavigationDestination(
          icon: Icon(Icons.support_agent_outlined),
          selectedIcon: Icon(
            Icons.support_agent_rounded,
            color: primaryColor,
          ),
          label: supportLabel,
        ),
      ],
    );
  }
}
