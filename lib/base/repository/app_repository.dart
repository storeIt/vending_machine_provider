import '../../feature/category/model/category.dart';
import '../../feature/products/model/product.dart';
import 'base_repository.dart';

abstract class AppRepository extends BaseRepository {
  Future<List<Product>> fetchProducts();
  Future<List<Product>> saveProducts(List<Product> products);
  Future<List<Product>> getProducts();
  Future<List<Category>> getCategories();
  Future<List<Product>> getProductsByCategory(String category);
  Future<void> updateQuantity(Product product);
  Future<int> deleteProduct(int id);
}
