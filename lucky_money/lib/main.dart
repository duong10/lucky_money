import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:lucky_money/app/navigation/router.dart';
import 'package:lucky_money/presenation/bloc/money_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory:
        kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory(
              (await getApplicationDocumentsDirectory()).path,
            ),
  );
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
    return BlocProvider(
      create: (_) => MoneyBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        routerConfig: AppRouter.appRouter,
      ),
    );
  }
}
