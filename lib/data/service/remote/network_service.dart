import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_template/core/base/error/custom_error.dart';

abstract class NetworkService {
  Future<Either<Failure, Response>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool forceRefresh = false,
    Duration? cacheDuration,
  });

  Future<Either<Failure, Response>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, Response>> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, Response>> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<Failure, Response>> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  });

  void addHeader(String key, String value);
  void removeHeader(String key);
  Dio get dio;
  String get baseUrl;
}
