import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/domain/usecase/user/IsLoggedInUseCase.dart';
import 'package:app/domain/usecase/user/MyInfoUseCase.dart';
import 'package:app/presentation/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';
import '../../../redux.dart';
import '../../../main.dart';
import 'Reducer.dart';

class UserPresenter extends MiddlewareClass<AppState> {
  final IMyInfoUseCase _myInfoUseCase;
  final IIsLoggedInUseCase _isLoggedInUseCase;
  final IMyPostsUseCase _myPostsUseCase;

  UserPresenter(
      this._myInfoUseCase, this._isLoggedInUseCase, this._myPostsUseCase);

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is FetchMyInfoAction) {
      store.dispatch(FetchingUserAction());
      _myInfoUseCase.run().then((user) {
        store.dispatch(SetUserAction(user));
      }).catchError((e) {
        print(e);
      });
    } else if (action is CheckIfIsLoggedInAction) {
      store.dispatch(IsLoggingInAction());
      _isLoggedInUseCase.run().then((isLogged) {
        if (isLogged) {
          store.dispatch(LoginSuccessAction());
          store.dispatch(NavigateReplaceAction(AppRoutes.home));
        } else {
          store.dispatch(LoginFailedAction());
          store.dispatch(NavigateReplaceAction(AppRoutes.login));
        }
      }).catchError((e) {
        print(e);
      });
    } else if (action is FetchMyPostsAction) {
      this._myPostsUseCase.run().then((posts) {
        store.dispatch(SetUserPostsAction(posts));
      }).catchError((e) {
        print(e);
      });
    }
    next(action);
  }
}

class FetchMyInfoAction {
  FetchMyInfoAction();
}

class CheckIfIsLoggedInAction {
  CheckIfIsLoggedInAction();
}

class FetchMyPostsAction {
  FetchMyPostsAction();
}
