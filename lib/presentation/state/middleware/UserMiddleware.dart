import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/aggregates/ChallengeData.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
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
    if (action is FetchMyInfoAction) {
      store.dispatch(FetchingUserAction());
      _myInfoUseCase.run().then((user) {
        store.dispatch(SetUserAction(user));
      }).catchError((e) {
        print(e);
        store.dispatch(FetchingUserErrorAction());
      });
    } else if (action is FetchMyPostsAction) {
      this._myPostsUseCase.run().then((posts) {
        store.dispatch(SetUserPostsAction(posts));
      }).catchError((e) {
        print(e);
        store.dispatch(FetchingMyPostsErrorAction());
      });
    } else if (action is FetchMyChallengesAction) {
      this._myChallengesUseCase.run().then((challenges) async {
        final futures = challenges.map((challenge) async {
          final challenger = await _getUserById.run(challenge.challenger);
          final challenged = challenge.challenged == null
              ? null
              : await _getUserById.run(challenge.challenged);
          return ChallengeData(
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
        store.dispatch(FetchingMyChallengesErrorAction());
      });
    } else if (action is PostCreatedAction) {
      store.dispatch(FetchMyPostsAction());
    } else if (action is MyProfileInfoWasChangedAction) {
      store.dispatch(FetchMyInfoAction());
      if (store.state.route.last == AppRoutes.editProfile) {
        store.dispatch(NavigatePopAction());
      }
    } else if (action is SubmitUserProfileChangesAction) {
      try {
        await setUserDescriptionUseCase.run(action.bio);
        await setUserInstagramUseCase.run(action.instagram);
        store.dispatch(
          MyProfileInfoWasChangedAction(
            action.bio,
            action.instagram,
          ),
        );
      } catch (e) {
        print(e);
      }
    }
    next(action);
  }
}
