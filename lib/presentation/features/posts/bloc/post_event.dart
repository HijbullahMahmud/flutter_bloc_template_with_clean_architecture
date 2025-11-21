part of 'post_bloc.dart';

abstract class PostEvent {
  const PostEvent();
}

// On Fetching posts event
class OnGettingPostEvent extends PostEvent {
  final bool withLoading;
  final String query;

  OnGettingPostEvent(this.query, {this.withLoading = true});
}

// On Pagination
class OnLoadMorePostsEvent extends PostEvent{
  final String query;

  OnLoadMorePostsEvent({required this.query});

}

// On Searching post event
class OnsearchingPostEvent extends PostEvent {
  final String query;

  OnsearchingPostEvent({required this.query});
}
