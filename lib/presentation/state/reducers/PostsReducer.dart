import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class PostState {
  final Data<List<PostData>> posts;
  final bool isCreatingPost;

  PostState(this.posts, this.isCreatingPost);

  factory PostState.initial() => PostState(
      Data(),
      true
  );

  PostState copyWith({
    Data<List<PostData>> posts,
    bool isCreatingPost
  }) {
    final state = PostState(
      posts ?? this.posts,
      isCreatingPost ?? this.isCreatingPost
    );
    return state;
  }
}

final Reducer<PostState> postReducer = combineReducers<PostState>([
  TypedReducer<PostState, DeletePostAction>(deletePost),
  TypedReducer<PostState, ExplorePostsRetrievedAction>(explorePostsRetrieved),
  TypedReducer<PostState, ExplorePostsAction>(explorePosts),
  TypedReducer<PostState, CreatePostAction>(createPost),
  TypedReducer<PostState, PostCreationAction>(postCreation),
]);

PostState deletePost(PostState state, DeletePostAction action) {
  if (state.posts.content == null) {
    return state;
  }
  final posts = state.posts.content.where((post) {
    return post.id != action.postId;
  }).toList();
  return state.copyWith(
    posts: state.posts.copyWith(
      content: posts,
    ),
  );
}

PostState explorePostsRetrieved(PostState state, ExplorePostsRetrievedAction action) {
  return state.copyWith(posts: Data(content: action.post, isLoading: false));
}

PostState explorePosts(PostState state, ExplorePostsAction action) {
  return state.copyWith(posts: state.posts.copyWith(isLoading: true, errorMessage: ""));
}


PostState createPost(PostState state, CreatePostAction action) {
  return state.copyWith(
     isCreatingPost: true
  );
}

PostState postCreation(PostState state, PostCreationAction action) {
  return state.copyWith(
    isCreatingPost: false,
  );
}
