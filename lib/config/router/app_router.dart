import 'package:flutter/material.dart';

import '../../feature/category/view/category_page.dart';
import '../../feature/products/model/product.dart';
import '../../feature/products/view/products_page.dart';
import '../../feature/vending/view/vending_page.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CategoriesPage.routeName:
        return MaterialPageRoute(builder: (BuildContext context) => const CategoriesPage());
      case ProductsPage.routeName:
        final args = settings.arguments as String;
        return MaterialPageRoute(builder: (BuildContext context) => ProductsPage(category: args));
      case VendingPage.routeName:
        return MaterialPageRoute(
            builder: (BuildContext context) => VendingPage(product: settings.arguments as Product));
      default:
        return null;
    }
  }

  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (BuildContext context) => const CategoriesPage());
  }
}
