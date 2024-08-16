import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';
import 'package:tasky_admin_dashboard/presentation/widgets/widgets.dart';
import 'package:tasky_admin_dashboard/notifier/pending_case_notifier/get_pending_case_notifier.dart';

class SupportView extends ConsumerStatefulWidget {
  const SupportView({super.key});

  @override
  SupportViewState createState() => SupportViewState();
}

class SupportViewState extends ConsumerState<SupportView> {

  @override
  void initState() {
    super.initState();
    ref.read(pendingCaseProvider.notifier).getPendingCases();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final pendingCases = ref.watch(pendingCaseProvider);

    return Scaffold(
      body: FadeInUp(
        duration: duratinOfSupportScreenAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: supportHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Text(
                supportTitle,
                style: TextStyle(
                  color: colors.primary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: pendingCases.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : PendingCaseCard(pendingCase: pendingCases),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
