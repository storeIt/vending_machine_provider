import '../../../base/view_model/base_view_model.dart';
import '../../../util/helper/event_bus_event/update_categories.dart';
import '../../category/view/category_page.dart';
import '../repository/initial_repository.dart';

class InitialViewModel extends BaseViewModel {
  final InitialRepository _repository = InitialRepository();

  void init() async {
    subscriptions.add(eventBus.on<UpdateCategories>().listen((event) {
      checkDb();
    }));
    checkDb();
  }

  void checkDb() async {
    await _repository.dbClient.getProducts().then((value) {
      if (value.isNotEmpty) {
        pushReplacementNamed(CategoryPage.routeName);
      } else {
        fetchProducts(_repository);
      }
    });
  }
}
