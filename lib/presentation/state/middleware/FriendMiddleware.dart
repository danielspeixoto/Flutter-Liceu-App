import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

List<Middleware<AppState>> friendMiddleware(
  IGetUserPostsUseCase getUserPostsUseCase,
  IGetUserByIdUseCase getUserById,
) {
  void fetchPosts(Store<AppState> store, FetchFriendPostsAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final posts = await getUserPostsUseCase.run(action.id);
      store.dispatch(SetFriendPostsAction(posts));
    } catch (e) {
      print(e);
      store.dispatch(FetchFriendPostsErrorAction());
    }
  }

  void viewFriend(Store<AppState> store, NavigateViewFriendAction action,
      NextDispatcher next) {
    next(action);
    store.dispatch(NavigatePushAction(AppRoutes.friend));
  }

  void userClick(
      Store<AppState> store, UserClickedAction action, NextDispatcher next) {
    next(action);
    store.dispatch(SetFriendAction(action.user));
    store.dispatch(FetchFriendPostsAction(action.user.id));
    store.dispatch(NavigatePushAction(AppRoutes.friend));
  }

  return [
    TypedMiddleware<AppState, FetchFriendPostsAction>(fetchPosts),
    TypedMiddleware<AppState, NavigateViewFriendAction>(viewFriend),
    TypedMiddleware<AppState, UserClickedAction>(userClick)
  ];
}
