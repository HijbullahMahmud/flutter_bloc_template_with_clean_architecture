import 'package:flutter_bloc_template/core/core/error/error_type.dart';

class CustomError {
  final String message;
  final int? statusCode;
  final ErrorType type;
  final dynamic data;

  CustomError({
    required this.message,
    this.statusCode,
    required this.type,
    this.data,
  });

  @override
  String toString() =>
      'CustomError(message: $message, statusCode: $statusCode, type: $type)';
}
