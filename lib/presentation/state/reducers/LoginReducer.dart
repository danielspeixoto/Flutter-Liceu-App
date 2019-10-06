import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:redux/redux.dart';

import 'Data.dart';

class LoginState {
  final Data<bool> loginStatus;
  final String message;

  LoginState(this.loginStatus, this.message);

  factory LoginState.initial() => LoginState(
        Data(),
        null
      );

  LoginState copyWith({
    Data<bool> isLoggedIn,
    String message
  }) {
    final state = LoginState(
      isLoggedIn ?? this.loginStatus,
      message ?? this.message
    );
    return state;
  }

  bool isUserLoggedIn() {
    return loginStatus.content != null && loginStatus.content;
  }
}

final Reducer<LoginState> loginReducer = combineReducers<LoginState>([
//  Login
  TypedReducer<LoginState, LoginSuccessAction>(loginSuccess),
  TypedReducer<LoginState, NotLoggedInAction>(loginFailed),
  TypedReducer<LoginState, IsLoggingInAction>(login),
  TypedReducer<LoginState, SetLoginReportFieldAction>(setMessage),
]);

LoginState loginSuccess(LoginState state, LoginSuccessAction action) {
  return state.copyWith(
    isLoggedIn: state.loginStatus.copyWith(content: true, isLoading: false),
  );
}

LoginState loginFailed(LoginState state, NotLoggedInAction action) {
  return state.copyWith(
    isLoggedIn: state.loginStatus.copyWith(content: false, isLoading: false),
  );
}

LoginState login(LoginState state, IsLoggingInAction action) {
  return state.copyWith(
    isLoggedIn: Data(isLoading: true),
  );
}

LoginState setMessage(LoginState state, SetLoginReportFieldAction action) {
  return state.copyWith(
    message: action.message,
  );
}