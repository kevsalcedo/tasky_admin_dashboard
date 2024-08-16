import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tasky_admin_dashboard/domain/entities/pending_case.dart';

final fromFirestoreAPIProvider =
    Provider<FromFirestore>((ref) => FromFirestore());

class FromFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PendingCase>> getPendingCases() async {
    try {
      CollectionReference collectionReferencePendingCases =
          _firestore.collection('pendingCases');

      final QuerySnapshot querySnapshot =
          await collectionReferencePendingCases.get();

      final List<PendingCase> pendingCaseList = querySnapshot.docs
          .map((doc) => PendingCase.fromFirestore(doc))
          .toList();

      return pendingCaseList;
    } catch (e) {
      rethrow;
    }
  }
}
