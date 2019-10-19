import 'package:app/domain/aggregates/exceptions/CreatePostExceptions.dart';
import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UtilActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

List<Middleware<AppState>> postMiddleware(
    ICreateTextPostUseCase createPostUseCase,
    IDeletePostUseCase deletePostUseCase,
    IExplorePostUseCase explorePostUseCase,
    IGetUserByIdUseCase getUserByIdUseCase,
    ICreateImagePostUseCase createImagePostUseCase,
    IGetPostByIdUseCase getPostByIdUseCase,
    IUpdatePostRatingUseCase updatePostRatingUseCase,
    IUpdatePostCommentUseCase updatePostCommentUseCase) {
  void deletePost(Store<AppState> store, DeletePostAction action,
      NextDispatcher next) async {
    next(action);
    try {
      await deletePostUseCase.run(action.postId);
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      store.dispatch(OnCatchDefaultErrorAction(
          error.toString(), stackTrace, actionName, action.itemToJson()));
    }
  }

  void createTextPost(Store<AppState> store, SubmitTextPostAction action,
      NextDispatcher next) async {
    next(action);
    try {
      await createPostUseCase.run(action.text);
      store.dispatch(SubmitPostSuccessAction());
    } on CreatePostException catch (error, stackTrace) {
      store.dispatch(SubmitPostErrorTextSizeMismatchAction());
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      store.dispatch(OnCatchDefaultErrorAction(
          error.toString(), stackTrace, actionName, action.itemToJson()));
      store.dispatch(SubmitPostErrorAction());
    }
  }

  void updateRating(Store<AppState> store, SubmitPostUpdateRatingAction action,
      NextDispatcher next) async {
    next(action);
    try {
      await updatePostRatingUseCase.run(action.postId);
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      store.dispatch(
          OnCatchDefaultErrorAction(error.toString(), stackTrace, actionName));
    }
  }

  void updateComment(Store<AppState> store, SubmitPostCommentAction action,
      NextDispatcher next) async {
    next(action);
        try {
      await updatePostCommentUseCase.run(action.postId, action.comment);
      store.dispatch(SubmitPostCommentSuccessAction());
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      store.dispatch(
          OnCatchDefaultErrorAction(error.toString(), stackTrace, actionName));
      store.dispatch(SubmitPostCommentErrorAction());
    }
  }

  void createImagePost(Store<AppState> store, SubmitImagePostAction action,
      NextDispatcher next) async {
    next(action);
    try {
      await createImagePostUseCase.run(action.imageData, action.text);
      store.dispatch(SubmitPostSuccessAction());
    } on CreatePostException catch (error, stackTrace) {
      store.dispatch(SubmitPostErrorTextSizeMismatchAction());
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      store.dispatch(OnCatchDefaultErrorAction(
          error.toString(), stackTrace, actionName, action.itemToJson()));
    }
  }

  void postCreated(Store<AppState> store, SubmitPostSuccessAction action,
      NextDispatcher next) async {
    next(action);
    if (store.state.route.last == AppRoutes.createPost) {
      //store.dispatch(NavigatePopAction());
    }
  }

  void explorePosts(Store<AppState> store, FetchPostsAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final posts = await explorePostUseCase.run(50);
      final futures = posts.map((post) async {
        final author = await getUserByIdUseCase.run(post.userId);
        return PostData(post.id, author, post.type, post.text, post.imageURL,
            post.statusCode, post.likes);
      });
      final data = await Future.wait(futures);
      store.dispatch(FetchPostsSuccessAction(data));
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      store.dispatch(
          OnCatchDefaultErrorAction(error.toString(), stackTrace, actionName));
    }
  }

  void postCreation(Store<AppState> store, NavigateCreatePostAction action,
      NextDispatcher next) async {
    next(action);
    store.dispatch(NavigatePushAction(AppRoutes.createPost));
  }

  void navigatePost(Store<AppState> store, NavigatePostAction action,
      NextDispatcher next) async {
    next(action);
    store.dispatch(NavigatePushAction(AppRoutes.completePost));
    store.dispatch(SetCompletePostAction(action.post));
  }

  void fetchPostById(Store<AppState> store, FetchPostAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final post = await getPostByIdUseCase.run(action.postId);
      final user = await getUserByIdUseCase.run(post.userId);
      final postData = new PostData(post.id, user, post.type, post.text,
          post.imageURL, post.statusCode, post.likes);

      store.dispatch(NavigatePostAction(postData));
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      store.dispatch(
          OnCatchDefaultErrorAction(error.toString(), stackTrace, actionName));
    }
  }

  void navigatePostImageZoom(Store<AppState> store,
      NavigatePostImageZoomAction action, NextDispatcher next) async {
    next(action);
    store.dispatch(NavigatePushAction(AppRoutes.imagePost));
    store.dispatch(SetPostImageAction(action.imageURL));
  }

  return [
    TypedMiddleware<AppState, DeletePostAction>(deletePost),
    TypedMiddleware<AppState, NavigateCreatePostAction>(postCreation),
    TypedMiddleware<AppState, SubmitTextPostAction>(createTextPost),
    TypedMiddleware<AppState, SubmitImagePostAction>(createImagePost),
    TypedMiddleware<AppState, SubmitPostSuccessAction>(postCreated),
    TypedMiddleware<AppState, FetchPostsAction>(explorePosts),
    TypedMiddleware<AppState, NavigatePostAction>(navigatePost),
    TypedMiddleware<AppState, FetchPostAction>(fetchPostById),
    TypedMiddleware<AppState, NavigatePostImageZoomAction>(
        navigatePostImageZoom),
    TypedMiddleware<AppState, SubmitPostUpdateRatingAction>(updateRating),
    TypedMiddleware<AppState, SubmitPostCommentAction>(updateComment),
  ];
}
