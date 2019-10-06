
import 'package:app/presentation/state/actions/ItemActions.dart';

class NavigateLoginAction {}

class CheckIfIsLoggedInAction {
  CheckIfIsLoggedInAction();
}

class LoginAction extends ItemAction{
  final String accessToken;
  final String method;

  LoginAction(this.accessToken, this.method);

      @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'method': method
    };
  }
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

class SetLoginReportFieldAction {
  final String message;

  SetLoginReportFieldAction(this.message);
}
