import '../../constant/db_constant.dart';
import '../../feature/category/model/category.dart';
import '../../feature/products/model/product.dart';
import 'app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  @override
  Future<List<Product>> fetchProducts() async {
    final result = await restClient.fetchProducts();
    return result;
  }

  @override
  Future<List<Product>> saveProducts(List<Product> products) async {
    await dbClient.insertAll(products);
    return products;
  }

  @override
  Future<List<Product>> getProducts() async => await dbClient.getProducts().then((value) {
        return value;
      });

  @override
  Future<List<Category>> getCategories() async {
    List<Map<String, dynamic>> categoriesInfo = await dbClient.getCategories();
    return categoriesInfo
        .map((result) => Category(
              name: result[DbConstant.columnCategory] as String,
              price: result[DbConstant.columnPrice] as double,
            ))
        .toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final List<Map<String, dynamic>> result = await dbClient.getProductsByCategory(category);
    return result.map((item) => Product.fromMap(item)).toList();
  }

  @override
  Future<void> updateQuantity(Product product) async {
    await dbClient.updateQuantity(product);
  }

  @override
  Future<int> deleteProduct(int id) async {
    return await dbClient.deleteProduct(id);
  }
}
