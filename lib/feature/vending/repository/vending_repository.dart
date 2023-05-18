import '../../../base/repository/base_repository.dart';
import '../../products/model/product.dart';

class VendingRepository extends BaseRepository {
  Future<void> updateQuantity(Product product) async {
    await dbClient.updateQuantity(product);
  }

  Future<int> deleteProduct(int id) async {
    return await dbClient.deleteProduct(id);
  }
}
