import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationExtension on BuildContext {
  // Navigate to named route
  void goToNamed(String name, {Map<String, String>? params, Object? extra}) {
    GoRouter.of(this).goNamed(name, pathParameters: params ?? {}, extra: extra);
  }

  // Push named route
  void pushNamed(String name, {Map<String, String>? params, Object? extra}) {
    GoRouter.of(
      this,
    ).pushNamed(name, pathParameters: params ?? {}, extra: extra);
  }

  // Pop current route
  void pop([Object? result]) {
    GoRouter.of(this).pop(result);
  }

  // Check if can pop
  bool canPop() {
    return GoRouter.of(this).canPop();
  }

  // Replace current route
  void replaceNamed(String name, {Map<String, String>? params, Object? extra}) {
    GoRouter.of(
      this,
    ).replaceNamed(name, pathParameters: params ?? {}, extra: extra);
  }
}
