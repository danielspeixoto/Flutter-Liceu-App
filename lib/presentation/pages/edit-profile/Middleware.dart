import 'package:redux/redux.dart';
import '../../../redux.dart';
import 'Reducer.dart';

class EditProfilePageMiddleware extends MiddlewareClass<AppState> {
  EditProfilePageMiddleware();

  @override
  Future call(Store<AppState> store, dynamic action, NextDispatcher next) async {
    if(action is FillUserFieldsInEditPageAction) {
      final user = store.state.userState.user.content;
      if(user != null) {
        store.dispatch(SetUserEditFieldAction(bio: user.bio));
        store.dispatch(SetLoadingEditPageAction(false));
      }
    }
    next(action);
  }
}

class FillUserFieldsInEditPageAction {
  FillUserFieldsInEditPageAction();
}
