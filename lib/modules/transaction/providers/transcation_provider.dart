import 'package:flutter/material.dart';
import 'package:uas_made/models/transaction.dart';
import 'package:uas_made/modules/database/database.dart';
import 'package:uas_made/repository/transaction_repository.dart';

class TransactionProvider extends ChangeNotifier {
  List<Transaction> transactions = [];
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }

    notifyListeners();
  }

  Future<void> findAllTransaction(String month) async {
    TranscationRepository transcationRepository =
        TranscationRepository(database: await DatabaseUtils.getDatabase());

    transactions = await transcationRepository.findAll(month);
    notifyListeners();
  }

  Future<void> createTransaction(Transaction transaction, String month) async {
    TranscationRepository transcationRepository =
        TranscationRepository(database: await DatabaseUtils.getDatabase());

    await transcationRepository.insert(transaction);

    findAllTransaction(month);
  }

  Future<void> deleteTransaction(Transaction transaction) async {
    TranscationRepository transcationRepository =
        TranscationRepository(database: await DatabaseUtils.getDatabase());

      await transcationRepository.delete(transaction.id ?? '');

      findAllTransaction(transaction.month);
  }
}
