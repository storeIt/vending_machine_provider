import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../base/view_model/base_view_model.dart';
import '../../../constant/app_constant.dart';
import '../../../constant/material/dimen.dart';
import '../../../util/service/service_locator.dart';
import '../../../util/service/view/state_event_service.dart';
import '../../../widget/info_screen.dart';
import '../view_model/category_view_model.dart';
import 'category_tile.dart';

class CategoriesPage extends StatefulWidget {
  static const routeName = '/categories';

  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends StateEventService<CategoriesPage> {
  late final CategoryViewModel _viewModel = locator<CategoryViewModel>(param1: eventBus);

  @override
  void initState() {
    super.initState();

    _viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(AppConstant.vendingTitle)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding),
              child: ChangeNotifierProvider<CategoryViewModel>(
                create: (context) => _viewModel,
                child: Consumer<CategoryViewModel>(
                  builder: (context, viewModel, _) {
                    return viewModel.categories.isNotEmpty
                        ? GridView.count(
                            crossAxisCount: 2,
                            mainAxisSpacing: defaultPadding,
                            crossAxisSpacing: defaultPadding,
                            childAspectRatio: 0.75,
                            physics: const ScrollPhysics(),
                            children: List.generate(
                              viewModel.categories.length,
                              (index) => CategoryTile(viewModel.categories[index]),
                            ),
                          )
                        : viewModel.refill
                            ? InfoScreen(
                                message: AppConstant.emptyVending,
                                withAction: AppConstant.emptyVendingAction,
                                onAction: _viewModel.init,
                              )
                            : const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  BaseViewModel getModel() {
    return _viewModel;
  }
}
