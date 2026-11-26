import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String id;
  final String name;
  final String email;

  const Usuario({
    required this.id,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  static Usuario fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Usuario(
      id: data?['id'],
      name: data?['name'],
      email: data?['email'],
    );
  }
}