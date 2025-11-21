import 'package:flutter_bloc_template/data/post/models/post_dto.dart';
import 'package:flutter_bloc_template/domain/post/entities/post.dart';

// Mapper from DTO -> Domain
extension PostDtoX on PostDto {
  Post toDomain() => Post(id: id, userId: userId, title: title, body: body);
}

// Mapper from Domain -> DTO
extension PostX on PostDto {
  PostDto toDto() => PostDto(id: id, userId: userId, title: title, body: body);
}
