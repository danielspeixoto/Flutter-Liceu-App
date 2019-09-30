import 'package:app/domain/boundary/UserBoundary.dart';
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
) {
  void fetchUserInfo(Store<AppState> store, FetchUserInfoAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final user = await fetchUserInfoUseCase.run();
      store.dispatch(SetUserAction(user));
    } catch (e) {
      print(e);
      store.dispatch(FetchUserErrorAction());
    }
  }

  void fetchUserPosts(Store<AppState> store, FetchUserPostsAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final posts = await fetchUserPostsUseCase.run();
      store.dispatch(SetUserPostsAction(posts));
    } catch (e) {
      print(e);
      store.dispatch(FetchUserPostsErrorAction());
    }
  }

  void fetchUserChallenges(Store<AppState> store,
      FetchUserChallengesAction action, NextDispatcher next) async {
    next(action);
    fetchUserChallengesUseCase.run().then((challenges) async {
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
      try {
        final challengeDataList = await Future.wait(futures);
        store.dispatch(SetUserChallengesAction(challengeDataList));
      } catch (e) {
        print(e);
      }
    }).catchError((e) {
      print(e);
      store.dispatch(FetchUserChallengesErrorAction());
    });
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
    } catch (e) {
      print(e);
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

    return [
    TypedMiddleware<AppState, FetchUserInfoAction>(fetchUserInfo),
    TypedMiddleware<AppState, FetchUserPostsAction>(fetchUserPosts),
    TypedMiddleware<AppState, FetchUserChallengesAction>(fetchUserChallenges),
    TypedMiddleware<AppState, SubmitPostSuccessAction>(submitPostSuccess),
    TypedMiddleware<AppState, SubmitUserProfileChangesSuccessAction>(submitUserProfileChangesSuccess),
    TypedMiddleware<AppState, SubmitUserProfileChangesAction>(submitUserProfileChanges),
    TypedMiddleware<AppState, SetUserAction>(setUser),
    TypedMiddleware<AppState, NavigateUserEditProfileAction>(navigateUserEditProfile),
  ];
}
