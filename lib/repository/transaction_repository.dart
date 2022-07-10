import 'package:sqflite/sqflite.dart';
import 'package:uas_made/models/transaction.dart' as model;

class TranscationRepository {
  Database database;

  TranscationRepository({required this.database});

  @override
  Future<void> delete(String id) async {
    await database.delete(model.Transaction.tableName, where: "id = ?", whereArgs: [id]);
  } 

  @override
  Future<List<model.Transaction>> findAll(String month) async {
    List<model.Transaction> result = [];

    List<Map> rows = await database.query(
      model.Transaction.tableName,
      where: "month = ?",
      whereArgs: [month],
    );

    for (var transaction in rows) {
      result.add(model.Transaction(
        month: transaction['month'].toString(),
        id: transaction['id'].toString(),
        title: transaction['title'].toString(),
        amount: transaction['amount'].toString(),
        createdAt: transaction['created_at'].toString(),
      ));
    }

    return result;
  }

  @override
  Future<model.Transaction> insert(model.Transaction transaction) async {
    transaction.id = DateTime.now().toIso8601String();

    await database.insert(model.Transaction.tableName, {
      'id': transaction.id,
      'title': transaction.title,
      'amount': transaction.amount,
      'month': transaction.month,
      'created_at': transaction.createdAt,
    });

    return transaction;
  }
}
