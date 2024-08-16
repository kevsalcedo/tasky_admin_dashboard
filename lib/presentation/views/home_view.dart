import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tasky_admin_dashboard/config/constants/constant.dart';
import 'package:tasky_admin_dashboard/presentation/widgets/widgets.dart';
import 'package:tasky_admin_dashboard/notifier/user_notifier/get_user_notifier.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(userNumberProvider.notifier).getInitialUserNumber();
    ref.read(userCountByDateProvider.notifier).getUserCountByDate();
    ref.read(userByGenderProvider.notifier).getNumberOfUsersByGender();
  }

  @override
  Widget build(BuildContext context) {
    final userCount = ref.watch(userNumberProvider);
    final userCountByDate = ref.watch(userCountByDateProvider);
    final userByGender = ref.watch(userByGenderProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: homeHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              FadeInUp(
                duration: duratinOfHomeScreenAnimation,
                child: userCount.isNaN
                    ? const Center(child: CircularProgressIndicator())
                    : UserQuantity(userCount: userCount),
              ),
              const SizedBox(height: 8),
              FadeInUp(
                duration: duratinOfHomeScreenAnimation,
                child: const ChartTitle(
                  text: barChartTitle,
                ),
              ),
              const SizedBox(height: 4),
              FadeInUp(
                duration: duratinOfHomeScreenAnimation,
                child: SizedBox(
                  height: 200,
                  child: userCountByDate.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : UserBarChart(userCountByDate: userCountByDate),
                ),
              ),
              const SizedBox(height: 34),
              FadeInUp(
                duration: duratinOfHomeScreenAnimation,
                child: const ChartTitle(
                  text: pieChartTitle,
                ),
              ),
              const SizedBox(height: 18),
              FadeInUp(
                duration: duratinOfHomeScreenAnimation,
                child: SizedBox(
                  height: 200,
                  child: userByGender.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : UserPieChart(userByGender: userByGender),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
