import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucky_money/data/models/transaction.dart';

class ItemCardDetail extends StatelessWidget {
  const ItemCardDetail({
    super.key,
    required this.transaction,
    required this.onTap,
    this.isEditItem,
  });

  final Transaction transaction;
  final VoidCallback onTap;
  final bool? isEditItem;

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
              child:
                  (isEditItem ?? false)
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    size: 20,
                                    Icons.remove_circle_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$prefix$amountCustom',
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 20,
                                      ),
                                    ),
                                    (transaction.comment == '')
                                        ? SizedBox.shrink()
                                        : Text(
                                          transaction.comment,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(
                                  formatter.format(transaction.date),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white38,
                                  size: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$prefix$amountCustom',
                                  style: TextStyle(color: color, fontSize: 20),
                                ),
                                (transaction.comment == '')
                                    ? SizedBox.shrink()
                                    : Text(
                                      transaction.comment,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                              ],
                            ),
                          ),

                          Flexible(
                            flex: 1,
                            child: Text(
                              formatter.format(transaction.date),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
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
