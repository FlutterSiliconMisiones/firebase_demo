part of 'product_list_cubit.dart';

class ProductListState extends Equatable {
  final List<Product> productList;
  final bool loading;

  const ProductListState({
    this.productList = const [],
    this.loading = false,
  });

  @override
  List<Object?> get props => [
        productList,
        loading,
      ];

  ProductListState copyWith({
    List<Product>? productList,
    bool? loading,
  }) {
    return ProductListState(
      productList: productList ?? this.productList,
      loading: loading ?? this.loading,
    );
  }
}
