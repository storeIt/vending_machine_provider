import '../../../base/view_model/base_view_model.dart';
import '../model/product.dart';
import '../repository/products_repository.dart';

class ProductsViewModel extends BaseViewModel {
  final ProductsRepository _repository = ProductsRepository();

  final List<Product> products = [];

  Future<void> getProducts(String category) async {
    List<Product> result = await _repository.getProductsByCategory(category);
    products.clear();
    if (result.isNotEmpty) {
      products.addAll(result);
    } else {
      requireCategoryUpdate();
    }
    notifyListeners();
  }
}
