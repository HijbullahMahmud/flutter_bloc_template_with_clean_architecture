import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_template/core/base/error/custom_error.dart';
import 'package:flutter_bloc_template/domain/post/entities/post.dart';

abstract class PostRepository {
  Future<Either<CustomError, List<Post>>> getPosts({required String endPoint});
}
