import '../../../base/repository/base_repository.dart';
import '../../../constant/db_constant.dart';
import '../../category/model/category.dart';
import '../../products/model/product.dart';

class CategoryRepository extends BaseRepository {
  Future<List<Product>> fetchProducts() => restClient.fetchProducts();

  Future<List<Object?>> saveProducts(List<Product> products) async {
    return await dbService.insertAll(products);
  }

  Future<List<Product>> getProducts() async {
    return await dbService.getProducts();
  }

  Future<List<Category>> getCategories() async {
    List<Map<String, dynamic>> categoriesInfo = await dbService.getCategories();
    return categoriesInfo
        .map((result) => Category(
              name: result[DbConstant.columnCategory] as String,
              price: result[DbConstant.columnPrice] as double,
            ))
        .toList();
  }
}
