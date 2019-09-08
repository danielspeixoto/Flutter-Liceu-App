import 'package:app/domain/boundary/LoginBoundary.dart';
import 'package:app/presentation/reducers/UserReducer.dart';
import 'package:redux/redux.dart';
import '../../State.dart';
import 'Reducer.dart';

class LoginPresenter extends MiddlewareClass<AppState> {

  final ILoginUseCase _loginUseCase;

  LoginPresenter(this._loginUseCase);

  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is LoginAction) {
      store.dispatch(LoginPageIsLoading(true));
        _loginUseCase.run(action.accessCode, action.method).then((v){
          store.dispatch(UpdateLoggedStatus(true));
          store.dispatch(LoginPageIsLoading(false));
        }).catchError((e) {
          print(e);
          store.dispatch(UpdateLoggedStatus(false));
        }).whenComplete(() {
          store.dispatch(LoginPageIsLoading(false));
        });
    } else {
      next(action);
    }
  }
}

class LoginAction {
  final String accessCode;
  final String method;

  LoginAction(this.accessCode, this.method);
}

