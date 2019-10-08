import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/actions/UtilActions.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

List<Middleware<AppState>> friendMiddleware(
  IGetUserPostsUseCase getUserPostsUseCase,
  IGetUserByIdUseCase getUserById,
  IMyIdUseCase getMyIdUseCase,
) {
  void fetchFriendInfo(Store<AppState> store, FetchFriendAction action,
      NextDispatcher next) async {
    try {
      final friend = await getUserById.run(action.id);
      store.dispatch(SetFriendAction(friend));
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      store.dispatch(
          OnCatchDefaultErrorAction(error.toString(), stackTrace, actionName));
      store.dispatch(FetchFriendErrorAction());
    }
  }

  void fetchPosts(Store<AppState> store, FetchFriendPostsAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final posts = await getUserPostsUseCase.run(action.id);
      store.dispatch(SetFriendPostsAction(posts));
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      store.dispatch(
          OnCatchDefaultErrorAction(error.toString(), stackTrace, actionName));
      store.dispatch(FetchFriendPostsErrorAction());
    }
  }

  void viewFriend(Store<AppState> store, NavigateViewFriendAction action,
      NextDispatcher next) async {
    next(action);
    store.dispatch(NavigatePushAction(AppRoutes.friend));
  }

  void userClick(Store<AppState> store, UserClickedAction action,
      NextDispatcher next) async {
    next(action);

    store.dispatch(NavigateViewFriendAction());
    store.dispatch(SetFriendAction(action.user));
    store.dispatch(FetchFriendPostsAction(action.user.id));
  }

  return [
    TypedMiddleware<AppState, FetchFriendAction>(fetchFriendInfo),
    TypedMiddleware<AppState, FetchFriendPostsAction>(fetchPosts),
    TypedMiddleware<AppState, NavigateViewFriendAction>(viewFriend),
    TypedMiddleware<AppState, UserClickedAction>(userClick)
  ];
}
