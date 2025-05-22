import 'package:product_list/core/utils/asset_util.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseUtil {
  DatabaseUtil._();

  static List<String> getQueriesFromSqlScript(String scripContent) {
    return scripContent
        .split(';')
        .map((e) => e.trim())
        .where((element) => element.isNotEmpty)
        .toList();
  }

  static Future<void> executeSqlScript(
      Database db, String sqlScriptPath) async {
    final String scriptContent =
        await AssetUtil.readFileFromBundle(sqlScriptPath);

    final List<String> queries = getQueriesFromSqlScript(scriptContent);

    for (final sql in queries) {
      await db.execute(sql);
    }
  }

  static Future<void> executeWholeSqlScript(
      Database db, String sqlScriptPath) async {
    final String scriptContent =
        await AssetUtil.readFileFromBundle(sqlScriptPath);

    await db.execute(scriptContent);
  }
}
