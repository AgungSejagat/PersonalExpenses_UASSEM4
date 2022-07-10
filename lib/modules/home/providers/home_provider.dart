import 'package:flutter/cupertino.dart';
import 'package:uas_made/modules/database/database.dart';
import 'package:uas_made/repository/transaction_repository.dart';

class HomeProvider extends ChangeNotifier {
  final months = [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december',
  ];

  List<Map<String, dynamic>> datas = [];

  Future<void> findAllAmount() async {
    List<Map<String, dynamic>> result = [];

    TranscationRepository transcationRepository =
        TranscationRepository(database: await DatabaseUtils.getDatabase());

      // find transaction by month
      for (var month in months) {
        BigInt count = BigInt.from(0);
        // count spend
        final transactions = await transcationRepository.findAll(month);
        for (var transaction in transactions) {
          final dummyCount = BigInt.from(int.parse(transaction.amount));

          count += dummyCount;
        }

        result.add({
          'month': month,
          'spend': count.toString(),
        });
      }

      datas = result;

      notifyListeners();
  }
}
