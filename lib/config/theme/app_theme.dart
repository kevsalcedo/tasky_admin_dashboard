import 'package:flutter/material.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: primaryColor,
        appBarTheme: const AppBarTheme(centerTitle: false)
      );
}
