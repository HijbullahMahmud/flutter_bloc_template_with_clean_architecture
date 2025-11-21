import 'package:flutter/material.dart';

extension DeviceTypeExtension on BuildContext {
  bool get isTablet {
    return MediaQuery.sizeOf(this).shortestSide >= 600;
  }
}

extension StringTitleCase on String {
  String toTitleCase() {
    return toLowerCase()
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : '',
        )
        .join(' ');
  }
}
