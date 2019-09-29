import 'package:app/domain/aggregates/exceptions/Exceptions.dart';
import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/aggregates/PostData.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';
import '../../app.dart';
import '../app_state.dart';

List<Middleware<AppState>> postMiddleware(
  ICreatePostUseCase createPostUseCase,
  IDeletePostUseCase deletePostUseCase,
  IExplorePostUseCase explorePostUseCase,
  IGetUserByIdUseCase getUserByIdUseCase,
) {
  void deletePost(Store<AppState> store, DeletePostAction action,
      NextDispatcher next) async {
    next(action);
    try {
      await deletePostUseCase.run(action.postId);
    } catch (e) {
      print(e);
    }
  }

  void createPost(Store<AppState> store, SubmitPostAction action,
      NextDispatcher next) async {
    next(action);
    try {
      await createPostUseCase.run(action.postType, action.text);
      store.dispatch(SubmitPostSuccessAction());
    } on SizeBoundaryException catch(e) {
      store.dispatch(SubmitPostErrorTextSizeMismatchAction());
    } catch (e) {
      print(e);
    }
  }

  void postCreated(Store<AppState> store, SubmitPostSuccessAction action,
      NextDispatcher next) async {
    next(action);
    if (store.state.route.last == AppRoutes.createPost) {
      store.dispatch(NavigatePopAction());
    }
  }

  void explorePosts(Store<AppState> store, FetchPostsAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final posts = await explorePostUseCase.run(5);
      final futures = posts.map((post) async {
        final author = await getUserByIdUseCase.run(post.userId);
        return PostData(
          post.id,
          author,
          post.type,
          post.text,
        );
      });
      final data = await Future.wait(futures);
      store.dispatch(FetchPostsSuccessAction(data));
    } catch (e) {
      print(e);
    }
  }

  void postCreation(Store<AppState> store, NavigateCreatePostAction action,
      NextDispatcher next) async {
    next(action);
    store.dispatch(NavigatePushAction(AppRoutes.createPost));
  }

  return [
    TypedMiddleware<AppState, DeletePostAction>(deletePost),
    TypedMiddleware<AppState, NavigateCreatePostAction>(postCreation),
    TypedMiddleware<AppState, SubmitPostAction>(createPost),
    TypedMiddleware<AppState, SubmitPostSuccessAction>(postCreated),
    TypedMiddleware<AppState, FetchPostsAction>(explorePosts),
  ];
}
