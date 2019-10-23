import 'dart:io';

import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class PostState {
  final Data<List<PostData>> posts;
  final String query;
  final Data<List<PostData>> searchPosts;
  final bool isCreatingPost;
  final File imageSubmission;
  final String createPostTextErrorMessage;
  final Data<PostData> post;
  final List<String> imageURL;
  final String message;
  final String reportText;
  final bool isCompletePostLoading;

  PostState(
      this.posts,
      this.searchPosts,
      this.isCreatingPost,
      this.createPostTextErrorMessage,
      this.imageSubmission,
      this.post,
      this.imageURL,
      this.message,
      this.reportText,
      this.query,
      this.isCompletePostLoading);

  factory PostState.initial() =>
      PostState(Data(), Data(), true, "", null, Data(), null, null, null, "", true);

  PostState copyWith({
    Data<List<PostData>> posts,
    Data<List<PostData>> searchPosts,
    bool isCreatingPost,
    String createPostTextErrorMessage,
    File imageSubmission,
    Data<PostData> post,
    List<String> imageURL,
    String message,
    String reportText,
    String query,
    bool isCompletePostLoading
  }) {
    final state = PostState(
      posts ?? this.posts,
      searchPosts ?? this.searchPosts,
      isCreatingPost ?? this.isCreatingPost,
      createPostTextErrorMessage ?? this.createPostTextErrorMessage,
      imageSubmission ?? this.imageSubmission,
      post ?? this.post,
      imageURL ?? this.imageURL,
      message ?? this.message,
      reportText ?? this.reportText,
      query ?? this.query,
      isCompletePostLoading ?? this.isCompletePostLoading
    );
    return state;
  }
}

final Reducer<PostState> postReducer = combineReducers<PostState>([
  TypedReducer<PostState, DeletePostAction>(deletePost),
  TypedReducer<PostState, FetchPostsSuccessAction>(explorePostsRetrieved),
  TypedReducer<PostState, SearchPostSuccessAction>(searchPostsRetrieved),
  TypedReducer<PostState, SearchPostAction>(setQuery),
  TypedReducer<PostState, FetchPostsAction>(explorePosts),
  TypedReducer<PostState, SubmitTextPostAction>(createPost),
  TypedReducer<PostState, SubmitImagePostAction>(createImagePost),
  TypedReducer<PostState, SetImageForSubmission>(setImageForSubmission),
  TypedReducer<PostState, NavigateCreatePostAction>(navigateCreatePost),
  TypedReducer<PostState, SubmitPostErrorTextSizeMismatchAction>(
      onCreatePostTextSizeMismatch),
  TypedReducer<PostState, SetCompletePostAction>(setPost),
  TypedReducer<PostState, SetPostImageAction>(setImage),
  TypedReducer<PostState, SubmitPostSuccessAction>(setSuccessMessage),
  TypedReducer<PostState, SubmitPostErrorAction>(setErrorMessage),
  TypedReducer<PostState, SetPostReportTextFieldAction>(setReportTextField),
  TypedReducer<PostState, FetchPostAction>(fetchPost),
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

PostState fetchPost(PostState state, FetchPostAction action) {
  return state.copyWith(
    post: Data(isLoading: true),
    isCompletePostLoading: true
  );
}

PostState setSuccessMessage(PostState state, SubmitPostSuccessAction action) {
  return state.copyWith(
    message:
        "Seu resumo foi criado com sucesso, e passará por um processo de aprovação antes de ser postado.",
    isCreatingPost: false,
  );
}

PostState setErrorMessage(PostState state, SubmitPostErrorAction action) {
  return state.copyWith(
    message: "Algum erro ocorreu ao criar o resumo.",
    isCreatingPost: false,
  );
}

PostState setPost(PostState state, SetCompletePostAction action) {
  return state.copyWith(
    post: Data(content: action.post, isLoading: false),
    isCompletePostLoading: false
  );
}

PostState setReportTextField(
    PostState state, SetPostReportTextFieldAction action) {
  return state.copyWith(reportText: action.text);
}

PostState explorePostsRetrieved(
    PostState state, FetchPostsSuccessAction action) {
  return state.copyWith(posts: Data(content: action.post, isLoading: false));
}

PostState searchPostsRetrieved(
    PostState state, SearchPostSuccessAction action) {
  return state.copyWith(
      searchPosts: Data(content: action.post, isLoading: false));
}

PostState explorePosts(PostState state, FetchPostsAction action) {
  return state.copyWith(
      posts: state.posts.copyWith(
    isLoading: true,
    errorMessage: "",
  ));
}

PostState createPost(PostState state, SubmitTextPostAction action) {
  return PostState(
    state.posts,
    state.searchPosts,
    true,
    "",
    null,
    state.post,
    state.imageURL,
    state.message,
    state.reportText,
    state.query,
    false
  );
}

PostState createImagePost(PostState state, SubmitImagePostAction action) {
  return PostState(
    state.posts,
    state.searchPosts,
    true,
    "",
    null,
    state.post,
    state.imageURL,
    state.message,
    state.reportText,
    state.query,
    false
  );
}

PostState setImageForSubmission(PostState state, SetImageForSubmission action) {
  return state.copyWith(
    imageSubmission: action.image,
  );
}

PostState navigateCreatePost(PostState state, NavigateCreatePostAction action) {
  return state.copyWith(
      isCreatingPost: false, createPostTextErrorMessage: "", message: "");
}

PostState onCreatePostTextSizeMismatch(
    PostState state, SubmitPostErrorTextSizeMismatchAction action) {
  return state.copyWith(
      isCreatingPost: false,
      createPostTextErrorMessage:
          "O tamanho do texto é menor que 100 ou maior que 2000 caracteres.");
}

PostState setImage(PostState state, SetPostImageAction action) {
  return state.copyWith(imageURL: action.imageURL);
}

PostState setQuery(PostState state, SearchPostAction action) {
  return state.copyWith(query: action.query);
}
