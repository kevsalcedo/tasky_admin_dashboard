import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fromFirestoreAPIProvider =
    Provider<FromFirestore>((ref) => FromFirestore());

class FromFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getUserNumber() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection('users').get();
    return querySnapshot.size;
  }

  Future<Map<DateTime, int>> getUsersCountByDate() async {
    CollectionReference collectionReferenceUser =
        _firestore.collection('users');

    final QuerySnapshot querySnapshot = await collectionReferenceUser.get();

    final Map<DateTime, int> userCountByDate = {};

    for (var doc in querySnapshot.docs) {
      final registerDate = (doc['registerDate'] as Timestamp).toDate();
      final date =
          DateTime(registerDate.year, registerDate.month, registerDate.day);

      if (userCountByDate.containsKey(date)) {
        userCountByDate[date] = userCountByDate[date]! + 1;
      } else {
        userCountByDate[date] = 1;
      }
    }

    return userCountByDate;
  }

  Future<Map<String, int>> getNumberOfUsersByGender() async {
    CollectionReference collectionReferenceUser =
        _firestore.collection('users');

    QuerySnapshot queryUser = await collectionReferenceUser.get();

    int numberOfMen = 0;
    int numberOfWomen = 0;

    for (var doc in queryUser.docs) {
      var genre = doc.get('genre');
      if (genre == 0) {
        numberOfMen++;
      } else if (genre == 1) {
        numberOfWomen++;
      }
    }

    return {
      'men': numberOfMen,
      'women': numberOfWomen,
    };
  }
}
