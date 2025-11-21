import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/core/di/dependency_injection.dart';
import 'package:flutter_bloc_template/core/extensions/app_localization.dart';
import 'package:flutter_bloc_template/domain/post/entities/post.dart';
import 'package:flutter_bloc_template/domain/post/usecases/get_posts_usecase.dart';
import 'package:flutter_bloc_template/presentation/core/widgets/empty_result.dart';
import 'package:flutter_bloc_template/presentation/core/widgets/loading_indicator.dart';
import 'package:flutter_bloc_template/presentation/features/posts/bloc/post_bloc.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final PostBloc _bloc = PostBloc(usecase: injector.get<GetPostsUsecase>());
  List<Post> allPosts = [];

  final searchController = TextEditingController();
  bool isSearching = false;
  final FocusNode _searchFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  loadPosts({bool withLoading = true}) {
    _bloc.add(
      OnGettingPostEvent(
        searchController.text.trim(),
        withLoading: withLoading,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadPosts();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Fetch next page when close to the bottom
      _bloc.add(OnLoadMorePostsEvent(query: searchController.text.trim()));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? Text("Posts")
            : TextField(
                controller: searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hint: Text(context.locale.search),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      setState(() {
                        isSearching = !isSearching;
                        if (isSearching) {
                          _searchFocusNode.requestFocus();
                        } else {
                          if (searchController.text.isNotEmpty) {
                            _searchFocusNode.unfocus();
                            searchController.clear();
                            loadPosts();
                          } else {
                            _searchFocusNode.unfocus();
                            searchController.clear();
                          }
                        }
                      });
                    },
                    icon: Icon(Icons.close),
                  ),
                ),

                onChanged: (value) {
                  _bloc.add(OnsearchingPostEvent(query: value.trim()));
                },
              ),
        actions: [
          if (!isSearching) ...{
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (isSearching) {
                    _searchFocusNode.requestFocus();
                  } else {
                    _searchFocusNode.unfocus();
                    searchController.clear();
                    loadPosts();
                  }
                });
              },
              icon: Icon(Icons.search),
            ),
          },
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<PostBloc, PostState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is LoadingGetPostsState) {
              return Center(child: LoadingIndicator());
            } else if (state is ErrorGetPostsState) {
              return Center(
                child: EmptyResultView(
                  message: state.message,
                  onRetryPressed: loadPosts,
                ),
              );
            }
            //Check it there is no data
            if (allPosts.isEmpty) {
              return Center(child: EmptyResultView(message: "Empty"));
            }

            return RefreshIndicator(
              onRefresh: () {
                loadPosts();
                return Future.delayed(Duration.zero);
              },
              child: ListView.builder(
                itemCount: allPosts.length,
                // shrinkWrap: true,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  if (index == allPosts.length) {
                    if (state is LoadingMorePostsState) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(child: LoadingIndicator()),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }

                  final post = allPosts[index];
                  return ListTile(
                    leading: Text("${post.id}"),
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              ),
            );
          },
          listener: (context, state) {
            if (state is SuccessGetPostsState) {
              allPosts.clear();
              allPosts = List.from(state.posts);
            } else if (state is SearchingState) {
              allPosts.clear();
              allPosts = state.posts;
            } else if (state is LoadingMorePostsState) {
              allPosts = List.from(state.oldPosts);
            }
          },
        ),
      ),
    );
  }
}
