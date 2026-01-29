import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucky_money/app/navigation/router_location.dart';

import '../widget/card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                onTap: () {},
                child: Text(
                  'Done',
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
            physics: AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'LuckyMoney',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(height: 12),
                    Divider(thickness: 0.2, height: 0.2, color: Colors.grey),
                    itemCard(
                      onTap:
                          () => context.pushNamed(AppRouterLocation.item.name),
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
                context.pushNamed(AppRouterLocation.add.name);

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
  }
}
