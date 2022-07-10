import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_made/models/transaction.dart';
import 'package:uas_made/modules/home/providers/home_provider.dart';
import 'package:uas_made/modules/transaction/providers/transcation_provider.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: IconButton(
            onPressed: () {
              context
                  .read<TransactionProvider>()
                  .deleteTransaction(transaction);
              context.read<HomeProvider>().findAllAmount();
            },
            icon:  Icon(
              Icons.delete,
              color: Colors.green.shade500,
            ),
          ),
          title: Text(transaction.title),
          subtitle: Text(transaction.createdAt),
          trailing: Text(
            'Rp ${transaction.amount}',
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
