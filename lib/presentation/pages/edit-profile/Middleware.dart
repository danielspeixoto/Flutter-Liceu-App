import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/redux/actions/UserActions.dart';
import 'package:app/presentation/redux/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../../redux.dart';
import 'Actions.dart';

class EditProfilePageMiddleware extends MiddlewareClass<AppState> {
  final ISetUserDescriptionUseCase setUserDescriptionUseCase;
  final ISetUserInstagramUseCase setUserInstagramUseCase;

  EditProfilePageMiddleware(
    this.setUserDescriptionUseCase,
    this.setUserInstagramUseCase,
  );

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is SubmitUserProfileChangesAction) {
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
      store.dispatch(NavigatePopAction());
    }
    next(action);
  }
}
