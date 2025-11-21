import 'package:dio/dio.dart';
import 'package:flutter_bloc_template/core/base/error/custom_error.dart';
import 'package:flutter_bloc_template/core/base/error/error_type.dart';

class ErrorHandler {
  static CustomError handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return CustomError(
          message: 'Connection timeout. Please check your internet connection.',
          type: ErrorType.timeout,
          statusCode: error.response?.statusCode,
        );

      case DioExceptionType.badResponse:
        return _handleHttpError(error);

      case DioExceptionType.cancel:
        return CustomError(
          message: 'Request was cancelled',
          type: ErrorType.cancel,
        );

      case DioExceptionType.connectionError:
        return _handleConnectionError(error);

      case DioExceptionType.badCertificate:
        return CustomError(
          message: 'SSL certificate verification failed',
          type: ErrorType.network,
        );

      case DioExceptionType.unknown:
        return CustomError(
          message: error.message ?? 'An unexpected error occurred',
          type: ErrorType.unknown,
        );
    }
  }

  static CustomError _handleConnectionError(DioException error) {
    final errorMessage = error.message?.toLowerCase() ?? '';
    final errorString = error.error?.toString().toLowerCase() ?? '';

    // Check for common endpoint/URL related errors
    if (errorMessage.contains('failed host lookup') ||
        errorMessage.contains('nodename nor servname provided') ||
        errorMessage.contains('no address associated with hostname') ||
        errorString.contains('socketexception') ||
        errorString.contains('failed host lookup')) {
      return CustomError(
        message: 'Invalid endpoint or server address. Please contact support.',
        type: ErrorType.notFound,
        statusCode: 404,
      );
    }

    // Check for connection refused (server not running or wrong port)
    if (errorMessage.contains('connection refused') ||
        errorString.contains('connection refused')) {
      return CustomError(
        message: 'Unable to connect to server. Please try again later.',
        type: ErrorType.server,
        statusCode: 503,
      );
    }

    // Check for network unreachable
    if (errorMessage.contains('network is unreachable') ||
        errorString.contains('network is unreachable')) {
      return CustomError(
        message: 'No internet connection. Please check your network.',
        type: ErrorType.network,
      );
    }

    // Default to generic connection error
    return CustomError(
      message: 'Connection error. Please check your internet or try again.',
      type: ErrorType.network,
    );
  }

  static CustomError _handleHttpError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    switch (statusCode) {
      case 400:
        return CustomError(
          message: data?['message'] ?? 'Bad request',
          statusCode: statusCode,
          type: ErrorType.badRequest,
          data: data,
        );

      case 401:
        return CustomError(
          message: data?['message'] ?? 'Unauthorized. Please login again.',
          statusCode: statusCode,
          type: ErrorType.unauthorized,
          data: data,
        );

      case 403:
        return CustomError(
          message: data?['message'] ?? 'Access forbidden',
          statusCode: statusCode,
          type: ErrorType.unauthorized,
          data: data,
        );

      case 404:
        return CustomError(
          message: data?['message'] ?? 'Resource not found',
          statusCode: statusCode,
          type: ErrorType.notFound,
          data: data,
        );

      case 500:
      case 502:
      case 503:
        return CustomError(
          message: data?['message'] ?? 'Server error. Please try again later.',
          statusCode: statusCode,
          type: ErrorType.server,
          data: data,
        );

      default:
        return CustomError(
          message: data?['message'] ?? 'Something went wrong',
          statusCode: statusCode,
          type: ErrorType.server,
          data: data,
        );
    }
  }

  static CustomError handleUnknownError(dynamic error) {
    return CustomError(
      message: 'Unexpected error: ${error.toString()}',
      type: ErrorType.unknown,
    );
  }
}
