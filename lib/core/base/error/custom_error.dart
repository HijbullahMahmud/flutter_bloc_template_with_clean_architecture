import 'package:flutter_bloc_template/core/base/error/error_type.dart';

class Failure {
  final String message;
  final int? statusCode;
  final ErrorType type;
  final dynamic data;

  Failure({
    required this.message,
    this.statusCode,
    required this.type,
    this.data,
  });

  @override
  String toString() =>
      'CustomError(message: $message, statusCode: $statusCode, type: $type)';
}
