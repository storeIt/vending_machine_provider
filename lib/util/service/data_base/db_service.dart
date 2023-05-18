import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../constant/db_constant.dart';

abstract class DbService {
  static const databaseVersion = 1;

  Database? _database;

  Future<Database> getDb() async {
    _database ??= await _getDatabase();
    return _database!;
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DbConstant.dbName),
      onCreate: (db, version) async {
        final batch = db.batch();
        _createVendingTable(batch);
      },
      version: databaseVersion,
    );
  }

  void _createVendingTable(Batch batch) {
    batch.execute(
      ''' 
      CREATE TABLE ${DbConstant.tableName} ( 
        ${DbConstant.columnId} INTEGER PRIMARY KEY, 
        ${DbConstant.columnCategory} TEXT NOT NULL,
        ${DbConstant.categoryImageUrl} TEXT,
        ${DbConstant.columnName} TEXT NOT NULL
        ${DbConstant.columnPrice} REAL NOT NULL,
        ${DbConstant.columnImageUrl} TEXT,
        ${DbConstant.columnQuantity} INTEGER NOT NULL);
      ''',
    );
  }
}
