import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucky_money/data/models/transaction.dart';

class ItemCardDetail extends StatelessWidget {
  const ItemCardDetail({
    super.key,
    required this.transaction,
    required this.onTap,
  });

  final Transaction transaction;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('d MMM yyyy', 'en_US');
    final currencyFormatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
    );

    final amountCustom = currencyFormatter.format(transaction.amount.abs());
    final color = transaction.isGive ? Colors.green : Colors.red;
    final prefix = transaction.isGive ? '+' : '-';

    return Card(
      color: Colors.black,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Text(
                      '$prefix$amountCustom',
                      style: TextStyle(color: color, fontSize: 18),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Text(
                      formatter.format(transaction.date),
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 0.2, thickness: 0.2, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
