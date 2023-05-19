import 'package:flutter/material.dart';

import '../../../constant/app_constant.dart';
import '../../../constant/material/dimen.dart';
import '../../products/view/products_page.dart';
import '../model/category.dart';

class CategoryTile extends StatelessWidget {
  final Category _category;

  const CategoryTile(this._category, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductsPage.routeName, arguments: _category.name);
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Colors.orange[100],
          border: Border.all(color: Colors.grey), // Outline border
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding / 4),
              child: Text(
                _category.name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${AppConstant.currencySymbol} ${_category.price}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
