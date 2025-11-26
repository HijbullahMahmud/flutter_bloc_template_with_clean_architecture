import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_template/core/base/error/custom_error.dart';
import 'package:flutter_bloc_template/domain/post/entities/post.dart';
import 'package:flutter_bloc_template/domain/post/repositories/post_repository.dart';

class GetPostsUsecase {
  final PostRepository repository;

  GetPostsUsecase({required this.repository});

  Future<Either<Failure, List<Post>>> call({required String endPoint}) =>
      repository.getPosts(endPoint: endPoint);
}
