import 'package:app/domain/boundary/LoginBoundary.dart';
import 'package:app/presentation/navigator/NavigatorActions.dart';
import 'package:app/presentation/reducers/user/Reducer.dart';
import 'package:redux/redux.dart';
import '../../../State.dart';
import '../../../main.dart';
import 'Reducer.dart';

class LoginPresenter extends MiddlewareClass<AppState> {

  final ILoginUseCase _loginUseCase;

  LoginPresenter(this._loginUseCase);

  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is LoginAction) {
      store.dispatch(LoginPageIsLoading(true));
        _loginUseCase.run(action.accessCode, action.method).then((_){
          store.dispatch(UpdateLoggedStatus(true));
          store.dispatch(LoginPageIsLoading(false));
          store.dispatch(NavigateReplaceAction(AppRoutes.home));
        }).catchError((e) {
          print(e);
          store.dispatch(UpdateLoggedStatus(false));
        }).whenComplete(() {
          store.dispatch(LoginPageIsLoading(false));
        });
    }
    next(action);

  }
}

class LoginAction {
  final String accessCode;
  final String method;

  LoginAction(this.accessCode, this.method);
}

