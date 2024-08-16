import 'package:cloud_firestore/cloud_firestore.dart';

class PendingCase {
  final String error;
  final String information;
  final String userName;

  PendingCase({
    required this.error,
    required this.information,
    required this.userName,
  });

  factory PendingCase.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return PendingCase(
      error: data['error'] ?? '',
      information: data['information'] ?? '',
      userName: data['userName'] ?? '',
    );
  }
}
