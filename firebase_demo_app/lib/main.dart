import 'package:firebase_demo_app/features/list_products/cubit/product_list_cubit.dart';
import 'package:firebase_demo_app/features/list_products/view/product_list_page.dart';
import 'package:firebase_demo_app/services/database/database_service.dart';
import 'package:firebase_demo_app/services/database/database_repository_impl.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_demo_app/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate, // Agrega esta línea
        // GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // Cambia según tus preferencias
      ],
      home: ProductListPage(),
    );
  }
}
