import 'package:app/presentation/state/middleware/LoggerMiddleware.dart';
import 'package:app/presentation/state/middleware/TriviaMiddleware.dart';
import 'package:app/presentation/state/reducers/ChallengeReducer.dart';
import 'package:app/presentation/state/reducers/ENEMReducer.dart';
import 'package:app/presentation/state/reducers/EditMyInfoReducer.dart';
import 'package:app/presentation/state/reducers/FriendReducer.dart';
import 'package:app/presentation/state/reducers/LoginReducer.dart';
import 'package:app/presentation/state/reducers/PostsReducer.dart';
import 'package:app/presentation/state/reducers/TriviaReducer.dart';
import 'package:app/presentation/state/reducers/UserReducer.dart';
import 'package:redux/redux.dart';

import '../../injection.dart';
import 'middleware/AnalyticsMiddleware.dart';
import 'middleware/ChallengeMiddleware.dart';
import 'middleware/ENEMMiddleware.dart';
import 'middleware/FriendMiddleware.dart';
import 'middleware/LoginMiddleware.dart';
import 'middleware/NotificationMiddleware.dart';
import 'middleware/PostMiddleware.dart';
import 'middleware/SentryMiddleware.dart';
import 'middleware/UserMiddleware.dart';
import 'navigator/NavigatorMiddleware.dart';
import 'navigator/NavigatorReducer.dart';

class AppState {
  final UserState userState;
  final FriendState friendState;
  final PostState postState;
  final LoginState loginState;
  final ENEMState enemState;
  final EditMyInfoState editMyInfoState;
  final ChallengeState challengeState;
  final TriviaState triviaState;
  final List<String> route;

  AppState({
    this.userState,
    this.friendState,
    this.postState,
    this.route,
    this.editMyInfoState,
    this.loginState,
    this.enemState,
    this.triviaState,
    this.challengeState,
  });

  factory AppState.initial() => AppState(
        route: ["/"],
        userState: UserState.initial(),
        friendState: FriendState.initial(),
        postState: PostState.initial(),
        loginState: LoginState.initial(),
        enemState: ENEMState.initial(),
        challengeState: ChallengeState.initial(),
        triviaState: TriviaState.initial(),
        editMyInfoState: EditMyInfoState.initial(),
      );
}

AppState appReducer(AppState state, action) => AppState(
      route: navigationReducer(state.route, action),
      userState: userReducer(state.userState, action),
      friendState: friendReducer(state.friendState, action),
      postState: postReducer(state.postState, action),
      loginState: loginReducer(state.loginState, action),
      enemState: enemReducer(state.enemState, action),
      challengeState: challengeReducer(state.challengeState, action),
      triviaState: triviaReducer(state.triviaState, action),
      editMyInfoState: editMyInfoReducer(state.editMyInfoState, action),
    );

final Store<AppState> store = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    LoggerMiddleware(),
    ...analyticsMiddleware(myIdUseCase),
    ...sentryMiddleware(),
    ...loginMiddleware(
      logoutUseCase,
      loginUseCase,
      isLoggedInUseCase,
      checkUseCase,
    ),
    ...userMiddleware(
      myInfoUseCase,
      myPostsUseCase,
      myChallengesUseCase,
      getUserByIdUseCase,
      setUserDescriptionUseCase,
      setUserInstagramUseCase,
      myIdUseCase,
      submitUserFcmTokenUseCase
    ),
    ...postMiddleware(
      createPostUseCase,
      deletePostUseCase,
      getExplorePostsUseCase,
      getUserByIdUseCase,
    ),
    ...ENEMMiddleware(
      getRankingUseCase,
      getUserByIdUseCase,
      getENEMQuestionsUseCase,
      getENEMQuestionsVideosUseCase,
      submitENEMGamesUseCase,
    ),
    ...challengeMiddleware(
      getChallengeUseCase,
      getChallengeByIdUseCase,
      challengeSomeoneUseCase,
      getUserByIdUseCase,
      submitChallengeAnswersUseCase,
    ),
    ...friendMiddleware(
      getUserPostsUseCase,
      getUserByIdUseCase,
    ),
    ...triviaMiddleware(
      createTriviaUseCase,
    ),
    ...notificationMiddleware(
      isLoggedInUseCase,
    ),
    ...navigationMiddleware()
  ],
);
