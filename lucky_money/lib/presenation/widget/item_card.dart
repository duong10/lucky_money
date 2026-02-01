import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/models/obj_money.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.objMoney, required this.onTap});

  final ObjMoney objMoney;
  final VoidCallback onTap;

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      objMoney.name,
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            '$prefix$totalAmount',
                            style: TextStyle(color: color, fontSize: 18),
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

    // return BlocBuilder<MoneyBloc, MoneyState>(
    //   buildWhen: (previous, current) {
    //
    //     final total = state.listObjMoney.map((e) => e.totalAmount).toList();
    //
    //     if (previous.listObjMoney.isEmpty) {
    //       return false;
    //     }
    //     return previous.listObjMoney.length != current.listObjMoney.length;
    //   },
    //   builder: (context, state) {
    //     return Card(
    //       color: Colors.black,
    //       child: InkWell(
    //         onTap: onTap,
    //         child: Column(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.symmetric(
    //                 horizontal: 0,
    //                 vertical: 8,
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                 children: [
    //                   Text(
    //                     objMoney.name,
    //                     style: TextStyle(color: Colors.white, fontSize: 22),
    //                   ),
    //                   Row(
    //                     children: [
    //                       Text(
    //                         '',
    //                         // '$prefix$amountString',
    //                         // style: TextStyle(color: color, fontSize: 18),
    //                       ),
    //                       const SizedBox(width: 8),
    //                       Icon(
    //                         Icons.arrow_forward_ios,
    //                         color: Colors.white38,
    //                         size: 12,
    //                       ),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             Divider(height: 0.2, thickness: 0.2, color: Colors.grey),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
