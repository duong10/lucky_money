import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucky_money/data/models/obj_money.dart';
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
        // Tìm đối tượng ObjMoney mới nhất trong state dựa vào name
        final currentObjMoney = state.listObjMoney.firstWhere(
          (element) => element.name == objMoney.name,
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
                            return (state.isEditItem ?? false)
                                ? ItemCardDetail(
                                  transaction: transaction,
                                  isEditItem: state.isEditItem,
                                  onTap: () => _showBotton(context),
                                )
                                : ItemCardDetail(
                                  transaction: transaction,
                                  onTap: () => _showBotton(context),
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
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
            height: MediaQuery.sizeOf(context).height * 0.08,
            color: Colors.grey.shade900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.settings_rounded),
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

  Future<dynamic> _showBotton(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 0.9;

    return showModalBottomSheet(
      clipBehavior: Clip.antiAlias,
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.18,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  width: width,
                  child: Center(
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
                Divider(thickness: 0.2, height: 0.2, color: Colors.grey),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade800,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  width: width,
                  child: Center(
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
                SizedBox(height: 8),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    width: width,
                    child: Center(
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
