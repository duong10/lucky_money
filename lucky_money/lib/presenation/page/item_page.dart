import 'package:flutter/material.dart';
import 'package:lucky_money/presenation/widget/card.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // leading: Row(children: [Icon(Icons.arrow_back_ios)]),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Edit',
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
              // height: double.minPositive,
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    SizedBox(height: 12),
                    Divider(thickness: 0.2, height: 0.2, color: Colors.grey),
                    itemCard(onTap: () => showBotton(context)),
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
            Icon(Icons.settings_rounded),
            InkWell(child: Icon(Icons.add), onTap: () {}),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showBotton(BuildContext context) {
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
