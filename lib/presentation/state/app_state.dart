import 'package:app/presentation/state/middleware/LoggerMiddleware.dart';
import 'package:app/presentation/state/middleware/ReportMiddleware.dart';
import 'package:app/presentation/state/middleware/TriviaMiddleware.dart';
import 'package:app/presentation/state/reducers/ChallengeReducer.dart';
import 'package:app/presentation/state/reducers/ENEMReducer.dart';
import 'package:app/presentation/state/reducers/EditMyInfoReducer.dart';
import 'package:app/presentation/state/reducers/FeatureReducer.dart';
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
  final FeatureState featureState;

  AppState(
      {this.userState,
      this.friendState,
      this.postState,
      this.route,
      this.editMyInfoState,
      this.loginState,
      this.enemState,
      this.triviaState,
      this.challengeState,
      this.featureState});

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
      featureState: FeatureState.initial());
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
    featureState: featureReducer(state.featureState, action));

final Store<AppState> store = Store<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [
    ...loggerMiddleware(),
    ...analyticsMiddleware(Dependencies.get().myIdUseCase),
    ...sentryMiddleware(),
    ...loginMiddleware(
      Dependencies.get().logoutUseCase,
      Dependencies.get().loginUseCase,
      Dependencies.get().isLoggedInUseCase,
      Dependencies.get().checkUseCase,
    ),
    ...userMiddleware(
      Dependencies.get().myInfoUseCase,
      Dependencies.get().myPostsUseCase,
      Dependencies.get().myChallengesUseCase,
      Dependencies.get().getUserByIdUseCase,
      Dependencies.get().setUserDescriptionUseCase,
      Dependencies.get().setUserInstagramUseCase,
      Dependencies.get().setUserDesiredCourseUseCase,
      Dependencies.get().setUserPhoneUseCase,
      Dependencies.get().myIdUseCase,
      Dependencies.get().submitUserFcmTokenUseCase,
      Dependencies.get().savePostUseCase,
      Dependencies.get().getSavedPostsUseCase
    ),
    ...postMiddleware(
      Dependencies.get().createTextPostUseCase,
      Dependencies.get().deletePostUseCase,
      Dependencies.get().getExplorePostsUseCase,
      Dependencies.get().getUserByIdUseCase,
      Dependencies.get().createImagePostUseCase,
      Dependencies.get().getPostByIdUseCase,
      Dependencies.get().updatePostRatingUseCase,
      Dependencies.get().updatePostCommentUseCase,
      Dependencies.get().searchPostsUseCase,
      Dependencies.get().getSavedPostsUseCase
    ),
    ...ENEMMiddleware(
      Dependencies.get().getRankingUseCase,
      Dependencies.get().getUserByIdUseCase,
      Dependencies.get().getENEMQuestionsUseCase,
      Dependencies.get().getENEMQuestionsVideosUseCase,
      Dependencies.get().submitENEMGamesUseCase,
    ),
    ...challengeMiddleware(
      Dependencies.get().getChallengeUseCase,
      Dependencies.get().getChallengeByIdUseCase,
      Dependencies.get().challengeSomeoneUseCase,
      Dependencies.get().getUserByIdUseCase,
      Dependencies.get().submitChallengeAnswersUseCase,
      Dependencies.get().myIdUseCase,
    ),
    ...friendMiddleware(
      Dependencies.get().getUserPostsUseCase,
      Dependencies.get().getUserByIdUseCase,
      Dependencies.get().myIdUseCase,
    ),
    ...triviaMiddleware(
      Dependencies.get().createTriviaUseCase,
    ),
    ...notificationMiddleware(
      Dependencies.get().isLoggedInUseCase,
    ),
    ...reportMiddleware(
      Dependencies.get().submitReportUseCase,
    ),
    ...navigationMiddleware()
  ],
);
