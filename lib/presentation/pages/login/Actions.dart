class LoginAction {
  final String accessToken;
  final String method;

  LoginAction(this.accessToken, this.method);
}

class LoginSuccessAction {
  LoginSuccessAction();
}

class NotLoggedInAction {
  NotLoggedInAction();
}

class IsLoggingInAction {
  IsLoggingInAction();
}

class LogOutAction {
  LogOutAction();
}