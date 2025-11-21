import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/core/utility/api_endpoints.dart';
import 'package:flutter_bloc_template/domain/post/usecases/get_posts_usecase.dart';

import '../../../../domain/post/entities/post.dart';

part 'post_state.dart';
part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUsecase usecase;

  // List of posts
  List<Post> allPosts = [];
  int _page = 1;
  final int _limit = 10;
  bool _hasMore = true;
  bool _isFetching = false;

  PostBloc({required this.usecase}) : super(LoadingGetPostsState()) {
    on<OnGettingPostEvent>(_onGettingPostEvent);
    on<OnsearchingPostEvent>(_onSearchingEvent);
    on<OnLoadMorePostsEvent>(_onLoadMorePostsEvent);
  }

  // Getting posts event
  _onGettingPostEvent(
    OnGettingPostEvent event,
    Emitter<PostState> emitter,
  ) async {
    if (_isFetching) return;
    _isFetching = true;

    if (event.withLoading) {
      emitter(LoadingGetPostsState());
    }

    _page = 1;
    _hasMore = true;
    allPosts.clear();

    final result = await usecase.call(
      endPoint: "${ApiEndpoints.posts}?_page=$_page&_limit=$_limit",
    );
    result.fold(
      (error) {
        emitter(ErrorGetPostsState(message: error.message));
      },
      (r) {
        allPosts = r;
        if (r.length < _limit) _hasMore = false;
        emitter(SuccessGetPostsState(posts: _filterPosts(event.query)));
      },
    );
    _isFetching = false;
  }

  // Loading more
  Future<void> _onLoadMorePostsEvent(
    OnLoadMorePostsEvent event,
    Emitter<PostState> emitter,
  ) async {
    if (!_hasMore || _isFetching) return;
    _isFetching = true;

    emitter(LoadingMorePostsState(oldPosts: List.from(allPosts)));

    _page++;

    final result = await usecase.call(
      endPoint: "${ApiEndpoints.posts}?_page=$_page&_limit=$_limit",
    );

    result.fold(
      (error) {
        _hasMore = false;
        emitter(ErrorGetPostsState(message: error.message));
      },
      (r) {
        if (r.isEmpty) _hasMore = false;
        allPosts.addAll(r);
        emitter(SuccessGetPostsState(posts: _filterPosts(event.query)));
      },
    );
    _isFetching = false;
  }

  // Searching Posts event
  _onSearchingEvent(
    OnsearchingPostEvent event,
    Emitter<PostState> emitter,
  ) async {
    emitter(SearchingState(posts: _filterPosts(event.query)));
  }

  List<Post> _filterPosts(String query) {
    List<Post> results = [];
    if (query.isEmpty) {
      // If the search field is empty or only cotnains white-space, we'll display all users
      results = List.from(allPosts);
    } else {
      results = allPosts.where((post) {
        return (post.title).toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    return results;
  }
}
