import '../../../base/view_model/base_view_model.dart';
import '../../category/view/category_page.dart';
import '../initial_repository/initial_repository.dart';

class InitialViewModel extends BaseViewModel {
  final InitialRepository _repository = InitialRepository();

  void init() async {
    await _repository.dbClient.getProducts().then((value) {
      if (value.isNotEmpty) {
        pushReplacementNamed(CategoryPage.routeName);
      } else {
        fetchProducts(_repository);
      }
    });
  }
}
