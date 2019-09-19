import 'package:app/presentation/state/reducers/ChallengeReducer.dart';
import 'package:app/presentation/state/reducers/EditMyInfoReducer.dart';
import 'package:app/presentation/state/reducers/LoginReducer.dart';
import 'package:app/presentation/state/reducers/TournamentReducer.dart';
import 'package:app/presentation/state/reducers/UserReducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import '../../injection.dart';
import 'middleware/AnalyticsMiddleware.dart';
import 'middleware/ChallengeMiddleware.dart';
import 'middleware/LoginMiddleware.dart';
import 'middleware/PostMiddleware.dart';
import 'middleware/TournamentMiddleware.dart';
import 'middleware/UserMiddleware.dart';
import 'navigator/NavigatorMiddleware.dart';
import 'navigator/NavigatorReducer.dart';

class AppState {
  final UserState userState;
  final LoginState loginState;
  final TournamentState tournamentState;
  final EditMyInfoState editMyInfoState;
  final ChallengeState challengeState;
  final List<String> route;

  AppState({
    this.userState,
    this.route,
    this.editMyInfoState,
    this.loginState,
    this.tournamentState,
    this.challengeState,
  });

  factory AppState.initial() => AppState(
        route: ["/"],
        userState: UserState.initial(),
        loginState: LoginState.initial(),
        tournamentState: TournamentState.initial(),
    challengeState: ChallengeState.initial(),
    editMyInfoState: EditMyInfoState.initial(),
      );
}

AppState appReducer(AppState state, action) => AppState(
      route: navigationReducer(state.route, action),
      userState: userReducer(state.userState, action),
      loginState: loginReducer(state.loginState, action),
      tournamentState: tournamentReducer(state.tournamentState, action),
      challengeState: challengeReducer(state.challengeState, action),
      editMyInfoState: editMyInfoReducer(state.editMyInfoState, action),
    );

final Store<AppState> store = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    new LoggingMiddleware.printer(),
    AnalyticsMiddleware(),
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
      myChallengesUseCase,
      getUserByIdUseCase,
    ),
    ...postMiddleware(
      createPostUseCase,
      deletePostUseCase,
    ),
    ...tournamentMiddleware(
      getRankingUseCase,
      getUserByIdUseCase,
    ),
    ...challengeMiddleware(
      getChallengeUseCase,
      getUserByIdUseCase,
      submitChallengeAnswersUseCase,
    ),
    ...navigationMiddleware()
  ],
);
