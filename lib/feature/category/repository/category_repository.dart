import '../../../base/repository/base_repository.dart';
import '../../../constant/db_constant.dart';
import '../../category/model/category.dart';

class CategoryRepository extends BaseRepository {
  Future<List<Category>> getCategories() async {
    List<Map<String, dynamic>> categoriesInfo = await dbClient.getCategories();
    return categoriesInfo
        .map((result) => Category(
              name: result[DbConstant.columnCategory] as String,
              price: result[DbConstant.columnPrice] as double,
            ))
        .toList();
  }
}
