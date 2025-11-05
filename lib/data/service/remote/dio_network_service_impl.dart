import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_template/core/core/error/custom_error.dart';
import 'package:flutter_bloc_template/core/core/error/error_handler.dart';
import 'package:flutter_bloc_template/data/service/remote/network_service.dart';

class DioNetworkServiceImpl extends NetworkService {
  late final Dio _dio;

  DioNetworkServiceImpl({
    String? baseUrl,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, dynamic>? headers,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? '',
        connectTimeout: connectTimeout ?? const Duration(seconds: 30),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 30),
        headers: headers ?? {'Content-Type': 'application/json'},
      ),
    );

    // Add interceptors if needed
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add auth token or modify request here
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  @override
  Future<Either<CustomError, Response>> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handleError(e));
    } catch (e) {
      return Left(ErrorHandler.handleUnknownError(e));
    }
  }

  @override
  Future<Either<CustomError, Response>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handleError(e));
    } catch (e) {
      return Left(ErrorHandler.handleUnknownError(e));
    }
  }

  @override
  Future<Either<CustomError, Response>> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handleError(e));
    } catch (e) {
      return Left(ErrorHandler.handleUnknownError(e));
    }
  }

  @override
  Future<Either<CustomError, Response>> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handleError(e));
    } catch (e) {
      return Left(ErrorHandler.handleUnknownError(e));
    }
  }

  @override
  Future<Either<CustomError, Response>> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handleError(e));
    } catch (e) {
      return Left(ErrorHandler.handleUnknownError(e));
    }
  }

  @override
  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  @override
  Dio get dio => _dio;

  @override
  void addHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }
}
