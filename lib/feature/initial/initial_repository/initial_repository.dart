import '../../../base/repository/base_repository.dart';
import '../../products/model/product.dart';

class InitialRepository extends BaseRepository {
  Future<List<Product>> fetchProducts() async {
    final result = await restClient.fetchProducts();
    return result;
  }

  Future<List<Product>> saveProducts(List<Product> products) async {
    await dbClient.insertAll(products);
    return products;
  }
}
