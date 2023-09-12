import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo_app/features/list_products/models/product.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Product>> getProducts() async {
    QuerySnapshot<Map<String, dynamic>> productosSnapshot =
        await _db.collection('productos').get();

    final List<Product> listaProductos = productosSnapshot.docs.map((doc) {
      return Product.fromDocumentSnapshot(doc);
    }).toList();
    return listaProductos;
  }

  Future<void> saveDummyData() async {
    final productos = [
      {
        'nombre': 'Camiseta',
        'precio': 20.0,
      },
      {
        'nombre': 'Pantalones',
        'precio': 30.0,
      },
      {
        'nombre': 'Zapatos',
        'precio': 50.0,
      },
      {
        'nombre': 'Gorra',
        'precio': 10.0,
      },
      {
        'nombre': 'Calcetines',
        'precio': 5.0,
      },
      {
        'nombre': 'Chaqueta',
        'precio': 60.0,
      },
      {
        'nombre': 'Bufanda',
        'precio': 15.0,
      },
      {
        'nombre': 'Bolsa',
        'precio': 25.0,
      },
      {
        'nombre': 'Reloj',
        'precio': 70.0,
      },
      {
        'nombre': 'Gafas de sol',
        'precio': 40.0,
      },
    ];

    for (var producto in productos) {
      await _db.collection('productos').add(producto);
    }
  }
}
