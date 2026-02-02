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
    final currencyFormatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
    );

    final totalAmount = currencyFormatter.format(objMoney.totalAmount.abs());
    final color = switch (objMoney.totalAmount) {
      > 0 => Colors.green,
      < 0 => Colors.red,
      _ => Colors.grey,
    };
    final prefix = switch (objMoney.totalAmount) {
      > 0 => '+',
      < 0 => '-',
      _ => '',
    };

    return Card(
      color: Colors.black,
      child: InkWell(
        onTap: onTap,
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
                                  padding: EdgeInsets.only(bottom: 2),
                                  child: InkWell(
                                    onTap: onRemove,
                                    child: Icon(
                                      size: 20,
                                      Icons.remove_circle_outlined,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  objMoney.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '$prefix$totalAmount',
                              style: TextStyle(color: color, fontSize: 18),
                            ),
                          ),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              objMoney.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    '$prefix$totalAmount',
                                    style: TextStyle(
                                      color: color,
                                      fontSize: 18,
                                    ),
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
                      ),
            ),
            Divider(height: 0.2, thickness: 0.2, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
