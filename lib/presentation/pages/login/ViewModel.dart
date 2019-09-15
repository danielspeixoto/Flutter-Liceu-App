import 'package:app/presentation/redux/actions/LoginActions.dart';
import 'package:app/presentation/redux/app_state.dart';
import 'package:redux/redux.dart';

class LoginViewModel {
  final Function(String, String) login;
  final bool isLoading;

  LoginViewModel({this.login, this.isLoading});

  factory LoginViewModel.create(
      Store<AppState> store) {
    return LoginViewModel(
      login: (String accessCode, String method) {
        store.dispatch(LoginAction(accessCode, method));
      },
      isLoading: store.state.loginState.isLoggedIn.isLoading,
    );
  }
}
