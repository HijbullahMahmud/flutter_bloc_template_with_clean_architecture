import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/presentation/core/router/routes.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("Splash Screen")));
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    context.goNamed(Routes.home);
  }
}
