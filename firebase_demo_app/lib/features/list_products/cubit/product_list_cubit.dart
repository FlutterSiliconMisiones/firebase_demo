import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_demo_app/services/database/database_repository_impl.dart';
import 'package:meta/meta.dart';

import '../models/product.dart';

part 'product_list_state.dart';

class ProductListCubit extends Cubit<ProductListState> {
  ProductListCubit(this._databaseRepository) : super(ProductListState());

  final DatabaseRepository _databaseRepository;

  Future<void> addProduct(String nombre, double precio) async {
    emit(state.copyWith(loading: true));

    await _databaseRepository.addProduct(nombre, precio);

    emit(state.copyWith(loading: false));
  }

  void getProducts() async {
    emit(state.copyWith(loading: true));

    // List<Product> productList = await _databaseRepository.getProducts();
    Stream<List<Product>> productListStream =
        _databaseRepository.getProductsStream();

    productListStream.listen(
      (event) {
        emit(
          state.copyWith(
            loading: false,
            productList: event,
          ),
        );
      },
    );
  }

  void saveDummyData() async {
    emit(state.copyWith(loading: true));

    await _databaseRepository.saveDummyData();

    emit(state.copyWith(loading: false));
  }
}
