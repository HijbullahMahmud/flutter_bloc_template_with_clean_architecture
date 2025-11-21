import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationShell extends StatefulWidget {
  const NavigationShell({super.key, required this.statefulNavigationShell});
  final StatefulNavigationShell statefulNavigationShell;

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter BloC Template')),
      body: widget.statefulNavigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.statefulNavigationShell.currentIndex,
        onTap: (index) => widget.statefulNavigationShell.goBranch(index),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
