import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/LoggerActions.dart';
import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:app/presentation/state/actions/SentryActions.dart';
import 'package:app/presentation/state/aggregates/ChallengeHistoryData.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

final analytics = FirebaseAnalytics();

List<Middleware<AppState>> userMiddleware(
    IMyInfoUseCase fetchUserInfoUseCase,
    IMyPostsUseCase fetchUserPostsUseCase,
    IMyChallengesUseCase fetchUserChallengesUseCase,
    IGetUserByIdUseCase fetchUserByIdUseCase,
    ISetUserDescriptionUseCase setUserDescriptionUseCase,
    ISetUserInstagramUseCase setUserInstagramUseCase,
    IMyIdUseCase _myIdUseCase,
    ISubmitFcmTokenUseCase _submitFcmTokenUseCase) {
  void fetchUserInfo(Store<AppState> store, FetchUserInfoAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final user = await fetchUserInfoUseCase.run();
      store.dispatch(SetUserAction(user));
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);

      store.dispatch(LoggerErrorAction(actionName));
      store.dispatch(ReportSentryErrorAction(error, stackTrace, actionName));
      store.dispatch(FetchUserErrorAction());
    }
  }

  void fetchUserPosts(Store<AppState> store, FetchUserPostsAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final posts = await fetchUserPostsUseCase.run();
      store.dispatch(SetUserPostsAction(posts));
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);

      store.dispatch(LoggerErrorAction(actionName));
      store.dispatch(ReportSentryErrorAction(error, stackTrace, actionName));
      store.dispatch(FetchUserPostsErrorAction());
    }
  }

  void fetchUserChallenges(Store<AppState> store,
      FetchUserChallengesAction action, NextDispatcher next) async {
    next(action);
    try {
      final challenges = await fetchUserChallengesUseCase.run();
      final futures = challenges.map((challenge) async {
        final challenger = await fetchUserByIdUseCase.run(challenge.challenger);
        final challenged = challenge.challenged == null
            ? null
            : await fetchUserByIdUseCase.run(challenge.challenged);
        return ChallengeHistoryData(
          challenge.id,
          challenger,
          challenged,
          challenge.scoreChallenger,
          challenge.scoreChallenged,
          challenge.questions,
        );
      });
      final challengeDataList = await Future.wait(futures);
      store.dispatch(SetUserChallengesAction(challengeDataList));
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);

      store.dispatch(LoggerErrorAction(actionName));
      store.dispatch(ReportSentryErrorAction(error, stackTrace, actionName));
      store.dispatch(FetchUserChallengesErrorAction());
    }
  }

  void submitPostSuccess(Store<AppState> store, SubmitPostSuccessAction action,
      NextDispatcher next) async {
    next(action);
    store.dispatch(FetchUserPostsAction());
  }

  void submitUserProfileChangesSuccess(Store<AppState> store,
      SubmitUserProfileChangesSuccessAction action, NextDispatcher next) async {
    next(action);
    store.dispatch(FetchUserInfoAction());
    if (store.state.route.last == AppRoutes.editProfile) {
      store.dispatch(NavigatePopAction());
    }
  }

  void submitUserProfileChanges(Store<AppState> store,
      SubmitUserProfileChangesAction action, NextDispatcher next) async {
    next(action);
    try {
      await setUserDescriptionUseCase.run(action.bio);
      await setUserInstagramUseCase.run(action.instagram);
      store.dispatch(
        SubmitUserProfileChangesSuccessAction(
          action.bio,
          action.instagram,
        ),
      );
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);

      store.dispatch(LoggerErrorAction(actionName));
      store.dispatch(ReportSentryErrorAction(
          error, stackTrace, actionName, action.itemToJson()));
    }
  }

  void setUser(
      Store<AppState> store, SetUserAction action, NextDispatcher next) async {
    next(action);
    analytics.setUserProperty(name: "name", value: action.user.name);
  }

  void navigateUserEditProfile(Store<AppState> store,
      NavigateUserEditProfileAction action, NextDispatcher next) async {
    next(action);
    store.dispatch(NavigatePushAction(AppRoutes.editProfile));
  }

  void loginSuccess(Store<AppState> store, LoginSuccessAction action,
      NextDispatcher next) async {
    next(action);
    store.dispatch(SubmitUserFcmTokenAction(store.state.userState.fcmtoken));
  }

  void submitFcmToken(Store<AppState> store, SubmitUserFcmTokenAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final id = await _myIdUseCase.run();
      await _submitFcmTokenUseCase.run(action.fcmtoken, id);
    } catch (error, stackTrace) {
      final actionName = action.toString().substring(11);

      store.dispatch(LoggerErrorAction(actionName));
      store.dispatch(ReportSentryErrorAction(
          error, stackTrace, actionName, action.itemToJson()));
    }
  }

  return [
    TypedMiddleware<AppState, FetchUserInfoAction>(fetchUserInfo),
    TypedMiddleware<AppState, FetchUserPostsAction>(fetchUserPosts),
    TypedMiddleware<AppState, FetchUserChallengesAction>(fetchUserChallenges),
    TypedMiddleware<AppState, SubmitPostSuccessAction>(submitPostSuccess),
    TypedMiddleware<AppState, SubmitUserProfileChangesSuccessAction>(
        submitUserProfileChangesSuccess),
    TypedMiddleware<AppState, SubmitUserProfileChangesAction>(
        submitUserProfileChanges),
    TypedMiddleware<AppState, SetUserAction>(setUser),
    TypedMiddleware<AppState, NavigateUserEditProfileAction>(
        navigateUserEditProfile),
    TypedMiddleware<AppState, LoginSuccessAction>(loginSuccess),
    TypedMiddleware<AppState, SubmitUserFcmTokenAction>(submitFcmToken),
  ];
}
