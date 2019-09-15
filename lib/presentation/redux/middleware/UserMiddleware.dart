import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/pages/create-post/Actions.dart';
import 'package:app/presentation/pages/edit-profile/Actions.dart';
import 'package:app/presentation/redux/actions/UserActions.dart';
import 'package:redux/redux.dart';

import '../../../redux.dart';

class UserMiddleware extends MiddlewareClass<AppState> {
  final IMyInfoUseCase _myInfoUseCase;
  final IMyPostsUseCase _myPostsUseCase;

  UserMiddleware(
    this._myInfoUseCase,
    this._myPostsUseCase,
  );

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is FetchMyInfoAction) {
      store.dispatch(FetchingUserAction());
      _myInfoUseCase.run().then((user) {
        store.dispatch(SetUserAction(user));
      }).catchError((e) {
        print(e);
        store.dispatch(FetchingUserErrorAction());
      });
    } else if (action is FetchMyPostsAction) {
      this._myPostsUseCase.run().then((posts) {
        store.dispatch(SetUserPostsAction(posts));
      }).catchError((e) {
        print(e);
        store.dispatch(FetchingMyPostsErrorAction());
      });
    } else if (action is PostCreatedAction) {
      store.dispatch(FetchMyPostsAction());
    } else if (action is MyProfileInfoWasChangedAction) {
      store.dispatch(FetchMyInfoAction());
    }
    next(action);
  }
}
