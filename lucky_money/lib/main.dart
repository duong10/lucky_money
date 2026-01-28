import 'package:flutter/material.dart';
import 'package:lucky_money/presenation/widget/card.dart';

void main() {
  runApp(const LuckyMoney());
}

class LuckyMoney extends StatefulWidget {
  const LuckyMoney({super.key});

  @override
  State<LuckyMoney> createState() => _LuckyMoneyState();
}

class _LuckyMoneyState extends State<LuckyMoney> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
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
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LuckyMoney',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(height: 12),
                Divider(thickness: 0.5, height: 1, color: Colors.grey),
                itemCard(),
                itemCard(),
                itemCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
