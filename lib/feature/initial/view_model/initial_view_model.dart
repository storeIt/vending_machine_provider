import '../../../base/view_model/base_view_model.dart';
import '../../../util/helper/event_bus_event/update_categories.dart';
import '../../category/view/category_page.dart';

class InitialViewModel extends BaseViewModel {
  void init() async {
    subscriptions.add(eventBus.on<UpdateCategories>().listen((event) {
      checkDb();
    }));
    checkDb();
  }

  void checkDb() async {
    await repository.getProducts().then((value) {
      if (value.isNotEmpty) {
        pushReplacementNamed(CategoryPage.routeName);
      } else {
        fetchProducts();
      }
    });
  }
}
