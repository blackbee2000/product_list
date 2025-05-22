class ClientDatabase {
  ClientDatabase._();
  static const String databaseName = 'product_list.db';
  static const int currentVersion = 1;

  static const String tableProduct = 'Products';

  /// SQL
  static const String initSql = 'assets/sql/init_db_local.sql';
}
