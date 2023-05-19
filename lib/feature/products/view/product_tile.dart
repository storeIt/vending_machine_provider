import 'package:flutter/material.dart';

import '../../../constant/app_constant.dart';
import '../../../constant/material/dimen.dart';
import '../model/product.dart';

class ProductTile extends StatelessWidget {
  final Product _product;
  final VoidCallback onTap;

  const ProductTile(this._product, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: const Color(0xFFd6eadf),
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
                _product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              '${AppConstant.currencySymbol} ${_product.price}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
