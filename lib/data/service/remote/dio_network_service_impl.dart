import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_bloc_template/core/utility/api_endpoints.dart';
import 'package:flutter_bloc_template/core/base/error/custom_error.dart';
import 'package:flutter_bloc_template/core/base/error/error_handler.dart';
import 'package:flutter_bloc_template/data/service/remote/network_service.dart';
import 'package:flutter_bloc_template/data/service/remote/token_interceptor.dart';
import 'package:flutter_bloc_template/data/service/remote/token_manager.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';

class DioNetworkServiceImpl extends NetworkService {
  late final Dio _dio;
  final TokenManager? _tokenManager;
  late final CacheOptions _cacheOptions;
  late final String _cachePath;

  DioNetworkServiceImpl({
    required String cachePath,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Map<String, dynamic>? headers,
    TokenManager? tokenManager,
    Future<bool> Function()? onTokenRefresh,
  }) : _tokenManager = tokenManager,
       _cachePath = cachePath {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout ?? const Duration(seconds: 60),
        receiveTimeout: receiveTimeout ?? const Duration(seconds: 60),
        headers: headers ?? {'Content-Type': 'application/json'},
      ),
    );

    // Cache interceptor FIRST
    _cacheOptions = CacheOptions(
      store: HiveCacheStore(_cachePath),
      policy: CachePolicy.request,
      // hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(minutes: 30),
      priority: CachePriority.high,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    );
    _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));

    // Add Token Interceptor if TokenManager is provided
    if (_tokenManager != null) {
      _dio.interceptors.add(
        TokenInterceptor(_tokenManager, onTokenRefresh: onTokenRefresh),
      );
    }

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

  // ✅ Helper to build cache options
  Options _buildCacheOptions(bool forceRefresh, Duration? cacheDuration) {
    if (forceRefresh) {
      return _cacheOptions.copyWith(policy: CachePolicy.refresh).toOptions();
    }
    return _cacheOptions
        .copyWith(
          policy: CachePolicy.request,
          maxStale: cacheDuration ?? const Duration(minutes: 30),
        )
        .toOptions();
  }

  @override
  Future<Either<Failure, Response>> delete(
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
  Future<Either<Failure, Response>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool forceRefresh = false,
    Duration? cacheDuration,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options ?? _buildCacheOptions(forceRefresh, cacheDuration),
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorHandler.handleError(e));
    } catch (e) {
      return Left(ErrorHandler.handleUnknownError(e));
    }
  }

  @override
  Future<Either<Failure, Response>> patch(
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
  Future<Either<Failure, Response>> post(
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
  Future<Either<Failure, Response>> put(
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

  @override
  String get baseUrl => ApiEndpoints.baseUrl;
}
