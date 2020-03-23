import 'package:dart_cricket/interfaces/db/model_interface.dart';

class PlayerModel implements IDbModel {
  static const String _table = 'player';
  static const String columnId = 'id';
  static const String columnName = 'name';

  int _id = 0;
  String _name = '';

  @override
  String createTable() {
    return "CREATE TABLE $_table($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL)";
  }

  @override
  int id() {
    return _id;
  }

  @override
  String table() {
    return PlayerModel._table;
  }

  @override
  List<String> columns() {
    return [ columnId, columnName ];
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    _id = map.containsKey(columnId) ? map[columnId] : 0;
    _name = map.containsKey(columnName) ? map[columnName] : '';
  }

  @override
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: _name
    };
    if (_id != 0) {
      map[columnId] = id;
    }
    return map;
  }
}