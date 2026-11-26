import 'package:cloud_firestore/cloud_firestore.dart';

class Demonio {
  final String id;
  final String nombre;
  final String descripcion;
  final int apariciones;
  final String rango;
  final String foto;

  const Demonio({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.apariciones,
    required this.rango,
    required this.foto
  });

    Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'apariciones': apariciones,
      'rango': rango,
      'foto': foto
    };
  }

  static Demonio fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Demonio(
      id: data?['id'],
      nombre: data?['nombre'],
      descripcion: data?['descripcion'],
      apariciones: data?['apariciones'],
      rango: data?['rango'],
      foto: data?['foto'],

    );
  }

}
