import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

List<Middleware<AppState>> postMiddleware(
  ICreatePostUseCase createPostUseCase,
  IDeletePostUseCase deletePostUseCase,
) {
  void deletePost(Store<AppState> store, DeletePostAction action,
      NextDispatcher next) async {
    next(action);
    try {
      deletePostUseCase.run(action.postId);
    } catch (e) {
      print(e);
    }
  }

  void createPost(Store<AppState> store, CreatePostAction action,
      NextDispatcher next) async {
    next(action);
    try {
      await createPostUseCase.run(action.postType, action.text);
      store.dispatch(PostCreatedAction());
    } catch (e) {
      print(e);
    }
  }

  void postCreated(Store<AppState> store, PostCreatedAction action,
      NextDispatcher next) async {
    next(action);
    if (store.state.route.last == AppRoutes.createPost) {
      store.dispatch(NavigatePopAction());
    }
  }

  return [
    TypedMiddleware<AppState, DeletePostAction>(deletePost),
    TypedMiddleware<AppState, CreatePostAction>(createPost),
    TypedMiddleware<AppState, PostCreatedAction>(postCreated),
  ];
}
