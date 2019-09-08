import 'package:redux/redux.dart';

class LoginPageState {
  final bool isLoading;

  LoginPageState(this.isLoading);

  factory LoginPageState.initial() => LoginPageState(false);
}

final Reducer<LoginPageState> loginPageReducer = combineReducers<LoginPageState>([
  TypedReducer<LoginPageState, LoginPageIsLoading>(pageIsLoading)
]);

class LoginPageIsLoading {
  final bool isLoading;

  LoginPageIsLoading(this.isLoading);
}

LoginPageState pageIsLoading(LoginPageState state, LoginPageIsLoading action) {
  return LoginPageState(
      action.isLoading
  );
}