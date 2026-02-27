import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/obj_money.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.objMoney,
    required this.onTap,
    this.isEdit,
    required this.onRemove,
  });

  final ObjMoney objMoney;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final bool? isEdit;

  @override
  Widget build(BuildContext context) {
    Widget buildTotalText(double totalValue, String currency) {
      if (totalValue == 0) return const SizedBox.shrink();

      final formatter = NumberFormat.currency(
        locale: currency == 'USD' ? 'en_US' : 'vi_VN',
        symbol: currency == 'USD' ? 'USD ' : 'đ',
        decimalDigits: currency == 'USD' ? 2 : 0,
      );

      final color = totalValue > 0 ? Colors.green : Colors.red;
      final prefix = totalValue > 0 ? '+' : '-';
      final formattedAmount = formatter.format(totalValue.abs());

      return Text(
        '$prefix$formattedAmount',
        style: TextStyle(color: color, fontSize: 18),
      );
    }

    return Card(
      color: Colors.black,
      child: InkWell(
        highlightColor:
            (isEdit ?? false)
                ? Colors.transparent
                : Theme.of(context).highlightColor,
        splashColor:
            (isEdit ?? false)
                ? Colors.transparent
                : Theme.of(context).splashColor,
        onTap: (isEdit ?? false) ? () {} : onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child:
                  (isEdit ?? false)
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 2),
                                  child: InkWell(
                                    onTap: onRemove,
                                    child: const Icon(
                                      size: 20,
                                      Icons.remove_circle_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  objMoney.name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              buildTotalText(objMoney.totalVND, 'VND'),
                              buildTotalText(objMoney.totalUSD, 'USD'),
                            ],
                          ),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              objMoney.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      buildTotalText(objMoney.totalVND, 'VND'),
                                      buildTotalText(objMoney.totalUSD, 'USD'),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white38,
                                  size: 12,
                                ),
                              ],
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
