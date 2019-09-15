import 'package:app/domain/boundary/LoginBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/pages/login/Actions.dart';
import 'package:app/presentation/redux/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../../main.dart';
import '../../../redux.dart';

class UserMiddleware extends MiddlewareClass<AppState> {
  final ILogOutUseCase _logoutUseCase;
  final ILoginUseCase _loginUseCase;

  UserMiddleware(
    this._logoutUseCase,
    this._loginUseCase,
  );

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is LogOutAction) {
      this._logoutUseCase.run().then((_) {
        store.dispatch(NotLoggedInAction());
        store.dispatch(NavigateReplaceAction(AppRoutes.login));
      }).catchError((e) {
        print(e);
      });
    } else if (action is LoginAction) {
      store.dispatch(IsLoggingInAction());
      _loginUseCase.run(action.accessToken, action.method).then((_) {
        store.dispatch(LoginSuccessAction());
        store.dispatch(NavigateReplaceAction(AppRoutes.home));
      }).catchError(
        (e) {
          print(e);
        },
      );
    }
    next(action);
  }
}
