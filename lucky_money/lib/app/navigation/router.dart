import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:lucky_money/app/navigation/router_location.dart';
import 'package:lucky_money/data/models/obj_money.dart';
import 'package:lucky_money/presenation/page/add_page.dart';
import 'package:lucky_money/presenation/page/home_page.dart';
import 'package:lucky_money/presenation/page/item_page.dart';

abstract class AppRouter {
  static GoRouter appRouter = GoRouter(
    initialLocation: AppRouterLocation.home.path,
    routes: [
      GoRoute(
        path: AppRouterLocation.home.path,
        name: AppRouterLocation.home.name,
        pageBuilder:
            (context, state) =>
                buildPage(child: const HomePage(), state: state),
      ),
      GoRoute(
        path: AppRouterLocation.add.path,
        name: AppRouterLocation.add.name,
        pageBuilder:
            (context, state) => buildPage(child: const AddPage(), state: state),
      ),
      GoRoute(
        path: AppRouterLocation.item.path,
        name: AppRouterLocation.item.name,
        pageBuilder: (context, state) {
          final objMoney = state.extra as ObjMoney;
          return CupertinoPage(child: ItemPage(objMoney: objMoney));
        },
      ),
    ],
  );
}

CustomTransitionPage<T> buildPage<T>({
  required Widget child,
  required GoRouterState state,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 150),
    reverseTransitionDuration: const Duration(milliseconds: 120),
    child: child,
    transitionsBuilder: (context, animation, secondary, child) {
      if (kIsWeb) {
        return FadeTransition(opacity: animation, child: child);
      }

      final offsetAnimation = Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
