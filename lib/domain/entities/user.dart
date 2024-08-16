import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final int genre;
  final String name, userName, avatar;
  final Timestamp registerDate;

  User({
    required this.id,
    required this.genre,
    required this.name,
    required this.userName,
    required this.avatar,
    required this.registerDate,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      id: doc.id,
      genre: data['genre'],
      name: data['name'],
      userName: data['userName'],
      avatar: data['avatar'],
      registerDate: data['registerDate'],
    );
  }
}
