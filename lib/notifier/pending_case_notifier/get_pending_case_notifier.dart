import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tasky_admin_dashboard/domain/entities/pending_case.dart';
import 'package:tasky_admin_dashboard/apis/pending_case_api/get_pending_case_api.dart'
    as pending_case_api;

class GetPendingCaseNotifier extends StateNotifier<List<PendingCase>> {
  final pending_case_api.FromFirestore fromFirestore;

  GetPendingCaseNotifier({required this.fromFirestore}) : super([]);

  Future<void> getPendingCases() async {
    try {
      final pendingCase = await fromFirestore.getPendingCases();
      state = pendingCase;
    } catch (e) {
      rethrow;
    }
  }
}

final pendingCaseProvider =
    StateNotifierProvider<GetPendingCaseNotifier, List<PendingCase>>((ref) {
  final fromFirestore = ref.watch(pending_case_api.fromFirestoreAPIProvider);
  return GetPendingCaseNotifier(fromFirestore: fromFirestore);
});
