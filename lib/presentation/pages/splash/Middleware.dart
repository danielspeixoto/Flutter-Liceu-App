import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/pages/login/Actions.dart';
import 'package:app/presentation/redux/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../../main.dart';
import '../../../redux.dart';
import 'Actions.dart';

class UserMiddleware extends MiddlewareClass<AppState> {
  final IIsLoggedInUseCase _isLoggedInUseCase;

  UserMiddleware(
    this._isLoggedInUseCase,
  );

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is CheckIfIsLoggedInAction) {
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
    } else if (action is LoginSuccessAction) {
      store.dispatch(NavigateReplaceAction(AppRoutes.home));
    } else if (action is NotLoggedInAction) {
      store.dispatch(NavigateReplaceAction(AppRoutes.login));
    }
    next(action);
  }
}
