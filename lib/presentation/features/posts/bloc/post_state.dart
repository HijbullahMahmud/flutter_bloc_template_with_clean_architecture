part of 'post_bloc.dart';

abstract class PostState {
  const PostState();
}

class PostsInitial extends PostState {}

class LoadingGetPostsState extends PostState {}

class ErrorGetPostsState extends PostState {
  final String message;

  ErrorGetPostsState({required this.message});
}

class SuccessGetPostsState extends PostState {
  final List<Post> posts;

  SuccessGetPostsState({required this.posts});
}

// Pagination
class LoadingMorePostsState extends PostState {
  final List<Post> oldPosts;

  LoadingMorePostsState({required this.oldPosts});
}

// ------- Search -----------//
class SearchingState extends PostState {
  final List<Post> posts;

  SearchingState({required this.posts});
}
