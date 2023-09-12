import 'package:firebase_demo_app/features/list_products/cubit/product_list_cubit.dart';
import 'package:firebase_demo_app/services/database/database_service.dart';
import 'package:firebase_demo_app/services/database/lib/services/database/database_repository_impl.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListCubit(
        DatabaseRepositoryImpl(),
      ),
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                DatabaseService databaseService = DatabaseService();
                await databaseService.saveDummyData();
              },
              icon: Icon(Icons.data_saver_on),
            ),
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
      ),
    );
  }
}
