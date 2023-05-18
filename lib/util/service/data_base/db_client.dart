import 'package:sqflite/sqflite.dart';

import '../../../constant/db_constant.dart';
import '../../../feature/products/model/product.dart';
import '../../helper/logger_helper.dart';
import '../service_locator.dart';
import 'db_service.dart';

class DbClient extends DbService {
  final logger = locator<LoggerHelper>();

  Future<int> insert(Product product) async {
    try {
      final db = await getDb();
      var id = await db.insert(DbConstant.tableName, product.toMap());
      return id;
    } catch (e) {
      logger.e(DbConstant.dbError, e, StackTrace.current);
      return -1;
    }
  }

  Future<List<Object?>> insertAll(List<Product> products) async {
    try {
      final db = await getDb();
      Batch batch = db.batch();
      for (Product product in products) {
        batch.insert(DbConstant.tableName, product.toMap());
      }
      return await batch.commit();
    } catch (e) {
      logger.e(DbConstant.dbError, e, StackTrace.current);
      return [];
    }
  }

  Future<Product?> getProduct(int id) async {
    try {
      final db = await getDb();
      List<Map<String, Object?>> maps = await db.query(DbConstant.tableName,
          columns: [
            DbConstant.columnId,
            DbConstant.columnName,
            DbConstant.columnPrice,
            DbConstant.columnImageUrl,
            DbConstant.columnCategory,
            DbConstant.columnQuantity,
          ],
          where: '${DbConstant.columnId} = ?',
          whereArgs: [id]);
      if (maps.isNotEmpty) {
        return Product.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      logger.e(DbConstant.dbError, e, StackTrace.current);
      return null;
    }
  }

  Future<List<Product>> getProducts() async {
    try {
      final db = await getDb();
      List<Map<String, Object?>> maps = await db.query(DbConstant.tableName, columns: [
        DbConstant.columnId,
        DbConstant.columnName,
        DbConstant.columnPrice,
        DbConstant.columnImageUrl,
        DbConstant.columnCategory,
        DbConstant.columnQuantity,
      ]);
      if (maps.isNotEmpty) {
        return maps.map((e) => Product.fromMap(e)).toList();
      }
    } catch (e) {
      logger.e(DbConstant.dbError, e, StackTrace.current);
    }
    return [];
  }

  Future<int> deleteProduct(int id) async {
    try {
      final db = await getDb();
      return await db.delete(
        DbConstant.tableName,
        where: '${DbConstant.columnId} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      logger.e(DbConstant.dbError, e, StackTrace.current);
      return 0;
    }
  }

  Future<int> updateQuantity(Product product) async {
    try {
      final db = await getDb();
      return await db.update(
        DbConstant.tableName,
        product.toMap(),
        where: '${DbConstant.columnId} = ?',
        whereArgs: [product.quantity],
      );
    } catch (e) {
      logger.e(DbConstant.dbError, e, StackTrace.current);
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      final db = await getDb();
      return await db.rawQuery(
          'SELECT DISTINCT ${DbConstant.columnCategory}, ${DbConstant.columnPrice} FROM ${DbConstant.tableName}');
    } catch (e) {
      logger.e(DbConstant.dbError, e, StackTrace.current);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getProductsByCategory(String category) async {
    try {
      final db = await getDb();
      return await db.query(
        DbConstant.tableName,
        where: '${DbConstant.columnCategory} = ?',
        whereArgs: [category],
      );
    } catch (e) {
      logger.e(DbConstant.dbError, e, StackTrace.current);
      return [];
    }
  }
}
