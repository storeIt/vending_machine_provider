import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/view_model/base_view_model.dart';
import '../../../constant/material/dimen.dart';
import '../../../util/helper/event_bus_event/update_products.dart';
import '../../../util/service/service_locator.dart';
import '../../../util/service/view/state_event_service.dart';
import '../../../widget/info_screen.dart';
import '../../vending/view/vending_page.dart';
import '../view_model/products_view_model.dart';
import 'product_tile.dart';

class ProductsPage extends StatefulWidget {
  static const String routeName = '/products';

  final String category;

  const ProductsPage({super.key, required this.category});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends StateEventService<ProductsPage> {
  final ProductsViewModel _viewModel = locator<ProductsViewModel>();

  @override
  void initState() {
    super.initState();

    _viewModel.getProducts(widget.category);
    _viewModel.subscriptions.add(_viewModel.eventBus.on<UpdateProducts>().listen((event) {
      _viewModel.getProducts(widget.category);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Choose ${widget.category}')),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
                child: ChangeNotifierProvider<ProductsViewModel>(
                  create: (context) => _viewModel,
                  child: Consumer<ProductsViewModel>(
                    builder: (context, viewModel, _) {
                      return viewModel.products.isNotEmpty
                          ? GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: defaultPadding,
                              crossAxisSpacing: defaultPadding,
                              childAspectRatio: 0.75,
                              physics: const ScrollPhysics(),
                              children: List.generate(
                                viewModel.products.length,
                                (index) => ProductTile(viewModel.products[index], onTap: () {
                                  // viewModel.unsubscribe();
                                  Navigator.pushNamed(context, VendingPage.routeName,
                                      arguments: viewModel.products[index]);
                                }),
                              ),
                            )
                          : InfoScreen(message: 'No more ${widget.category}, choose something else');
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BaseViewModel getModel() {
    return _viewModel;
  }
}
