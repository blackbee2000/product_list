import 'package:path/path.dart';
import 'package:product_list/core/database/util_database.dart';
import 'package:sqflite/sqflite.dart';

import 'client_database.dart';

class ClientDatabaseManager extends DatabaseExecutor {
  static const String beginTransactionQuery = 'BEGIN TRANSACTION';
  static const String commitTransactionQuery = 'COMMIT';
  static const String rollbackTransactionQuery = 'ROLLBACK';
  static const String alias = 'CLIENT';

  static final ClientDatabaseManager _instance =
      ClientDatabaseManager._internal();
  static ClientDatabaseManager get instance => _instance;

  Database? _database;

  @override
  Database get database => _database!;

  factory ClientDatabaseManager() {
    return _instance;
  }

  ClientDatabaseManager._internal();

  /// Open database
  Future<void> open() async => await _getDatabase();

  /// Get instance of object Database
  Future<Database> _getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  /// Close current connection
  Future<void> closeConnection() async {
    try {
      if (_database == null) {
        return;
      }
      await _database!.close();
      _database = null;
    } catch (e) {
      throw Exception('Can\'t close master database. Error: $e');
    }
  }

  static Future<String> getDatabasePath() async {
    final String databasesPath = await getDatabasesPath();
    final String userDBPath = join(databasesPath, ClientDatabase.databaseName);
    return userDBPath;
  }

  static Future<Database> _initDatabase() async {
    try {
      final String databasesPath = await getDatabasePath();

      return await openDatabase(
        databasesPath,
        version: ClientDatabase.currentVersion,
        onCreate: (Database db, int version) async {
          await DatabaseUtil.executeSqlScript(db, ClientDatabase.initSql);
        },
        onOpen: (Database db) async {},
        onUpgrade: (Database db, int oldVersion, int newVersion) async {},
      );
    } catch (e) {
      throw Exception('Can\'t connect local database $e');
    }
  }

  static Future<void> deleteClientDatabase() async {
    try {
      final path = await getDatabasePath();
      await deleteDatabase(path);
    } catch (e) {
      throw Exception('Can\'t delete master database. Error: $e');
    }
  }

  Future<void> deleteTableClientDB({required String tableName}) async {
    try {
      final db = await _initDatabase();
      await db.delete(tableName);
    } catch (e) {
      throw Exception('Can\'t delete table. Error: $e');
    }
  }

  @override
  Future<List<Map<String, Object?>>> query(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    return _database!.query(
      table,
      distinct: distinct,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );
  }

  @override
  Batch batch() {
    throw UnimplementedError();
  }

  @override
  Future<int> delete(
    String table, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    return _database!.delete(
      table,
      whereArgs: whereArgs,
      where: where,
    );
  }

  @override
  Future<void> execute(String sql, [List<Object?>? arguments]) async {
    return _database!.execute(sql, arguments);
  }

  @override
  Future<int> insert(
    String table,
    Map<String, Object?> values, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    try {
      await _database!.rawQuery(ClientDatabaseManager.beginTransactionQuery);

      final result = await _database!.insert(
        table,
        values,
        nullColumnHack: nullColumnHack,
        conflictAlgorithm: conflictAlgorithm,
      );

      await _database!.rawQuery(ClientDatabaseManager.commitTransactionQuery);

      return result;
    } catch (e) {
      await _database!.rawQuery(ClientDatabaseManager.rollbackTransactionQuery);
      rethrow;
    }
  }

  @override
  Future<QueryCursor> queryCursor(
    String table, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
    int? bufferSize,
  }) async {
    return _database!.queryCursor(
      table,
      columns: columns,
      where: where,
      whereArgs: whereArgs,
      groupBy: groupBy,
      having: having,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
      bufferSize: bufferSize,
    );
  }

  @override
  Future<int> rawDelete(String sql, [List<Object?>? arguments]) async {
    return _database!.rawDelete(sql, arguments);
  }

  @override
  Future<int> rawInsert(String sql, [List<Object?>? arguments]) async {
    try {
      await _database!.rawQuery(ClientDatabaseManager.beginTransactionQuery);

      final result = await _database!.rawInsert(sql, arguments);

      await _database!.rawQuery(ClientDatabaseManager.commitTransactionQuery);

      return result;
    } catch (e) {
      await _database!.rawQuery(ClientDatabaseManager.rollbackTransactionQuery);
      rethrow;
    }
  }

  @override
  Future<List<Map<String, Object?>>> rawQuery(String sql,
      [List<Object?>? arguments]) async {
    return _database!.rawQuery(sql, arguments);
  }

  @override
  Future<QueryCursor> rawQueryCursor(String sql, List<Object?>? arguments,
      {int? bufferSize}) async {
    return _database!.rawQueryCursor(sql, arguments);
  }

  @override
  Future<int> rawUpdate(String sql, [List<Object?>? arguments]) async {
    try {
      await _database!.rawQuery(ClientDatabaseManager.beginTransactionQuery);

      final result = await _database!.rawUpdate(sql, arguments);

      await _database!.rawQuery(ClientDatabaseManager.commitTransactionQuery);

      return result;
    } catch (e) {
      await _database!.rawQuery(ClientDatabaseManager.rollbackTransactionQuery);
      rethrow;
    }
  }

  @override
  Future<int> update(
    String table,
    Map<String, Object?> values, {
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    try {
      await _database!.rawQuery(ClientDatabaseManager.beginTransactionQuery);

      final result = await _database!.update(
        table,
        values,
        where: where,
        whereArgs: whereArgs,
        conflictAlgorithm: conflictAlgorithm,
      );

      await _database!.rawQuery(ClientDatabaseManager.commitTransactionQuery);

      return result;
    } catch (e) {
      await _database!.rawQuery(ClientDatabaseManager.rollbackTransactionQuery);
      rethrow;
    }
  }
}
