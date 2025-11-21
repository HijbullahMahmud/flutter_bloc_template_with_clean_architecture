import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_template/core/base/error/custom_error.dart';
import 'package:flutter_bloc_template/data/post/models/post_dto.dart';
import 'package:flutter_bloc_template/data/service/remote/network_service.dart';

abstract class PostRemoteDatasource {
  Future<Either<CustomError, List<PostDto>>> getPosts({
    required String endPoint,
  });
}

class PostRemoteDatasourceImpl extends PostRemoteDatasource {
  final NetworkService networkService;

  PostRemoteDatasourceImpl({required this.networkService});

  @override
  Future<Either<CustomError, List<PostDto>>> getPosts({
    required String endPoint,
  }) async {
    try {
      final response = await networkService.get(endPoint);
      return response.fold((error) => Left(error), (success) async {
        // Convert dynamic response data to a list of maps
        final List<dynamic> data = success.data as List<dynamic>;

        // Parse each element using compute() for isolate parsing
        final postListDto = await Future.wait(
          data
              .map((json) => compute(postDtoFromJson, jsonEncode(json)))
              .toList(),
        );

        return Right(postListDto);
      });
    } catch (e) {
      rethrow;
    }
  }
}
