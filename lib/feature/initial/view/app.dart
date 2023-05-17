import 'package:flutter/material.dart';

import '../../../config/router/app_router.dart';
import '../../category/view/category_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CategoriesPage(),
      onGenerateRoute: AppRouter.generateRoute,
      onUnknownRoute: AppRouter.unknownRoute,
    );
  }
}
