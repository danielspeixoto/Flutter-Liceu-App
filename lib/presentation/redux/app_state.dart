import 'package:app/presentation/redux/reducers/EditMyInfoReducer.dart';
import 'package:app/presentation/redux/reducers/LoginReducer.dart';
import 'package:app/presentation/redux/reducers/UserReducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import '../../injection.dart';
import 'middleware/LoginMiddleware.dart';
import 'middleware/PostMiddleware.dart';
import 'middleware/UserMiddleware.dart';
import 'navigator/NavigatorMiddleware.dart';
import 'navigator/NavigatorReducer.dart';

class AppState {
  final UserState userState;
  final LoginState loginState;
  final EditMyInfoState editMyInfoState;
  final List<String> route;

  AppState({
    this.userState,
    this.route,
    this.editMyInfoState,
    this.loginState,
  });

  factory AppState.initial() => AppState(
        route: ["/"],
        userState: UserState.initial(),
        loginState: LoginState.initial(),
        editMyInfoState: EditMyInfoState.initial(),
      );
}

AppState appReducer(AppState state, action) => AppState(
      route: navigationReducer(state.route, action),
      userState: userReducer(state.userState, action),
      loginState: loginReducer(state.loginState, action),
      editMyInfoState: editMyInfoReducer(state.editMyInfoState, action),
    );

final Store<AppState> store = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    new LoggingMiddleware.printer(),
    LoginMiddleware(
      logoutUseCase,
      loginUseCase,
      isLoggedInUseCase,
    ),
    UserMiddleware(
      myInfoUseCase,
      myPostsUseCase,
      setUserDescriptionUseCase,
      setUserInstagramUseCase,
    ),
    PostMiddleware(
      deletePostUseCase,
      createPostUseCase,
    ),
    ...navigationMiddleware()
  ],
);