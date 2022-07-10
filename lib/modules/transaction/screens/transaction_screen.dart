import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uas_made/models/transaction.dart';
import 'package:uas_made/modules/home/providers/home_provider.dart';
import 'package:uas_made/modules/transaction/providers/transcation_provider.dart';
import 'package:uas_made/widget/transaction_card.dart';

class TransactionScreen extends StatefulWidget {
  final String month;

  const TransactionScreen({
    Key? key,
    required this.month,
  }) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late TextEditingController titleController;
  late TextEditingController amountController;

  @override
  void initState() {
    titleController = TextEditingController();
    amountController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  String toDateFormat(DateTime dateTime) {
    final day = DateFormat('EEEE').format(dateTime).toString().substring(0, 3);
    final month = DateFormat(DateFormat.MONTH)
        .format(dateTime)
        .toString()
        .substring(0, 3);

    return '$day, $month ${dateTime.day}, ${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Transaction detail of ${widget.month.substring(0, 1).toUpperCase() + widget.month.substring(1)}'),
      ),
      body: FutureBuilder(
        future:
            context.read<TransactionProvider>().findAllTransaction(widget.month),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Consumer<TransactionProvider>(
            builder: (context, value, child) {
              if (value.transactions.isEmpty) {
                return const Center(
                  child: Text('Data kosong, mohon diisi'),
                );
              }

              return ListView.builder(
                itemCount: value.transactions.length,
                itemBuilder: (context, index) {
                  final data = value.transactions[index];

                  return TransactionCard(
                    transaction: data,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: const InputDecoration(hintText: 'Title'),
                      controller: titleController,
                    ),
                    TextField(
                      decoration: const InputDecoration(hintText: 'Amount'),
                      controller: amountController,
                      keyboardType: TextInputType.number,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<TransactionProvider>(
                          builder: (context, value, child) {
                            return Text(
                                'Picked Date: ${toDateFormat(context.read<TransactionProvider>().selectedDate)}');
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            context
                                .read<TransactionProvider>()
                                .selectDate(context);
                          },
                          child: const Text('Choose date'),
                        )
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final currentMonth = DateFormat('MMMM').format(
                            context.read<TransactionProvider>().selectedDate);

                        final transaction = Transaction(
                          id: DateTime.now().toIso8601String(),
                          month: currentMonth.toLowerCase(),
                          title: titleController.text,
                          amount: amountController.text,
                          createdAt: toDateFormat(
                              context.read<TransactionProvider>().selectedDate),
                        );

                        context
                            .read<TransactionProvider>()
                            .createTransaction(transaction, widget.month);

                        context.read<HomeProvider>().findAllAmount();
                        Navigator.pop(context);
                      },
                      child: const Text('Add Transaction'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
