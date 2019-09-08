import 'package:redux/redux.dart';

import '../../State.dart';
import 'Presenter.dart';

class LoginViewModel {
  final Function(String, String) login;
  final bool isLoading;

  LoginViewModel(this.login, this.isLoading);

  factory LoginViewModel.create(Store<AppState> store) {
    var state = store.state.loginScreenState;
    return LoginViewModel(
        (String accessCode, String method) =>
            store.dispatch(LoginAction(accessCode, method)),
        state.isLoading);
  }
}

