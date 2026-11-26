import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:entrega_final/entities/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

final userProvider = StateNotifierProvider<UsersNotifier, List<Usuario>>(
  (ref) => UsersNotifier(FirebaseFirestore.instance),
);

class UsersNotifier extends StateNotifier<List<Usuario>> {
  final FirebaseFirestore db;
  final FirebaseAuth auth = FirebaseAuth.instance;

  UsersNotifier(this.db) : super([]);

  Future<void> addUser(Usuario user) async {
    final doc = db.collection('users').doc(user.id);
    try {
      await doc.set(user.toFirestore());
      state = [...state, user];
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllUsers() async {
    final docs = db.collection('users').withConverter(
        fromFirestore: Usuario.fromFirestore,
        toFirestore: (Usuario user, _) => user.toFirestore());
    final users = await docs.get();
    state = [...state, ...users.docs.map((d) => d.data())];
  }
}