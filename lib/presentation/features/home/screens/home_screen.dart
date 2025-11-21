import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/extensions/navigation_extension.dart';
import 'package:flutter_bloc_template/presentation/core/router/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Text("Home Page"),
            FilledButton(
              onPressed: () => context.pushNamed(Routes.postsScreen),
              child: Text("Go To Posts Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
