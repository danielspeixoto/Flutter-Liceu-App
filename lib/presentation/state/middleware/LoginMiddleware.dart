import 'package:app/domain/boundary/LoginBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

class LoginMiddleware extends MiddlewareClass<AppState> {
  final ILogOutUseCase _logoutUseCase;
  final ILoginUseCase _loginUseCase;
  final IIsLoggedInUseCase _isLoggedInUseCase;
  final analytics = FirebaseAnalytics();

  LoginMiddleware(
    this._logoutUseCase,
    this._loginUseCase,
    this._isLoggedInUseCase,
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
//
    } else if (action is LoginAction) {
      store.dispatch(IsLoggingInAction());
      _loginUseCase.run(action.accessToken, action.method).then((id) {
        analytics.logLogin(loginMethod: action.method);
        analytics.setUserId(id);
        store.dispatch(LoginSuccessAction());
      }).catchError(
        (e) {
          print(e);
        },
      );
//
    } else if (action is CheckIfIsLoggedInAction) {
      store.dispatch(IsLoggingInAction());
      _isLoggedInUseCase.run().then((isLogged) {
        if (isLogged) {
          store.dispatch(LoginSuccessAction());
        } else {
          store.dispatch(NotLoggedInAction());
        }
      }).catchError((e) {
        print(e);
        store.dispatch(NotLoggedInAction());
      });
//
    } else if (action is LoginSuccessAction) {
      store.dispatch(NavigateReplaceAction(AppRoutes.home));
//
    } else if (action is NotLoggedInAction) {
      store.dispatch(NavigateReplaceAction(AppRoutes.login));
    }
    next(action);
  }
}
