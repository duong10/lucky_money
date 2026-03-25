import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucky_money/app/navigation/router_location.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        context.goNamed(AppRouterLocation.home.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/img_splash.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
