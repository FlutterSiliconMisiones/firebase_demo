import 'package:firebase_demo_app/features/list_products/view/product_list_page.dart';
import 'package:flutter/widgets.dart';

// import '../../home/view/home_page.dart';
import '../../login/view/login_page.dart';
import '../bloc/app_bloc.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [ProductListPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
