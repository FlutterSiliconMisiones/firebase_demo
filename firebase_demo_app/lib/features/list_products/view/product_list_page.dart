import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/database/database_service.dart';
import '../cubit/product_list_cubit.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              DatabaseService databaseService = DatabaseService();
              await databaseService.saveDummyData();
            },
            icon: const Icon(Icons.data_saver_on),
          ),
        ],
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        bloc: BlocProvider.of<ProductListCubit>(context)..getProducts(),
        builder: (context, state) {
          return (state.loading)
              ? const CircularProgressIndicator()
              : Center(
                  child: ListView.builder(
                    itemCount: state.productList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.productList[index].nombre),
                        subtitle: Text('\$${state.productList[index].precio}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () =>
                              context.read<ProductListCubit>().deleteProduct(
                                    state.productList[index].id,
                                  ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openDialog(context),
      ),
    );
  }

  _openDialog(
    BuildContext context,
  ) {
    String name = '';
    double precio = 0.0;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Complete los campos'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Nombre'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Precio'),
                  onChanged: (value) {
                    precio = double.parse(value);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text('Guardar'),
                onPressed: () {
                  context.read<ProductListCubit>().addProduct(name, precio);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
