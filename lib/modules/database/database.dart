import 'package:sqflite/sqflite.dart';
import 'package:uas_made/models/transaction.dart' as model;

class DatabaseUtils {
  static Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/check.db';

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        return await db.execute(
            "CREATE TABLE ${model.Transaction.tableName} (id TEXT PRIMARY KEY, title TEXT, amount TEXT, month TEXT, created_at TEXT)");
      },
    );
  }
}
