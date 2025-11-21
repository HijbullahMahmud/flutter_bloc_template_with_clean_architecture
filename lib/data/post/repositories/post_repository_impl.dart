import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_template/core/base/error/custom_error.dart';
import 'package:flutter_bloc_template/data/post/datasources/local/post_local_datasource.dart';
import 'package:flutter_bloc_template/data/post/datasources/remote/post_remote_datasource.dart';
import 'package:flutter_bloc_template/data/post/mapper/post_dto_mapper.dart';
import 'package:flutter_bloc_template/data/post/mapper/post_isar_mapper.dart';
import 'package:flutter_bloc_template/domain/post/entities/post.dart';
import 'package:flutter_bloc_template/domain/post/repositories/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final PostRemoteDatasource remoteDatasource;
  final PostLocalDatasource localDatasource;

  PostRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<CustomError, List<Post>>> getPosts({
    required String endPoint,
  }) async {
    try {
      final response = await remoteDatasource.getPosts(endPoint: endPoint);
      return response.fold((error) => Left(error), (remotePosts) async {
        // Convert DTO -> Domain
        final domainPosts = remotePosts.map((e) => e.toDomain()).toList();

        // Cache posts locally in Isar
        await localDatasource.savePosts(
          remotePosts.map((e) => e.toIsar()).toList(),
        );
        
        return Right(domainPosts);
      });
    } catch (e) {
      rethrow;
    }
  }
}
