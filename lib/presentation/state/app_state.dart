import 'package:app/presentation/state/reducers/ChallengeReducer.dart';
import 'package:app/presentation/state/reducers/CreatePostReducer.dart';
import 'package:app/presentation/state/reducers/ENEMReducer.dart';
import 'package:app/presentation/state/reducers/EditMyInfoReducer.dart';
import 'package:app/presentation/state/reducers/LoginReducer.dart';
import 'package:app/presentation/state/reducers/PostsReducer.dart';
import 'package:app/presentation/state/reducers/UserReducer.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import '../../injection.dart';
import 'middleware/AnalyticsMiddleware.dart';
import 'middleware/ChallengeMiddleware.dart';
import 'middleware/ENEMMiddleware.dart';
import 'middleware/LoginMiddleware.dart';
import 'middleware/PostMiddleware.dart';
import 'middleware/UserMiddleware.dart';
import 'navigator/NavigatorMiddleware.dart';
import 'navigator/NavigatorReducer.dart';

class AppState {
  final UserState userState;
  final PostState postState;
  final CreatePostState createPostState;
  final LoginState loginState;
  final ENEMState enemState;
  final EditMyInfoState editMyInfoState;
  final ChallengeState challengeState;
  final List<String> route;

  AppState({
    this.userState,
    this.postState,
    this.createPostState,
    this.route,
    this.editMyInfoState,
    this.loginState,
    this.enemState,
    this.challengeState,
  });

  factory AppState.initial() => AppState(
        route: ["/"],
        userState: UserState.initial(),
        postState: PostState.initial(),
        createPostState: CreatePostState.initial(),
        loginState: LoginState.initial(),
        enemState: ENEMState.initial(),
        challengeState: ChallengeState.initial(),
        editMyInfoState: EditMyInfoState.initial(),
      );
}

AppState appReducer(AppState state, action) => AppState(
      route: navigationReducer(state.route, action),
      userState: userReducer(state.userState, action),
      postState: postReducer(state.postState, action),
      createPostState: createPostReducer(state.createPostState, action),
      loginState: loginReducer(state.loginState, action),
      enemState: enemReducer(state.enemState, action),
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
      getUserByIdUseCase,
      submitChallengeAnswersUseCase,
    ),
    ...navigationMiddleware()
  ],
);
