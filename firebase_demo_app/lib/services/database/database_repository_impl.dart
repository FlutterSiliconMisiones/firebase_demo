import 'package:firebase_demo_app/features/list_products/models/product.dart';
import 'package:firebase_demo_app/services/database/database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  @override
  Future<void> deleteProduct(String productId) {
    return service.deleteProduct(productId);
  }

  @override
  Future<void> addProduct(String nombre, double precio) {
    return service.addProduct(nombre, precio);
  }

  @override
  Future<List<Product>> getProducts() {
    return service.getProducts();
  }

  @override
  Stream<List<Product>> getProductsStream() {
    return service.getProductsStream();
  }

  @override
  Future<void> saveDummyData() {
    return service.saveDummyData();
  }
}

abstract class DatabaseRepository {
  Future<void> deleteProduct(String productId);
  Future<void> addProduct(String nombre, double precio);
  Future<List<Product>> getProducts();
  Stream<List<Product>> getProductsStream();
  Future<void> saveDummyData();
}
