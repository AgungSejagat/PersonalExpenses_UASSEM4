import 'package:flutter/material.dart';
import 'package:uas_made/modules/transaction/screens/transaction_screen.dart';

class MonthCard extends StatelessWidget {
  final String month;
  final String spending;

  const MonthCard({
    Key? key,
    required this.month,
    required this.spending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return TransactionScreen(
                month: month,
              );
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.lime, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(month.substring(0, 1).toUpperCase() + month.substring(1),
                style: Theme.of(context).textTheme.headline6),
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade500,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              height: 50,
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Spending',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                    (spending.length > 8) ? 'Rp. ${spending.substring(0, 7)}...' : 'Rp. $spending',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
