import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class PostState {
  final Data<List<PostData>> posts;
  final bool isCreatingPost;
  final String createPostTextErrorMessage;

  PostState(this.posts, this.isCreatingPost, this.createPostTextErrorMessage);

  factory PostState.initial() => PostState(
      Data(),
      true,
      ""
  );

  PostState copyWith({
    Data<List<PostData>> posts,
    bool isCreatingPost,
    String createPostTextErrorMessage
  }) {
    final state = PostState(
      posts ?? this.posts,
      isCreatingPost ?? this.isCreatingPost,
      createPostTextErrorMessage ?? this.createPostTextErrorMessage
    );
    return state;
  }
}

final Reducer<PostState> postReducer = combineReducers<PostState>([
  TypedReducer<PostState, DeletePostAction>(deletePost),
  TypedReducer<PostState, FetchPostsSuccessAction>(explorePostsRetrieved),
  TypedReducer<PostState, FetchPostsAction>(explorePosts),
  TypedReducer<PostState, SubmitPostAction>(createPost),
  TypedReducer<PostState, NavigateCreatePostAction>(navigateCreatePost),
  TypedReducer<PostState, SubmitPostErrorTextSizeMismatchAction>(onCreatePostTextSizeMismatch)
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

PostState explorePostsRetrieved(PostState state, FetchPostsSuccessAction action) {
  return state.copyWith(posts: Data(content: action.post, isLoading: false));
}

PostState explorePosts(PostState state, FetchPostsAction action) {
  return state.copyWith(posts: state.posts.copyWith(isLoading: true, errorMessage: ""));
}


PostState createPost(PostState state, SubmitPostAction action) {
  return state.copyWith(
     isCreatingPost: true,
     createPostTextErrorMessage: ""
  );
}

PostState navigateCreatePost(PostState state, NavigateCreatePostAction action) {
  return state.copyWith(
    isCreatingPost: false,
     createPostTextErrorMessage: ""
  );
}

PostState onCreatePostTextSizeMismatch(PostState state, SubmitPostErrorTextSizeMismatchAction action) {
  return state.copyWith(
    isCreatingPost: false,
    createPostTextErrorMessage: "O tamanho do texto é menor que 100 ou maior que 2000 caracteres."
  );
}
