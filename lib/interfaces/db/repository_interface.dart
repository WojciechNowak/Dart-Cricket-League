import 'package:dart_cricket/interfaces/db/db_executor_interface.dart';
import 'package:dart_cricket/interfaces/db/model_interface.dart';
import 'package:tuple/tuple.dart';

abstract class IRepository<T extends IDbModel> {
  Future<Tuple2<bool, int>> insert(T obj);
  Future<bool> update(T obj);
  Future<bool> delete(T obj);
  Future<T> fetch(T obj);
  Future<List<T>> fetchAll(T Function() construct);
  Future<List<T>> fetchBy(T Function() construct, [QueryLimiter limit]);
}