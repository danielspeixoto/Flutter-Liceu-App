import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/aggregates/ChallengeHistoryData.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

class UserMiddleware extends MiddlewareClass<AppState> {
  final IMyInfoUseCase _myInfoUseCase;
  final IMyPostsUseCase _myPostsUseCase;
  final ISetUserDescriptionUseCase setUserDescriptionUseCase;
  final ISetUserInstagramUseCase setUserInstagramUseCase;
  final IMyChallengesUseCase _myChallengesUseCase;
  final IGetUserByIdUseCase _getUserById;
  final analytics = FirebaseAnalytics();

  UserMiddleware(
    this._myInfoUseCase,
    this._myPostsUseCase,
    this.setUserDescriptionUseCase,
    this.setUserInstagramUseCase,
    this._myChallengesUseCase,
    this._getUserById,
  );

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is FetchUserInfoAction) {
      store.dispatch(FetchUserAction());
      _myInfoUseCase.run().then((user) {
        store.dispatch(SetUserAction(user));
      }).catchError((e) {
        print(e);
        store.dispatch(FetchUserErrorAction());
      });
    } else if (action is FetchUserPostsAction) {
      this._myPostsUseCase.run().then((posts) {
        store.dispatch(SetUserPostsAction(posts));
      }).catchError((e) {
        print(e);
        store.dispatch(FetchUserPostsErrorAction());
      });
    } else if (action is FetchUserChallengesAction) {
      this._myChallengesUseCase.run().then((challenges) async {
        final futures = challenges.map((challenge) async {
          final challenger = await _getUserById.run(challenge.challenger);
          final challenged = challenge.challenged == null
              ? null
              : await _getUserById.run(challenge.challenged);
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
    } else if (action is SubmitPostSuccessAction) {
      store.dispatch(FetchUserPostsAction());
    } else if (action is SubmitUserProfileChangesSuccessAction) {
      store.dispatch(FetchUserInfoAction());
      if (store.state.route.last == AppRoutes.editProfile) {
        store.dispatch(NavigatePopAction());
      }
    } else if (action is SubmitUserProfileChangesAction) {
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
    } else if (action is SetUserAction) {
      analytics.setUserProperty(name: "name", value: action.user.name);
    }
    next(action);
  }
}
