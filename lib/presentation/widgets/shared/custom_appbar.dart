import 'package:flutter/material.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AppBar(
        leading: Icon(Icons.diamond, color: colors.primary),
        title: Text(
          appName,
          style: TextStyle(
            color: colors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      );
  }
}
