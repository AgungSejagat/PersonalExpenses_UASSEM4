class Transaction {
  String? id;
  final String title;
  final String amount;
  final String createdAt;
  final String month;

  Transaction({
    this.id,
    required this.title,
    required this.amount,
    required this.month,
    required this.createdAt,
  });

  static const String tableName = 'transactions';
}
