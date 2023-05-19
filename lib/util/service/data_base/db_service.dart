import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../constant/db_constant.dart';

abstract class DbService {
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
      create table ${DbConstant.tableName} ( 
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
}
