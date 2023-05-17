import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';

import '../../feature/category/view_model/category_view_model.dart';
import '../../feature/products/view_model/products_view_model.dart';
import '../../feature/vending/view_model/vending_view_model.dart';
import '../helper/logger_helper.dart';
import 'networking/retrofit_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton(() => RetrofitService());
  locator.registerLazySingleton(() => EventBus());
  locator.registerFactory<LoggerHelper>(() => LoggerHelper());

  // Register view models
  locator.registerFactoryParam<CategoryViewModel, EventBus, void>((args, _) => CategoryViewModel(args));
  locator.registerFactory<ProductsViewModel>(() => ProductsViewModel());
  locator.registerFactory<VendingViewModel>(() => VendingViewModel());
}
