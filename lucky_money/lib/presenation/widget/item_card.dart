import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/obj_money.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item, required this.onTap});

  final ObjMoney item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
    );
    final amountString = currencyFormatter.format(item.amount);
    final color = item.isGive ? Colors.red : Colors.green;
    final prefix = item.isGive ? '+' : '-';

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
                  Text(
                    item.name,
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Row(
                    children: [
                      Text(
                        '$prefix$amountString',
                        style: TextStyle(color: color, fontSize: 18),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white38,
                        size: 12,
                      ),
                    ],
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
