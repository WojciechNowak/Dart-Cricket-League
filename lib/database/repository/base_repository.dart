import 'package:dart_cricket/interfaces/all_interfaces.dart';
import 'package:dart_cricket/interfaces/db/db_executor_interface.dart';
import 'package:dart_cricket/interfaces/db/model_interface.dart';
import 'package:dart_cricket/interfaces/db/repository_interface.dart';
import 'package:tuple/tuple.dart';

class BaseRepository<T extends IDbModel> implements IRepository<T> {
  final IDbCmdExecutor _dbCmdExecutor;

  BaseRepository(this._dbCmdExecutor);

  @override
  Future<Tuple2<bool, int>> insert(T obj) async {
    final int id = await _dbCmdExecutor.insert(obj.table(), obj.toMap());
    return Tuple2(id != 0, id);
  }

  @override
  Future<bool> delete(T obj) async {
    return await _dbCmdExecutor.delete(obj.table(), obj.id()) != 0;
  }

  @override
  Future<bool> update(T obj) async {
    return await _dbCmdExecutor.update(obj.table(), obj.id(), obj.toMap()) != 0;
  }

  @override
  Future<T> fetch(T obj) async {
    var result = await _dbCmdExecutor.fetch(obj.table(), obj.id(), obj.toMap().keys);
    if (result.length > 0) {
      obj.fromMap(result.first);
      return obj;
    } else {
      return null;
    }
  }

  @override
  Future<List<T>> fetchAll(T Function() construct) async {
    return await fetchBy(construct);
  }

  @override
  Future<List<T>> fetchBy(T Function() construct, [QueryLimiter limit]) async {
    final obj = construct();
    final result = await _dbCmdExecutor.fetchBy(obj.table(), obj.columns(), limit);
    //TODO lazy loading
    return result.map((m) { final model = construct(); model.fromMap(m); return model; }).toList();
  }
}