// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.g.dart';
part 'post_dto.freezed.dart';

List<PostDto> postDtoListFromJson(dynamic json) =>
    (json as List).map((e) => PostDto.fromJson(e)).toList();

@freezed
sealed class PostDto with _$PostDto {
  const factory PostDto({
    @JsonKey(name: "id") required int id,
    @JsonKey(name: "userId") required int userId,
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "body") required String body,
  }) = _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);
}
