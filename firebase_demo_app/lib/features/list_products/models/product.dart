import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String nombre;
  final double precio;

  Product({
    required this.id,
    required this.nombre,
    required this.precio,
  });

  factory Product.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    return Product(
      id: doc.id,
      nombre: doc.data()!['nombre'] ?? '',
      precio: doc.data()!['precio'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
    };
  }
}
