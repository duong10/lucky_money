import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucky_money/app/navigation/router_location.dart';

import '../bloc/money_bloc.dart';
import '../widget/item_card.dart';
import 'add_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyBloc, MoneyState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.only(right: 8),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap:
                        () => context.read<MoneyBloc>().add(
                          IsEditEvent(isEdit: !(state.isEdit ?? false)),
                        ),
                    child: Text(
                      (state.isEdit ?? false) ? 'Done' : 'Edit',
                      style: TextStyle(color: Colors.blue, fontSize: 22),
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
                        const Text(
                          'LuckyMoney',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        const SizedBox(height: 12),
                        const Divider(
                          thickness: 0.2,
                          height: 0.2,
                          color: Colors.grey,
                        ),
                        if (state.listObjMoney.isEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              'No Data',
                              style: TextStyle(color: Colors.white54),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.listObjMoney.length,
                            itemBuilder: (context, index) {
                              final objMoney = state.listObjMoney[index];
                              return ItemCard(
                                objMoney: objMoney,
                                onTap:
                                    () => context.pushNamed(
                                      AppRouterLocation.item.name,
                                      extra: objMoney,
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
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 0),
            height: MediaQuery.sizeOf(context).height * 0.08,
            color: Colors.grey.shade900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.share),
                InkWell(
                  child: Icon(Icons.add),
                  onTap: () {
                    AddPage.show(context);
                    // context.pushNamed(AppRouterLocation.add.name);

                    // Navigator.push(
                    //   context,
                    //   PageRouteBuilder(
                    //     opaque: false, // quan trọng
                    //     pageBuilder: (_, __, ___) => const AddPage(),
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
