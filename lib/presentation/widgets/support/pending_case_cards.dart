import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';
import 'package:tasky_admin_dashboard/domain/entities/pending_case.dart';

class PendingCaseCard extends StatelessWidget {
  final List<PendingCase> pendingCase;

  const PendingCaseCard({super.key, required this.pendingCase});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListView.builder(
      itemCount: pendingCase.length,
      itemBuilder: (context, index) {
        return CustomCard(pendingCase: pendingCase, colors: colors, index: index);
      }
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.pendingCase,
    required this.colors,
    required this.index,
  });

  final List<PendingCase> pendingCase;
  final ColorScheme colors;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(),
                  const SizedBox(height: 4),
                  Text(
                    "@${pendingCase[index].userName}",
                    style: TextStyle(color: colors.primary),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pendingCase[index].error,
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    pendingCase[index].information,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            FilledButton(
              //onPressed: () => context.push('/chat'),
              onPressed: () {  },
              child: const Text(buttonChatTitle),
            ),
          ],
        ),
      ),
    );
  }
}
