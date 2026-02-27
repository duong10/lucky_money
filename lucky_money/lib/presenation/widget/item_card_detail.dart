import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucky_money/data/models/obj_money.dart';
import 'package:lucky_money/data/models/transaction.dart';
import 'package:lucky_money/presenation/page/add_page.dart';

class ItemCardDetail extends StatelessWidget {
  const ItemCardDetail({
    super.key,
    required this.transaction,
    required this.onTap,
    this.isEditItem,
    this.objMoney,
    required this.onRemove,
  });

  final Transaction transaction;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final bool? isEditItem;
  final ObjMoney? objMoney;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('d MMM yyyy', 'en_US');
    final currencyFormatter = NumberFormat.currency(
      locale: transaction.currency == 'USD' ? 'en_US' : 'vi_VN',
      symbol: transaction.currency == 'USD' ? 'USD ' : 'đ',
      decimalDigits: transaction.currency == 'USD' ? 2 : 0,
    );

    final amountCustom = currencyFormatter.format(transaction.amount.abs());
    final color = transaction.isGive ? Colors.green : Colors.red;
    final prefix = transaction.isGive ? '+' : '-';

    return Card(
      color: Colors.black,
      child: InkWell(
        onTap:
            (isEditItem ?? false)
                ? () {
                  AddPage.show(
                    context,
                    objMoney: objMoney,
                    transaction: transaction,
                    pageName: 'Edit Transaction',
                  );
                }
                : onTap,
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
                                  onTap: onRemove,
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
                                    fontSize: 16,
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
