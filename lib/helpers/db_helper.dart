import "package:path/path.dart" as path;
import "package:sqflite/sqflite.dart";

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      path.join(dbPath, "places.db"),
      version: 1,
      onCreate: (db, version) {
        return db.execute("CREATE TABLE user_places(id TEXT PRIMARY KEY, name TEXT, image TEXT)");
      },
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<Map<String, dynamic>>> fetchData(String table) async {
    final db = await DBHelper.database();

    return db.query(table);
  }
}