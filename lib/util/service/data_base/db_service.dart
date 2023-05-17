import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../constant/db_constant.dart';
import '../../../feature/products/model/product.dart';

class DbService {
  static final DbService instance = DbService._init();
  DbService._init();

  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _open();
    return _database!;
  }

  Future<Database> _open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DbConstant.dbName);
    return _database = await openDatabase(path, version: 3, onCreate: (Database db, int version) async {
      await db.execute(''' 
      create table ${DbConstant.tableVending} ( 
        ${DbConstant.columnId} integer primary key, 
        ${DbConstant.columnCategory} text not null,
        ${DbConstant.categoryImageUrl} text,
        ${DbConstant.columnName} text not null,
        ${DbConstant.columnPrice} real not null,
        ${DbConstant.columnImageUrl} text,
        ${DbConstant.columnQuantity} integer not null)
      ''');
    });
  }

  Future<int> insert(Product product) async {
    final db = await instance.database;
    var id = await db.insert(DbConstant.tableVending, product.toMap());
    return id;
  }

  Future<List<Object?>> insertAll(List<Product> products) async {
    final db = await instance.database;
    Batch batch = db.batch();
    for (Product product in products) {
      batch.insert(DbConstant.tableVending, product.toMap());
    }
    return await batch.commit();
  }

  Future<Product?> getProduct(int id) async {
    final db = await instance.database;
    List<Map<String, Object?>> maps = await db.query(DbConstant.tableVending,
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
  }

  Future<List<Product>> getProducts() async {
    final db = await instance.database;
    List<Map<String, Object?>> maps = await db.query(DbConstant.tableVending, columns: [
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
    return [];
  }

  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    return await db.delete(
      DbConstant.tableVending,
      where: '${DbConstant.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateQuantity(Product product) async {
    final db = await instance.database;
    return await db.update(
      DbConstant.tableVending,
      product.toMap(),
      where: '${DbConstant.columnId} = ?',
      whereArgs: [product.quantity],
    );
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    final db = await instance.database;
    return await db.rawQuery(
        'SELECT DISTINCT ${DbConstant.columnCategory}, ${DbConstant.columnPrice} FROM ${DbConstant.tableVending}');
  }

  Future<List<Map<String, dynamic>>> getProductsByCategory(String category) async {
    final db = await instance.database;
    return await db.query(
      DbConstant.tableVending,
      where: '${DbConstant.columnCategory} = ?',
      whereArgs: [category],
    );
  }

  Future close() async {
    final db = await instance.database;
    return db.close();
  }
}
