import '../../../base/repository/base_repository.dart';
import '../../products/model/product.dart';

class ProductsRepository extends BaseRepository {
  Future<List<Product>> getProductsByCategory(String category) async {
    final List<Map<String, dynamic>> result = await dbClient.getProductsByCategory(category);
    return result.map((item) => Product.fromMap(item)).toList();
  }
}
