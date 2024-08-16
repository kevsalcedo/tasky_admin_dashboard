import 'package:flutter/material.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';

class UserQuantity extends StatelessWidget {
  const UserQuantity({super.key, required this.userCount});

  final int userCount;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Card(
        elevation: 10,
        color: colors.primary,
        child: Column(
          children: [
            Text(
              registeredUsers,
              style: TextStyle(
                fontSize: 48,
                color: colors.onSecondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 48,
                  color: colors.onSecondary,
                ),
                AnimatedFlipCounter(
                  value: userCount.isNaN ? 00 : userCount,
                  fractionDigits: 0,
                  hideLeadingZeroes: true,
                  thousandSeparator: ',',
                  padding: const EdgeInsets.all(8),
                  duration: const Duration(seconds: 1),
                  textStyle: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -8.0,
                    color: colors.onSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
