import '../../../base/view_model/base_view_model.dart';
import '../../../util/helper/event_bus_event/update_categories.dart';
import '../../category/model/category.dart';

class CategoryViewModel extends BaseViewModel {
  final List<Category> categories = [];

  CategoryViewModel() {
    getCategories();
    subscriptions.add(eventBus.on<UpdateCategories>().listen((event) {
      getCategories();
    }));
  }

  Future<void> getCategories() async {
    await repository.getCategories().then((value) {
      _manageCategory(value);
    });
  }

  void _manageCategory(List<Category> value) {
    categories.clear();
    if (value.isNotEmpty) {
      categories.addAll(value);
    } else {
      refill = true;
    }
    notifyListeners();
  }

  void refillVending() async {
    await fetchProducts();
  }
}
