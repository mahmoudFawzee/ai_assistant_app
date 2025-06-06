abstract class DatabaseInterface {
  //?this is the method we will use to create a new table
  Future createTable(String query);
  Future dropTable(String tableName);
  Future insertRow(String tableName, Map<String, dynamic> row);
  Future updateRow(String tableName, Map<String, dynamic> row);
  Future getRows(String tableName);
  
  Future getSpecificRows(String tableName,
      {required String where, required List<Object?> whereArgs});
  Future deleteRow(String tableName,
      {required String where, required List<Object?> whereArgs});
  // Future deleteRows(
  //   String tableName, {
  //   required String where,
  //   required List<Object?> argsWhere,
  // });

  Future getTableLastItemId(String tableName);
  Future isTableExists(String tableName);
  Future getRowsInRange({
    required String tableName,
    required String orderedBy,
    required int limit,
    required int offset,
  });
  Future<int> getNumberOfRows(String tableName);
}
