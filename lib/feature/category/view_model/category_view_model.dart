import 'package:dartz/dartz.dart';
import 'package:event_bus/event_bus.dart';

import '../../../base/view_model/base_view_model.dart';
import '../../../util/helper/event_bus_event/update_categories.dart';
import '../../category/model/category.dart';
import '../../products/model/product.dart';
import '../repository/category_repository.dart';

class CategoryViewModel extends BaseViewModel {
  final CategoryRepository _repository = CategoryRepository();
  final EventBus eventBus;
  final List<Category> categories = [];

  bool _refill = false;
  bool get refill => _refill;

  CategoryViewModel(this.eventBus);

  void init() async {
    showLoading();
    subscriptions.add(eventBus.on<UpdateCategories>().listen((_) {
      _refill = true;
      getCategories();
    }));
    await getCategories();
    hideLoading();
    if (categories.isEmpty) {
      fetchProducts();
    }
  }

  void fetchProducts() {
    executeRequest(
      repository: _repository,
      request: _repository.fetchProducts(),
      success: (Right<Object, List<Product>> products) async {
        await _repository.saveProducts(products.value);
        getCategories();
      },
    );
  }

  Future<void> getCategories() async {
    await _repository.getCategories().then((value) {
      categories.clear();
      if (value.isNotEmpty) {
        categories.addAll(value);
      }
      notifyListeners();
    });
  }
}
