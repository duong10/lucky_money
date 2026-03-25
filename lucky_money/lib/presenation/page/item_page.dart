import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lucky_money/data/models/obj_money.dart';
import 'package:lucky_money/data/models/transaction.dart';
import 'package:lucky_money/presenation/bloc/money_bloc.dart';
import 'package:lucky_money/presenation/widget/item_card_detail.dart';

import 'add_page.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key, required this.objMoney});

  final ObjMoney objMoney;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyBloc, MoneyState>(
      builder: (context, state) {
        // Tìm đối tượng ObjMoney mới nhất trong state dựa vào id
        final currentObjMoney = state.listObjMoney.firstWhere(
          (element) => element.id == objMoney.id,
          orElse: () => objMoney,
        );
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap:
                        () => context.read<MoneyBloc>().add(
                          IsEditEvent(isEditItem: !(state.isEditItem ?? false)),
                        ),
                    child: Text(
                      (state.isEditItem ?? false) ? 'Done' : 'Edit',
                      style: const TextStyle(color: Colors.blue, fontSize: 22),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentObjMoney.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(
                          thickness: 0.2,
                          height: 0.2,
                          color: Colors.grey,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: currentObjMoney.transactions.length,
                          itemBuilder: (context, index) {
                            final transaction =
                                currentObjMoney.transactions[index];
                            return Dismissible(
                              key: ValueKey(transaction.idTransaction),
                              direction: DismissDirection.endToStart,
                              // Chỉ vuốt từ phải sang trái (hoặc startToEnd cho trái sang phải)
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              confirmDismiss: (direction) async {
                                return await _show(context, transaction) ??
                                    false;
                              },
                              onDismissed: (direction) {
                                //Xóa item khỏi list
                                context.read<MoneyBloc>().add(
                                  RemoveTransEvent(
                                    currentObjMoney.id ?? 0,
                                    idTrans: transaction.idTransaction ?? 0,
                                  ),
                                );
                                // Hiển thị snackbar để undo
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Đã xóa thành công')),
                                );
                              },
                              child: ItemCardDetail(
                                onRemove: () async {
                                  final bloc = context.read<MoneyBloc>();
                                  final confrm = await _show(
                                    context,
                                    transaction,
                                  );
                                  if (confrm) {
                                    bloc.add(
                                      RemoveTransEvent(
                                        currentObjMoney.id ?? 0,
                                        idTrans: transaction.idTransaction ?? 0,
                                      ),
                                    );
                                  }
                                },
                                objMoney: currentObjMoney,
                                transaction: transaction,
                                isEditItem: state.isEditItem,
                                onTap:
                                    () => _showBotton(
                                      context,
                                      transaction,
                                      currentObjMoney,
                                    ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.only(
              left: 32,
              right: 32,
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
            height:
                MediaQuery.sizeOf(context).height * 0.08 +
                MediaQuery.paddingOf(context).bottom,
            color: Colors.grey.shade900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Icon(Icons.settings_rounded),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (currentObjMoney.totalVND != 0)
                        Builder(
                          builder: (context) {
                            final value = currentObjMoney.totalVND;
                            final formatter = NumberFormat.currency(
                              locale: 'vi_VN',
                              symbol: 'đ',
                              decimalDigits: 0,
                            );
                            final color = value > 0 ? Colors.green : Colors.red;
                            final prefix = value > 0 ? '+' : '';
                            return Text(
                              '$prefix${formatter.format(value)}',
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
                      if (currentObjMoney.totalUSD != 0)
                        Builder(
                          builder: (context) {
                            final value = currentObjMoney.totalUSD;
                            final formatter = NumberFormat.currency(
                              locale: 'en_US',
                              symbol: 'USD ',
                              decimalDigits: 2,
                            );
                            final color = value > 0 ? Colors.green : Colors.red;
                            final prefix = value > 0 ? '+' : '';
                            return Text(
                              '$prefix${formatter.format(value)}',
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
                      if (currentObjMoney.totalVND == 0 &&
                          currentObjMoney.totalUSD == 0)
                        const Text(
                          '0đ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                    ],
                  ),
                ),
                InkWell(
                  child: const Icon(Icons.add),
                  onTap: () {
                    AddPage.show(context, objMoney: currentObjMoney);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _showBotton(
    BuildContext context,
    Transaction transaction,
    ObjMoney objMoney,
  ) {
    final width = MediaQuery.sizeOf(context).width * 0.9;
    final sizeWeight = MediaQuery.sizeOf(context).width * 0.05;

    return showModalBottomSheet(
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: 24 + MediaQuery.paddingOf(context).bottom,
          ),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.18,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    final payTransaction = Transaction(
                      amount: transaction.amount,
                      date: DateTime.now(),
                      comment: transaction.comment,
                      isGive: !transaction.isGive,
                      currency: transaction.currency,
                    );
                    context.read<MoneyBloc>().add(
                      AddTransactionEvent(
                        name: objMoney.name,
                        transactionItem: payTransaction,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    width: width,
                    child: const Center(
                      child: Text(
                        'Pay this',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWeight),
                  child: const Divider(
                    thickness: 0.2,
                    height: 0.2,
                    color: Colors.grey,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    AddPage.show(
                      context,
                      objMoney: objMoney,
                      transaction: transaction,
                      pageName: 'Edit Transaction',
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    width: width,
                    child: const Center(
                      child: Text(
                        'Edit this',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    width: width,
                    child: const Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Future<dynamic> _show(BuildContext context, Transaction trans) {
  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Center(child: const Text('Confirm deletion')),
          content: Text(
            'Are you sure you want to delete?',
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          ],
        ),
  );
}
