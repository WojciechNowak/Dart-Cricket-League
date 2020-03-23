import 'package:dart_cricket/interfaces/db/model_interface.dart';
import 'package:meta/meta.dart';

class QueryLimiter {
  final String fields;
  final List<dynamic> values;

  QueryLimiter({this.fields, this.values});
}

abstract class IDbCmdExecutor {
  Future<int> insert(String tableName, Map<String, dynamic> obj);
  Future<int> delete(String tableName, int id);
  Future<int> update(String tableName, int id, Map<String, dynamic> obj);
  Future<List<Map>> fetch(String tableName, int id, List<String> columns);
  Future<List<Map>> fetchBy(String tableName, List<String> columns, QueryLimiter limit);
}
