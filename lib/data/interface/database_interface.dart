abstract class DatabaseInterface {
  //?this is the method we will use to create a new table
  Future createTable(String query);
  Future insertRow(String tableName, Map<String, dynamic> row);
  Future updateRow(String tableName, Map<String, dynamic> row);
  Future getRows(String tableName);
  Future getSpecificRows(
    String tableName, {
    required String where,
    required List<Object?> whereArgs,
  });
  Future deleteRow(String tableName, int id);
  Future isTableExists(String tableName);
}
