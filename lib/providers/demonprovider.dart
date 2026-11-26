import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:entrega_final/entities/demonio.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:firebase_auth/firebase_auth.dart';

final demonProvider = StateNotifierProvider<DemonNotifier, List<Demonio>>(
  (ref) => DemonNotifier(FirebaseFirestore.instance),
);

class DemonNotifier extends StateNotifier<List<Demonio>> {
  final FirebaseFirestore db;
  final FirebaseAuth auth = FirebaseAuth.instance;

  DemonNotifier(this.db) : super([]);

  Future<void> addDemon(Demonio demon) async {
    final doc = db.collection('users').doc(auth.currentUser?.uid).collection('demonios').doc();
    final nuevoDemonio = Demonio(
      id: doc.id,
      nombre: demon.nombre,
      descripcion: demon.descripcion,
      rango: demon.rango,
      apariciones: demon.apariciones,
      foto: demon.foto
    );

    try {
      await doc.set(nuevoDemonio.toFirestore());
      state = [...state, nuevoDemonio];
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteDemon(Demonio demon) async {
    final doc = db.collection('users').doc(auth.currentUser?.uid).collection('demonios').doc(demon.id);
    try {
      await doc.delete();
      state = state.where((item) => item.id != demon.id).toList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> modifyDemon(Demonio demon) async {
    final doc = db.collection('users/${auth.currentUser?.uid}/demonios').doc(demon.id);
    final nuevoDemonio = Demonio(
      id: demon.id,
      nombre: demon.nombre,
      descripcion: demon.descripcion,
      rango: demon.rango,
      apariciones: demon.apariciones,
      foto: demon.foto
    );

    try {
      await doc.set(nuevoDemonio.toFirestore());
      state = state
          .map((item) => item.id == nuevoDemonio.id ? nuevoDemonio : item)
          .toList();
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAllDemons() async {
    final docs = db
        .collection('users/${auth.currentUser?.uid}/demonios')
        .withConverter(
          fromFirestore: Demonio.fromFirestore,
          toFirestore: (Demonio demon, _) => demon.toFirestore(),
        );
    final users = await docs.get();
    state = [...state, ...users.docs.map((d) => d.data())];
  }
}
