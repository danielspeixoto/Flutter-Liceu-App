import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:app/presentation/state/actions/ReportActions.dart';
import 'package:app/presentation/state/app_state.dart';
import 'package:redux/redux.dart';

class LoginViewModel {
  final Function(String, String) login;
  final Function(String) onMessageTextChanged;
  final Function() onSendMessageButtonPressed;
  final bool isLoading;
  final String message;

  LoginViewModel(
      {this.login,
      this.onMessageTextChanged,
      this.onSendMessageButtonPressed,
      this.isLoading,
      this.message});

  factory LoginViewModel.create(Store<AppState> store) {
    final loginState = store.state.loginState;
    return LoginViewModel(
        login: (String accessCode, String method) {
          store.dispatch(LoginAction(accessCode, method));
        },
        isLoading: loginState.loginStatus.isLoading,
        message: loginState.message,
        onMessageTextChanged: (String message) {
          store.dispatch(SetLoginReportFieldAction(message));
        },
        onSendMessageButtonPressed: () {
          Map<String, dynamic> params = {
            "UserSituation": "on login page"
          };

          List<String> tags = ["created", "message", "login"];

          store.dispatch(SubmitReportAction(loginState.message, tags, params));
        });
  }
}
