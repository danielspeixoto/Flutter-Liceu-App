import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/redux/actions/PostActions.dart';
import 'package:app/presentation/redux/actions/UserActions.dart';
import 'package:app/presentation/redux/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../../main.dart';
import '../../app.dart';
import '../app_state.dart';

class UserMiddleware extends MiddlewareClass<AppState> {
  final IMyInfoUseCase _myInfoUseCase;
  final IMyPostsUseCase _myPostsUseCase;
  final ISetUserDescriptionUseCase setUserDescriptionUseCase;
  final ISetUserInstagramUseCase setUserInstagramUseCase;

  UserMiddleware(
    this._myInfoUseCase,
    this._myPostsUseCase,
    this.setUserDescriptionUseCase,
    this.setUserInstagramUseCase,
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
    } else if (action is PostCreatedAction) {
      store.dispatch(FetchMyPostsAction());
    } else if (action is MyProfileInfoWasChangedAction) {
      store.dispatch(FetchMyInfoAction());
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
    } else if (action is MyProfileInfoWasChangedAction) {
      if(store.state.route.last == AppRoutes.editProfile) {
        store.dispatch(NavigatePopAction());
      }
    }
    next(action);
  }
}
