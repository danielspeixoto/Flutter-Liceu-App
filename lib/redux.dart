import 'package:app/presentation/navigator/NavigatorMiddleware.dart';
import 'package:app/presentation/navigator/NavigatorReducer.dart';
import 'package:app/presentation/pages/edit-profile/Middleware.dart';
import 'package:app/presentation/pages/edit-profile/Reducer.dart';
import 'package:app/presentation/reducers/user/Presenter.dart';
import 'package:app/presentation/reducers/user/Reducer.dart';
import 'package:redux_logging/redux_logging.dart';

import 'injection.dart';

class AppState {
  final UserState userState;
  final EditProfilePageState editProfilePageState;
  final List<String> route;

  AppState({this.userState, this.route, this.editProfilePageState});

  factory AppState.initial() => AppState(
        userState: UserState.initial(),
        route: ["/"],
        editProfilePageState: EditProfilePageState.initial(),
      );
}

AppState appReducer(AppState state, action) => AppState(
    userState: userReducer(state.userState, action),
    route: navigationReducer(state.route, action),
    editProfilePageState:
        editProfilePageReducer(state.editProfilePageState, action));