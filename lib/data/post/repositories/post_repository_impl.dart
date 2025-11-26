import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_template/core/base/error/custom_error.dart';
import 'package:flutter_bloc_template/data/post/datasources/remote/post_remote_datasource.dart';
import 'package:flutter_bloc_template/data/post/mapper/post_dto_mapper.dart';
import 'package:flutter_bloc_template/domain/post/entities/post.dart';
import 'package:flutter_bloc_template/domain/post/repositories/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final PostRemoteDatasource remoteDatasource;

  PostRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, List<Post>>> getPosts({
    required String endPoint,
  }) async {
    try {
      final response = await remoteDatasource.getPosts(endPoint: endPoint);
      return response.fold((error) => Left(error), (remotePosts) async {
        // Convert DTO -> Domain
        final domainPosts = remotePosts.map((e) => e.toDomain()).toList();
        return Right(domainPosts);
      });
    } catch (e) {
      rethrow;
    }
  }
}
