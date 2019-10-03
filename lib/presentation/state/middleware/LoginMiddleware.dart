import 'package:app/domain/boundary/LoginBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/LoggerActions.dart';
import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:app/presentation/state/actions/SentryActions.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

List<Middleware<AppState>> loginMiddleware(
    ILogOutUseCase _logoutUseCase,
    ILoginUseCase _loginUseCase,
    IIsLoggedInUseCase _isLoggedInUseCase,
    ICheckUseCase _checkUseCase) {
  void logOut(
      Store<AppState> store, LogOutAction action, NextDispatcher next) async {
    try {
      await _logoutUseCase.run();
      store.dispatch(NotLoggedInAction());
      store.dispatch(NavigateReplaceAction(AppRoutes.login));
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      
      store.dispatch(LoggerErrorAction(actionName));
      store.dispatch(ReportSentryErrorAction(error, stackTrace, actionName));
    }
    next(action);
  }

  void login(
      Store<AppState> store, LoginAction action, NextDispatcher next) async {
    try {
      store.dispatch(IsLoggingInAction());
      await _loginUseCase.run(action.accessToken, action.method);
      store.dispatch(LoginSuccessAction());
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      
      store.dispatch(LoggerErrorAction(actionName));
      store.dispatch(ReportSentryErrorAction(error, stackTrace, actionName, action.itemToJson()));
    }
    next(action);
  }

  void isLogged(Store<AppState> store, CheckIfIsLoggedInAction action,
      NextDispatcher next) async {
    next(action);
    try {
      store.dispatch(IsLoggingInAction());
      final isLogged = await _isLoggedInUseCase.run();
      if (isLogged) {
        store.dispatch(LoginSuccessAction());
      } else {
        store.dispatch(NotLoggedInAction());
      }
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);
      
      store.dispatch(LoggerErrorAction(actionName));
      store.dispatch(ReportSentryErrorAction(error, stackTrace, actionName));
      store.dispatch(NotLoggedInAction());
    }
  }

  void loginSuccess(Store<AppState> store, LoginSuccessAction action,
      NextDispatcher next) async {
    store.dispatch(NavigateReplaceAction(AppRoutes.home));
    new Future.delayed(const Duration(seconds: 5), () {
      _checkUseCase.run();
    });
    next(action);
  }

  void isNotLogged(Store<AppState> store, NotLoggedInAction action,
      NextDispatcher next) async {
    next(action);
    store.dispatch(NavigateReplaceAction(AppRoutes.intro));
  }

  void navigateLogin(Store<AppState> store, NavigateLoginAction action,
      NextDispatcher next) async {
    next(action);
    store.dispatch(NavigateReplaceAction(AppRoutes.login));
  }

  return [
    TypedMiddleware<AppState, LogOutAction>(logOut),
    TypedMiddleware<AppState, LoginAction>(login),
    TypedMiddleware<AppState, CheckIfIsLoggedInAction>(isLogged),
    TypedMiddleware<AppState, LoginSuccessAction>(loginSuccess),
    TypedMiddleware<AppState, NotLoggedInAction>(isNotLogged),
    TypedMiddleware<AppState, NavigateLoginAction>(navigateLogin),
  ];
}
