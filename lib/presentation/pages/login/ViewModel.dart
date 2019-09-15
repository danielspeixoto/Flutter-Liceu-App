import 'package:redux/redux.dart';
import '../../../redux.dart';
import 'Actions.dart';

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
      isLoading: store.state.userState.isLoggedIn.isLoading,
    );
  }
}
