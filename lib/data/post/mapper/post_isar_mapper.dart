import 'package:flutter_bloc_template/data/post/models/post_dto.dart';
import 'package:flutter_bloc_template/data/post/models/post_isar.dart';

extension PostIsarMapper on PostIsar {
  /// Convert an Isar entity to a DTO
  PostDto toDto() {
    return PostDto(id: id, userId: userId, title: title, body: body);
  }
}

extension PostDtoMapper on PostDto {
  /// Convert a DTO to an Isar entity
  PostIsar toIsar() {
    final post = PostIsar()
      ..id = id
      ..userId = userId
      ..title = title
      ..body = body;
    return post;
  }
}
