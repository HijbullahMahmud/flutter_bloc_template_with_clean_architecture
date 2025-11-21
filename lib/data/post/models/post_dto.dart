// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.g.dart';
part 'post_dto.freezed.dart';

PostDto postDtoFromJson(String str)=> PostDto.fromJson(json.decode(str));

@freezed
sealed class PostDto with _$PostDto{
  const factory PostDto({
    @JsonKey(name: "id")  required int id,
    @JsonKey(name: "userId") required int userId, 
    @JsonKey(name: "title") required String title, 
    @JsonKey(name: "body") required String body,
  })= _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);
}