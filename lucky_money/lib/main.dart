import 'package:flutter/material.dart';
import 'package:lucky_money/app/navigation/router.dart';

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      routerConfig: AppRouter.appRouter,
    );
  }
}
