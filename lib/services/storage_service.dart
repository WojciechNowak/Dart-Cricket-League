import 'package:dart_cricket/database/model/player.dart';
import 'package:dart_cricket/database/repository/base_repository.dart';
import 'package:dart_cricket/dto/player.dart';
import 'package:dart_cricket/interfaces/all_interfaces.dart';
import 'package:dart_cricket/interfaces/db/db_executor_interface.dart';
import 'package:dart_cricket/interfaces/db/repository_interface.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

class StorageService implements IStorageService, IDbCmdExecutor {
  final String _databaseName = "dart-league.db";
  final int _dbVersion = 1;
  Map<String, IRepository<IDbModel>> _repositories;
  Map<String, IDbModel> _models;
  sql.Database _db;

  void _initializeModels() {
    _models = {
      "PlayerModel": PlayerModel(),
    };
  }

  void _initializeRepositories() {
    _repositories = {
      "PlayerModel": BaseRepository<PlayerModel>(this)
    };
  }

  void _initializeDatabase() {
    _initializeModels();
    _initializeRepositories();
  }

  @override
  Future<bool> initialize() async {
    _initializeDatabase();

    final dbPath = path.join(await sql.getDatabasesPath(), _databaseName);

    _db = await sql.openDatabase(dbPath, version: _dbVersion, onCreate: (sql.Database db, int version) async {
      await Future.forEach(_models.values, (model) async => await db.execute(model.createTable()));
    });

    return Future.value(_db.isOpen);
  }

  @override
  Future<bool> shutdown() async {
    await _db.close();
    return true;
  }

  @override
  IRepository<T> getRepository<T extends IDbModel>() {
    assert(_repositories.containsKey(T.toString()), 'Repository for ${T.toString()} doesn\'t exist');
    return _repositories.containsKey(T.toString()) ? _repositories[T.toString()] : null;
  }

  @override
  Future<int> delete(String tableName, int id) async {
    assert(id != null, 'Id is null');
    return await _db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> update(String tableName, int id, Map<String, dynamic> model) async {
    assert(id != null, 'Id is null');
    return await _db.update(tableName, model, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> insert(String tableName, Map<String, dynamic> model) async {
    return await _db.insert(tableName, model);
  }

  @override
  Future<List<Map>> fetch(String tableName, int id, List<String> columns) async {
    assert(id != null, 'Id is null');
    return await _db.query(tableName, columns: columns, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Map>> fetchBy(String tableName, List<String> columns, QueryLimiter limit) async {
    //TODO decorator pattern for AND/OR/NOT/IN/LIKE etc.
    if (limit != null) {
      assert(limit.fields.length == limit.values.length, 'Fields and values should have the same length');
      return await _db.query(tableName, columns: columns, where: limit.fields, whereArgs: limit.values);
    } else {
      return await _db.query(tableName, columns: columns);
    }
  }
}
