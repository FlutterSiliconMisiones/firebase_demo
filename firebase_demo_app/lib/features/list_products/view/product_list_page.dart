import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/bloc/app_bloc.dart';
import '../../../services/database/database_service.dart';
import '../cubit/product_list_cubit.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  static Page<void> page() =>
      const MaterialPage<void>(child: ProductListPage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              DatabaseService databaseService = DatabaseService();
              await databaseService.saveDummyData();
            },
            icon: Icon(Icons.data_saver_on),
          ),
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              context.read<AppBloc>().add(const AppLogoutRequested());
            },
          )
        ],
      ),
      body: BlocBuilder<ProductListCubit, ProductListState>(
        bloc: BlocProvider.of<ProductListCubit>(context)..getProducts(),
        builder: (context, state) {
          return (state.loading)
              ? CircularProgressIndicator()
              : Center(
                  child: ListView.builder(
                      itemCount: state.productList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.productList[index].nombre),
                          subtitle:
                              Text('\$${state.productList[index].precio}'),
                        );
                      }),
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
