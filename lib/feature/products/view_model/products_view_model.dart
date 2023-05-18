import '../../../base/view_model/base_view_model.dart';
import '../../../util/helper/event_bus_event/update_categories.dart';
import '../model/product.dart';
import '../repository/products_repository.dart';

class ProductsViewModel extends BaseViewModel {
  final ProductsRepository _repository = ProductsRepository();

  Future<void> getProducts(String category) async {
    List<Product> result = await _repository.getProductsByCategory(category);
    products.clear();
    if (result.isNotEmpty) {
      products.addAll(result);
    } else {
      eventBus.fire(UpdateCategories());
    }
    notifyListeners();
  }
}
