abstract class IDbModel {
  int id();

  String createTable();

  String table();

  List<String> columns();

  Map<String, dynamic> toMap();

  void fromMap(Map<String, dynamic> map);
}
