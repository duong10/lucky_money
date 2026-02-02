import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucky_money/app/navigation/router_location.dart';
import 'package:lucky_money/data/models/obj_money.dart';

import '../bloc/money_bloc.dart';
import '../widget/item_card.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Thêm biến để xử lý onPanUpdate

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
                    padding: const EdgeInsets.only(left: 16),
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

                              return Dismissible(
                                key: ValueKey(objMoney.id),
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
                                  return await _showDialog(context, objMoney) ??
                                      false;
                                },
                                onDismissed: (direction) {
                                  // Xóa item khỏi list
                                  context.read<MoneyBloc>().add(
                                    RemoveObjEvent(id: objMoney.id ?? 0),
                                  );
                                  // Hiển thị snackbar để undo
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Đã xóa ${objMoney.name}'),
                                    ),
                                  );
                                },
                                child: ItemCard(
                                  key: const ValueKey('swiped'),
                                  objMoney: objMoney,
                                  isEdit: state.isEdit,
                                  onTap:
                                      () => context.pushNamed(
                                        AppRouterLocation.item.name,
                                        extra: objMoney,
                                      ),
                                  onRemove: () async {
                                    final bloc = context.read<MoneyBloc>();
                                    final confirm = await _showDialog(
                                      context,
                                      objMoney,
                                    );
                                    if (confirm) {
                                      return bloc.add(
                                        RemoveObjEvent(id: objMoney.id ?? 0),
                                      );
                                    }
                                  },
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

  Future<dynamic> _showDialog(BuildContext context, ObjMoney objMoney) {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Center(child: const Text('Xác nhận xóa')),
            content: Text(
              'Bạn có chắc muốn xóa ${objMoney.name}?',
              textAlign: TextAlign.center,
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('Hủy'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text(
                      'Xóa',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
