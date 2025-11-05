import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_template/core/core/error/custom_error.dart';

abstract class NetworkService {
  Future<Either<CustomError, Response>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Either<CustomError, Response>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Either<CustomError, Response>> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Either<CustomError, Response>> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<Either<CustomError, Response>> patch(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  void addHeader(String key, String value);
  void removeHeader(String key);
  Dio get dio;
}