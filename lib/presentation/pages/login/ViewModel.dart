import 'package:app/domain/boundary/LoginBoundary.dart';
import 'package:app/presentation/navigator/NavigatorActions.dart';
import 'package:app/presentation/reducers/user/Reducer.dart';
import 'package:redux/redux.dart';
import '../../../State.dart';
import '../../../main.dart';

class LoginViewModel {
  final Function(String, String) login;
  final bool isLoading;

  LoginViewModel({this.login, this.isLoading});

  factory LoginViewModel.create(
      Store<AppState> store, ILoginUseCase _loginUseCase) {
    return LoginViewModel(
      login: (String accessCode, String method) {
        store.dispatch(IsLoggingInAction());
        _loginUseCase.run(accessCode, method).then((_) {
          store.dispatch(LoginSuccessAction());
          store.dispatch(NavigateReplaceAction(AppRoutes.home));
        }).catchError(
          (e) {
            print(e);
          },
        );
      },
      isLoading: store.state.userState.isLoggedIn.isLoading,
    );
  }
}
