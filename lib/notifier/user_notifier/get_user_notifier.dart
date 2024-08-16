import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tasky_admin_dashboard/apis/user_api/get_user_api.dart'
    as user_api;

class GetUserNotifier extends StateNotifier<int> {
  final user_api.FromFirestore fromFirestore;

  GetUserNotifier({required this.fromFirestore}) : super(0);

  Future<void> getInitialUserNumber() async {
    try {
      final userCount = await fromFirestore.getUserNumber();
      state = userCount;
    } catch (e) {
      rethrow;
    }
  }
}

final userNumberProvider = StateNotifierProvider<GetUserNotifier, int>((ref) {
  final fromFirestore = ref.watch(user_api.fromFirestoreAPIProvider);
  return GetUserNotifier(fromFirestore: fromFirestore);
});

class GetUserByDateNotifier extends StateNotifier<Map<DateTime, int>> {
  final user_api.FromFirestore fromFirestore;

  GetUserByDateNotifier({required this.fromFirestore}) : super({});

  Future<void> getUserCountByDate() async {
    try {
      final userCountByDate = await fromFirestore.getUsersCountByDate();
      state = userCountByDate;
    } catch (e) {
      rethrow;
    }
  }
}

final userCountByDateProvider =
    StateNotifierProvider<GetUserByDateNotifier, Map<DateTime, int>>((ref) {
  final fromFirestore = ref.watch(user_api.fromFirestoreAPIProvider);
  return GetUserByDateNotifier(fromFirestore: fromFirestore);
});

class GetUserByGenderNotifier extends StateNotifier<Map<String, int>> {
  final user_api.FromFirestore fromFirestore;

  GetUserByGenderNotifier({required this.fromFirestore}) : super({});

  Future<void> getNumberOfUsersByGender() async {
    try {
      final userByGender = await fromFirestore.getNumberOfUsersByGender();
      state = userByGender;
    } catch (e) {
      rethrow;
    }
  }
}

final userByGenderProvider =
    StateNotifierProvider<GetUserByGenderNotifier, Map<String, int>>((ref) {
  final fromFirestore = ref.watch(user_api.fromFirestoreAPIProvider);
  return GetUserByGenderNotifier(fromFirestore: fromFirestore);
});
